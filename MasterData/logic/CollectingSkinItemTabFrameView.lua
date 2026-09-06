-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/view/CollectingSkinItemTabFrameView.lua

module("logic.extensions.collectingskin.view.CollectingSkinItemTabFrameView", package.seeall)

local CollectingSkinItemTabFrameView = class("CollectingSkinItemTabFrameView", ViewComponent)

function CollectingSkinItemTabFrameView:ctor()
	CollectingSkinItemTabFrameView.super.ctor(self)

	self._frameId = 0
end

function CollectingSkinItemTabFrameView:unbindEvents()
	CollectingSkinItemTabFrameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function CollectingSkinItemTabFrameView:bindEvents()
	CollectingSkinItemTabFrameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function CollectingSkinItemTabFrameView:buildUI()
	CollectingSkinItemTabFrameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._tabCol = self:getGo("tabCol")
	self._contentCol = self:getGo("contentCol")
	self._bg = self:getGo("bg")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._strTxtTitle = self._txtTitle.text
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._contentCol, self._tabCol, self._frameId)
end

function CollectingSkinItemTabFrameView:onExit()
	CollectingSkinItemTabFrameView.super.onExit(self)
end

function CollectingSkinItemTabFrameView:onEnter()
	CollectingSkinItemTabFrameView.super.onEnter(self)

	local param = self:getOpenParam() or {}
	local frameId = checknumber(param[1])

	if frameId <= 0 then
		printError("缺失传入参数 frameId")
		self:close()

		return
	end

	local oldHeadTabId = self._tabFrameWorkShow:getHeadTabId()
	local oldSecTabId = self._tabFrameWorkShow:getSecTabId()
	local headTabId = CollectingSkinController.JumpTab_HeadTabId
	local secTabId = CollectingSkinController.JumpTab_SecTabId

	if headTabId > 0 or secTabId > 0 then
		CollectingSkinController.JumpTab_HeadTabId = 0
		CollectingSkinController.JumpTab_SecTabId = 0
	else
		headTabId = oldHeadTabId
		secTabId = oldSecTabId
	end

	self:_updateFrameTab(frameId, headTabId, secTabId)
	self.addGEvent(self, GlobalNotify.HandleTabFrameWorkShowJump, self._handleTabFrameWorkShowJump, self)

	local baseData = TabFrameWorkConfig.instance:getFwBaseData(self._frameId)

	self._txtTitle.text = baseData and not string.nilorempty(baseData.planName) and baseData.planName or self._strTxtTitle
end

function CollectingSkinItemTabFrameView:_handleTabFrameWorkShowJump(frameId, headTabId, secTabId)
	if frameId ~= self._frameId then
		local baseData = TabFrameWorkConfig.instance:getFwBaseData(frameId)

		if baseData then
			if not baseData.viewName then
				local viewName = ""

				if self._viewPresentor.viewName == viewName then
					self:_updateFrameTab(frameId, headTabId, secTabId)
				end

				return
			end
		end
	end

	self._tabFrameWorkShow:jumpTab(headTabId, secTabId)
end

function CollectingSkinItemTabFrameView:_updateFrameTab(frameId, headTabId, secTabId)
	if self._frameId ~= frameId then
		self._frameId = frameId

		self._tabFrameWorkShow:init(self, self._contentCol, self._tabCol, self._frameId)
	end

	self._tabFrameWorkShow:jumpTab(headTabId, secTabId)
end

function CollectingSkinItemTabFrameView:_onClickBtnTip()
	local frameId = self._frameId
	local baseData = TabFrameWorkConfig.instance:getFwBaseData(frameId)

	if baseData and not string.nilorempty(baseData.ruleKey) then
		TipsFacade.instance:openRulesView(baseData.ruleKey)
	end
end

return CollectingSkinItemTabFrameView
