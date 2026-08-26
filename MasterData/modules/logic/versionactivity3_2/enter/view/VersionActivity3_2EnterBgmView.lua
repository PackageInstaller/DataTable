-- chunkname: @modules/logic/versionactivity3_2/enter/view/VersionActivity3_2EnterBgmView.lua

module("modules.logic.versionactivity3_2.enter.view.VersionActivity3_2EnterBgmView", package.seeall)

local VersionActivity3_2EnterBgmView = class("VersionActivity3_2EnterBgmView", VersionActivityFixedEnterBgmView)

function VersionActivity3_2EnterBgmView:initActHandle()
	self.actHandleDict = self.actHandleDict or {
		[BossRushConfig.instance:getActivityId()] = self._bossrushBgmHandle,
		[VersionActivity3_2Enum.ActivityId.Reactivity] = self._reactivityBgmHandle,
		[VersionActivity3_2Enum.ActivityId.AutoChess] = self._autochessBgmHandle
	}
end

function VersionActivity3_2EnterBgmView:defaultBgmHandle(actId)
	VersionActivity3_2EnterBgmView.super.defaultBgmHandle(self, actId)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.SwitchBGM, actId)
end

function VersionActivity3_2EnterBgmView:_autochessBgmHandle(actId)
	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	self.bgmId = bgmId

	local bgmLayer = VersionActivityFixedHelper.getVersionActivityAudioBgmLayer()

	AudioBgmManager.instance:setSwitchData(bgmLayer, "autochess", "prepare")
	AudioBgmManager.instance:modifyBgmAudioId(bgmLayer, bgmId)
end

return VersionActivity3_2EnterBgmView
