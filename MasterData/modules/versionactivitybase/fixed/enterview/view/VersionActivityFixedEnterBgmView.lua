-- chunkname: @modules/versionactivitybase/fixed/enterview/view/VersionActivityFixedEnterBgmView.lua

module("modules.versionactivitybase.fixed.enterview.view.VersionActivityFixedEnterBgmView", package.seeall)

local VersionActivityFixedEnterBgmView = class("VersionActivityFixedEnterBgmView", BaseView)

function VersionActivityFixedEnterBgmView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityFixedEnterBgmView:addEvents()
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivityFixedEnterBgmView:removeEvents()
	self.removeEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivityFixedEnterBgmView:_editableInitView()
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	self:initActHandle()
end

function VersionActivityFixedEnterBgmView:initActHandle()
	self.actHandleDict = self.actHandleDict or {
		[BossRushConfig.instance:getActivityId()] = self._bossrushBgmHandle,
		[ChgController.instance:actId()] = self._chgBgmHandle
	}
end

function VersionActivityFixedEnterBgmView:onOpen()
	if not self.viewParam.activitySettingList then
		local activitySettingList = {}
		local defaultIndex = VersionActivityEnterHelper.getTabIndex(activitySettingList, self.viewParam.jumpActId)
		local actSetting = activitySettingList[defaultIndex]
		local actId = VersionActivityEnterHelper.getActId(actSetting)

		self._isFirstOpenMainAct = actId == VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion).ActivityId.Dungeon

		if not self.viewParam.isExitFight then
			self:modifyBgm(actId)
		end

		self._isFirstOpenMainAct = false
	end
end

function VersionActivityFixedEnterBgmView:onSelectActId(actId)
	self:modifyBgm(actId)
end

function VersionActivityFixedEnterBgmView:modifyBgm(actId)
	local enum = VersionActivityFixedHelper.getVersionActivityEnum()

	self._isMainAct = actId == enum.ActivityId.Dungeon

	local delayTime = 0

	if self._isMainAct then
		AudioBgmManager.instance:modifyAndPlay(VersionActivityFixedHelper.getVersionActivityAudioBgmLayer(), 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		self.playingActId = nil
		self.bgmId = nil

		if self._isFirstOpenMainAct then
			self._isFirstOpenMainAct = false
			delayTime = 3.5

			if enum.Audio and enum.Audio.FirstOpenDungeonTab then
				AudioMgr.instance:trigger(enum.Audio.FirstOpenDungeonTab)
			end
		else
			delayTime = 1

			if enum.Audio and enum.Audio.ReturnDungeonTab then
				AudioMgr.instance:trigger(enum.Audio.ReturnDungeonTab)
			end
		end
	end

	self._actId = actId

	TaskDispatcher.cancelTask(self._doModifyBgm, self)
	TaskDispatcher.runDelay(self._doModifyBgm, self, delayTime)
end

function VersionActivityFixedEnterBgmView:_doModifyBgm()
	if not self.actHandleDict[self._actId] then
		-- block empty
	end
end

function VersionActivityFixedEnterBgmView:defaultBgmHandle(actId)
	if self.playingActId == actId then
		return
	end

	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	if bgmId == 0 then
		logError("actId : " .. tostring(actId) .. " 没有配置背景音乐")

		bgmId = AudioEnum.Bgm.Act2_3DungeonBgm
	end

	if not self._isMainAct and bgmId == self.bgmId then
		return
	end

	self.bgmId = bgmId

	AudioBgmManager.instance:setSwitchData(VersionActivityFixedHelper.getVersionActivityAudioBgmLayer())
	AudioBgmManager.instance:modifyBgmAudioId(VersionActivityFixedHelper.getVersionActivityAudioBgmLayer(), bgmId)
end

function VersionActivityFixedEnterBgmView:onClose()
	TaskDispatcher.cancelTask(self._doModifyBgm, self)
end

function VersionActivityFixedEnterBgmView:_bossrushBgmHandle(actId)
	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	self.bgmId = bgmId

	AudioBgmManager.instance:setSwitchData(VersionActivityFixedHelper.getVersionActivityAudioBgmLayer(), FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
	AudioBgmManager.instance:modifyBgmAudioId(VersionActivityFixedHelper.getVersionActivityAudioBgmLayer(), bgmId)
end

function VersionActivityFixedEnterBgmView:_chgBgmHandle(actId)
	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	self.bgmId = bgmId

	AudioBgmManager.instance:setSwitchData(VersionActivityFixedHelper.getVersionActivityAudioBgmLayer(), FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Fightnormal)
	AudioBgmManager.instance:modifyBgmAudioId(VersionActivityFixedHelper.getVersionActivityAudioBgmLayer(), bgmId)
end

function VersionActivityFixedEnterBgmView:_reactivityBgmHandle(actId)
	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	self.bgmId = bgmId

	AudioBgmManager.instance:setSwitchData(VersionActivityFixedHelper.getVersionActivityAudioBgmLayer(), "music_vocal_filter", "original")
	AudioBgmManager.instance:modifyBgmAudioId(VersionActivityFixedHelper.getVersionActivityAudioBgmLayer(), bgmId)
end

return VersionActivityFixedEnterBgmView
