local SUseSkill = dataclass("SUseSkill")
SUseSkill.ProtocolType = 14
SUseSkill.entityid = 0
SUseSkill.skillid = 0
SUseSkill.camp = 0
SUseSkill.isImaged = 0

function SUseSkill:Ctor(client)
end

function SUseSkill:Marshal(data)
  data.entityid = self.entityid
  data.skillid = self.skillid
  data.camp = self.camp
  data.isImaged = self.isImaged
end

function SUseSkill:Unmarshal(data)
  self.entityid = data.entityid
  self.skillid = data.skillid
  self.camp = data.camp
  self.isImaged = data.isImaged
  return true
end

function SUseSkill:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  if type(self.camp) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.camp) = %s. number required.", type(self.camp))
    return false
  end
  if type(self.isImaged) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isImaged) = %s. number required.", type(self.isImaged))
    return false
  end
  return true
end

return SUseSkill
