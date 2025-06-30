-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sskillpowercost.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SSkillPowerCost = dataclass("SSkillPowerCost")
SSkillPowerCost.ProtocolType = 6
SSkillPowerCost.entityid = 0
SSkillPowerCost.skillid = 0
SSkillPowerCost.redchange = 0
SSkillPowerCost.bluechange = 0
SSkillPowerCost.redcurrent = 0
SSkillPowerCost.bluecurrent = 0
SSkillPowerCost.breakoutPower = 0
SSkillPowerCost.breakoutPowerMax = 0
SSkillPowerCost.Ctor = function(self, client)
  -- function num : 0_0
end

SSkillPowerCost.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.skillid = self.skillid
  data.redchange = self.redchange
  data.bluechange = self.bluechange
  data.redcurrent = self.redcurrent
  data.bluecurrent = self.bluecurrent
  data.breakoutPower = self.breakoutPower
  data.breakoutPowerMax = self.breakoutPowerMax
end

SSkillPowerCost.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.skillid = data.skillid
  self.redchange = data.redchange
  self.bluechange = data.bluechange
  self.redcurrent = data.redcurrent
  self.bluecurrent = data.bluecurrent
  self.breakoutPower = data.breakoutPower
  self.breakoutPowerMax = data.breakoutPowerMax
  return true
end

SSkillPowerCost.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  if type(self.redchange) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.redchange) = %s. number required.", type(self.redchange))
    return false
  end
  if type(self.bluechange) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.bluechange) = %s. number required.", type(self.bluechange))
    return false
  end
  if type(self.redcurrent) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.redcurrent) = %s. number required.", type(self.redcurrent))
    return false
  end
  if type(self.bluecurrent) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.bluecurrent) = %s. number required.", type(self.bluecurrent))
    return false
  end
  if type(self.breakoutPower) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.breakoutPower) = %s. number required.", type(self.breakoutPower))
    return false
  end
  if type(self.breakoutPowerMax) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.breakoutPowerMax) = %s. number required.", type(self.breakoutPowerMax))
    return false
  end
  return true
end

return SSkillPowerCost

