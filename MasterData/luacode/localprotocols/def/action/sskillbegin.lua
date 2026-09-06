local SSkillBegin = dataclass("SSkillBegin")
SSkillBegin.ProtocolType = 44
SSkillBegin.entityid = 0
SSkillBegin.skillid = 0
SSkillBegin.type = 0
SSkillBegin.lasttime = 0
SSkillBegin.skillattr = 0

function SSkillBegin:Ctor(client)
end

function SSkillBegin:Marshal(data)
  data.entityid = self.entityid
  data.skillid = self.skillid
  data.type = self.type
  data.lasttime = self.lasttime
  data.skillattr = self.skillattr
end

function SSkillBegin:Unmarshal(data)
  self.entityid = data.entityid
  self.skillid = data.skillid
  self.type = data.type
  self.lasttime = data.lasttime
  self.skillattr = data.skillattr
  return true
end

function SSkillBegin:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  if type(self.type) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.type) = %s. number required.", type(self.type))
    return false
  end
  if type(self.lasttime) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.lasttime) = %s. number required.", type(self.lasttime))
    return false
  end
  if type(self.skillattr) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillattr) = %s. number required.", type(self.skillattr))
    return false
  end
  return true
end

return SSkillBegin
