-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/view/MiniPartyView.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.view.MiniPartyView", package.seeall)

local MiniPartyView = class("MiniPartyView", BaseView)

function MiniPartyView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._txttime = gohelper.findChildText(self.viewGO, "Left/#txt_time")
	self._gofrienditem = gohelper.findChild(self.viewGO, "Left/scroll_FriendList/Viewport/Content/#go_frienditem")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_jump")
	self._txtjumpnum = gohelper.findChildText(self.viewGO, "Right/#btn_jump/#txt_jumpnum")
	self._gojumpreddot = gohelper.findChild(self.viewGO, "Right/#btn_jump/#go_jumpreddot")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MiniPartyView:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
end

function MiniPartyView:removeEvents()
	self._btnjump:RemoveClickListener()
end

function MiniPartyView:_btnjumpOnClick()
	local actId = VersionActivity3_4Enum.ActivityId.LaplaceTitleAppoint
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	self._popularCount = TitleAppointmentModel.instance:getPopularValueCount()

	gohelper.setActive(self._gojumpreddot, false)
	LaplaceForumController.instance:openLaplaceTitleAppointmentView()
end

function MiniPartyView:_editableInitView()
	self._actId = VersionActivity3_4Enum.ActivityId.LaplaceMiniParty

	gohelper.setActive(self._gojumpreddot, false)
	self:_addSelfEvents()
end

function MiniPartyView:_addSelfEvents()
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshUI, self)
end

function MiniPartyView:_removeSelfEvents()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshUI, self)
end

function MiniPartyView:onUpdateParam()
	return
end

function MiniPartyView:onOpen()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)

	self._popularCount = TitleAppointmentModel.instance:getPopularValueCount()

	self:_refreshTime()
	self:_refreshUI()
end

function MiniPartyView:_refreshTime()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function MiniPartyView:_refreshUI()
	local popularCount = TitleAppointmentModel.instance:getPopularValueCount()

	if self._popularCount ~= popularCount then
		local lastStage = TitleAppointmentModel.instance:getTitleStageByPopularCount(self._popularCount)
		local curStage = TitleAppointmentModel.instance:getTitleStageByPopularCount(popularCount)

		gohelper.setActive(self._gojumpreddot, lastStage < curStage)
	end

	self._txtjumpnum.text = GameUtil.numberDisplay(popularCount)
end

function MiniPartyView:onClose()
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function MiniPartyView:onDestroyView()
	self:_removeSelfEvents()
end

return MiniPartyView
