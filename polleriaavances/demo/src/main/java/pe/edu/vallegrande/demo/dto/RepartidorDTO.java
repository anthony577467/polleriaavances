package pe.edu.vallegrande.demo.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class RepartidorDTO {
    private int id;
    private String names;
    private String surnames;
    private String document;
    private String plate;
    private String email;
    private String phone;
}
