package com.example.boardtest.service;

import com.example.boardtest.BoardDto.BoardDto;
import com.example.boardtest.mapper.BoardMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service("BoardService")
public class BoardService implements IBoardService{
    private final BoardMapper boardMapper;

    @Autowired
    public BoardService(BoardMapper boardMapper){
        this.boardMapper = boardMapper;
    }

    @Override
    public List<BoardDto> getBoardList(BoardDto vo){

        return boardMapper.getBoardList(vo);
    }

    @Override
    public int insertBoard(BoardDto vo){
        int result = 0;
        result = this.boardMapper.insertBoard(vo);

        return result;

    }
    @Override
    public BoardDto getBoardById(BoardDto vo) {
        return this.boardMapper.getBoardById(vo);
    }
    @Override
    public void updateBoard(BoardDto vo) {
        this.boardMapper.updateBoard(vo);
    }
    @Override
    public void deleteBoard(BoardDto vo) {
        this.boardMapper.deleteBoard(vo);
    }
}
