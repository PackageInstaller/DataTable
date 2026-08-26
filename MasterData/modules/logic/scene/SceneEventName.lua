-- chunkname: @modules/logic/scene/SceneEventName.lua

module("modules.logic.scene.SceneEventName", package.seeall)

local SceneEventName = {}

SceneEventName.EnterScene = 9900
SceneEventName.EnterSceneFinish = 9901
SceneEventName.ExitScene = 9902
SceneEventName.OnLevelLoaded = 9903
SceneEventName.OpenLoading = 9904
SceneEventName.CloseLoading = 9905
SceneEventName.AgainOpenLoading = 9906
SceneEventName.DelayCloseLoading = 9907
SceneEventName.StopLoading = 9908
SceneEventName.WaitViewOpenCloseLoading = 9909
SceneEventName.SetLoadingTypeOnce = 9910
SceneEventName.WaitCloseHeadsetView = 9911
SceneEventName.ShowDownloadInfo = 9912
SceneEventName.SetManualClose = 9913
SceneEventName.ManualClose = 9914
SceneEventName.LoadingAnimEnd = 9915
SceneEventName.SceneGoChangeVisible = 9916
SceneEventName.CanCloseLoading = 9917

return SceneEventName
