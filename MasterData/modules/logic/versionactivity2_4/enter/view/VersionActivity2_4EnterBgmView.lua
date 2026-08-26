-- chunkname: @modules/logic/versionactivity2_4/enter/view/VersionActivity2_4EnterBgmView.lua

module("modules.logic.versionactivity2_4.enter.view.VersionActivity2_4EnterBgmView", package.seeall)

local VersionActivity2_4EnterBgmView = class("VersionActivity2_4EnterBgmView", BaseView)

function VersionActivity2_4EnterBgmView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4EnterBgmView:addEvents()
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivity2_4EnterBgmView:removeEvents()
	self.removeEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivity2_4EnterBgmView:_editableInitView()
	self:initActHandle()
end

function VersionActivity2_4EnterBgmView:initActHandle()
	self.actHandleDict = self.actHandleDict or {
		[BossRushConfig.instance:getActivityId()] = self._bossrushBgmHandle
	}
end

function VersionActivity2_4EnterBgmView:onOpen()
	if not self.viewParam.activitySettingList then
		local activitySettingList = {}
		local defaultIndex = VersionActivityEnterHelper.getTabIndex(activitySettingList, self.viewParam.jumpActId)
		local actSetting = activitySettingList[defaultIndex]
		local actId = VersionActivityEnterHelper.getActId(actSetting)

		self._isFirstOpenMainAct = actId == VersionActivity2_4Enum.ActivityId.Dungeon

		self:modifyBgm(actId)

		self._isFirstOpenMainAct = false
	end
end

function VersionActivity2_4EnterBgmView:onSelectActId(actId)
	self:modifyBgm(actId)
end

function VersionActivity2_4EnterBgmView:modifyBgm(actId)
	self._isMainAct = actId == VersionActivity2_4Enum.ActivityId.Dungeon

	local delayTime = 0

	if self._isMainAct then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity2_4Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		self.playingActId = nil
		self.bgmId = nil

		if self._isFirstOpenMainAct then
			self._isFirstOpenMainAct = false
			delayTime = 3.5
		else
			delayTime = 1
		end
	end

	self._actId = actId

	TaskDispatcher.cancelTask(self._doModifyBgm, self)
	TaskDispatcher.runDelay(self._doModifyBgm, self, delayTime)
end

function VersionActivity2_4EnterBgmView:_doModifyBgm()
	if not self.actHandleDict[self._actId] then
		-- block empty
	end
end

function VersionActivity2_4EnterBgmView:defaultBgmHandle(actId)
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

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_4Main)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_4Main, bgmId)
end

function VersionActivity2_4EnterBgmView:onClose()
	TaskDispatcher.cancelTask(self._doModifyBgm, self)
end

function VersionActivity2_4EnterBgmView:_bossrushBgmHandle(actId)
	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	self.bgmId = bgmId

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_4Main, FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_4Main, bgmId)
end

return VersionActivity2_4EnterBgmView
