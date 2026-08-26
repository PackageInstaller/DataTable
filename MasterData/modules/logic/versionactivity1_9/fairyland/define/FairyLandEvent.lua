-- chunkname: @modules/logic/versionactivity1_9/fairyland/define/FairyLandEvent.lua

module("modules.logic.versionactivity1_9.fairyland.define.FairyLandEvent", package.seeall)

local FairyLandEvent = _M

FairyLandEvent.UpdateInfo = 1000
FairyLandEvent.ResolveSuccess = 1010
FairyLandEvent.SetStairPos = 1020
FairyLandEvent.SceneLoadFinish = 1030
FairyLandEvent.DialogFinish = 1040
FairyLandEvent.ElementFinish = 1050
FairyLandEvent.ElementLoadFinish = 1060
FairyLandEvent.SetSceneUpdatePos = 1070
FairyLandEvent.ShowDialogView = 1080
FairyLandEvent.DoStairAnim = 1090
FairyLandEvent.CloseDialogView = 1100
FairyLandEvent.SetTextBgVisible = 1110
FairyLandEvent.OnMoveEnd = 1120
FairyLandEvent.GuideLatestElementFinish = 1901
FairyLandEvent.GuideLatestPuzzleFinish = 1902

return FairyLandEvent
