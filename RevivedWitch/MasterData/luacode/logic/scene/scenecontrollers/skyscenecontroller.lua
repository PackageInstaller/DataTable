-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/skyscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TimelineManager = (((CS.PixelNeko).P1).TimeLine).TimelineManager
local CSkySceneTimelineTable = (BeanManager.GetTableByName)("scene.cskyscenetimeline")
local CSpecialSceneTimeline = (BeanManager.GetTableByName)("scene.cspecialscenetimeline")
local SceneInfoTable = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local PlayableDirectorStaticFunction = ((CS.PixelNeko).Lua).PlayableDirectorStaticFunctions
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local NavMeshStaticFunctions = ((CS.PixelNeko).Lua).NavMeshStaticFunctions
local SkySceneController = class("SkySceneController", SceneController)
SkySceneController.Init = function(self)
  -- function num : 0_0 , upvalues : SkySceneController, CSpecialSceneTimeline, _ENV, CSkySceneTimelineTable, PlayableDirectorStaticFunction, TransformStaticFunctions, NavMeshStaticFunctions
  ((SkySceneController.super).Init)(self)
  self._isTimelinePlayed = {}
  self._timelineInfoList = {}
  self:PlaySceneBGM()
  local sceneTimelineRecord = CSpecialSceneTimeline:GetRecorder(self:GetSceneID())
  if sceneTimelineRecord ~= nil then
    local timelineIDList = sceneTimelineRecord.timelineList
    local timelineDirectorList = {}
    for k,v in ipairs(timelineIDList) do
      local timelineInfo = CSkySceneTimelineTable:GetRecorder(v)
      if timelineInfo == nil then
        LogError("SkySceneController", "no timeline info with id : " .. v)
      else
        ;
        (table.insert)(self._timelineInfoList, timelineInfo)
        ;
        (table.insert)(self._isTimelinePlayed, false)
        local timeDirector = (PlayableDirectorStaticFunction.Get)(((TransformStaticFunctions.GetChild)((self._sceneRef):GetRootGameObject(), timelineInfo.timelineObj)).gameObject)
        ;
        (table.insert)(timelineDirectorList, timeDirector)
      end
    end
    ;
    (self._sceneRef):SetTimeLineDirectorList(timelineDirectorList)
  end
  do
    self._rockerDialog = (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
    ;
    (LuaNotificationCenter.AddObserver)(self, self.OnRockerMove, Common.n_RockerMove, nil)
    ;
    (LuaNotificationCenter.AddObserver)(self, self.OnRockerEnd, Common.n_RockerEnd, nil)
    ;
    (NavMeshStaticFunctions.AddNavAgent)(((self._sceneRef).actor).object)
  end
end

SkySceneController.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
  self._rockerDialog = nil
end

SkySceneController.PlaySceneBGM = function(self)
  -- function num : 0_2 , upvalues : SceneInfoTable, _ENV
  local v = SceneInfoTable:GetRecorder(self:GetSceneID())
  if self._isDay or v.bgmNight == 0 then
    (LuaAudioManager.PlayBGM)(v.bgm)
  else
    ;
    (LuaAudioManager.PlayBGM)(v.bgmNight)
  end
end

SkySceneController.Update = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_3 , upvalues : SkySceneController, _ENV
  ((SkySceneController.super).Update)(self, deltaTime, unscaleDeltaTime)
  for k,v in ipairs(self._timelineInfoList) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'

    if (self._isTimelinePlayed)[k] == false then
      (self._isTimelinePlayed)[k] = self:CheckInTrigger(k)
    end
  end
end

SkySceneController.StopWalking = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).StopWalking)(((self._sceneRef).actor).object)
end

SkySceneController.MoveTowards = function(self, x, y, offset)
  -- function num : 0_5 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).MoveTowards)(((self._sceneRef).actor).object, x, y, offset)
end

SkySceneController.OnMouseButtonDown = function(self, x, y)
  -- function num : 0_6 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).MoveToScreenPos)(((self._sceneRef).actor).object, x, y)
end

SkySceneController.OnRockerMove = function(self, notification)
  -- function num : 0_7
  local axisVector = (notification.userInfo).axisVector
  if (notification.userInfo).axisOffset > 0.01 then
    self:MoveTowards(axisVector.x, axisVector.y, (notification.userInfo).axisOffset)
  end
end

SkySceneController.OnRockerEnd = function(self, notification)
  -- function num : 0_8
  self:StopWalking()
end

SkySceneController.ResetRocker = function(self)
  -- function num : 0_9
  (self._rockerDialog):Mute()
  ;
  (self._rockerDialog):UnMute()
end

SkySceneController.CheckInTrigger = function(self, index)
  -- function num : 0_10
  local timelineInfo = (self._timelineInfoList)[index]
  local topLeftX = timelineInfo.topLeftX
  local topLeftZ = timelineInfo.topLeftZ
  local bottonRightX = timelineInfo.bottonRightX
  local bottonRightZ = timelineInfo.bottonRightZ
  local pos = ((((self._sceneRef).actor).object).transform).position
  do
    if topLeftX < pos.x and pos.x < bottonRightX and bottonRightZ < pos.z and pos.z < topLeftZ then
      local timelineDirector = (self._sceneRef):GetTimeLineDirectorList(index)
      timelineDirector:Play()
      return true
    end
    return false
  end
end

return SkySceneController

