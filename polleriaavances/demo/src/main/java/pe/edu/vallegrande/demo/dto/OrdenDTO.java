package pe.edu.vallegrande.demo.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class OrdenDTO {
    private int id;
    private double totalPrice;
    private String locationDelivery;
    private String date;
    private int localOrDelivery;
    private int deliveryId;
    private int clientId;
}
