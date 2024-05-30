package pe.edu.vallegrande.demo.test;

import pe.edu.vallegrande.demo.connection.SqlConnection;

import java.sql.SQLException;

public class PruebaConexion {

    public static void main(String[] args) throws SQLException {
        SqlConnection.getConnection();
        System.out.println("Conexion exitosa");

    }
}
