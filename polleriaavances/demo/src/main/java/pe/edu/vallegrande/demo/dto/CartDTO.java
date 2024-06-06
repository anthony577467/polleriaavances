package pe.edu.vallegrande.demo.dto;

import java.math.BigDecimal;
import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CartDTO {
    private int id;
    private String nombre;
    private BigDecimal precio;
    private int cantidad;
}
