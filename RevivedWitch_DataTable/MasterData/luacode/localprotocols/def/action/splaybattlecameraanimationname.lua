-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/splaybattlecameraanimationname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SPlayBattleCameraAnimationName = dataclass("SPlayBattleCameraAnimationName")
SPlayBattleCameraAnimationName.ProtocolType = 57
SPlayBattleCameraAnimationName.cameraMoveType = 0
SPlayBattleCameraAnimationName.moveDelayTime = 0
SPlayBattleCameraAnimationName.resetDelayTime = 0
SPlayBattleCameraAnimationName.skillId = 0
SPlayBattleCameraAnimationName.Ctor = function(self, client)
  -- function num : 0_0
end

SPlayBattleCameraAnimationName.Marshal = function(self, data)
  -- function num : 0_1
  data.cameraMoveType = self.cameraMoveType
  data.moveDelayTime = self.moveDelayTime
  data.resetDelayTime = self.resetDelayTime
  data.skillId = self.skillId
end

SPlayBattleCameraAnimationName.Unmarshal = function(self, data)
  -- function num : 0_2
  self.cameraMoveType = data.cameraMoveType
  self.moveDelayTime = data.moveDelayTime
  self.resetDelayTime = data.resetDelayTime
  self.skillId = data.skillId
  return true
end

SPlayBattleCameraAnimationName.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
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

