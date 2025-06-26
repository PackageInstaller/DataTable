-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sdestroybuffeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SDestroyBuffEffect = dataclass("SDestroyBuffEffect")
SDestroyBuffEffect.ProtocolType = 22
SDestroyBuffEffect.entityid = 0
SDestroyBuffEffect.point = ""
SDestroyBuffEffect.effectname = ""
SDestroyBuffEffect.Ctor = function(self, client)
  -- function num : 0_0
end

SDestroyBuffEffect.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.point = self.point
  data.effectname = self.effectname
end

SDestroyBuffEffect.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.point = data.point
  self.effectname = data.effectname
  return true
end

SDestroyBuffEffect.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.point) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.point) = %s. string required.", type(self.point))
    return false
  end
  if type(self.effectname) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.effectname) = %s. string required.", type(self.effectname))
    return false
  end
  return true
end

return SDestroyBuffEffect

