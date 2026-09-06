local DM_Role = class("DM_Role")

function DM_Role:Ctor()
  self._roleData = NekoData.Data.role
end

function DM_Role:SetRole(role)
  table.insert(self._roleData, role)
end

return DM_Role
