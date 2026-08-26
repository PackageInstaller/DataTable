-- chunkname: @modules/logic/versionactivity2_8/enter/view/VersionActivity2_8EnterBgmView.lua

module("modules.logic.versionactivity2_8.enter.view.VersionActivity2_8EnterBgmView", package.seeall)

local VersionActivity2_8EnterBgmView = class("VersionActivity2_8EnterBgmView", BaseView)

function VersionActivity2_8EnterBgmView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_8EnterBgmView:addEvents()
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
end

function VersionActivity2_8EnterBgmView:removeEvents()
	self.removeEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivity2_8EnterBgmView:_editableInitView()
	self:initActHandle()
end

function VersionActivity2_8EnterBgmView:initActHandle()
	self.actHandleDict = self.actHandleDict or {
		[VersionActivity2_8Enum.ActivityId.Dungeon] = self._dungeonBgmHandle,
		[VersionActivity2_8Enum.ActivityId.AutoChess] = self._autochessBgmHandle
	}
end

function VersionActivity2_8EnterBgmView:onOpen()
	if not self.viewParam.activitySettingList then
		local activitySettingList = {}
		local defaultIndex = VersionActivityEnterHelper.getTabIndex(activitySettingList, self.viewParam.jumpActId)
		local actSetting = activitySettingList[defaultIndex]
		local actId = VersionActivityEnterHelper.getActId(actSetting)

		self._isFirstOpenMainAct = actId == VersionActivity2_8Enum.ActivityId.Dungeon

		self:modifyBgm(actId)

		self._isFirstOpenMainAct = false
	end
end

function VersionActivity2_8EnterBgmView:onSelectActId(actId)
	self:modifyBgm(actId)
end

function VersionActivity2_8EnterBgmView:modifyBgm(actId)
	self._isMainAct = actId == VersionActivity2_8Enum.ActivityId.Dungeon

	local delayTime = 0

	if self._isMainAct then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity2_8Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		self.playingActId = nil
		self.bgmId = nil

		if self._isFirstOpenMainAct then
			self._isFirstOpenMainAct = false
			delayTime = 3.5

			AudioMgr.instance:trigger(AudioEnum2_8.VersionActivity2_8Enter.play_ui_jinye_open)
		else
			delayTime = 1

			AudioMgr.instance:trigger(AudioEnum2_8.VersionActivity2_8Enter.play_ui_jinye_unfold)
		end
	end

	self._actId = actId

	TaskDispatcher.cancelTask(self._doModifyBgm, self)
	TaskDispatcher.runDelay(self._doModifyBgm, self, delayTime)
end

function VersionActivity2_8EnterBgmView:_doModifyBgm()
	if not self.actHandleDict[self._actId] then
		-- block empty
	end
end

function VersionActivity2_8EnterBgmView:defaultBgmHandle(actId)
	if self.playingActId == actId then
		return
	end

	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	if bgmId == 0 then
		logError("actId : " .. tostring(actId) .. " 没有配置背景音乐")

		bgmId = AudioEnum.Bgm.Act2_0DungeonBgm
	end

	if not self._isMainAct and bgmId == self.bgmId then
		return
	end

	self.bgmId = bgmId

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_8Main)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_8Main, bgmId)
end

function VersionActivity2_8EnterBgmView:onClose()
	TaskDispatcher.cancelTask(self._doModifyBgm, self)
end

function VersionActivity2_8EnterBgmView:_reactivityBgmHandle(actId)
	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	self.bgmId = bgmId

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_8Main, "music_vocal_filter", "original")
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_8Main, bgmId)
end

function VersionActivity2_8EnterBgmView:_dungeonBgmHandle(actId)
	self.playingActId = actId
	self.bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_8Main)

	self._isFinishChapter = DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_10)

	if self._isFinishChapter then
		AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_8Main, "music_vocal_filter", "original")

		self.bgmId = AudioEnum2_8.DungeonBgm.enterView
	end

	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_8Main, self.bgmId)
end

function VersionActivity2_8EnterBgmView:_onUpdateDungeonInfo()
	if self.playingActId ~= VersionActivity2_8Enum.ActivityId.Dungeon then
		return
	end

	if self._isFinishChapter then
		return
	end

	if DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_10) then
		self:_dungeonBgmHandle(self.playingActId)
	end
end

function VersionActivity2_8EnterBgmView:_autochessBgmHandle(actId)
	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	self.bgmId = bgmId

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_8Main, "autochess", "prepare")
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_8Main, bgmId)
end

return VersionActivity2_8EnterBgmView
