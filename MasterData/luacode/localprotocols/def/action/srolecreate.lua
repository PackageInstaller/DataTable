local SRoleCreate = dataclass("SRoleCreate")
SRoleCreate.ProtocolType = 1
SRoleCreate.entityid = 0
SRoleCreate.type = 0
SRoleCreate.isinitial = 0
SRoleCreate.Role = 1
SRoleCreate.Monster = 2

function SRoleCreate:Ctor(client)
  self.attribute = require("localprotocols.bean.data.attribute").Create()
  self.buffs = {}
end

function SRoleCreate:Marshal(data)
  data.entityid = self.entityid
  data.type = self.type
  data.attribute = {}
  self.attribute:Marshal(data.attribute)
  for key, value in pairs(self.buffs) do
    data.buffs[key] = {}
    self.buffs[key]:Marshal(data.buffs[key])
  end
  data.isinitial = self.isinitial
end

function SRoleCreate:Unmarshal(data)
  self.entityid = data.entityid
  self.type = data.type
  self.attribute = require("localprotocols.bean.data.attribute").Create()
  self.attribute:Unmarshal(data.attribute)
  for key, value in pairs(data.buffs) do
    self.buffs[key] = require("localprotocols.bean.data.buff").Create()
    self.buffs[key]:Unmarshal(data.buffs[key])
  end
  self.isinitial = data.isinitial
  return true
end

function SRoleCreate:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.type) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.type) = %s. number required.", type(self.type))
    return false
  end
  if not self.attribute:CheckVariable() then
    return false
  end
  if type(self.buffs) ~= "table" then
    LogErrorFormat("LocalProtocols", "type error!type(self.buffs) = %s. table required.", type(self.buffs))
    return false
  end
  for key, value in pairs(self.buffs) do
    if type(key) ~= "number" then
      LogErrorFormat("LocalProtocols", "type error!type(self.buffs -> key) = %s. number required.", type(key))
      return false
    end
    if not value:CheckVariable() then
      return false
    end
  end
  if type(self.isinitial) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isinitial) = %s. number required.", type(self.isinitial))
    return false
  end
  return true
end

return SRoleCreate
