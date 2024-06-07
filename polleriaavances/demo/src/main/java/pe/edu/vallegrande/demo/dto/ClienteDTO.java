package pe.edu.vallegrande.demo.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ClienteDTO {
    private int id;
    private String nombres;
    private String apellidos;
    private String tipoDocumento; // Nuevo campo
    private String dniocarnet;
    private String telefono;
    private String correo;
    private String direccion;
    private String ubigeo;
    private String fechaNacimiento; // Nuevo campo
    private String clave;
    private String rol;
    private String activo;
}
