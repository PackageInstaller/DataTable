-- chunkname: @modules/logic/mainsceneswitch/controller/MainSceneSwitchEvent.lua

module("modules.logic.mainsceneswitch.controller.MainSceneSwitchEvent", package.seeall)

local MainSceneSwitchEvent = _M

MainSceneSwitchEvent.BeforeStartSwitchScene = GameUtil.getEventId()
MainSceneSwitchEvent.StartSwitchScene = GameUtil.getEventId()
MainSceneSwitchEvent.SwitchSceneFinish = GameUtil.getEventId()
MainSceneSwitchEvent.SwitchSceneInitFinish = GameUtil.getEventId()
MainSceneSwitchEvent.CloseSwitchSceneLoading = GameUtil.getEventId()
MainSceneSwitchEvent.SwitchSceneFinishStory = GameUtil.getEventId()
MainSceneSwitchEvent.ClickSwitchItem = GameUtil.getEventId()
MainSceneSwitchEvent.SwitchCategoryClick = GameUtil.getEventId()
MainSceneSwitchEvent.SceneSwitchUIVisible = GameUtil.getEventId()
MainSceneSwitchEvent.PreviewSceneSwitchUIVisible = GameUtil.getEventId()
MainSceneSwitchEvent.ShowSceneInfo = GameUtil.getEventId()
MainSceneSwitchEvent.ShowPreviewSceneInfo = GameUtil.getEventId()
MainSceneSwitchEvent.ForceShowSceneTab = GameUtil.getEventId()

return MainSceneSwitchEvent
