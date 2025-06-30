-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guide.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cGuideLinkConfing = (BeanManager.GetTableByName)("guide.cguidelinkconfig")
local Guide = class("Guide")
local Stage = require("logic.guide.stage")
Guide.Status = {NotStarted = 0, Doing = 1, Finished = 2}
local SetStage = function(self)
  -- function num : 0_0 , upvalues : cGuideLinkConfing, _ENV, Stage, Guide
  local guideInfo = cGuideLinkConfing:GetRecorder(self._id)
  if guideInfo == nil then
    LogError("Guide", "guide id error")
    return 
  end
  self._isWeakGuide = guideInfo.guideType ~= 1
  self._stageNum = 0
  for i,v in ipairs(guideInfo.stage) do
    local stage = (Stage.Create)(i, v, self._id)
    ;
    (table.insert)(self._stageList, stage)
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self._stageTable)[i] = stage
    self._stageNum = self._stageNum + 1
  end
  self._status = (Guide.Status).NotStarted
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

local HandleStage = function(self)
  -- function num : 0_1 , upvalues : Guide, Stage, _ENV
  if self._status == (Guide.Status).Doing and self._stageNum > 0 then
    if self._isWeakGuide then
      for i = 1, self._stageNum do
        local stage = (self._stageList)[i]
        stage:Play()
      end
    else
      do
        local playIndex = nil
        for i = 1, self._stageNum do
          if ((self._stageList)[i]):GetStatus() == (Stage.Status).NotStarted then
            playIndex = i
            break
          end
        end
        do
          if playIndex then
            local stage = (self._stageList)[playIndex]
            LogInfoFormat("Guide", "HandleStage guideId = %s, stageId = %s", self._id, playIndex)
            stage:Play()
          end
        end
      end
    end
  end
end

local OnGuideStageFinished = function(self, notification)
  -- function num : 0_2 , upvalues : Guide, HandleStage
  if self._status == (Guide.Status).Doing and self:IsCurrentStage((notification.userInfo).stageID) then
    HandleStage(self)
  end
end

Guide.Ctor = function(self, id)
  -- function num : 0_3 , upvalues : SetStage
  self._id = id
  self._stageList = {}
  self._stageTable = {}
  SetStage(self)
end

Guide.Destroy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in ipairs(self._stageList) do
    v:Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

Guide.GetID = function(self)
  -- function num : 0_5
  return self._id
end

Guide.IsCurrentStage = function(self, stageID)
  -- function num : 0_6 , upvalues : Stage
  local stage = (self._stageList)[stageID]
  if stage == nil then
    return false
  end
  do return (((self._stageList)[stageID + 1] and ((self._stageList)[stageID + 1]):GetStatus() == (Stage.Status).NotStarted) or not (self._stageList)[stageID + 1]) and stage:GetStatus() ~= (Stage.Status).NotStarted end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Guide.Play = function(self)
  -- function num : 0_7 , upvalues : _ENV, Guide, OnGuideStageFinished, HandleStage
  LogInfoFormat("Guide", "--- Play id = %s ---", self._id)
  self._status = (Guide.Status).Doing
  if not self._triggerStage then
    self._triggerStage = true
    ;
    (LuaNotificationCenter.AddObserver)(self, OnGuideStageFinished, Common.n_GuideStageFinished, nil)
  end
  HandleStage(self)
end

Guide.Cancle = function(self)
  -- function num : 0_8 , upvalues : _ENV, Stage, Guide
  LogInfoFormat("Guide", "--- CancleGuideId = %s ---", self._id)
  for k,v in ipairs(self._stageList) do
    -- DECOMPILER ERROR at PC19: Unhandled construct in 'MakeBoolean' P1

    if not self._isWeakGuide and v:GetStatus() ~= (Stage.Status).Finished then
      v:Reset()
      break
    end
    v:Reset()
  end
  do
    self._status = (Guide.Status).NotStarted
    ;
    (LuaNotificationCenter.RemoveObserver)(self)
  end
end

Guide.Finished = function(self)
  -- function num : 0_9 , upvalues : _ENV, Guide
  LogInfoFormat("Guide", "--- Finished id = %s ---", self._id)
  for k,v in ipairs(self._stageList) do
    v:Destroy()
  end
  self._status = (Guide.Status).Finished
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

return Guide

