local SPerformSkill = dataclass("SPerformSkill")
SPerformSkill.ProtocolType = 4
SPerformSkill.entityId = 0
SPerformSkill.skilleffectid = 0
SPerformSkill.rad = 0

function SPerformSkill:Ctor(client)
end

function SPerformSkill:Marshal(data)
  data.entityId = self.entityId
  data.skilleffectid = self.skilleffectid
  data.rad = self.rad
end

function SPerformSkill:Unmarshal(data)
  self.entityId = data.entityId
  self.skilleffectid = data.skilleffectid
  self.rad = data.rad
  return true
end

function SPerformSkill:CheckVariable()
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.skilleffectid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skilleffectid) = %s. number required.", type(self.skilleffectid))
    return false
  end
  if type(self.rad) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.rad) = %s. number required.", type(self.rad))
    return false
  end
  return true
end

return SPerformSkill
