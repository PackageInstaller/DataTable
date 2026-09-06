local SPlayBattleCameraAnimationName = dataclass("SPlayBattleCameraAnimationName")
SPlayBattleCameraAnimationName.ProtocolType = 57
SPlayBattleCameraAnimationName.cameraMoveType = 0
SPlayBattleCameraAnimationName.moveDelayTime = 0
SPlayBattleCameraAnimationName.resetDelayTime = 0
SPlayBattleCameraAnimationName.skillId = 0

function SPlayBattleCameraAnimationName:Ctor(client)
end

function SPlayBattleCameraAnimationName:Marshal(data)
  data.cameraMoveType = self.cameraMoveType
  data.moveDelayTime = self.moveDelayTime
  data.resetDelayTime = self.resetDelayTime
  data.skillId = self.skillId
end

function SPlayBattleCameraAnimationName:Unmarshal(data)
  self.cameraMoveType = data.cameraMoveType
  self.moveDelayTime = data.moveDelayTime
  self.resetDelayTime = data.resetDelayTime
  self.skillId = data.skillId
  return true
end

function SPlayBattleCameraAnimationName:CheckVariable()
  if type(self.cameraMoveType) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.cameraMoveType) = %s. number required.", type(self.cameraMoveType))
    return false
  end
  if type(self.moveDelayTime) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.moveDelayTime) = %s. number required.", type(self.moveDelayTime))
    return false
  end
  if type(self.resetDelayTime) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.resetDelayTime) = %s. number required.", type(self.resetDelayTime))
    return false
  end
  if type(self.skillId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillId) = %s. number required.", type(self.skillId))
    return false
  end
  return true
end

return SPlayBattleCameraAnimationName
