package pe.edu.vallegrande.demo.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class OrdenDetallesDTO {
    private int id;
    private int amount;
    private double subtotal;
    private String paymentMethod;
    private int orderId;
}