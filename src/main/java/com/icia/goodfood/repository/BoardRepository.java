package com.icia.goodfood.repository;

import com.icia.goodfood.dto.BoardDTO;
import com.icia.goodfood.dto.BoardFileDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class BoardRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public List<BoardDTO> pagingList(Map<String, Integer> pagingParams) {
        return sql.selectList("Board.pagingList", pagingParams);
    }

    public int boardCount() { return sql.selectOne("Board.count"); }

    public List<BoardDTO> searchList(Map<String, Object> pagingParam) {
        return sql.selectList("Board.searchList", pagingParam);
    }

    public int boardSearchCount(String q) {
        return sql.selectOne("Board.searchCount", q);
    }

    public List<BoardDTO> categoryList(Map<String, Object> pagingParam) {
        return sql.selectList("Board.categoryList", pagingParam);
    }

    public int categoryCount(int boardCategory) {
        return sql.selectOne("Board.categoryCount", boardCategory);
    }

    public List<BoardDTO> categorySearchList(Map<String, Object> pagingParam) {
        return sql.selectList("Board.categorySearchList", pagingParam);
    }

    public int categorySearchCount(Map<String, Object> pagingParams) {
        return sql.selectOne("Board.categorySearchCount", pagingParams);
    }

    public BoardDTO doubleCheck(BoardDTO boardDTO) {
        return sql.selectOne("Board.doubleCheck", boardDTO);
    }

    public BoardDTO save(BoardDTO boardDTO) {
        sql.insert("Board.save", boardDTO);
        return boardDTO;
    }

    public void saveFile(BoardFileDTO boardFileDTO) {
        sql.insert("Board.saveFile", boardFileDTO);
    }
}
