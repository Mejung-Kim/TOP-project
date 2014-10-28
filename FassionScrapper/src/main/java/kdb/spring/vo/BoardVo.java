package kdb.spring.vo;

public class BoardVo {

	private int boardNo; //게시판번호
	private String userNo; //회원번호
	private String img; //이미지
	private int recom; //추천수
	private String boardDate; //게시일
	private String title; //제목
	private int type; //게시판 타입
	private int viewcnt; //조회수
	private String userNick;
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo2) {
		this.userNo = userNo2;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getRecom() {
		return recom;
	}
	public void setRecom(int recom) {
		this.recom = recom;
	}
	
	public String getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public String getUserNick() {
		return userNick;
	}
	public void setUserNick(String userNick) {
		this.userNick = userNick;
	}
	
	@Override
	public String toString() {
		return "BoardVo [boardNo=" + boardNo + ", userNo=" + userNo + ", img="
				+ img + ", recom=" + recom + ", boardDate=" + boardDate
				+ ", title=" + title + ", type=" + type + ", viewcnt="
				+ viewcnt + ", userNick=" + userNick + "]";
	}
}
