local cGuideLinkConfing = BeanManager.GetTableByName("guide.cguidelinkconfig")
local Guide = class("Guide")
local Stage = require("logic.guide.stage")
Guide.Status = {
  NotStarted = 0,
  Doing = 1,
  Finished = 2
}

local function SetStage(self)
  local guideInfo = cGuideLinkConfing:GetRecorder(self._id)
  if guideInfo == nil then
    LogError("Guide", "guide id error")
    return
  end
  self._isWeakGuide = guideInfo.guideType ~= 1
  self._stageNum = 0
  for i, v in ipairs(guideInfo.stage) do
    local stage = Stage.Create(i, v, self._id)
    table.insert(self._stageList, stage)
    self._stageTable[i] = stage
    self._stageNum = self._stageNum + 1
  end
  self._status = Guide.Status.NotStarted
end

local function HandleStage(self)
  if self._status == Guide.Status.Doing and self._stageNum > 0 then
    if self._isWeakGuide then
      for i = 1, self._stageNum do
        local stage = self._stageList[i]
        stage:Play()
      end
    else
      local playIndex
      for i = 1, self._stageNum do
        if self._stageList[i]:GetStatus() == Stage.Status.NotStarted then
          playIndex = i
          break
        end
      end
      if playIndex then
        local stage = self._stageList[playIndex]
        LogInfoFormat("Guide", "HandleStage guideId = %s, stageId = %s", self._id, playIndex)
        stage:Play()
      end
    end
  end
end

local function OnGuideStageFinished(self, notification)
  if self._status == Guide.Status.Doing and self:IsCurrentStage(notification.userInfo.stageID) then
    HandleStage(self)
  end
end

function Guide:Ctor(id)
  self._id = id
  self._stageList = {}
  self._stageTable = {}
  SetStage(self)
end

function Guide:Destroy()
  for k, v in ipairs(self._stageList) do
    v:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function Guide:GetID()
  return self._id
end

function Guide:IsCurrentStage(stageID)
  local stage = self._stageList[stageID]
  if stage == nil then
    return false
  end
  return (self._stageList[stageID + 1] and self._stageList[stageID + 1]:GetStatus() == Stage.Status.NotStarted or not self._stageList[stageID + 1]) and stage:GetStatus() ~= Stage.Status.NotStarted
end

function Guide:Play()
  LogInfoFormat("Guide", "--- Play id = %s ---", self._id)
  self._status = Guide.Status.Doing
  if not self._triggerStage then
    self._triggerStage = true
    LuaNotificationCenter.AddObserver(self, OnGuideStageFinished, Common.n_GuideStageFinished, nil)
  end
  HandleStage(self)
end

function Guide:Cancle()
  LogInfoFormat("Guide", "--- CancleGuideId = %s ---", self._id)
  for k, v in ipairs(self._stageList) do
    if not self._isWeakGuide then
      if v:GetStatus() ~= Stage.Status.Finished then
        v:Reset()
        break
      end
    else
      v:Reset()
    end
  end
  self._status = Guide.Status.NotStarted
  LuaNotificationCenter.RemoveObserver(self)
end

function Guide:Finished()
  LogInfoFormat("Guide", "--- Finished id = %s ---", self._id)
  for k, v in ipairs(self._stageList) do
    v:Destroy()
  end
  self._status = Guide.Status.Finished
  LuaNotificationCenter.RemoveObserver(self)
end

return Guide
