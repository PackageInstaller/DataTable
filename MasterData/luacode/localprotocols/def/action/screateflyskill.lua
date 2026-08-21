-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/screateflyskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SCreateFlySkill = dataclass("SCreateFlySkill")
SCreateFlySkill.ProtocolType = 8
SCreateFlySkill.entityId = 0
SCreateFlySkill.playerEntityId = 0
SCreateFlySkill.effectid = 0
SCreateFlySkill.posX = 0
SCreateFlySkill.posY = 0
SCreateFlySkill.posZ = 0
SCreateFlySkill.rad = 0
SCreateFlySkill.isImaged = 0
SCreateFlySkill.Ctor = function(self, client)
  -- function num : 0_0
end

SCreateFlySkill.Marshal = function(self, data)
  -- function num : 0_1
  data.entityId = self.entityId
  data.playerEntityId = self.playerEntityId
  data.effectid = self.effectid
  data.posX = self.posX
  data.posY = self.posY
  data.posZ = self.posZ
  data.rad = self.rad
  data.isImaged = self.isImaged
end

SCreateFlySkill.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityId = data.entityId
  self.playerEntityId = data.playerEntityId
  self.effectid = data.effectid
  self.posX = data.posX
  self.posY = data.posY
  self.posZ = data.posZ
  self.rad = data.rad
  self.isImaged = data.isImaged
  return true
end

SCreateFlySkill.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.playerEntityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.playerEntityId) = %s. number required.", type(self.playerEntityId))
    return false
  end
  if type(self.effectid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.effectid) = %s. number required.", type(self.effectid))
    return false
  end
  if type(self.posX) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.posX) = %s. number required.", type(self.posX))
    return false
  end
  if type(self.posY) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.posY) = %s. number required.", type(self.posY))
    return false
  end
  if type(self.posZ) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.posZ) = %s. number required.", type(self.posZ))
    return false
  end
  if type(self.rad) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.rad) = %s. number required.", type(self.rad))
    return false
  end
  if type(self.isImaged) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isImaged) = %s. number required.", type(self.isImaged))
    return false
  end
  return true
end

return SCreateFlySkill

