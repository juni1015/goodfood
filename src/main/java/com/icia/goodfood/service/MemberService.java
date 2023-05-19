package com.icia.goodfood.service;

import com.icia.goodfood.dto.MemberDTO;
import com.icia.goodfood.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
    @Autowired
    private MemberRepository memberRepository;

    public MemberDTO emailCheck(String memberEmailFull) {
        return memberRepository.emailCheck(memberEmailFull);
    }

    public MemberDTO nicknameCheck(String memberNickname) {
        return memberRepository.nicknameCheck(memberNickname);
    }
}
