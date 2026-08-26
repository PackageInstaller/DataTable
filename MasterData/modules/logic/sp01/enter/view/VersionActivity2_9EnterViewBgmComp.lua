-- chunkname: @modules/logic/sp01/enter/view/VersionActivity2_9EnterViewBgmComp.lua

module("modules.logic.sp01.enter.view.VersionActivity2_9EnterViewBgmComp", package.seeall)

local VersionActivity2_9EnterViewBgmComp = class("VersionActivity2_9EnterViewBgmComp", BaseView)

function VersionActivity2_9EnterViewBgmComp:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_9EnterViewBgmComp:addEvents()
	self.addEventCb(self, VersionActivity2_9EnterController.instance, VersionActivity2_9Event.ManualSwitchBgm, self._manualSwitchBgm, self)
	self.addEventCb(self, VersionActivity2_9EnterController.instance, VersionActivity2_9Event.StopBgm, self._stopBgm, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function VersionActivity2_9EnterViewBgmComp:removeEvents()
	return
end

function VersionActivity2_9EnterViewBgmComp:_editableInitView()
	self._bgmLayer = VersionActivityFixedHelper.getVersionActivityAudioBgmLayer(2, 9)
end

function VersionActivity2_9EnterViewBgmComp:viewName2BgmHandle(viewName)
	self:_initBgmConfigs()

	local actId = self:viewName2ActId(viewName)
	local bgmHandle, bgmId = self:actId2BgmHandle(actId)

	return bgmHandle, bgmId
end

function VersionActivity2_9EnterViewBgmComp:viewName2ActId(viewName)
	if self._viewName2ActId then
		local actId = self._viewName2ActId[viewName]

		if not self._viewName2ActId then
			if self._viewName2ActIdHandle then
				if self._viewName2ActIdHandle then
					actId = self:_viewName2ActIdHandle(viewName)
				end
			end
		end

		return self._viewName2ActId
	end
end

function VersionActivity2_9EnterViewBgmComp:actId2BgmHandle(actId)
	if not actId then
		return
	end

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	if self._actId2BgmHandle then
		if bgmId and bgmId ~= 0 and not self._actId2BgmHandle then
			logError(string.format("缺少播放活动背景音乐的方法! actId = %s, bgmId = %s", actId, bgmId))
		end

		return self._actId2BgmHandle, bgmId
	end
end

function VersionActivity2_9EnterViewBgmComp:_initBgmConfigs()
	if not self._viewName2ActId then
		self._viewName2ActId = {}
		self._viewName2ActId[ViewName.AssassinLoginView] = VersionActivity2_9Enum.ActivityId.Outside
		self._viewName2ActId[ViewName.AssassinMapView] = VersionActivity2_9Enum.ActivityId.Outside
		self._viewName2ActId[ViewName.V1a4_BossRushMainView] = VersionActivity2_9Enum.ActivityId.BossRush
		self._viewName2ActId[ViewName.VersionActivity2_9DungeonMapView] = VersionActivity2_9Enum.ActivityId.Dungeon
		self._viewName2ActId[ViewName.OdysseyDungeonView] = VersionActivity2_9Enum.ActivityId.Dungeon2
	end

	if not self._viewName2ActIdHandle then
		self._viewName2ActIdHandle = {}
		self._viewName2ActIdHandle[ViewName.VersionActivity2_9EnterView] = self.getActIdHandle_EnterView
	end

	if not self._actId2BgmHandle then
		self._actId2BgmHandle = {}
		self._actId2BgmHandle[VersionActivity2_9Enum.ActivityId.EnterView] = self.playBgm_EnterView
		self._actId2BgmHandle[VersionActivity2_9Enum.ActivityId.EnterView2] = self.playBgm_EnterView
		self._actId2BgmHandle[VersionActivity2_9Enum.ActivityId.BossRush] = self.playBgm_BossRush
		self._actId2BgmHandle[VersionActivity2_9Enum.ActivityId.Outside] = self.playBgm_default
		self._actId2BgmHandle[VersionActivity2_9Enum.ActivityId.Dungeon] = self.playBgm_default
		self._actId2BgmHandle[VersionActivity2_9Enum.ActivityId.Dungeon2] = self.playBgm_default
	end
end

function VersionActivity2_9EnterViewBgmComp:getActIdHandle_EnterView()
	local groupIndex = self.viewContainer._views[1].showGroupIndex

	return self.viewParam.mainActIdList[groupIndex]
end

function VersionActivity2_9EnterViewBgmComp:playBgm_EnterView(bgmId)
	AudioBgmManager.instance:modifyAndPlay(self._bgmLayer, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	AudioBgmManager.instance:modifyBgmAudioId(self._bgmLayer, bgmId)
end

function VersionActivity2_9EnterViewBgmComp:playBgm_BossRush(bgmId)
	AudioBgmManager.instance:setSwitchData(self._bgmLayer, FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
	AudioBgmManager.instance:modifyBgmAudioId(self._bgmLayer, bgmId)
end

function VersionActivity2_9EnterViewBgmComp:playBgm_default(bgmId)
	AudioBgmManager.instance:setSwitchData(self._bgmLayer)
	AudioBgmManager.instance:modifyBgmAudioId(self._bgmLayer, bgmId)
end

function VersionActivity2_9EnterViewBgmComp:_onOpenViewFinish(viewName)
	self:tryModifyBgm()
end

function VersionActivity2_9EnterViewBgmComp:_onCloseViewFinish(viewName)
	self:tryModifyBgm()
end

function VersionActivity2_9EnterViewBgmComp:tryModifyBgm()
	local viewNameList = ViewMgr.instance:getOpenViewNameList()

	if viewNameList then
		if not #viewNameList then
			local openViewNum = 0

			for i = openViewNum, 1, -1 do
				local openViewName = viewNameList[i]
				local bgmHandle, bgmId = self:viewName2BgmHandle(openViewName)

				if self._playingBgmId and self._playingBgmId == bgmId then
					break
				end

				if bgmHandle and bgmId and bgmId ~= 0 then
					bgmHandle(self, bgmId)

					self._playingBgmId = bgmId

					break
				end
			end
		end
	end
end

function VersionActivity2_9EnterViewBgmComp:_stopBgm()
	AudioBgmManager.instance:stopBgm(self._bgmLayer)
end

function VersionActivity2_9EnterViewBgmComp:_manualSwitchBgm()
	self:tryModifyBgm()
end

return VersionActivity2_9EnterViewBgmComp
