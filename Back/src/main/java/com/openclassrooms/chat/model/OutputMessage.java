package com.openclassrooms.chat.model;

import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class OutputMessage {

    private String from;
    private String text;
    private String time;

}