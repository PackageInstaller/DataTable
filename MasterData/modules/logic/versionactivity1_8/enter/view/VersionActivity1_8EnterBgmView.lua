-- chunkname: @modules/logic/versionactivity1_8/enter/view/VersionActivity1_8EnterBgmView.lua

module("modules.logic.versionactivity1_8.enter.view.VersionActivity1_8EnterBgmView", package.seeall)

local VersionActivity1_8EnterBgmView = class("VersionActivity1_8EnterBgmView", BaseView)

function VersionActivity1_8EnterBgmView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8EnterBgmView:addEvents()
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivity1_8EnterBgmView:removeEvents()
	self.removeEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivity1_8EnterBgmView:_editableInitView()
	self:initActHandle()
end

function VersionActivity1_8EnterBgmView:initActHandle()
	self.actHandleDict = self.actHandleDict or {
		[BossRushConfig.instance:getActivityId()] = self._bossrushBgmHandle
	}
end

function VersionActivity1_8EnterBgmView:onOpen()
	if not self.viewParam.activitySettingList then
		local activitySettingList = {}
		local defaultIndex = VersionActivityEnterHelper.getTabIndex(activitySettingList, self.viewParam.jumpActId)
		local actSetting = activitySettingList[defaultIndex]
		local actId = VersionActivityEnterHelper.getActId(actSetting)

		self._isFirstOpenMainAct = actId == VersionActivity1_8Enum.ActivityId.Dungeon

		if self.viewParam.playVideo then
			self:modifyBgm(actId)
		end

		self._isFirstOpenMainAct = false
	end
end

function VersionActivity1_8EnterBgmView:onSelectActId(actId)
	self:modifyBgm(actId)
end

function VersionActivity1_8EnterBgmView:modifyBgm(actId)
	self._isMainAct = actId == VersionActivity1_8Enum.ActivityId.Dungeon

	local delayTime = 0

	if self._isMainAct then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_8Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		self.playingActId = nil
		self.bgmId = nil

		if self._isFirstOpenMainAct then
			self._isFirstOpenMainAct = false
			delayTime = 3.5

			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_8Enter.play_ui_jinye_open)
		else
			delayTime = 1

			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_8Enter.play_ui_jinye_unfold)
		end
	end

	self._actId = actId

	TaskDispatcher.cancelTask(self._doModifyBgm, self)
	TaskDispatcher.runDelay(self._doModifyBgm, self, delayTime)
end

function VersionActivity1_8EnterBgmView:_doModifyBgm()
	if not self.actHandleDict[self._actId] then
		-- block empty
	end
end

function VersionActivity1_8EnterBgmView:defaultBgmHandle(actId)
	if self.playingActId == actId then
		return
	end

	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	if bgmId == 0 then
		logError("actId : " .. tostring(actId) .. " 没有配置背景音乐")

		bgmId = AudioEnum.Bgm.Act1_8DungeonBgm
	end

	if not self._isMainAct and bgmId == self.bgmId then
		return
	end

	self.bgmId = bgmId

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_8Main, bgmId, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function VersionActivity1_8EnterBgmView:onClose()
	TaskDispatcher.cancelTask(self._doModifyBgm, self)
end

function VersionActivity1_8EnterBgmView:_bossrushBgmHandle(actId)
	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	if bgmId == 0 then
		bgmId = AudioEnum.Bgm.Activity128LevelViewBgm
	end

	self.playingActId = actId
	self.bgmId = bgmId

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_8Main, bgmId, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm, nil, nil, FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
end

return VersionActivity1_8EnterBgmView
