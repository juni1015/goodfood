package com.icia.goodfood.repository;

import com.icia.goodfood.dto.MemberDTO;
import com.icia.goodfood.dto.MemberProfileDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public MemberDTO emailCheck(String memberEmailFull) {
        return sql.selectOne("Member.emailCheck", memberEmailFull);
    }

    public MemberDTO nicknameCheck(String memberNickname) {
        return sql.selectOne("Member.nicknameCheck", memberNickname);
    }

    public MemberDTO save(MemberDTO memberDTO) {
        sql.insert("Member.save", memberDTO);
        return memberDTO;
    }

    public void saveProfile(MemberProfileDTO memberProfileDTO) {
        sql.insert("Member.saveProfile", memberProfileDTO);
    }

    public MemberDTO login(MemberDTO memberDTO) {
        return sql.selectOne("Member.login", memberDTO);
    }

    public MemberDTO findById(Long id) {
        return sql.selectOne("Member.findById", id);
    }

    public MemberProfileDTO findProfile(Long memberId) {
        return sql.selectOne("Member.findProfile", memberId);
    }

    public void delete(Long id) {
        sql.delete("Member.delete", id);
    }
}
