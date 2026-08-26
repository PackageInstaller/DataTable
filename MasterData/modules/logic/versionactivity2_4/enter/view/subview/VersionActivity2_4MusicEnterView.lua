-- chunkname: @modules/logic/versionactivity2_4/enter/view/subview/VersionActivity2_4MusicEnterView.lua

module("modules.logic.versionactivity2_4.enter.view.subview.VersionActivity2_4MusicEnterView", package.seeall)

local VersionActivity2_4MusicEnterView = class("VersionActivity2_4MusicEnterView", VersionActivityEnterBaseSubView)

function VersionActivity2_4MusicEnterView:onInitView()
	self._txtLimitTime = gohelper.findChildTextMesh(self.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_Descr")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._gored = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/image_TryBtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicEnterView:addEvents()
	self._btnEnter:AddClickListener(self._enterGame, self)
	self._btnLocked:AddClickListener(self._clickLock, self)
	self._btnTrial:AddClickListener(self._clickTrial, self)
end

function VersionActivity2_4MusicEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
end

function VersionActivity2_4MusicEnterView:_editableInitView()
	self.actId = VersionActivity2_4Enum.ActivityId.MusicGame
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.actCo.actDesc
end

function VersionActivity2_4MusicEnterView:onOpen()
	VersionActivity2_4MusicEnterView.super.onOpen(self)
	RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V2a4MusicTaskRed)
	self:_refreshTime()
end

function VersionActivity2_4MusicEnterView:_enterGame()
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicChapterView()
end

function VersionActivity2_4MusicEnterView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function VersionActivity2_4MusicEnterView:_clickTask()
	return
end

function VersionActivity2_4MusicEnterView:_clickTrial()
	if ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function VersionActivity2_4MusicEnterView:everySecondCall()
	self:_refreshTime()
end

function VersionActivity2_4MusicEnterView:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end

		local isLock = ActivityHelper.getActivityStatus(self.actId) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
	end
end

return VersionActivity2_4MusicEnterView
