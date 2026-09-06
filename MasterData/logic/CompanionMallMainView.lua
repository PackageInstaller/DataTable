-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionMallMainView.lua

module("logic.extensions.companionmall.view.CompanionMallMainView", package.seeall)

local CompanionMallMainView = class("CompanionMallMainView", ViewComponent)

function CompanionMallMainView:ctor()
	CompanionMallMainView.super.ctor(self)
end

function CompanionMallMainView:destroyUI()
	CompanionMallMainView.super.destroyUI(self)
end

function CompanionMallMainView:buildUI()
	CompanionMallMainView.super.buildUI(self)

	self._txtTime = self:getTxt("txtOpenTime/txt")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._tablist = self:getGo("tablist")
	self._contentCol = self:getGo("contentCol")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnShowPV = self:getGo("tablist/btnShowPV")
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._contentCol, self._tablist, self._getFrameId(), GameUtil.handler(self._getExtParam, self))

	self._tabFrameWorkShow:setUpdateRightExtCallBack(GameUtil.handler(self._onJumpRight, self))
end

function CompanionMallMainView:bindEvents()
	CompanionMallMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnShowPV, self._onClickBtnShowPv, self)
	GlobalDispatcher:addListener("onFirstGotoCompanionMallMainView", self._onGetInfoRes, self)
end

function CompanionMallMainView:unbindEvents()
	CompanionMallMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShowPV)
end

function CompanionMallMainView:onEnter()
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._tabIdx = checknumber(params[2])
	self._secTabIdx = checknumber(params[3])

	if self._activityId == 0 then
		local arr = string.split(self:getFirstParam(), "#")

		if checknumber(arr[1]) ~= 0 then
			self._activityId = checknumber(arr[1])
			self._tabIdx = checknumber(arr[2])
			self._secTabIdx = checknumber(arr[3])
		else
			self._activityId = CompanionMallController.instance:getInTimeActId()
		end
	end

	if self._tabIdx == 0 then
		self._tabIdx = checknumber(CompanionMallController.instance.tabIdx)
		self._secTabIdx = checknumber(CompanionMallController.instance.secTabIdx)

		local canGainCompanionId = CompanionMallController.instance:getCurCanGainCompanionId(self._activityId)
		local curCompanionId = CompanionMallController.instance:getCurCompanionId(self._activityId)

		if canGainCompanionId > 0 then
			self._tabIdx = canGainCompanionId
		elseif curCompanionId > 1 then
			self._tabIdx = curCompanionId
		end
	end

	self._actCfg = CompanionMallConfig.instance:getActivityCfgById(self._activityId)

	CompanionMallMainView.super.onEnter(self)

	if self._tabIdx > 0 then
		self._tabFrameWorkShow:jumpTab(self._tabIdx, self._secTabIdx)
	else
		self._tabFrameWorkShow:jumpTab()
	end

	local baseData = TabFrameWorkConfig.instance:getFwBaseData(self._getFrameId())

	if self._txtTitle and not string.nilorempty(baseData.planName) then
		self._txtTitle.text = baseData.planName
	end

	if self._txtTime then
		self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	CompanionMallModel.instance:hasOpenMainView()
	CompanionMallController.instance:sendGetInfo(self._activityId)
end

function CompanionMallMainView:onExit()
	CompanionMallMainView.super.onExit(self)
end

function CompanionMallMainView:_getExtParam()
	return self._activityId
end

function CompanionMallMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function CompanionMallMainView:_onClickClose()
	self:close()

	CompanionMallController.instance.tabIdx = nil
	CompanionMallController.instance.secTabIdx = nil
end

function CompanionMallMainView:_getFrameId()
	return ActivityDefineController.instance:getActivityIdByType(492)
end

function CompanionMallMainView:_onJumpRight(tabData)
	local data = tabData.data

	CompanionMallController.instance.tabIdx = data.headTabId
	CompanionMallController.instance.secTabIdx = data.secTabId
end

function CompanionMallMainView:_onClickBtnShowPv()
	local curVedioName = self._actCfg.vedioName

	UIStateManager.instance:push(ViewName.ActivityOP220701VedioView, curVedioName)
end

function CompanionMallMainView:_onGetInfoRes()
	GlobalDispatcher:removeListener("onFirstGotoCompanionMallMainView", self._onGetInfoRes, self)

	local canGainCompanionId = CompanionMallController.instance:getCurCanGainCompanionId(self._activityId)
	local curCompanionId = CompanionMallController.instance:getCurCompanionId(self._activityId)

	if canGainCompanionId > 0 then
		self._tabIdx = canGainCompanionId
	elseif curCompanionId > 1 then
		self._tabIdx = curCompanionId
	end

	self._tabFrameWorkShow:jumpTab(self._tabIdx, self._secTabIdx)
end

return CompanionMallMainView
