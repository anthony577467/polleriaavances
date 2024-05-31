package pe.edu.vallegrande.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ProductoDTO {
    private int id;
    private String nombre;
    private String descripcion;
    private BigDecimal precio;
    private String categoria;
    private String imagen;
    private String estado;
}
