-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sdestroyeffectbyname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SDestroyEffectByName = dataclass("SDestroyEffectByName")
SDestroyEffectByName.ProtocolType = 43
SDestroyEffectByName.camp = 0
SDestroyEffectByName.effectname = ""
SDestroyEffectByName.Ctor = function(self, client)
  -- function num : 0_0
end

SDestroyEffectByName.Marshal = function(self, data)
  -- function num : 0_1
  data.camp = self.camp
  data.effectname = self.effectname
end

SDestroyEffectByName.Unmarshal = function(self, data)
  -- function num : 0_2
  self.camp = data.camp
  self.effectname = data.effectname
  return true
end

SDestroyEffectByName.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.camp) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.camp) = %s. number required.", type(self.camp))
    return false
  end
  if type(self.effectname) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.effectname) = %s. string required.", type(self.effectname))
    return false
  end
  return true
end

return SDestroyEffectByName

