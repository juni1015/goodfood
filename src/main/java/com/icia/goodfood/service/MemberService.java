package com.icia.goodfood.service;

import com.icia.goodfood.dto.MemberDTO;
import com.icia.goodfood.dto.MemberProfileDTO;
import com.icia.goodfood.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;

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

    public void save(MemberDTO memberDTO) throws IOException {
        if (memberDTO.getMemberProfile().isEmpty()) {
            System.out.println("파일없음");
            memberDTO.setProfileAttached(0);
            memberRepository.save(memberDTO);
        } else {
            System.out.println("파일있음");
            memberDTO.setProfileAttached(1);
            MemberDTO dto = memberRepository.save(memberDTO);
            // 저장한 member의 id에 저장된 profile의 원본 파일명 (memberProfile 테이블에 memberId 값을 담기 위해)
            String originalProfileName = dto.getMemberProfile().getOriginalFilename();
            // 서버용 파일명
            String storeProfileName = System.currentTimeMillis() + "-" + originalProfileName;
            // 저장할 MemberProfileDTO 셋팅
            MemberProfileDTO memberProfileDTO = new MemberProfileDTO();
            memberProfileDTO.setOriginalFileName(originalProfileName);
            memberProfileDTO.setStoredFileName(storeProfileName);
            memberProfileDTO.setMemberId(dto.getId());
            // 로컬에 파일을 저장할 경로 설정 (폴더 경로 + 저장할 이름)
            String savePath = "D:\\goodfood_img\\" + storeProfileName;
            // profile 저장 처리
            dto.getMemberProfile().transferTo(new File(savePath));
            memberRepository.saveProfile(memberProfileDTO);
        }
    }

    public MemberDTO login(MemberDTO memberDTO) {
        return memberRepository.login(memberDTO);
    }
}
