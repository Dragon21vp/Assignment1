/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ADMIN
 */
public class Role {
    private int RoleId;
    private String RoleName;

    public Role(int RoleId, String RoleName) {
        this.RoleId = RoleId;
        this.RoleName = RoleName;
    }

    public int getRoleId() {
        return RoleId;
    }

    public void setRoleId(int RoleId) {
        this.RoleId = RoleId;
    }

    public String getRoleName() {
        return RoleName;
    }

    public void setRoleName(String RoleName) {
        this.RoleName = RoleName;
    }

    @Override
    public String toString() {
        return "\nRole{" + "RoleId=" + RoleId + ", RoleName=" + RoleName + '}';
    }
    
    
    
}
