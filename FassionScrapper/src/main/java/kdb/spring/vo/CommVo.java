package kdb.spring.vo;

public class CommVo {
	private int comNo;
	private String comContent;
	private int boardNo;
	private int memNo;
	private String nickname;
	private String comDate;
	
	public int getComNo() {
		return comNo;
	}
	public void setComNo(int comNo) {
		this.comNo = comNo;
	}
	public String getComContent() {
		return comContent;
	}
	public void setComContent(String comContent) {
		this.comContent = comContent;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getComDate() {
		return comDate;
	}
	public void setComDate(String comDate) {
		this.comDate = comDate;
	}
	@Override
	public String toString() {
		return "CommVo [comNo=" + comNo + ", comContent=" + comContent
				+ ", boardNo=" + boardNo + ", memNo=" + memNo + ", nickname="
				+ nickname + ", comDate=" + comDate + "]";
	}
	
	

}
