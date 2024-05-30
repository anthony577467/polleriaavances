package pe.edu.vallegrande.demo.test;

import pe.edu.vallegrande.demo.dto.ClienteDTO;
import pe.edu.vallegrande.demo.service.ClienteService;

import java.util.List;

public class Prueba {
    public static void main(String[] args) {
        ClienteService service = new ClienteService();
        List<ClienteDTO> lista = service.getAll();
        System.out.println(lista);
    }
}
