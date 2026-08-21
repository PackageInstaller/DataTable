-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/spartnercreate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SPartnerCreate = dataclass("SPartnerCreate")
SPartnerCreate.ProtocolType = 31
SPartnerCreate.entityid = 0
SPartnerCreate.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : _ENV
  self.attribute = ((require("localprotocols.bean.data.attribute")).Create)()
end

SPartnerCreate.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.attribute = {}
  ;
  (self.attribute):Marshal(data.attribute)
end

SPartnerCreate.Unmarshal = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.entityid = data.entityid
  self.attribute = ((require("localprotocols.bean.data.attribute")).Create)()
  ;
  (self.attribute):Unmarshal(data.attribute)
  return true
end

SPartnerCreate.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if not (self.attribute):CheckVariable() then
    return false
  end
  return true
end

return SPartnerCreate

