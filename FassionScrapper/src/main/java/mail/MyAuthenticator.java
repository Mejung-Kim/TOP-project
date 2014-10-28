package mail;


import javax.mail.Authenticator;

public class MyAuthenticator extends Authenticator {

    private String id;
    private String pw;

    public MyAuthenticator(String id, String pw) {
        this.id = "nallya722";
        this.pw = "wwr197356";
    }

    protected javax.mail.PasswordAuthentication getPasswordAuthentication() {

        return new javax.mail.PasswordAuthentication(id, pw);

    }
}
