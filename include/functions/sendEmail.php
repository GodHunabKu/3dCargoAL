<?php
	require 'include/mailer/PHPMailer.php';
	require 'include/mailer/Exception.php';
	use PHPMailer\PHPMailer\PHPMailer;
	
	$mail = new PHPMailer();
	
	// USA SENDMAIL invece di SMTP (per hosting con firewall SMTP)
	$mail->isSendmail();
	$mail->Sendmail = '/usr/sbin/sendmail -t -i';
	
	$mail->CharSet = 'UTF-8';
	
	$mail->SetFrom($email_username, $site_title);
	$mail->AddReplyTo($email_username, $site_title);

	$mail->Subject = $subject;
	$mail->AltBody = $alt_message;
	$mail->MsgHTML($html_mail);
	$mail->AddAddress($sendEmail, $sendName);

	// IMPORTANTE: Imposta variabile globale per sistema notifiche
	$email_sent_successfully = $mail->Send();
	
	// Se usi la vecchia pagina administration.php (non newadministration.php),
	// togli il commento qui sotto per vedere gli errori:
	/*
	if(!$email_sent_successfully) {
		print '<div class="alert alert-danger alert-dismissible fade show" role="alert">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
			
			</button>Please contact an administrator!</br>'.$mail->ErrorInfo.'</div>';
	}
	*/
?>