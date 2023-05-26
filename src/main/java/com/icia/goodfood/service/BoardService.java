package com.icia.goodfood.service;

import com.icia.goodfood.dto.*;
import com.icia.goodfood.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
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

    public BoardDTO doubleCheck(BoardDTO boardDTO) {
        return boardRepository.doubleCheck(boardDTO);
    }

    public void save(BoardDTO boardDTO) throws IOException {
        if (boardDTO.getBoardFile().isEmpty()) {
            System.out.println("파일없음");
            boardDTO.setFileAttached(0);
            boardRepository.save(boardDTO);
        } else {
            System.out.println("파일있음");
            boardDTO.setFileAttached(1);
            BoardDTO dto = boardRepository.save(boardDTO);
            // 저장한 member의 id에 저장된 profile의 원본 파일명 (memberProfile 테이블에 memberId 값을 담기 위해)
            String originalProfileName = dto.getBoardFile().getOriginalFilename();
            // 서버용 파일명
            String storeProfileName = System.currentTimeMillis() + "-" + originalProfileName;
            // 저장할 MemberProfileDTO 셋팅
            BoardFileDTO boardFileDTO = new BoardFileDTO();
            boardFileDTO.setOriginalFileName(originalProfileName);
            boardFileDTO.setStoredFileName(storeProfileName);
            boardFileDTO.setBoardId(dto.getId());
            // 로컬에 파일을 저장할 경로 설정 (폴더 경로 + 저장할 이름)
            String savePath = "D:\\goodfood_img\\" + storeProfileName;
            // profile 저장 처리
            dto.getBoardFile().transferTo(new File(savePath));
            boardRepository.saveFile(boardFileDTO);
        }
    }

    public void dataSetting(BoardDTO boardDTO) {
        boardRepository.save(boardDTO);
    }

    public void boardHitsUp(Long id) {
        boardRepository.boardHitsUp(id);
    }

    public BoardDTO findById(Long id) {
        return boardRepository.findById(id);
    }

    public BoardFileDTO findFile(Long id) {
        return boardRepository.findFile(id);
    }

    public ChoiceDTO findChoice(ChoiceDTO choiceDTO) {
        return boardRepository.findChoice(choiceDTO);
    }

    public void choice(ChoiceDTO choiceDTO) {
        boardRepository.choice(choiceDTO);
    }

    public void unChoice(ChoiceDTO choiceDTO) {
        boardRepository.unChoice(choiceDTO);
    }

    public void choiceUp(Long boardId) {
        boardRepository.choiceUp(boardId);
    }

    public void choiceDown(Long boardId) {
        boardRepository.choiceDown(boardId);
    }
}
