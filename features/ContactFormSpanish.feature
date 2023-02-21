#language: es

Característica: ContactForm

  Antecedentes:
    Dadas estoy en la página de inicio

  @assertLang
  Escenario: Mi primer inicio de sesión
    Cuando sigo "Spanish"
    Y sigo "Contacto"
    Entonces debo ver "Website feedback"
    Y relleno "Su nombre" con "John"
    Y relleno "Su dirección de correo electrónico" con "priyasi.singh@axelerant.com"
    Y relleno "Asunto" con "Prueba de asignatura"
    Y relleno "Mensaje" con "Prueba de asignatura"
    Y presiono "Enviar mensaje"
    Y yo espero 5 seconds
    Entonces debo ver "El sitio web encontró un error inesperado. Vuelva a intentarlo más tarde."

