package com.petpal.controller;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.petpal.configuration.CustomFileuploadProperties;
import com.petpal.dao.MemberDao;
import com.petpal.dao.ProductAttachmentDao;
import com.petpal.dao.ProductDao;
import com.petpal.dao.ProductImageDao;
import com.petpal.dto.AttachmentDto;
import com.petpal.dto.MemberDto;
import com.petpal.dto.ProductDto;
import com.petpal.dto.ProductImageDto;
import com.petpal.vo.PaginationVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired MemberDao memberDao;
	
	@Autowired ProductDao productDao;
	
	@Autowired ProductAttachmentDao productAttachmentDao;
	
	@Autowired private CustomFileuploadProperties fileuploadProperties;
	
	@Autowired private ProductImageDao productImageDao;
	
	private File dir;
	@PostConstruct
	public void init() {
		dir = new File(fileuploadProperties.getPath());
	}
	
	// 관리자 홈
	@GetMapping("/home")
	public String home() {
		return "/WEB-INF/views/admin/home.jsp";
	}
	
	// 관리자 상품등록 페이지
	@GetMapping("/product/insert")
	public String insert() {
		return "/WEB-INF/views/admin/product/insert.jsp";
	}
	
	@PostMapping("/product/insertProcess")
	public String insert(@ModelAttribute ProductDto productDto,
			@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		productDto.setProductNo(productDao.sequence());
		productDao.insert(productDto);
		if(!attach.isEmpty()) {
			int attachmentNo = productAttachmentDao.sequence();	
			File target = new File(dir, String.valueOf(attachmentNo));
			attach.transferTo(target);
			
			productAttachmentDao.insert(AttachmentDto.builder()
											.attachmentNo(attachmentNo)
											.attachmentName(attach.getOriginalFilename())
											.attachmentType(attach.getContentType())
											.attachmentSize(attach.getSize())
											.build()
					);
			
			productImageDao.insert(ProductImageDto.builder()
											.productNo(productDto.getProductNo())
											.attachmentNo(attachmentNo)
											.build()
					);
		}
		return "redirect:insertFinish";
	}
	
	// 상품등록 완료 페이지
	@GetMapping("/product/insertFinish")
	public String insertFinish() {
		return "/WEB-INF/views/admin/product/insertFinish.jsp";
	}
	
	// 상품 리스트 페이지
	@GetMapping("/product/list")
	public String productList(Model model, @ModelAttribute("vo") PaginationVO vo) {
		
		int totalProductCnt = productDao.totalProductCnt();
		vo.setCount(totalProductCnt);
		model.addAttribute("productList", productDao.selectList(vo));
		return "/WEB-INF/views/admin/product/list.jsp";
	}
	
	// 상품정보 변경
	@GetMapping("/product/edit")
	public String productEdit(Model model, @RequestParam int productNo) {
		ProductDto productDto = productDao.selectOne(productNo);
		model.addAttribute("productDto", productDto);
		return "/WEB-INF/views/admin/product/edit.jsp";
	}
	
	@PostMapping("/product/edit")
	public String productEdit(@ModelAttribute ProductDto productDto, 
										RedirectAttributes attr) {
		// 정보변경
		productDao.changeProductInfo(productDto);
		attr.addAttribute("productNo", productDto.getProductNo());
		return "redirect:list";
	}
	
	// 상품 삭제
	@GetMapping("/product/delete")
	public String delete(@RequestParam int productNo) {
		productDao.delete(productNo);
		return "redirect:list";
	}
	
	// 회원 리스트 페이지
	@GetMapping("/member/list")
	public String memberList(Model model, @ModelAttribute("vo") PaginationVO vo) {
		int totalMemberCnt = memberDao.selectCount();
		vo.setCount(totalMemberCnt);
		model.addAttribute("memberList", memberDao.selectList(vo));
		return "/WEB-INF/views/admin/member/list.jsp";
	}
	
	// 회원정보 상세
	@GetMapping("/member/detail")
	public String memberDetail(Model model,
						@RequestParam String memberId) {
		model.addAttribute("memberDto", memberDao.selectOne(memberId));
		return "/WEB-INF/views/admin/member/detail.jsp";
	}
	
	// 회원정보 업데이트
	@GetMapping("/member/edit")
	public String memberEdit(Model model, @RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		return "WEB-INF/views/admin/member/edit.jsp";
	}
	@PostMapping("/member/edit")
	public String memberEdit(@ModelAttribute MemberDto memberDto, 
									RedirectAttributes attr) {
		memberDao.changeInformationByAdmin(memberDto);
		attr.addAttribute("memberId", memberDto.getMemberId());
		return "redirect:detail";
	}
	
	
}

