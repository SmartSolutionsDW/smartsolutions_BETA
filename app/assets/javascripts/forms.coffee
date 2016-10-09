$(document).on "ajax:beforeSend", "#emails-form", ()->
	$("#email-info").html "Se está procesando tu petición"
$(document).on "ajax:success", "#emails-form", (e,data,estado,xhr)->
	$(this).slideUp()
	$("#email-info").html "Bienvenido a Karaoke Bar, en la brevedad posible nos pondremos en contacto."
$(document).on "ajax:error", "#emails-form", (e,data,estado,xhr)->
	$("#email-info").html data.responseJSON.email[0]