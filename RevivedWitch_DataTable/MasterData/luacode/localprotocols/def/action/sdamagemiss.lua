-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sdamagemiss.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SDamageMiss = dataclass("SDamageMiss")
SDamageMiss.ProtocolType = 34
SDamageMiss.entityid = 0
SDamageMiss.damegetype = 0
SDamageMiss.Ctor = function(self, client)
  -- function num : 0_0
end

SDamageMiss.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.damegetype = self.damegetype
end

SDamageMiss.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.damegetype = data.damegetype
  return true
end

SDamageMiss.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.damegetype) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.damegetype) = %s. number required.", type(self.damegetype))
    return false
  end
  return true
end

return SDamageMiss

