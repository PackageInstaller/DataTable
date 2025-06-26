-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sshoworderpowerspecialuieffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SShowOrderPowerSpecialUIEffect = dataclass("SShowOrderPowerSpecialUIEffect")
SShowOrderPowerSpecialUIEffect.ProtocolType = 58
SShowOrderPowerSpecialUIEffect.effectType = 0
SShowOrderPowerSpecialUIEffect.powerGridIndex = 0
SShowOrderPowerSpecialUIEffect.Ctor = function(self, client)
  -- function num : 0_0
end

SShowOrderPowerSpecialUIEffect.Marshal = function(self, data)
  -- function num : 0_1
  data.effectType = self.effectType
  data.powerGridIndex = self.powerGridIndex
end

SShowOrderPowerSpecialUIEffect.Unmarshal = function(self, data)
  -- function num : 0_2
  self.effectType = data.effectType
  self.powerGridIndex = data.powerGridIndex
  return true
end

SShowOrderPowerSpecialUIEffect.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.effectType) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.effectType) = %s. number required.", type(self.effectType))
    return false
  end
  if type(self.powerGridIndex) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.powerGridIndex) = %s. number required.", type(self.powerGridIndex))
    return false
  end
  return true
end

return SShowOrderPowerSpecialUIEffect

