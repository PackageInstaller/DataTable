-- chunkname: @modules/logic/versionactivity1_2/yaxian/define/YaXianEvent.lua

module("modules.logic.versionactivity1_2.yaxian.define.YaXianEvent", package.seeall)

local YaXianEvent = _M

YaXianEvent.InteractObjectCreated = 1
YaXianEvent.ShowCanWalkGround = 2
YaXianEvent.UpdateRound = 3
YaXianEvent.OnGameVictory = 4
YaXianEvent.OnGameFail = 5
YaXianEvent.OnStateFinish = 6
YaXianEvent.OnInteractFinish = 7
YaXianEvent.MainResLoadDone = 8
YaXianEvent.RefreshAllInteractAlertArea = 9
YaXianEvent.QuitGame = 10
YaXianEvent.DeleteInteractObj = 11
YaXianEvent.OnUpdateSkillInfo = 12
YaXianEvent.OnUpdateEffectInfo = 13
YaXianEvent.OnSelectInteract = 14
YaXianEvent.OnCancelSelectInteract = 15
YaXianEvent.OnRevert = 16
YaXianEvent.RefreshInteractStatus = 17
YaXianEvent.RefreshInteractPath = 18
YaXianEvent.OnInteractLoadDone = 19
YaXianEvent.OnResetView = 20
YaXianEvent.SetInteractObjActive = 21
YaXianEvent.GuideClickTile = 22
YaXianEvent.OnGameLoadDone = 100
YaXianEvent.OnSelectChapterChange = 200
YaXianEvent.OnUpdateEpisodeInfo = 201
YaXianEvent.OnUpdateBonus = 202
YaXianEvent.OnPlayingClickAnimationValueChange = 203

return YaXianEvent
