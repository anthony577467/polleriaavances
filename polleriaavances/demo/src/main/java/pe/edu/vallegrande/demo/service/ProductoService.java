package pe.edu.vallegrande.demo.service;

import pe.edu.vallegrande.demo.connection.SqlConnection;
import pe.edu.vallegrande.demo.dto.ProductoDTO;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoService {

    public List<ProductoDTO> getAllProd() {
        List<ProductoDTO> lista = new ArrayList<>();
        try (Connection cn = SqlConnection.getConnection();
             PreparedStatement pstm = cn.prepareStatement("SELECT ID, nombre, descripcion, precio, categoria, imagen, estado FROM producto");
             ResultSet rs = pstm.executeQuery()) {
            while (rs.next()) {
                ProductoDTO bean = new ProductoDTO();
                bean.setId(rs.getInt("ID"));
                bean.setNombre(rs.getString("nombre"));
                bean.setDescripcion(rs.getString("descripcion"));
                // Obtener el precio como BigDecimal
                BigDecimal precio = rs.getBigDecimal("precio");
                // Verificar si el valor del precio es nulo antes de asignarlo
                if (precio != null) {
                    bean.setPrecio(precio);
                }
                bean.setCategoria(rs.getString("categoria"));
                bean.setImagen(rs.getString("imagen"));
                bean.setEstado(rs.getString("estado"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
        return lista;
    }

    public ProductoDTO createProd(ProductoDTO bean) {
        Connection cn = null;
        PreparedStatement pstm;
        ResultSet rs;
        String sql;
        int id;
        sql = "INSERT INTO producto (nombre, descripcion, precio, categoria, imagen, estado) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            cn = SqlConnection.getConnection();
            cn.setAutoCommit(false);
            pstm = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstm.setString(1, bean.getNombre());
            pstm.setString(2, bean.getDescripcion());
            pstm.setBigDecimal(3, bean.getPrecio());
            pstm.setString(4, bean.getCategoria());
            pstm.setString(5, bean.getImagen());
            pstm.setString(6, bean.getEstado());

            int rows = pstm.executeUpdate();
            if (rows > 0) {
                rs = pstm.getGeneratedKeys();
                if (rs.next()) {
                    id = rs.getInt(1);
                    bean.setId(id);
                    System.out.println("El id es " + id);
                }
            }

            pstm.close();
            cn.commit();

        } catch (SQLException e) {
            if (cn != null) {
                try {
                    cn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw new RuntimeException(e.getMessage(), e);
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException e) {
                throw new RuntimeException(e.getMessage());
            }
        }
        return bean;
    }

    public ProductoDTO getByIdProd(int id) {
        ProductoDTO producto = null;
        try (Connection conn = SqlConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT ID, nombre, descripcion, precio, categoria, imagen, estado FROM producto WHERE ID = ?")) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    producto = new ProductoDTO();
                    producto.setId(rs.getInt("ID"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecio(rs.getBigDecimal("precio")); // Obtener el precio como BigDecimal
                    producto.setCategoria(rs.getString("categoria"));
                    producto.setImagen(rs.getString("imagen"));
                    producto.setEstado(rs.getString("estado"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener el producto por ID: " + e.getMessage());
        }
        return producto;
    }

    public void updateProd(ProductoDTO producto) {
        try (Connection conn = SqlConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("UPDATE producto SET Nombre = ?, Descripcion = ?, Precio = ?, categoria = ?, imagen = ?, estado = ? WHERE ID = ?")) {
            pstmt.setString(1, producto.getNombre());
            pstmt.setString(2, producto.getDescripcion());
            // Definir el precio como BigDecimal y establecer la precisión y la escala
            BigDecimal precio = new BigDecimal(String.valueOf(producto.getPrecio())).setScale(2, RoundingMode.HALF_UP);
            pstmt.setBigDecimal(3, precio);
            pstmt.setString(4, producto.getCategoria());
            pstmt.setString(5, producto.getImagen());
            pstmt.setString(6, producto.getEstado());
            pstmt.setInt(7, producto.getId());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<ProductoDTO> getAllActivosProd() {
        List<ProductoDTO> lista = new ArrayList<>();
        try (Connection cn = SqlConnection.getConnection();
             PreparedStatement pstm = cn.prepareStatement("SELECT ID, nombre, descripcion, precio, categoria, imagen, estado FROM producto WHERE estado = 'activo'");
             ResultSet rs = pstm.executeQuery()) {
            while (rs.next()) {
                ProductoDTO bean = new ProductoDTO();
                bean.setId(rs.getInt("ID"));
                bean.setNombre(rs.getString("nombre"));
                bean.setDescripcion(rs.getString("descripcion"));
                bean.setPrecio(rs.getBigDecimal("precio")); // Obtener el precio como BigDecimal
                bean.setCategoria(rs.getString("categoria"));
                bean.setImagen(rs.getString("imagen"));
                bean.setEstado(rs.getString("estado"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener los productos activos: " + e.getMessage());
        }
        return lista;
    }

    public List<ProductoDTO> getAllInactivoProd() {
        List<ProductoDTO> lista = new ArrayList<>();
        try (Connection cn = SqlConnection.getConnection();
             PreparedStatement pstm = cn.prepareStatement("SELECT ID, nombre, descripcion, precio, categoria, imagen, estado FROM producto WHERE estado = 'inactivo'");
             ResultSet rs = pstm.executeQuery()) {
            while (rs.next()) {
                ProductoDTO bean = new ProductoDTO();
                bean.setId(rs.getInt("ID"));
                bean.setNombre(rs.getString("nombre"));
                bean.setDescripcion(rs.getString("descripcion"));
                bean.setPrecio(rs.getBigDecimal("precio")); // Obtener el precio como BigDecimal
                bean.setCategoria(rs.getString("categoria"));
                bean.setImagen(rs.getString("imagen"));
                bean.setEstado(rs.getString("estado"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener los productos inactivos: " + e.getMessage());
        }
        return lista;
    }

    public void deleteProd(int id) {
        try (Connection conn = SqlConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("UPDATE producto SET estado = 'inactivo' WHERE id = ?")) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public void restaurarProd(int id) {
        try (Connection conn = SqlConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("UPDATE producto SET estado = 'activo' WHERE id = ?")) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }


}
