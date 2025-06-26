-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/loadstory.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local dialog = nil
local State = {}
local CStoryTimelineConfig = (BeanManager.GetTableByName)("timeline.cstorytimelineconfig")
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, dialog
  LogInfo("BaseMainFSM", "LoadStory Enter")
  ;
  (controller._baseMainFSM):SetBoolean("haveFSMHandleOrMainCityGuide", true)
  local storyId = (controller._baseMainFSM):GetParameter("storyId")
  if storyId ~= 2002 then
    dialog = (DialogManager.CreateSingletonDialog)("storyloadingdialog")
  end
end

State.Update = function(controller)
  -- function num : 0_1 , upvalues : dialog, _ENV
  local storyId = (controller._baseMainFSM):GetParameter("storyId")
  if storyId ~= 2002 and dialog:IsCover() then
    controller:SetBaseCharActive(false)
    controller:CreateTimeline(storyId)
    local sceneUICamera = (controller._sceneRef):GetSceneUICamera()
    if sceneUICamera then
      sceneUICamera:SetActive(false)
    end
    local uiDialog = (DialogManager.GetDialog)("base.basemainui")
    if uiDialog then
      uiDialog:Hide()
      ;
      (uiDialog:GetRootWindow()):SetActive(false)
    end
    uiDialog = (DialogManager.GetDialog)("base.basemainmenudialog")
    if uiDialog then
      (uiDialog:GetRootWindow()):SetActive(false)
    end
    uiDialog = (DialogManager.GetDialog)("base.baseinteractdialog")
    if uiDialog then
      (uiDialog:GetRootWindow()):SetActive(false)
    end
    ;
    (controller._baseMainFSM):SetBoolean("toStory", true)
  end
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, dialog, CStoryTimelineConfig
  LogInfo("BaseMainFSM", "LoadStory Exit")
  ;
  (controller._baseMainFSM):SetBoolean("toStory", false)
  dialog = (DialogManager.CreateSingletonDialog)("storyloadingdialog")
  local recorder = CStoryTimelineConfig:GetRecorder((controller._baseMainFSM):GetParameter("storyId"))
  if recorder and recorder.BGM ~= -1 then
    (LuaAudioManager.PlayBGM)(recorder.BGM)
  end
end

return State

