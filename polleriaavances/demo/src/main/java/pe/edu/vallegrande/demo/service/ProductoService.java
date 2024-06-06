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
                BigDecimal precio = rs.getBigDecimal("precio");
                if (precio != null) {
                    bean.setPrecio(precio);
                }
                bean.setCategoria(rs.getString("categoria"));
                bean.setImagen(rs.getString("imagen"));
                bean.setEstado(rs.getString("estado"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener todos los productos: " + e.getMessage(), e);
        }
        return lista;
    }

    public ProductoDTO createProd(ProductoDTO bean) {
        String sql = "INSERT INTO producto (nombre, descripcion, precio, categoria, imagen, estado) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection cn = SqlConnection.getConnection();
             PreparedStatement pstm = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            cn.setAutoCommit(false);
            pstm.setString(1, bean.getNombre());
            pstm.setString(2, bean.getDescripcion());
            pstm.setBigDecimal(3, bean.getPrecio());
            pstm.setString(4, bean.getCategoria());
            pstm.setString(5, bean.getImagen());
            pstm.setString(6, bean.getEstado());

            int rows = pstm.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = pstm.getGeneratedKeys()) {
                    if (rs.next()) {
                        bean.setId(rs.getInt(1));
                        System.out.println("El id es " + rs.getInt(1));
                    }
                }
            }
            cn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            try (Connection cn = SqlConnection.getConnection()) {
                cn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            throw new RuntimeException("Error al crear el producto: " + e.getMessage(), e);
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
                    producto.setPrecio(rs.getBigDecimal("precio"));
                    producto.setCategoria(rs.getString("categoria"));
                    producto.setImagen(rs.getString("imagen"));
                    producto.setEstado(rs.getString("estado"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener el producto por ID: " + e.getMessage(), e);
        }
        return producto;
    }

    public void updateProd(ProductoDTO producto) {
        String sql = "UPDATE producto SET Nombre = ?, Descripcion = ?, Precio = ?, categoria = ?, imagen = ?, estado = ? WHERE ID = ?";
        try (Connection conn = SqlConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, producto.getNombre());
            pstmt.setString(2, producto.getDescripcion());
            BigDecimal precio = new BigDecimal(String.valueOf(producto.getPrecio())).setScale(2, RoundingMode.HALF_UP);
            pstmt.setBigDecimal(3, precio);
            pstmt.setString(4, producto.getCategoria());
            pstmt.setString(5, producto.getImagen());
            pstmt.setString(6, producto.getEstado());
            pstmt.setInt(7, producto.getId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error al actualizar el producto: " + e.getMessage(), e);
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
                bean.setPrecio(rs.getBigDecimal("precio"));
                bean.setCategoria(rs.getString("categoria"));
                bean.setImagen(rs.getString("imagen"));
                bean.setEstado(rs.getString("estado"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener los productos activos: " + e.getMessage(), e);
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
                bean.setPrecio(rs.getBigDecimal("precio"));
                bean.setCategoria(rs.getString("categoria"));
                bean.setImagen(rs.getString("imagen"));
                bean.setEstado(rs.getString("estado"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener los productos inactivos: " + e.getMessage(), e);
        }
        return lista;
    }

    public void deleteProdLog(int id) {
        String sql = "UPDATE producto SET estado = 'inactivo' WHERE id = ?";
        try (Connection conn = SqlConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
        } catch (SQLException e) {
            throw new RuntimeException("Error al eliminar el producto lógicamente: " + e.getMessage(), e);
        }
    }

    public void deletePoductoFis(int id) {
        String sql = "DELETE FROM producto WHERE id = ?";
        try (Connection conn = SqlConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error al eliminar el producto físicamente: " + e.getMessage(), e);
        }
    }

    public void restaurarProd(int id) {
        String sql = "UPDATE producto SET estado = 'activo' WHERE id = ?";
        try (Connection conn = SqlConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error al restaurar el producto: " + e.getMessage(), e);
        }
    }


}
