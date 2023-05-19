package com.icia.goodfood.controller;

import com.icia.goodfood.dto.MemberDTO;
import com.icia.goodfood.dto.MemberProfileDTO;
import com.icia.goodfood.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // 세션에 담긴 값 전체 삭제
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
        // 세션에 들어있는 로그인된 id 가져오기
        Long loginId = (Long) session.getAttribute("loginId");
        MemberDTO memberDTO = memberService.findById(loginId);
        model.addAttribute("member", memberDTO);
        if (memberDTO.getProfileAttached() == 1) {
            MemberProfileDTO memberProfileDTO = memberService.findProfile(loginId);
            model.addAttribute("memberProfile", memberProfileDTO);
        }
        return "memberPages/memberMyPage";
    }

    @GetMapping("/withdrawal")
    public String withdrawalForm(HttpSession session, Model model) {
        // 세션에 들어있는 로그인된 id 가져오기
        Long loginId = (Long) session.getAttribute("loginId");
        MemberDTO memberDTO = memberService.findById(loginId);
        model.addAttribute("member", memberDTO);
        return "memberPages/memberWithdrawal";
    }

    @PostMapping("/withdrawal")
    public String withdrawal(HttpSession session) {
        // 세션에 들어있는 로그인된 id 가져오기
        Long loginId = (Long) session.getAttribute("loginId");
        memberService.delete(loginId);
        return "redirect:/member/logout";
    }


}
