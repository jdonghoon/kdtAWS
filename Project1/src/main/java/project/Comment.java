package project;

public class Comment {
	private int cno;
	private int mino;
	private int uno;
	private String uid;
	private String rdate;
	private String content;
	private String state;
	
	
	public Comment() {}
	
	
	public Comment(int cno, int mino, int uno, String uid, String rdate, String content, String state) {
		this.cno = cno;
		this.mino = mino;
		this.uno = uno;
		this.uid = uid;
		this.rdate = rdate;
		this.content = content;
		this.state = state;
	}


	public int getCno() {
		return cno;
	}


	public void setCno(int cno) {
		this.cno = cno;
	}

	public int getMino() {
		return mino;
	}


	public void setMino(int mino) {
		this.mino = mino;
	}


	public int getUno() {
		return uno;
	}


	public void setUno(int uno) {
		this.uno = uno;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getRdate() {
		return rdate;
	}


	public void setRdate(String rdate) {
		this.rdate = rdate;
	}


	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
	}


	public String getUid() {
		return uid;
	}


	public void setUid(String uid) {
		this.uid = uid;
	}
	
	
}
