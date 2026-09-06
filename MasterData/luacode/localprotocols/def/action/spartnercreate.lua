local SPartnerCreate = dataclass("SPartnerCreate")
SPartnerCreate.ProtocolType = 31
SPartnerCreate.entityid = 0

function SPartnerCreate:Ctor(client)
  self.attribute = require("localprotocols.bean.data.attribute").Create()
end

function SPartnerCreate:Marshal(data)
  data.entityid = self.entityid
  data.attribute = {}
  self.attribute:Marshal(data.attribute)
end

function SPartnerCreate:Unmarshal(data)
  self.entityid = data.entityid
  self.attribute = require("localprotocols.bean.data.attribute").Create()
  self.attribute:Unmarshal(data.attribute)
  return true
end

function SPartnerCreate:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if not self.attribute:CheckVariable() then
    return false
  end
  return true
end

return SPartnerCreate
