window.addEventListener('DOMContentLoaded', () => {
    document.getElementById('boton').addEventListener('click', async function(i) {
        i.preventDefault();
        const dni = document.getElementById('client_DNI').value.trim();
        if (!dni) {
            alert("Por favor, ingresa un DNI para consultar incidencias");
            return;
        }
        try {
            const res = await fetch(`http://localhost:5000/cincidencies?client_DNI=${dni}`);
            const incidencias = await res.json();
            if (incidencias.length) {
                console.log(incidencias.consola_id)
                mostrarIncidenciasConCasos(incidencias);
            } else {
                alert("No s'han detectat incidencies");
                document.getElementById('cajaconsultasinci').innerHTML = "";
            }
        } catch (error) {
            alert("Error al consultar incidencias");
            console.error(error);
        }
        
    });

    function mostrarIncidenciasConCasos(incidencias) {
        const caixa = document.getElementById('cajaconsultasinci');
        const caixa2 = document.getElementById('consultasinci');
        caixa.innerHTML = "";

        incidencias.forEach(i => {
            const p = document.createElement('p');
            console.log('id_accessoris:', i.id_accessoris, typeof i.id_accessoris, 'consola_id:', i.consola_id, typeof i.consola_id);

            const consolaNum = Number(i.consola_id);
            const accesorisNum = Number(i.id_accessoris);

            if (!isNaN(consolaNum) && consolaNum > 0 && !isNaN(accesorisNum) && accesorisNum > 0) {
                p.textContent = `DNI: ${i.client_DNI} - Consola ID: ${consolaNum} - Accessori ID: ${accesorisNum} - Data: ${i.data_incidencia} - Servei: ${i.servei_solicitat}`;
            } 
            else if (!isNaN(accesorisNum) && accesorisNum > 0) {
                p.textContent = `DNI: ${i.client_DNI} - Accessoris ID: ${accesorisNum} - Data: ${i.data_incidencia} - Servei: ${i.servei_solicitat}`;
            }
            else if (!isNaN(consolaNum) && consolaNum > 0){
                p.textContent = `DNI: ${i.client_DNI} - Consola ID: ${consolaNum} - Data: ${i.data_incidencia} - Servei: ${i.servei_solicitat}`;
            }
            else {
                p.textContent = `DNI: ${i.client_DNI} - Data: ${i.data_incidencia} - Servei: ${i.servei_solicitat}`;
            }
            caixa.appendChild(p);
        });
        caixa2.style.display = "block";
    }

    const authModal = document.getElementById('authModal');
    const loginFormContainer = document.getElementById('loginFormContainer');
    const registerFormContainer = document.getElementById('registerFormContainer');
    const showLoginBtn = document.getElementById('showLogin');
    const showRegisterBtn = document.getElementById('showRegister');
    const citaForm = document.getElementById('citaForm');

    let usuarioAutenticado = false;
    let dniUsuario = null;
    authModal.style.display = 'flex';
    citaForm.querySelectorAll('input, select, textarea, button').forEach(el => el.disabled = true);
    function showLogin() {
        loginFormContainer.style.display = 'block';
        registerFormContainer.style.display = 'none';
        showLoginBtn.classList.add('active');
        showRegisterBtn.classList.remove('active');
    }

    function showRegister() {
        loginFormContainer.style.display = 'none';
        registerFormContainer.style.display = 'block';
        showLoginBtn.classList.remove('active');
        showRegisterBtn.classList.add('active');
    }

    showLoginBtn.addEventListener('click', showLogin);
    showRegisterBtn.addEventListener('click', showRegister);
    citaForm.addEventListener('submit', e => {
        if (!usuarioAutenticado) {
        e.preventDefault();
        alert("Has d'iniciar sessio o registrarte abans d'enviar el formulari.");
        }
    });

    document.getElementById('loginForm').addEventListener('submit', async (e) => {
        e.preventDefault();
        let dni = document.getElementById('dniLogin').value.trim().toUpperCase();
        const dniRegex = /^\d{8}[A-Z]$/;
        if (!dniRegex.test(dni)) {
            alert('DNI no valid. Ha de tindre 8 nombres i una lletra.');
            return;
        }
        
        try {
            const response = await fetch(`http://localhost:5000/api/check_cliente/${dni}`);
            const result = await response.json();

            if (result.exists) {
                usuarioAutenticado = true;
                dniUsuario = dni;
                authModal.style.display = 'none';
                citaForm.querySelectorAll('input, select, textarea, button').forEach(el => el.disabled = false);
                document.getElementById('client_DNI').value = dni;
                alert('Sessio iniciada correctament');
            } else {
                alert('DNI no registrat. Per favor, registrat.');
            }
        } catch (err) {
            alert('Error al servidor. Intenta-ho mes tard.');
        }
    });

    document.getElementById('registerForm').addEventListener('submit', async (e) => {
        e.preventDefault();

        let dni = document.getElementById('dniRegister').value.trim().toUpperCase();
        const nom = document.getElementById('nomRegister').value.trim();
        const telefon = document.getElementById('telefonRegister').value.trim();
        let correu = document.getElementById('correuRegister').value.trim().toLowerCase();

        const dniRegex = /^\d{8}[A-Z]$/;
        const correoRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
        const telefonoRegex = /^(6|7)\d{8}$/;

        if (!dniRegex.test(dni)) {
            alert('DNI no valid. Ha de tindre 8 nombres i una lletra.');
            return;
        }

        if (!correoRegex.test(correu)) {
            alert('Correo no valid. Ha de ser un correu de Gmail.');
            return;
        }

        if (!telefonoRegex.test(telefon)) {
            alert('Telefon no valid. Ha de ser un numero espanyol (9 digits, comença per 6 o 7).');
            return;
        }

        try {
            const response = await fetch('http://localhost:5000/api/register', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ DNI: dni, nom, telefon, correu })
            });
            const result = await response.json();

            if (result.success) {
                usuarioAutenticado = true;
                dniUsuario = dni;
                authModal.style.display = 'none';
                citaForm.querySelectorAll('input, select, textarea, button').forEach(el => el.disabled = false);
                document.getElementById('client_DNI').value = dni;
                alert('Registre i login exitosos');
            } else {
                alert(result.error || 'Error al registrarse');
            }
        } catch (err) {
            alert('Error al servidor. Intenta-ho mes tard.');
        }
    });

    fetch('http://localhost:5000/consoles')
        .then(res => res.json())
        .then(consoles => {
            const selectConsoles = document.getElementById('consoles_id');
            consoles.forEach(c => {
                const option = document.createElement('option');
                option.value = c.id;
                option.textContent = `${c.marca} (${c.any_fabricacio}) - ${c.preu}€`;
                selectConsoles.appendChild(option);
            });
        });

    fetch('http://localhost:5000/accessoris')
        .then(res => res.json())
        .then(accessoris => {
            const selectAccessoris = document.getElementById('accessoris_id');
            accessoris.forEach(a => {
                const option = document.createElement('option');
                option.value = a.id;
                option.textContent = `${a.marca} (${a.any_fabricacio}) - ${a.preu}€`;
                selectAccessoris.appendChild(option);
            });
        });
        
    document.getElementById('citaForm').addEventListener('submit', async function(e) {
        e.preventDefault();

        let consoles_id = document.getElementById('consoles_id').value || null;
        let accesoris_id = document.getElementById('accessoris_id').value || null;
        const servei_solicitat = document.getElementById('servei_solicitat').value.trim();
        const client_DNI = document.getElementById('client_DNI').value.trim().toUpperCase();
        let data_cita = document.getElementById('data_cita').value;

        // Convertir fecha/hora de "2025-05-25T14:30" a "2025-05-25 14:30"
        data_cita = data_cita.replace('T', ' ');

        if (!/^\d{8}[A-Z]$/.test(client_DNI)) {
            alert('DNI no valid. Ha de tindre 8 nombres i una lletra.');
            return;
        }

        const response = await fetch('http://localhost:5000/api/cita', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ consoles_id, data_cita, servei_solicitat, client_DNI, id_accessoris: accesoris_id })
        });

        const result = await response.json();
        alert(result.message || result.error || 'Resposta sense missatge');
    });
});