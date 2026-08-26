-- chunkname: @modules/logic/versionactivity2_7/enter/view/subview/V2a6_CooperGarlandEnterView.lua

module("modules.logic.versionactivity2_7.enter.view.subview.V2a6_CooperGarlandEnterView", package.seeall)

local V2a6_CooperGarlandEnterView = class("V2a6_CooperGarlandEnterView", VersionActivityEnterBaseSubView)

function V2a6_CooperGarlandEnterView:onInitView()
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "Right/#go_time/#txt_limittime")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/image_TryBtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a6_CooperGarlandEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
end

function V2a6_CooperGarlandEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
end

function V2a6_CooperGarlandEnterView:_btnEnterOnClick()
	CooperGarlandController.instance:openLevelView()
end

function V2a6_CooperGarlandEnterView:_btnLockedOnClick()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function V2a6_CooperGarlandEnterView:_btnTrialOnClick()
	local isOpen = CooperGarlandModel.instance:isAct192Open()

	if isOpen then
		local episodeId = self.actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_btnLockedOnClick()
	end
end

function V2a6_CooperGarlandEnterView:_editableInitView()
	self.actId = CooperGarlandModel.instance:getAct192Id()
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.actCo.actDesc
end

function V2a6_CooperGarlandEnterView:onOpen()
	V2a6_CooperGarlandEnterView.super.onOpen(self)
	self:_refreshTime()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a7CooperGarland)
end

function V2a6_CooperGarlandEnterView:everySecondCall()
	self:_refreshTime()
end

function V2a6_CooperGarlandEnterView:_refreshTime()
	local timeStr, isEnd = CooperGarlandModel.instance:getAct192RemainTimeStr(self.actId)

	self._txtlimittime.text = timeStr

	gohelper.setActive(self._txtlimittime.gameObject, not isEnd)

	local isOpen = CooperGarlandModel.instance:isAct192Open()

	gohelper.setActive(self._btnEnter, isOpen)
	gohelper.setActive(self._btnLocked, not isOpen)
end

return V2a6_CooperGarlandEnterView
