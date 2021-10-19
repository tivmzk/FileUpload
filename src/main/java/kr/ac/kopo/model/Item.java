package kr.ac.kopo.model;

import org.springframework.web.multipart.MultipartFile;

public class Item {
	private String title;
	private String filename;
	
	private MultipartFile uploadFile;
	private String filecode;
	
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getFilecode() {
		return filecode;
	}
	public void setFilecode(String filecode) {
		this.filecode = filecode;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public Item(String title) {
		this.title = title;
	}
	public Item() {
		
	}
	
}
