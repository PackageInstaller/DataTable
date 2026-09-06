local SCreateBuffEffect = dataclass("SCreateBuffEffect")
SCreateBuffEffect.ProtocolType = 21
SCreateBuffEffect.entityid = 0
SCreateBuffEffect.point = ""
SCreateBuffEffect.packagename = ""
SCreateBuffEffect.effectname = ""
SCreateBuffEffect.isImaged = 0
SCreateBuffEffect.rad = 0

function SCreateBuffEffect:Ctor(client)
end

function SCreateBuffEffect:Marshal(data)
  data.entityid = self.entityid
  data.point = self.point
  data.packagename = self.packagename
  data.effectname = self.effectname
  data.isImaged = self.isImaged
  data.rad = self.rad
end

function SCreateBuffEffect:Unmarshal(data)
  self.entityid = data.entityid
  self.point = data.point
  self.packagename = data.packagename
  self.effectname = data.effectname
  self.isImaged = data.isImaged
  self.rad = data.rad
  return true
end

function SCreateBuffEffect:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.point) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.point) = %s. string required.", type(self.point))
    return false
  end
  if type(self.packagename) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.packagename) = %s. string required.", type(self.packagename))
    return false
  end
  if type(self.effectname) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.effectname) = %s. string required.", type(self.effectname))
    return false
  end
  if type(self.isImaged) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isImaged) = %s. number required.", type(self.isImaged))
    return false
  end
  if type(self.rad) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.rad) = %s. number required.", type(self.rad))
    return false
  end
  return true
end

return SCreateBuffEffect
