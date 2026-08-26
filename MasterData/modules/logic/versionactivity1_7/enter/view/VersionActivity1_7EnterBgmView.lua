-- chunkname: @modules/logic/versionactivity1_7/enter/view/VersionActivity1_7EnterBgmView.lua

module("modules.logic.versionactivity1_7.enter.view.VersionActivity1_7EnterBgmView", package.seeall)

local VersionActivity1_7EnterBgmView = class("VersionActivity1_7EnterBgmView", BaseView)

function VersionActivity1_7EnterBgmView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_7EnterBgmView:addEvents()
	return
end

function VersionActivity1_7EnterBgmView:removeEvents()
	return
end

function VersionActivity1_7EnterBgmView:_editableInitView()
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivity1_7EnterBgmView:onOpen()
	local defaultIndex = VersionActivityEnterHelper.getTabIndex(self.viewParam.activityIdList, self.viewParam.jumpActId)
	local actId = VersionActivityEnterHelper.getActId(self.viewParam.activityIdList[defaultIndex])

	self._isFirstOpenMainAct = actId == VersionActivity1_7Enum.ActivityId.Dungeon

	self:modifyBgm(actId)

	self._isFirstOpenMainAct = false
end

function VersionActivity1_7EnterBgmView:onSelectActId(actId)
	self:modifyBgm(actId)
end

function VersionActivity1_7EnterBgmView:initActHandle()
	self.actHandleDict = self.actHandleDict or {
		[VersionActivity1_7Enum.ActivityId.BossRush] = self.playBossRushBgm
	}
end

function VersionActivity1_7EnterBgmView:modifyBgm(actId)
	self._isMainAct = actId == VersionActivity1_7Enum.ActivityId.Dungeon

	local delayTime = 0

	if self._isMainAct then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_7Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		if self._isFirstOpenMainAct then
			self._isFirstOpenMainAct = false
			delayTime = 3.5

			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Enter.play_ui_jinye_open)
		else
			delayTime = 1

			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Enter.play_ui_jinye_unfold)
		end
	end

	self._actId = actId

	TaskDispatcher.cancelTask(self._delayModifyBgm, self)
	TaskDispatcher.runDelay(self._delayModifyBgm, self, delayTime)
end

function VersionActivity1_7EnterBgmView:_delayModifyBgm()
	self:_doModifyBgm(self._actId)
end

function VersionActivity1_7EnterBgmView:_doModifyBgm(actId)
	self:initActHandle()

	local modifyFunc = self.actHandleDict[actId]

	modifyFunc = modifyFunc or self.defaultBgmHandle

	modifyFunc(self, actId)
end

function VersionActivity1_7EnterBgmView:defaultBgmHandle(actId)
	if self.playingActId == actId then
		return
	end

	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	if bgmId == 0 then
		logError("actId : " .. tostring(actId) .. " 没有配置背景音乐")

		bgmId = AudioEnum.Bgm.Act1_7DungeonBgm
	end

	if bgmId == self.bgmId and not self._isMainAct then
		return
	end

	self.bgmId = bgmId

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_7Main, bgmId, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function VersionActivity1_7EnterBgmView:playBossRushBgm(actId)
	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	self.bgmId = bgmId

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_7Main, bgmId, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm, nil, nil, FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
end

function VersionActivity1_7EnterBgmView:onClose()
	TaskDispatcher.cancelTask(self._delayModifyBgm, self)
end

return VersionActivity1_7EnterBgmView
