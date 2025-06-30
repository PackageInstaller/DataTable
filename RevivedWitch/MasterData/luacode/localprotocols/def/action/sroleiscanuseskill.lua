-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sroleiscanuseskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SRoleIsCanUseSKill = dataclass("SRoleIsCanUseSKill")
SRoleIsCanUseSKill.ProtocolType = 36
SRoleIsCanUseSKill.entityid = 0
SRoleIsCanUseSKill.iscan = 0
SRoleIsCanUseSKill.Ctor = function(self, client)
  -- function num : 0_0
end

SRoleIsCanUseSKill.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.iscan = self.iscan
end

SRoleIsCanUseSKill.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.iscan = data.iscan
  return true
end

SRoleIsCanUseSKill.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.iscan) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.iscan) = %s. number required.", type(self.iscan))
    return false
  end
  return true
end

return SRoleIsCanUseSKill

