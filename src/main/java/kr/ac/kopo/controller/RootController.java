package kr.ac.kopo.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.ac.kopo.model.Item;

@Controller
public class RootController {
	ArrayList<Item> list;
	
	public RootController() {
		list = new ArrayList<Item>();
	}
	
	@RequestMapping("/")
	public String index(Model model) {
		model.addAttribute("list", list);
		return "index";
	}
	
	@PostMapping("/upload")
	public String upload(Item item) {
		MultipartFile uploadFile = item.getUploadFile();
		if(uploadFile == null || uploadFile.isEmpty()) {
			System.out.println("정상적인 파일을 업로드 해 주세요");
		}
		else{
			String filename = uploadFile.getOriginalFilename();
			String path = "D:/upload/";
			
			try {
				item.setFilecode(UUID.randomUUID().toString() + "_" + filename);
				item.setFilename(filename);
				uploadFile.transferTo(new File(path + item.getFilecode()));
				list.add(item);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "redirect:.";
	}
	
	@ResponseBody
	@RequestMapping(value="/upload_ajax", method=RequestMethod.POST, produces="application/text;charset=utf8")
	public String uploadAjax(Item item) {
		
		upload(item);
		return String.format("%s:%s:%s", item.getTitle(), item.getFilename(), item.getFilecode());
	}
	
	@GetMapping("/delete/{title}")
	public String delete(@PathVariable String title) {
		for(Item item : list) {
			if(item.getTitle().equals(title)) {
				list.remove(item);
				break;
			}
		}
		return "redirect:..";
	}
	
	
}
