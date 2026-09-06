local BM_Role = class("BM_Role")

function BM_Role:Ctor()
  self._roleData = NekoData.Data.role
end

function BM_Role:GetRole(id)
  for i, onerole in ipairs(self._roleData) do
    if onerole.userid == id then
      return onerole
    end
  end
  return nil
end

return BM_Role
