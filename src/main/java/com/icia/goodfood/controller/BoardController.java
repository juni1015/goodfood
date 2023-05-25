package com.icia.goodfood.controller;

import com.icia.goodfood.dto.*;
import com.icia.goodfood.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService boardService;

    @GetMapping("/list")
    public String list(@RequestParam(value = "boardCategory", required = false, defaultValue = "0") int boardCategory,
                       @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                       @RequestParam(value = "q", required = false, defaultValue = "") String q,
                       Model model) {
        List<BoardDTO> boardDTOList = null;
        PageDTO pageDTO = null;
        if (boardCategory == 0) {
            if (q.equals("")) {
                boardDTOList = boardService.pagingList(page);
                pageDTO = boardService.pagingParam(page);
            } else {
                boardDTOList = boardService.searchList(page, q);
                pageDTO = boardService.pagingSearchParam(page, q);
            }
        } else {
            if (q.equals("")) {
                boardDTOList = boardService.categoryPagingList(boardCategory, page);
                pageDTO = boardService.categoryPagingParam(boardCategory, page);
            } else {
                boardDTOList = boardService.categorySearchList(boardCategory, page, q);
                pageDTO = boardService.categoryPagingSearchParam(boardCategory, page, q);
            }
        }
        model.addAttribute("boardList", boardDTOList);
        model.addAttribute("paging", pageDTO);
        model.addAttribute("q", q);
        model.addAttribute("boardCategory", boardCategory);
        return "boardPages/boardList";
    }

    @GetMapping("/save")
    public String saveForm() { return "boardPages/boardSave"; }

    @PostMapping("/double-check")
    public ResponseEntity doubleCheck(@ModelAttribute BoardDTO boardDTO) {
        BoardDTO dto = boardService.doubleCheck(boardDTO);
        if (dto == null) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }
    }

    @PostMapping("/save")
    public String save(HttpSession session, @ModelAttribute BoardDTO boardDTO) throws IOException {
        // 세션에 들어있는 로그인된 id 가져와서 boardDTO에 담기
        Long loginId = (Long) session.getAttribute("loginId");
        boardDTO.setMemberId(loginId);
//        boardDTO.setMemberId((Long) session.getAttribute("LoginId"));
        boardService.save(boardDTO);
        return "redirect:/board/list?boardCategory=" + boardDTO.getBoardCategory();
    }

    @GetMapping("/data")
    public String dataSetting(HttpSession session, @RequestParam("boardCategory") int boardCategory) {
        for (int i = 1; i < 55; i++) {
            BoardDTO boardDTO = new BoardDTO();
            // 세션에 들어있는 로그인된 id 가져와서 boardDTO에 담기
            Long loginId = (Long) session.getAttribute("loginId");
            boardDTO.setMemberId(loginId);
            boardDTO.setBoardCategory(boardCategory);
            boardDTO.setBoardStoreName(boardCategory + "StoreName" + i);
            boardDTO.setBoardStoreAddress(boardCategory + "StoreAddress" + i);
            boardDTO.setBoardStoreKind(boardCategory + "StoreKind" + i);
            boardDTO.setBoardStoreNumber(boardCategory + "010-0000-0000");
            boardDTO.setBoardStoreTime("9 AM - 5 PM");
            boardDTO.setBoardStoreHomepage("https://www.dummystore" + i + ".com");
            boardService.dataSetting(boardDTO);
        }
        return "redirect:/board/list?boardCategory=" + boardCategory;
    }

    @GetMapping("/detail")
    public String findById(@RequestParam("id") Long id,
                           @RequestParam(value = "boardCategory", required = false, defaultValue = "0") int boardCategory,
                           @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                           @RequestParam(value = "q", required = false, defaultValue = "") String q,
                           Model model) {
        boardService.boardHitsUp(id);
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        model.addAttribute("boardCategory", boardCategory);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        //파일 있으면 찾아오기
        if (boardDTO.getFileAttached() == 1) {
            BoardFileDTO boardFileDTO = boardService.findFile(id);
            model.addAttribute("boardFile", boardFileDTO);
        }
        return "boardPages/boardDetail";
    }
}
