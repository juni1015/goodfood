package com.icia.goodfood.controller;

import com.icia.goodfood.dto.MemberDTO;
import com.icia.goodfood.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
}
