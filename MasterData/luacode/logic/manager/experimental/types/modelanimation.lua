local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local CSkillAnimation = BeanManager.GetTableByName("skill.cskillanimation")
local AnimationType = {
  None = 0,
  OneAttackAction = 1,
  ThreeAnimationAction = 2
}
local FixPerFrameTime = 0.03333333333333333
local ModelAnimation = strictclass("ModelAnimation")

function ModelAnimation:Ctor(modelPrefabName, modelObj)
  self._modelObj = modelObj
  self._frapData = require("data.battledata.npcshapeanimationdata." .. string.lower(modelPrefabName))
  self:ClearState()
  LuaNotificationCenter.AddObserver(self, self.Update, Common.n_Update, nil)
end

function ModelAnimation:Destroy()
  self._modelObj = nil
  self._frapData = nil
  self:ClearState()
  LuaNotificationCenter.RemoveObserver(self)
end

function ModelAnimation:ClearState()
  self._loopTime = -1
  self._endAnima = ""
  self._needUpdate = false
  self._timeCount = 0
end

function ModelAnimation:PlaySkill(skillId)
  self:ClearState()
  local animationRecord = CSkillAnimation:GetRecorder(skillId)
  if animationRecord then
    if animationRecord.actionType == AnimationType.ThreeAnimationAction then
      local frapDataSkillStart = self._frapData[animationRecord.skillStart]
      if frapDataSkillStart then
        AnimationHelper.PlayAnimation(self._modelObj, animationRecord.skillStart)
        local startEndFrames = frapDataSkillStart.endEventFrames
        self._loopTime = startEndFrames + tonumber(animationRecord.loopTime)
        self._endAnima = animationRecord.skillEnd
        self._needUpdate = true
      end
    elseif animationRecord.actionType == AnimationType.OneAttackAction then
      AnimationHelper.PlayAnimation(self._modelObj, animationRecord.actionAtk)
    else
      LogErrorFormat("ModelAnimation", "Illegal actionType %d in skillId %d!", animationRecord.actionType, skillId)
    end
  else
    LogErrorFormat("ModelAnimation", "AnimationRecord not found in skillId %d!", skillId)
  end
end

function ModelAnimation:Update(notification)
  if not self._needUpdate then
    return
  end
  local deltaTime = notification.userInfo.deltaTime
  local unscaledDeltaTime = notification.userInfo.unscaledDeltaTime
  self._timeCount = self._timeCount + deltaTime
  while self._timeCount >= FixPerFrameTime do
    self._timeCount = self._timeCount - FixPerFrameTime
    self:LogicUpdate()
  end
end

function ModelAnimation:LogicUpdate()
  if self._loopTime > 0 then
    self._loopTime = self._loopTime - 1
  else
    AnimationHelper.PlayAnimation(self._modelObj, self._endAnima)
    self:ClearState()
  end
end

function ModelAnimation:SetSkillList(skillList)
  self._skillList = {}
  for index, value in ipairs(skillList) do
    self._skillList[index] = value
  end
  self._skillListKey = nil
end

function ModelAnimation:PlaySkillCyclically()
  if self._skillList == nil then
    return
  end
  local skillIdVal
  repeat
    self._skillListKey, skillIdVal = next(self._skillList, self._skillListKey)
  until self._skillListKey ~= nil
  self:PlaySkill(skillIdVal)
end

return ModelAnimation
