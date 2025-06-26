-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/screatefixpointskillattackedinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SCreateFixPointSkillAttackedInfo = dataclass("SCreateFixPointSkillAttackedInfo")
SCreateFixPointSkillAttackedInfo.ProtocolType = 9
SCreateFixPointSkillAttackedInfo.entityId = 0
SCreateFixPointSkillAttackedInfo.skillId = 0
SCreateFixPointSkillAttackedInfo.damageFrom = 0
SCreateFixPointSkillAttackedInfo.damageNum = 0
SCreateFixPointSkillAttackedInfo.type = 0
SCreateFixPointSkillAttackedInfo.currentHp = 0
SCreateFixPointSkillAttackedInfo.isPost = 0
SCreateFixPointSkillAttackedInfo.isImaged = 0
SCreateFixPointSkillAttackedInfo.rad = 0
SCreateFixPointSkillAttackedInfo.isPlayHpBarAnimation = 0
SCreateFixPointSkillAttackedInfo.damageType = 0
SCreateFixPointSkillAttackedInfo.isPlayAttackedEffect = 0
SCreateFixPointSkillAttackedInfo.Ctor = function(self, client)
  -- function num : 0_0
end

SCreateFixPointSkillAttackedInfo.Marshal = function(self, data)
  -- function num : 0_1
  data.entityId = self.entityId
  data.skillId = self.skillId
  data.damageFrom = self.damageFrom
  data.damageNum = self.damageNum
  data.type = self.type
  data.currentHp = self.currentHp
  data.isPost = self.isPost
  data.isImaged = self.isImaged
  data.rad = self.rad
  data.isPlayHpBarAnimation = self.isPlayHpBarAnimation
  data.damageType = self.damageType
  data.isPlayAttackedEffect = self.isPlayAttackedEffect
end

SCreateFixPointSkillAttackedInfo.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityId = data.entityId
  self.skillId = data.skillId
  self.damageFrom = data.damageFrom
  self.damageNum = data.damageNum
  self.type = data.type
  self.currentHp = data.currentHp
  self.isPost = data.isPost
  self.isImaged = data.isImaged
  self.rad = data.rad
  self.isPlayHpBarAnimation = data.isPlayHpBarAnimation
  self.damageType = data.damageType
  self.isPlayAttackedEffect = data.isPlayAttackedEffect
  return true
end

SCreateFixPointSkillAttackedInfo.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.skillId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillId) = %s. number required.", type(self.skillId))
    return false
  end
  if type(self.damageFrom) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.damageFrom) = %s. number required.", type(self.damageFrom))
    return false
  end
  if type(self.damageNum) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.damageNum) = %s. number required.", type(self.damageNum))
    return false
  end
  if type(self.type) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.type) = %s. number required.", type(self.type))
    return false
  end
  if type(self.currentHp) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.currentHp) = %s. number required.", type(self.currentHp))
    return false
  end
  if type(self.isPost) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isPost) = %s. number required.", type(self.isPost))
    return false
  end
  if type(self.isImaged) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isImaged) = %s. number required.", type(self.isImaged))
    return false
  end
  if type(self.rad) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.rad) = %s. number required.", type(self.rad))
    return false
  end
  if type(self.isPlayHpBarAnimation) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isPlayHpBarAnimation) = %s. number required.", type(self.isPlayHpBarAnimation))
    return false
  end
  if type(self.damageType) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.damageType) = %s. number required.", type(self.damageType))
    return false
  end
  if type(self.isPlayAttackedEffect) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isPlayAttackedEffect) = %s. number required.", type(self.isPlayAttackedEffect))
    return false
  end
  return true
end

return SCreateFixPointSkillAttackedInfo

