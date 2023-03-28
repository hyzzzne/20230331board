package com.example.boardtest.BoardDto;

import java.sql.Date;

import lombok.*;
import org.springframework.boot.autoconfigure.domain.EntityScan;


@Data
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BoardDto {

    private int no;
    private String title;
    private String writer;
    private String content;
    private Date regDate;
    private int hit;

}
