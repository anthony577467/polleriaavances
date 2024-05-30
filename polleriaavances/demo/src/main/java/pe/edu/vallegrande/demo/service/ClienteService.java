package pe.edu.vallegrande.demo.service;

import pe.edu.vallegrande.demo.connection.SqlConnection;
import pe.edu.vallegrande.demo.dto.ClienteDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteService {
    public List<ClienteDTO> getAll() {
        List<ClienteDTO> lista = new ArrayList<>();
        Connection cn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql;

        try {
            cn = SqlConnection.getConnection();
            sql = "SELECT id, nombres, apellidos, tipoDocumento, dniocarnet, telefono, correo, direccion, ubigeo, fechaNacimiento, activo FROM cliente_M WHERE activo = 1";
            pstm = cn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                ClienteDTO bean = new ClienteDTO();
                bean.setId(rs.getInt("id"));
                bean.setNombres(rs.getString("nombres"));
                bean.setApellidos(rs.getString("apellidos"));
                bean.setTipoDocumento(rs.getString("tipoDocumento"));
                bean.setDniocarnet(rs.getString("dniocarnet"));
                bean.setTelefono(rs.getString("telefono"));
                bean.setCorreo(rs.getString("correo"));
                bean.setDireccion(rs.getString("direccion"));
                bean.setUbigeo(rs.getString("ubigeo"));
                bean.setFechaNacimiento(rs.getString("fechaNacimiento"));
                bean.setActivo(rs.getString("activo"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstm != null) pstm.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return lista;
    }

    public List<ClienteDTO> getAllInactivos() {
        List<ClienteDTO> lista = new ArrayList<>();
        Connection cn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql;

        try {
            cn = SqlConnection.getConnection();
            sql = "SELECT id, nombres, apellidos, tipoDocumento, dniocarnet, telefono, correo, direccion, ubigeo, fechaNacimiento, activo FROM cliente_M WHERE activo = 0";
            pstm = cn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                ClienteDTO bean = new ClienteDTO();
                bean.setId(rs.getInt("id"));
                bean.setNombres(rs.getString("nombres"));
                bean.setApellidos(rs.getString("apellidos"));
                bean.setTipoDocumento(rs.getString("tipoDocumento"));
                bean.setDniocarnet(rs.getString("dniocarnet"));
                bean.setTelefono(rs.getString("telefono"));
                bean.setCorreo(rs.getString("correo"));
                bean.setDireccion(rs.getString("direccion"));
                bean.setUbigeo(rs.getString("ubigeo"));
                bean.setFechaNacimiento(rs.getString("fechaNacimiento"));
                bean.setActivo(rs.getString("activo"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstm != null) pstm.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return lista;
    }

    public ClienteDTO getById(int id) {
        ClienteDTO bean = null;
        Connection cn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql;

        try {
            cn = SqlConnection.getConnection();
            sql = "SELECT id, nombres, apellidos, tipoDocumento, dniocarnet, telefono, correo, direccion, ubigeo, fechaNacimiento, activo FROM cliente_M WHERE id = ?";
            pstm = cn.prepareStatement(sql);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                bean = new ClienteDTO();
                bean.setId(rs.getInt("id"));
                bean.setNombres(rs.getString("nombres"));
                bean.setApellidos(rs.getString("apellidos"));
                bean.setTipoDocumento(rs.getString("tipoDocumento"));
                bean.setDniocarnet(rs.getString("dniocarnet"));
                bean.setTelefono(rs.getString("telefono"));
                bean.setCorreo(rs.getString("correo"));
                bean.setDireccion(rs.getString("direccion"));
                bean.setUbigeo(rs.getString("ubigeo"));
                bean.setFechaNacimiento(rs.getString("fechaNacimiento"));
                bean.setActivo(rs.getString("activo"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstm != null) pstm.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return bean;
    }

    public int create(ClienteDTO bean) {
        Connection cn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql;
        int nuevoClienteId = 0;

        try {
            cn = SqlConnection.getConnection();
            sql = "INSERT INTO cliente_M (nombres, apellidos, tipoDocumento, dniocarnet, telefono, correo, direccion, ubigeo, fechaNacimiento, activo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstm = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstm.setString(1, bean.getNombres());
            pstm.setString(2, bean.getApellidos());
            pstm.setString(3, bean.getTipoDocumento());
            pstm.setString(4, bean.getDniocarnet());
            pstm.setString(5, bean.getTelefono());
            pstm.setString(6, bean.getCorreo());
            pstm.setString(7, bean.getDireccion());
            pstm.setString(8, bean.getUbigeo());
            pstm.setString(9, bean.getFechaNacimiento());
            pstm.setString(10, "1"); // Set activo to 1 by default

            pstm.executeUpdate();

            rs = pstm.getGeneratedKeys();
            if (rs.next()) {
                nuevoClienteId = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstm != null) pstm.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return nuevoClienteId;
    }


    public ClienteDTO update(ClienteDTO bean) {
        Connection cn = null;
        PreparedStatement pstm = null;
        String sql;

        try {
            cn = SqlConnection.getConnection();
            sql = "UPDATE cliente_M SET nombres = ?, apellidos = ?, tipoDocumento = ?, dniocarnet = ?, telefono = ?, correo = ?, direccion = ?, ubigeo = ?, fechaNacimiento = ?, activo = ? WHERE id = ?";
            pstm = cn.prepareStatement(sql);
            pstm.setString(1, bean.getNombres());
            pstm.setString(2, bean.getApellidos());
            pstm.setString(3, bean.getTipoDocumento());
            pstm.setString(4, bean.getDniocarnet());
            pstm.setString(5, bean.getTelefono());
            pstm.setString(6, bean.getCorreo());
            pstm.setString(7, bean.getDireccion());
            pstm.setString(8, bean.getUbigeo());
            pstm.setString(9, bean.getFechaNacimiento());
            pstm.setString(10, bean.getActivo());

            pstm.setInt(11, bean.getId());
            int rowsAffected = pstm.executeUpdate();
            if (rowsAffected == 0) {
                bean = null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstm != null) pstm.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return bean;
    }
    public ClienteDTO updateStatusToActive(int id) {
        Connection cn = null;
        PreparedStatement pstm = null;
        String sql;

        try {
            cn = SqlConnection.getConnection();
            sql = "UPDATE cliente_M SET activo = ? WHERE id = ?";
            pstm = cn.prepareStatement(sql);
            pstm.setString(1, "1"); // Cambiar el estado a activo (1)
            pstm.setInt(2, id);

            int rowsAffected = pstm.executeUpdate();
            if (rowsAffected == 0) {
                return null; // Si no se actualizó ninguna fila, devolver null
            } else {
                ClienteDTO updatedClient = getById(id); // Obtener el cliente actualizado para devolverlo
                return updatedClient;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            try {
                if (pstm != null) pstm.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean delete(int id) {
        Connection cn = null;
        PreparedStatement pstm = null;
        String sql;

        try {
            cn = SqlConnection.getConnection();
            sql = "UPDATE cliente_M SET activo = 0 WHERE id = ?";
            pstm = cn.prepareStatement(sql);
            pstm.setInt(1, id);
            int rowsAffected = pstm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (pstm != null) pstm.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
