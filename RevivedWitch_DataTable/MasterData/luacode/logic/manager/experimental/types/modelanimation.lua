-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/modelanimation.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local CSkillAnimation = (BeanManager.GetTableByName)("skill.cskillanimation")
local AnimationType = {None = 0, OneAttackAction = 1, ThreeAnimationAction = 2}
local FixPerFrameTime = 0.033333333333333
local ModelAnimation = strictclass("ModelAnimation")
ModelAnimation.Ctor = function(self, modelPrefabName, modelObj)
  -- function num : 0_0 , upvalues : _ENV
  self._modelObj = modelObj
  self._frapData = require("data.battledata.npcshapeanimationdata." .. (string.lower)(modelPrefabName))
  self:ClearState()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Update, Common.n_Update, nil)
end

ModelAnimation.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._modelObj = nil
  self._frapData = nil
  self:ClearState()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

ModelAnimation.ClearState = function(self)
  -- function num : 0_2
  self._loopTime = -1
  self._endAnima = ""
  self._needUpdate = false
  self._timeCount = 0
end

ModelAnimation.PlaySkill = function(self, skillId)
  -- function num : 0_3 , upvalues : CSkillAnimation, AnimationType, AnimationHelper, _ENV
  self:ClearState()
  local animationRecord = CSkillAnimation:GetRecorder(skillId)
  if animationRecord then
    if animationRecord.actionType == AnimationType.ThreeAnimationAction then
      local frapDataSkillStart = (self._frapData)[animationRecord.skillStart]
      if frapDataSkillStart then
        (AnimationHelper.PlayAnimation)(self._modelObj, animationRecord.skillStart)
        local startEndFrames = frapDataSkillStart.endEventFrames
        self._loopTime = startEndFrames + tonumber(animationRecord.loopTime)
        self._endAnima = animationRecord.skillEnd
        self._needUpdate = true
      end
    else
      do
        if animationRecord.actionType == AnimationType.OneAttackAction then
          (AnimationHelper.PlayAnimation)(self._modelObj, animationRecord.actionAtk)
        else
          LogErrorFormat("ModelAnimation", "Illegal actionType %d in skillId %d!", animationRecord.actionType, skillId)
        end
        LogErrorFormat("ModelAnimation", "AnimationRecord not found in skillId %d!", skillId)
      end
    end
  end
end

ModelAnimation.Update = function(self, notification)
  -- function num : 0_4 , upvalues : FixPerFrameTime
  if not self._needUpdate then
    return 
  end
  local deltaTime = (notification.userInfo).deltaTime
  local unscaledDeltaTime = (notification.userInfo).unscaledDeltaTime
  self._timeCount = self._timeCount + deltaTime
  while FixPerFrameTime <= self._timeCount do
    self._timeCount = self._timeCount - FixPerFrameTime
    self:LogicUpdate()
  end
end

ModelAnimation.LogicUpdate = function(self)
  -- function num : 0_5 , upvalues : AnimationHelper
  if self._loopTime > 0 then
    self._loopTime = self._loopTime - 1
  else
    ;
    (AnimationHelper.PlayAnimation)(self._modelObj, self._endAnima)
    self:ClearState()
  end
end

ModelAnimation.SetSkillList = function(self, skillList)
  -- function num : 0_6 , upvalues : _ENV
  self._skillList = {}
  for index,value in ipairs(skillList) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    (self._skillList)[index] = value
  end
  self._skillListKey = nil
end

ModelAnimation.PlaySkillCyclically = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self._skillList == nil then
    return 
  end
  local skillIdVal = nil
  repeat
    self._skillListKey = next(self._skillList, self._skillListKey)
  until self._skillListKey ~= nil
  self:PlaySkill(skillIdVal)
end

return ModelAnimation

