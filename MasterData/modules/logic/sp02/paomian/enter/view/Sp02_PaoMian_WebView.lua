-- chunkname: @modules/logic/sp02/paomian/enter/view/Sp02_PaoMian_WebView.lua

module("modules.logic.sp02.paomian.enter.view.Sp02_PaoMian_WebView", package.seeall)

local Sp02_PaoMian_WebView = class("Sp02_PaoMian_WebView", BaseView)

function Sp02_PaoMian_WebView:onInitView()
	self._goWeb = gohelper.findChild(self.viewGO, "#go_topleft/#go_web")
	self._btnWeb = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topleft/#go_web/#btn_web")
	self._goWebReddot = gohelper.findChild(self.viewGO, "#go_topleft/#go_web/#go_webreddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Sp02_PaoMian_WebView:addEvents()
	self._btnWeb:AddClickListener(self._btnWebOnClick, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._refreshReddot, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshActivityState, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshReddot, self)
end

function Sp02_PaoMian_WebView:removeEvents()
	self._btnWeb:RemoveClickListener()
end

function Sp02_PaoMian_WebView:_btnWebOnClick()
	SDKDataTrackMgr.instance:trackClickEnterActivityButton(self.viewName, "web")

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(self._actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId and toastId ~= 0 then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	if not Sp02_PaoMianController.instance:isShowWebEntry(self._actId) then
		return
	end

	local webUrl = Activity125Config.instance:getH5BaseUrl(self._actId)

	GameUtil.openURL(webUrl)
	Sp02_PaoMianController.instance:setWebWeekFirstLoginRed()
end

function Sp02_PaoMian_WebView:_editableInitView()
	self._actId = ActivityEnum.Activity.SP02_PaoMianActivityWeb
	self._reddotId = ActivityConfig.instance:getActivityRedDotId(self._actId)
	self._reddotCo = RedDotConfig.instance:getRedDotCO(self._reddotId)
	self._reddotType = self._reddotCo and self._reddotCo.style
	self._reddotComp = RedDotController.instance:addNotEventRedDot(self._goWebReddot, self._checkRed, self, self._reddotType)
end

function Sp02_PaoMian_WebView:_checkRed()
	return Sp02_PaoMianController.instance:isShowWebReddot()
end

function Sp02_PaoMian_WebView:_refreshReddot()
	if not self._reddotComp then
		return
	end

	self._reddotComp:refreshRedDot()
end

function Sp02_PaoMian_WebView:onUpdateParam()
	return
end

function Sp02_PaoMian_WebView:onOpen()
	self:refreshWebEntry()
end

function Sp02_PaoMian_WebView:refreshWebEntry()
	self:_refreshReddot()

	local isShow = Sp02_PaoMianController.instance:isShowWebEntry(self._actId)

	gohelper.setActive(self._goWeb, isShow)
end

function Sp02_PaoMian_WebView:_refreshActivityState()
	self:refreshWebEntry()
end

function Sp02_PaoMian_WebView:onClose()
	return
end

function Sp02_PaoMian_WebView:onDestroyView()
	return
end

return Sp02_PaoMian_WebView
