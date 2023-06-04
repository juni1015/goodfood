package com.icia.goodfood.service;

import com.icia.goodfood.dto.ReviewDTO;
import com.icia.goodfood.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewService {
    @Autowired
    private ReviewRepository reviewRepository;

    public void save(ReviewDTO reviewDTO) {
        reviewRepository.save(reviewDTO);
    }

    public List<ReviewDTO> findAll(Long boardId) {
        List<ReviewDTO> reviewDTOList = reviewRepository.findAll(boardId);
        return reviewDTOList;
    }
}
