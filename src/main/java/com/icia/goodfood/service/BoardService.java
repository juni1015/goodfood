package com.icia.goodfood.service;

import com.icia.goodfood.dto.BoardDTO;
import com.icia.goodfood.dto.PageDTO;
import com.icia.goodfood.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardService {
    @Autowired
    private BoardRepository boardRepository;

    // 페이징 관련 리스트
    public List<BoardDTO> pagingList(int page) {
//        int pageLimit = 10;
//        int pagingStart = (page-1) * pageLimit;
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setPageLimit(10);   // pageStart(게시글 시작번호)까지 계산됨
        Map<String, Integer> pagingParams = new HashMap<>();
        pagingParams.put("start", pageDTO.getPageStart());  // 게시글 시작번호
        pagingParams.put("limit", pageDTO.getPageLimit());
        List<BoardDTO> boardDTOList = boardRepository.pagingList(pagingParams);
        return boardDTOList;
    }

    public PageDTO pagingParam(int page) {
//        int pageLimit = 10;  // 한 페이지에 보여줄 글 갯수
//        int blockLimit = 5; //하단에 보여줄 페이지 번호 갯수
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setPageLimit(10);   // pageStart 까지 계산됨
        pageDTO.setBlockLimit(5);   // startPage(시작 페이지 값) 까지 계산됨
        // 전체 글 갯수 조회
        pageDTO.setBoardCount(boardRepository.boardCount());    //maxPage(전체 페이지 갯수)와 endPage(마지막 페이지 값) 까지 계산됨
        // 전체 페이지 갯수가 계산한 endPage 보다 작을 때 endPage 값을 maxPage 값과 같게 셋팅
        if (pageDTO.getEndPage() > pageDTO.getMaxPage()) {
            pageDTO.setEndPage(pageDTO.getMaxPage());
        }
        return pageDTO;
    }

    // 검색어 입력된 페이징 관련 리스트
    public List<BoardDTO> searchList(int page, String q) {
//        int pageLimit = 10;  // 한 페이지에 보여줄 글 갯수
//        int pagingStart = (page-1) * pageLimit;
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setPageLimit(10);   // pageStart(게시글 시작번호)까지 계산됨
        Map<String, Object> pagingParam = new HashMap<>();
        pagingParam.put("start", pageDTO.getPageStart());
        pagingParam.put("limit", pageDTO.getPageLimit());
        pagingParam.put("q", q);
        List<BoardDTO> boardDTOList = boardRepository.searchList(pagingParam);
        return boardDTOList;
    }

    public PageDTO pagingSearchParam(int page, String q) {
//        int pageLimit = 10;  // 한 페이지에 보여줄 글 갯수
//        int blockLimit = 5; // 하단에 보여줄 페이지 번호 갯수
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setPageLimit(10);   // pageStart 까지 계산됨
        pageDTO.setBlockLimit(5);   // startPage(시작 페이지 값) 까지 계산됨
        // 검색어에 해당하는 전체 글 갯수 조회
        pageDTO.setBoardCount(boardRepository.boardSearchCount(q));    //maxPage(전체 페이지 갯수)와 endPage(마지막 페이지 값) 까지 계산됨
        // 전체 페이지 갯수가 계산한 endPage 보다 작을 때 endPage 값이 maxPage 값과 같게 셋팅
        if (pageDTO.getEndPage() > pageDTO.getMaxPage()) {
            pageDTO.setEndPage(pageDTO.getMaxPage());
        }
        return pageDTO;
    }

    // 카테고리가 있는 게시글 페이징 관련 리스트
    public List<BoardDTO> categoryPagingList(int boardCategory, int page) {
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setPageLimit(10);   // pageStart(게시글 시작번호)까지 계산됨
        Map<String, Object> pagingParam = new HashMap<>();
        pagingParam.put("start", pageDTO.getPageStart());
        pagingParam.put("limit", pageDTO.getPageLimit());
        pagingParam.put("boardCategory", boardCategory);
        System.out.println("pagingParam = " + pagingParam);
        List<BoardDTO> boardDTOList = boardRepository.categoryList(pagingParam);
        return boardDTOList;
    }

    public PageDTO categoryPagingParam(int boardCategory, int page) {
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setPageLimit(10);   // pageStart 까지 계산됨
        pageDTO.setBlockLimit(5);   // startPage(시작 페이지 값) 까지 계산됨
        // 검색어에 해당하는 전체 글 갯수 조회
        pageDTO.setBoardCount(boardRepository.categoryCount(boardCategory));    //maxPage(전체 페이지 갯수)와 endPage(마지막 페이지 값) 까지 계산됨
        // 전체 페이지 갯수가 계산한 endPage 보다 작을 때 endPage 값이 maxPage 값과 같게 셋팅
        if (pageDTO.getEndPage() > pageDTO.getMaxPage()) {
            pageDTO.setEndPage(pageDTO.getMaxPage());
        }
        return pageDTO;
    }

    // 카테고리, 검색어가 있는 게시글 페이징 관련 리스트
    public List<BoardDTO> categorySearchList(int boardCategory, int page, String q) {
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setPageLimit(10);   // pageStart(게시글 시작번호)까지 계산됨
        Map<String, Object> pagingParam = new HashMap<>();
        pagingParam.put("start", pageDTO.getPageStart());
        pagingParam.put("limit", pageDTO.getPageLimit());
        pagingParam.put("boardCategory", boardCategory);
        pagingParam.put("q", q);
        List<BoardDTO> boardDTOList = boardRepository.categorySearchList(pagingParam);
        return boardDTOList;
    }

    public PageDTO categoryPagingSearchParam(int boardCategory, int page, String q) {
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setPageLimit(10);   // pageStart 까지 계산됨
        pageDTO.setBlockLimit(5);   // startPage(시작 페이지 값) 까지 계산됨
        Map<String, Object> pagingParams = new HashMap<>();
        pagingParams.put("q", q);
        pagingParams.put("boardCategory", boardCategory);
        // 검색어에 해당하는 전체 글 갯수 조회
        pageDTO.setBoardCount(boardRepository.categorySearchCount(pagingParams));    //maxPage(전체 페이지 갯수)와 endPage(마지막 페이지 값) 까지 계산됨
        // 전체 페이지 갯수가 계산한 endPage 보다 작을 때 endPage 값이 maxPage 값과 같게 셋팅
        if (pageDTO.getEndPage() > pageDTO.getMaxPage()) {
            pageDTO.setEndPage(pageDTO.getMaxPage());
        }
        return pageDTO;
    }
}
