-- chunkname: @modules/logic/versionactivity1_9/enter/view/VersionActivity1_9EnterBgmView.lua

module("modules.logic.versionactivity1_9.enter.view.VersionActivity1_9EnterBgmView", package.seeall)

local VersionActivity1_9EnterBgmView = class("VersionActivity1_9EnterBgmView", BaseView)

function VersionActivity1_9EnterBgmView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_9EnterBgmView:addEvents()
	return
end

function VersionActivity1_9EnterBgmView:removeEvents()
	return
end

function VersionActivity1_9EnterBgmView:_editableInitView()
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivity1_9EnterBgmView:onOpen()
	local defaultIndex = VersionActivityEnterHelper.getTabIndex(self.viewParam.activityIdList, self.viewParam.jumpActId)
	local actId = VersionActivityEnterHelper.getActId(self.viewParam.activityIdList[defaultIndex])

	self._isFirstOpenMainAct = actId == VersionActivity1_9Enum.ActivityId.Dungeon

	self:modifyBgm(actId)

	self._isFirstOpenMainAct = false
end

function VersionActivity1_9EnterBgmView:onSelectActId(actId)
	self:modifyBgm(actId)
end

function VersionActivity1_9EnterBgmView:initActHandle()
	self.actHandleDict = self.actHandleDict or {
		[VersionActivity1_9Enum.ActivityId.BossRush] = self.playBossRushBgm
	}
end

function VersionActivity1_9EnterBgmView:modifyBgm(actId)
	self._isMainAct = actId == VersionActivity1_9Enum.ActivityId.Dungeon

	local delayTime = 0

	if self._isMainAct then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_9Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		self.playingActId = nil
		self.bgmId = nil

		if self._isFirstOpenMainAct then
			self._isFirstOpenMainAct = false
			delayTime = 3.5

			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_9Enter.play_ui_jinye_open)
		else
			delayTime = 1

			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_9Enter.play_ui_jinye_unfold)
		end
	end

	self._actId = actId

	TaskDispatcher.cancelTask(self._delayModifyBgm, self)
	TaskDispatcher.runDelay(self._delayModifyBgm, self, delayTime)
end

function VersionActivity1_9EnterBgmView:_delayModifyBgm()
	self:_doModifyBgm(self._actId)
end

function VersionActivity1_9EnterBgmView:_doModifyBgm(actId)
	self:initActHandle()

	local modifyFunc = self.actHandleDict[actId]

	modifyFunc = modifyFunc or self.defaultBgmHandle

	modifyFunc(self, actId)
end

function VersionActivity1_9EnterBgmView:defaultBgmHandle(actId)
	if self.playingActId == actId then
		return
	end

	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	if bgmId == 0 then
		logError("actId : " .. tostring(actId) .. " 没有配置背景音乐")

		bgmId = AudioEnum.Bgm.Act1_9DungeonBgm
	end

	if bgmId == self.bgmId and not self._isMainAct then
		return
	end

	self.bgmId = bgmId

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity1_9Main)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity1_9Main, bgmId)
end

function VersionActivity1_9EnterBgmView:playBossRushBgm(actId)
	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	self.bgmId = bgmId

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity1_9Main, FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity1_9Main, bgmId)
end

function VersionActivity1_9EnterBgmView:onClose()
	TaskDispatcher.cancelTask(self._delayModifyBgm, self)
end

return VersionActivity1_9EnterBgmView
