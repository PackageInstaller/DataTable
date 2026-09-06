local SRoleSummonCreate = dataclass("SRoleSummonCreate")
SRoleSummonCreate.ProtocolType = 24
SRoleSummonCreate.entityid = 0
SRoleSummonCreate.fatherEntityId = 0
SRoleSummonCreate.Role = 1
SRoleSummonCreate.Monster = 2

function SRoleSummonCreate:Ctor(client)
  self.attribute = require("localprotocols.bean.data.attribute").Create()
end

function SRoleSummonCreate:Marshal(data)
  data.entityid = self.entityid
  data.attribute = {}
  self.attribute:Marshal(data.attribute)
  data.fatherEntityId = self.fatherEntityId
end

function SRoleSummonCreate:Unmarshal(data)
  self.entityid = data.entityid
  self.attribute = require("localprotocols.bean.data.attribute").Create()
  self.attribute:Unmarshal(data.attribute)
  self.fatherEntityId = data.fatherEntityId
  return true
end

function SRoleSummonCreate:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if not self.attribute:CheckVariable() then
    return false
  end
  if type(self.fatherEntityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.fatherEntityId) = %s. number required.", type(self.fatherEntityId))
    return false
  end
  return true
end

return SRoleSummonCreate
