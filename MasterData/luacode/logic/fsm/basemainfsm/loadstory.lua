local dialog
local State = {}
local CStoryTimelineConfig = BeanManager.GetTableByName("timeline.cstorytimelineconfig")

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "LoadStory Enter")
  controller._baseMainFSM:SetBoolean("haveFSMHandleOrMainCityGuide", true)
  local storyId = controller._baseMainFSM:GetParameter("storyId")
  if storyId ~= 2002 then
    dialog = DialogManager.CreateSingletonDialog("storyloadingdialog")
  end
end

function State.Update(controller)
  local storyId = controller._baseMainFSM:GetParameter("storyId")
  if storyId ~= 2002 and dialog:IsCover() then
    controller:SetBaseCharActive(false)
    controller:CreateTimeline(storyId)
    local sceneUICamera = controller._sceneRef:GetSceneUICamera()
    if sceneUICamera then
      sceneUICamera:SetActive(false)
    end
    local uiDialog = DialogManager.GetDialog("base.basemainui")
    if uiDialog then
      uiDialog:Hide()
      uiDialog:GetRootWindow():SetActive(false)
    end
    uiDialog = DialogManager.GetDialog("base.basemainmenudialog")
    if uiDialog then
      uiDialog:GetRootWindow():SetActive(false)
    end
    uiDialog = DialogManager.GetDialog("base.baseinteractdialog")
    if uiDialog then
      uiDialog:GetRootWindow():SetActive(false)
    end
    controller._baseMainFSM:SetBoolean("toStory", true)
  end
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "LoadStory Exit")
  controller._baseMainFSM:SetBoolean("toStory", false)
  dialog = DialogManager.CreateSingletonDialog("storyloadingdialog")
  local recorder = CStoryTimelineConfig:GetRecorder(controller._baseMainFSM:GetParameter("storyId"))
  if recorder and recorder.BGM ~= -1 then
    LuaAudioManager.PlayBGM(recorder.BGM)
  end
end

return State
