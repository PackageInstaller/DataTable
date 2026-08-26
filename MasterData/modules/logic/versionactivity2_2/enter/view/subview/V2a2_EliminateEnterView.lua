-- chunkname: @modules/logic/versionactivity2_2/enter/view/subview/V2a2_EliminateEnterView.lua

module("modules.logic.versionactivity2_2.enter.view.subview.V2a2_EliminateEnterView", package.seeall)

local V2a2_EliminateEnterView = class("V2a2_EliminateEnterView", VersionActivityEnterBaseSubView)

function V2a2_EliminateEnterView:onInitView()
	self._txtLimitTime = gohelper.findChildTextMesh(self.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_Descr")
	self._txtunlocked = gohelper.findChildTextMesh(self.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._gored = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a2_EliminateEnterView:addEvents()
	self._btnEnter:AddClickListener(self._enterGame, self)
	self._btnLocked:AddClickListener(self._clickLock, self)
end

function V2a2_EliminateEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
end

function V2a2_EliminateEnterView:_editableInitView()
	self.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_2Enum.ActivityId.Eliminate)
	self._txtDescr.text = self.actCo.actDesc
	self._txtunlocked.text = lua_toast.configDict[ToastEnum.EliminateLockDungeon].tips
end

function V2a2_EliminateEnterView:onOpen()
	V2a2_EliminateEnterView.super.onOpen(self)
	self:_refreshTime()
end

function V2a2_EliminateEnterView:_enterGame()
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Eliminate) then
		GameFacade.showToast(ToastEnum.EliminateLockDungeon)

		return
	end

	EliminateMapController.instance:openEliminateMapView()
end

function V2a2_EliminateEnterView:_onRecvMsg(cmd, resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function V2a2_EliminateEnterView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToast(ToastEnum.EliminateLockDungeon)
	end
end

function V2a2_EliminateEnterView:_clickTrial()
	if ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.Eliminate) == ActivityEnum.ActivityStatus.Normal then
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

function V2a2_EliminateEnterView:everySecondCall()
	self:_refreshTime()
end

function V2a2_EliminateEnterView:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_2Enum.ActivityId.Eliminate]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end

		local isLock = ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.Eliminate) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
	end
end

return V2a2_EliminateEnterView
