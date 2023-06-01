package com.icia.goodfood.controller;

import com.icia.goodfood.dto.*;
import com.icia.goodfood.service.BoardService;
import com.icia.goodfood.service.MemberService;
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
    @Autowired
    private MemberService memberService;

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
                           HttpSession session,
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
        // 찜 여부 확인
        // 세션에 들어있는 로그인된 id 가져오기
        Long loginId = (Long) session.getAttribute("loginId");
        ChoiceDTO choiceDTO = new ChoiceDTO();
        choiceDTO.setBoardId(id);
        choiceDTO.setMemberId(loginId);
        ChoiceDTO choiceDTO1 = boardService.findChoice(choiceDTO);
        System.out.println("choiceDTO1 = " + choiceDTO1);
        if (choiceDTO1 != null) {
            model.addAttribute("choice", 1);
        } else {
            model.addAttribute("choice", 0);
        }
        // 리뷰작성자 정보 및 이미지 가져오기
        MemberDTO memberDTO = memberService.findById(loginId);
        model.addAttribute("member", memberDTO);
        MemberProfileDTO memberProfileDTO = new MemberProfileDTO();
        if (memberDTO.getProfileAttached() == 1) {
            memberProfileDTO = memberService.findProfile(loginId);
        } else {
            memberProfileDTO.setMemberId(memberDTO.getId());
            memberProfileDTO.setStoredFileName("person_nonimg.png");
            memberProfileDTO.setOriginalFileName("person_nonimg.png");
        }
        model.addAttribute("memberProfile", memberProfileDTO);
        return "boardPages/boardDetail";
    }

    @PostMapping("/choice")
    public ResponseEntity choiceUp(@RequestParam("boardId") Long boardId,
                                   @RequestParam("memberId") Long memberId) {
        ChoiceDTO choiceDTO = new ChoiceDTO();
        choiceDTO.setBoardId(boardId);
        choiceDTO.setMemberId(memberId);
        boardService.choice(choiceDTO);
        boardService.choiceUp(boardId);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/unChoice")
    public ResponseEntity choiceDown(@RequestParam("boardId") Long boardId,
                                     @RequestParam("memberId") Long memberId) {
        ChoiceDTO choiceDTO = new ChoiceDTO();
        choiceDTO.setBoardId(boardId);
        choiceDTO.setMemberId(memberId);
        boardService.unChoice(choiceDTO);
        boardService.choiceDown(boardId);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping("/update")
    public String update(@RequestParam("id") Long id,
                         @RequestParam(value = "boardCategory", required = false, defaultValue = "0") int boardCategory,
                         @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                         @RequestParam(value = "q", required = false, defaultValue = "") String q,
                         Model model) {
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
        return "boardPages/boardUpdate";
    }

    @PostMapping("/update")
    public String update(@RequestParam("id") Long id,
                         @RequestParam(value = "boardCategory", required = false, defaultValue = "0") int boardCategory,
                         @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                         @RequestParam(value = "q", required = false, defaultValue = "") String q,
                         @ModelAttribute BoardDTO boardDTO) {
        boardDTO.setId(id);
        boardService.update(boardDTO);
        return "redirect:/board/detail?id=" + id + "&boardCategory=" + boardCategory + "&page=" + page + "&q=" + q;
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id,
                         @RequestParam(value = "boardCategory", required = false, defaultValue = "0") int boardCategory,
                         @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                         @RequestParam(value = "q", required = false, defaultValue = "") String q) {
        boardService.delete(id);
        return "redirect:/board/list?boardCategory=" + boardCategory + "&page=" + page + "&q=" + q;
    }
}
