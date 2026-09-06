local TimelineManager = CS.PixelNeko.P1.TimeLine.TimelineManager
local CSkySceneTimelineTable = BeanManager.GetTableByName("scene.cskyscenetimeline")
local CSpecialSceneTimeline = BeanManager.GetTableByName("scene.cspecialscenetimeline")
local SceneInfoTable = BeanManager.GetTableByName("scene.csceneinfostatic")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local PlayableDirectorStaticFunction = CS.PixelNeko.Lua.PlayableDirectorStaticFunctions
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local NavMeshStaticFunctions = CS.PixelNeko.Lua.NavMeshStaticFunctions
local SkySceneController = class("SkySceneController", SceneController)

function SkySceneController:Init()
  SkySceneController.super.Init(self)
  self._isTimelinePlayed = {}
  self._timelineInfoList = {}
  self:PlaySceneBGM()
  local sceneTimelineRecord = CSpecialSceneTimeline:GetRecorder(self:GetSceneID())
  if sceneTimelineRecord ~= nil then
    local timelineIDList = sceneTimelineRecord.timelineList
    local timelineDirectorList = {}
    for k, v in ipairs(timelineIDList) do
      local timelineInfo = CSkySceneTimelineTable:GetRecorder(v)
      if timelineInfo == nil then
        LogError("SkySceneController", "no timeline info with id : " .. v)
      else
        table.insert(self._timelineInfoList, timelineInfo)
        table.insert(self._isTimelinePlayed, false)
        local timeDirector = PlayableDirectorStaticFunction.Get(TransformStaticFunctions.GetChild(self._sceneRef:GetRootGameObject(), timelineInfo.timelineObj).gameObject)
        table.insert(timelineDirectorList, timeDirector)
      end
    end
    self._sceneRef:SetTimeLineDirectorList(timelineDirectorList)
  end
  self._rockerDialog = DialogManager.CreateSingletonDialog("dungeon.rockerdialog")
  LuaNotificationCenter.AddObserver(self, self.OnRockerMove, Common.n_RockerMove, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRockerEnd, Common.n_RockerEnd, nil)
  NavMeshStaticFunctions.AddNavAgent(self._sceneRef.actor.object)
end

function SkySceneController:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("dungeon.rockerdialog")
  self._rockerDialog = nil
end

function SkySceneController:PlaySceneBGM()
  local v = SceneInfoTable:GetRecorder(self:GetSceneID())
  if self._isDay or v.bgmNight == 0 then
    LuaAudioManager.PlayBGM(v.bgm)
  else
    LuaAudioManager.PlayBGM(v.bgmNight)
  end
end

function SkySceneController:Update(deltaTime, unscaleDeltaTime)
  SkySceneController.super.Update(self, deltaTime, unscaleDeltaTime)
  for k, v in ipairs(self._timelineInfoList) do
    if self._isTimelinePlayed[k] == false then
      self._isTimelinePlayed[k] = self:CheckInTrigger(k)
    end
  end
end

function SkySceneController:StopWalking()
  CS.PixelNeko.Lua.NavMeshStaticFunctions.StopWalking(self._sceneRef.actor.object)
end

function SkySceneController:MoveTowards(x, y, offset)
  CS.PixelNeko.Lua.NavMeshStaticFunctions.MoveTowards(self._sceneRef.actor.object, x, y, offset)
end

function SkySceneController:OnMouseButtonDown(x, y)
  CS.PixelNeko.Lua.NavMeshStaticFunctions.MoveToScreenPos(self._sceneRef.actor.object, x, y)
end

function SkySceneController:OnRockerMove(notification)
  local axisVector = notification.userInfo.axisVector
  if notification.userInfo.axisOffset > 0.01 then
    self:MoveTowards(axisVector.x, axisVector.y, notification.userInfo.axisOffset)
  end
end

function SkySceneController:OnRockerEnd(notification)
  self:StopWalking()
end

function SkySceneController:ResetRocker()
  self._rockerDialog:Mute()
  self._rockerDialog:UnMute()
end

function SkySceneController:CheckInTrigger(index)
  local timelineInfo = self._timelineInfoList[index]
  local topLeftX = timelineInfo.topLeftX
  local topLeftZ = timelineInfo.topLeftZ
  local bottonRightX = timelineInfo.bottonRightX
  local bottonRightZ = timelineInfo.bottonRightZ
  local pos = self._sceneRef.actor.object.transform.position
  if topLeftX < pos.x and bottonRightX > pos.x and bottonRightZ < pos.z and topLeftZ > pos.z then
    local timelineDirector = self._sceneRef:GetTimeLineDirectorList(index)
    timelineDirector:Play()
    return true
  end
  return false
end

return SkySceneController
