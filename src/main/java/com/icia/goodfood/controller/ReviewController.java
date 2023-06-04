package com.icia.goodfood.controller;

import com.icia.goodfood.dto.MemberDTO;
import com.icia.goodfood.dto.ReviewDTO;
import com.icia.goodfood.service.MemberService;
import com.icia.goodfood.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/review")
public class ReviewController {
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private MemberService memberService;

    @PostMapping("/save")
    public ResponseEntity save(@ModelAttribute ReviewDTO reviewDTO, HttpSession session) {
        Long loginId = (Long) session.getAttribute("loginId");
        reviewDTO.setMemberId(loginId);
        reviewService.save(reviewDTO);
        List<ReviewDTO> reviewDTOList = reviewService.findAll(reviewDTO.getBoardId());
        return new ResponseEntity<>(reviewDTOList, HttpStatus.OK);
    }
}
