local SCreateSceneEffect = dataclass("SCreateSceneEffect")
SCreateSceneEffect.ProtocolType = 25
SCreateSceneEffect.effectid = 0
SCreateSceneEffect.posX = 0
SCreateSceneEffect.posY = 0
SCreateSceneEffect.posZ = 0
SCreateSceneEffect.rad = 0
SCreateSceneEffect.camp = 0

function SCreateSceneEffect:Ctor(client)
end

function SCreateSceneEffect:Marshal(data)
  data.effectid = self.effectid
  data.posX = self.posX
  data.posY = self.posY
  data.posZ = self.posZ
  data.rad = self.rad
  data.camp = self.camp
end

function SCreateSceneEffect:Unmarshal(data)
  self.effectid = data.effectid
  self.posX = data.posX
  self.posY = data.posY
  self.posZ = data.posZ
  self.rad = data.rad
  self.camp = data.camp
  return true
end

function SCreateSceneEffect:CheckVariable()
  if type(self.effectid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.effectid) = %s. number required.", type(self.effectid))
    return false
  end
  if type(self.posX) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.posX) = %s. number required.", type(self.posX))
    return false
  end
  if type(self.posY) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.posY) = %s. number required.", type(self.posY))
    return false
  end
  if type(self.posZ) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.posZ) = %s. number required.", type(self.posZ))
    return false
  end
  if type(self.rad) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.rad) = %s. number required.", type(self.rad))
    return false
  end
  if type(self.camp) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.camp) = %s. number required.", type(self.camp))
    return false
  end
  return true
end

return SCreateSceneEffect
