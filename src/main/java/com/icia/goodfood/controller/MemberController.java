package com.icia.goodfood.controller;

import com.icia.goodfood.dto.MemberDTO;
import com.icia.goodfood.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/member")
public class MemberController {
    @Autowired
    private MemberService memberService;

    @GetMapping("/save")
    public String saveForm() { return "memberPages/memberSave"; }

    @PostMapping("/email-check")
    public ResponseEntity emailCheck(@RequestParam("memberEmail") String memberEmail,
                                     @RequestParam("memberDomain") String memberDomain) {
        String memberEmailFull = memberEmail + "@" + memberDomain;
        MemberDTO memberDTO = memberService.emailCheck(memberEmailFull);
        if (memberDTO == null) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }
    }

    @PostMapping("/nickname-check")
    public ResponseEntity nicknameCheck(@RequestParam("memberNickname") String memberNickname) {
        MemberDTO memberDTO = memberService.nicknameCheck(memberNickname);
        if (memberDTO == null) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }
    }

    @PostMapping("/save")
    public String save(@ModelAttribute MemberDTO memberDTO) throws IOException {
        String memberEmailFull = memberDTO.getMemberEmail() + "@" + memberDTO.getMemberDomain();
        memberDTO.setMemberEmailFull(memberEmailFull);
        memberService.save(memberDTO);
        return "memberPages/memberLogin";
    }

    @GetMapping("/login")
    public String loginForm() { return "memberPages/memberLogin"; }

    @PostMapping("/login")
    public String login(@ModelAttribute MemberDTO memberDTO, HttpSession session) {
        MemberDTO dto = memberService.login(memberDTO);
        if (dto != null) {
            session.setAttribute("loginEmailFull", dto.getMemberEmailFull());
            session.setAttribute("loginId", dto.getId());
            return "redirect:/";
        } else {
            return "memberPages/memberLoginError";
        }
    }
}
