-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/supdatebosshpstage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SUpdateBossHpStage = dataclass("SUpdateBossHpStage")
SUpdateBossHpStage.ProtocolType = 62
SUpdateBossHpStage.entityId = 0
SUpdateBossHpStage.Ctor = function(self, client)
  -- function num : 0_0
  self.bosshpstage = {}
end

SUpdateBossHpStage.Marshal = function(self, data)
  -- function num : 0_1 , upvalues : _ENV
  data.entityId = self.entityId
  data.bosshpstage = {}
  for index,value in ipairs(self.bosshpstage) do
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R7 in 'UnsetPending'

    (data.bosshpstage)[index] = {}
    ;
    ((self.bosshpstage)[index]):Marshal((data.bosshpstage)[index])
  end
end

SUpdateBossHpStage.Unmarshal = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.entityId = data.entityId
  for index,value in ipairs(data.bosshpstage) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

    (self.bosshpstage)[index] = ((require("localprotocols.bean.int")).Create)()
    ;
    ((self.bosshpstage)[index]):Unmarshal((data.bosshpstage)[index])
  end
  return true
end

SUpdateBossHpStage.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.bosshpstage) ~= "table" then
    LogErrorFormat("LocalProtocols", "type error!type(self.bosshpstage) = %s. table required.", type(self.bosshpstage))
    return false
  end
  for index,value in ipairs(self.bosshpstage) do
    if type(R7_PC34) ~= "number" then
      LogErrorFormat(R7_PC34, "type error!type(self.bosshpstage -> value) = %s. number required.", type(R10_PC42))
      return false
    end
  end
  return true
end

return SUpdateBossHpStage

