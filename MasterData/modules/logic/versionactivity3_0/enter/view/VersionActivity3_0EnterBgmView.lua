-- chunkname: @modules/logic/versionactivity3_0/enter/view/VersionActivity3_0EnterBgmView.lua

module("modules.logic.versionactivity3_0.enter.view.VersionActivity3_0EnterBgmView", package.seeall)

local VersionActivity3_0EnterBgmView = class("VersionActivity3_0EnterBgmView", BaseView)

function VersionActivity3_0EnterBgmView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_0EnterBgmView:addEvents()
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivity3_0EnterBgmView:removeEvents()
	self.removeEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivity3_0EnterBgmView:_editableInitView()
	self:initActHandle()
end

function VersionActivity3_0EnterBgmView:initActHandle()
	self.actHandleDict = self.actHandleDict or {}
end

function VersionActivity3_0EnterBgmView:onOpen()
	if not self.viewParam.activitySettingList then
		local activitySettingList = {}
		local defaultIndex = VersionActivityEnterHelper.getTabIndex(activitySettingList, self.viewParam.jumpActId)
		local actSetting = activitySettingList[defaultIndex]
		local actId = VersionActivityEnterHelper.getActId(actSetting)

		self._isFirstOpenMainAct = actId == VersionActivity3_0Enum.ActivityId.Dungeon

		self:modifyBgm(actId)

		self._isFirstOpenMainAct = false
	end
end

function VersionActivity3_0EnterBgmView:onSelectActId(actId)
	self:modifyBgm(actId)
end

function VersionActivity3_0EnterBgmView:modifyBgm(actId)
	self._isMainAct = actId == VersionActivity3_0Enum.ActivityId.Dungeon

	local delayTime = 0

	if self._isMainAct then
		AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.VersionActivity3_0MainAmbientSound, AudioEnum3_0.VersionActivity3_0Enter.play_ui_lushang_gunfire_loop, AudioEnum3_0.VersionActivity3_0Enter.stop_ui_lushang_gunfire_loop)
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity3_0Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		self.playingActId = nil
		self.bgmId = nil

		if self._isFirstOpenMainAct then
			self._isFirstOpenMainAct = false
			delayTime = 3.5

			AudioMgr.instance:trigger(AudioEnum3_0.VersionActivity3_0Enter.play_ui_jinye_open)
		else
			delayTime = 1

			AudioMgr.instance:trigger(AudioEnum3_0.VersionActivity3_0Enter.play_ui_jinye_unfold)
		end
	else
		AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.VersionActivity3_0MainAmbientSound, 0, AudioEnum3_0.VersionActivity3_0Enter.stop_ui_lushang_gunfire_loop)
	end

	self._actId = actId

	TaskDispatcher.cancelTask(self._doModifyBgm, self)
	TaskDispatcher.runDelay(self._doModifyBgm, self, delayTime)
end

function VersionActivity3_0EnterBgmView:_doModifyBgm()
	if not self.actHandleDict[self._actId] then
		-- block empty
	end
end

function VersionActivity3_0EnterBgmView:defaultBgmHandle(actId)
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

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity3_0Main)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity3_0Main, bgmId)
end

function VersionActivity3_0EnterBgmView:onClose()
	TaskDispatcher.cancelTask(self._doModifyBgm, self)
end

function VersionActivity3_0EnterBgmView:_reactivityBgmHandle(actId)
	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	self.bgmId = bgmId

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity3_0Main, "music_vocal_filter", "original")
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity3_0Main, bgmId)
end

return VersionActivity3_0EnterBgmView
