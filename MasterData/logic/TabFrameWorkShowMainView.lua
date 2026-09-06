-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabframework/view/common/TabFrameWorkShowMainView.lua

module("logic.extensions.tabframework.view.common.TabFrameWorkShowMainView", package.seeall)

local TabFrameWorkShowMainView = class("TabFrameWorkShowMainView", ViewComponent)

function TabFrameWorkShowMainView:ctor()
	TabFrameWorkShowMainView.super.ctor(self)

	self._frameId = 0
end

function TabFrameWorkShowMainView:buildUI()
	TabFrameWorkShowMainView.super.buildUI(self)

	self._btnClose = self:getGo(self:_getCloseBtnPath())
	self._btnTip = self:getGo(self:_getTipBtnPath())
	self._tablist = self:getGo(self:_getTabListPath())
	self._contentCol = self:getGo(self:_getContentPath())
	self._txtTitle = self:getTxt(self:_getTitlePath())
	self._strTxtTitle = self._txtTitle.text
	self._frameId = self:_getDefaultFrameId()
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._contentCol, self._tablist, self._frameId, GameUtil.handler(self._getTabFrameParams, self))
end

function TabFrameWorkShowMainView:bindEvents()
	TabFrameWorkShowMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function TabFrameWorkShowMainView:unbindEvents()
	TabFrameWorkShowMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function TabFrameWorkShowMainView:onEnter()
	TabFrameWorkShowMainView.super.onEnter(self)

	local oldHeadTabId = self._tabFrameWorkShow:getHeadTabId()
	local oldSecTabId = self._tabFrameWorkShow:getSecTabId()
	local enterContext = TabFrameWorkController.instance:consumeEnterContext(self._viewPresentor.viewName)

	if enterContext then
		if not enterContext.frameId then
			local frameId = self:_getEnterFrameId()

			if enterContext then
				if not enterContext.headTabId then
					local headTabId = self:_getEnterHeadTabId(oldHeadTabId)

					if enterContext then
						if not enterContext.secTabId then
							local secTabId = self:_getEnterSecTabId(oldSecTabId)

							self:_updateFrameTab(frameId, headTabId, secTabId)
							self.addGEvent(self, GlobalNotify.HandleTabFrameWorkShowJump, self._handleTabFrameWorkShowJump, self)
							self:_updateTitle()
							self:_onAfterEnterFrame()
						end
					end
				end
			end
		end
	end
end

function TabFrameWorkShowMainView:onExit()
	TabFrameWorkShowMainView.super.onExit(self)
end

function TabFrameWorkShowMainView:_getCloseBtnPath()
	return "leftTop/btnClose"
end

function TabFrameWorkShowMainView:_getTipBtnPath()
	return "leftTop/btnTip"
end

function TabFrameWorkShowMainView:_getTitlePath()
	return "leftTop/txtTitle"
end

function TabFrameWorkShowMainView:_getTabListPath()
	return "tablist"
end

function TabFrameWorkShowMainView:_getContentPath()
	return "contentCol"
end

function TabFrameWorkShowMainView:_getDefaultFrameId()
	return 0
end

function TabFrameWorkShowMainView:_getEnterFrameId()
	return self:_getDefaultFrameId()
end

function TabFrameWorkShowMainView:_getEnterHeadTabId(oldHeadTabId)
	return oldHeadTabId
end

function TabFrameWorkShowMainView:_getEnterSecTabId(oldSecTabId)
	return oldSecTabId
end

function TabFrameWorkShowMainView:_getTabFrameParams(data)
	return nil
end

function TabFrameWorkShowMainView:_onAfterEnterFrame()
	return
end

function TabFrameWorkShowMainView:_handleTabFrameWorkShowJump(frameId, headTabId, secTabId)
	if frameId ~= self._frameId then
		local baseData = TabFrameWorkConfig.instance:getFwBaseData(frameId)

		if baseData then
			if not baseData.viewName then
				local viewName = ""

				if self._viewPresentor.viewName ~= viewName then
					return
				end
			end
		end
	end

	self:_updateFrameTab(frameId, headTabId, secTabId)
	self:_updateTitle()
end

function TabFrameWorkShowMainView:_updateFrameTab(frameId, headTabId, secTabId)
	frameId = checknumber(frameId)

	if frameId > 0 and self._frameId ~= frameId then
		self._frameId = frameId

		self._tabFrameWorkShow:init(self, self._contentCol, self._tablist, self._frameId, GameUtil.handler(self._getTabFrameParams, self))
	end

	self._tabFrameWorkShow:jumpTab(headTabId, secTabId)
end

function TabFrameWorkShowMainView:_updateTitle()
	if not self._txtTitle then
		return
	end

	local baseData = TabFrameWorkConfig.instance:getFwBaseData(self._frameId)

	self._txtTitle.text = baseData and not string.nilorempty(baseData.planName) and baseData.planName or self._strTxtTitle
end

function TabFrameWorkShowMainView:_onClickBtnTip()
	local baseData = TabFrameWorkConfig.instance:getFwBaseData(self._frameId)

	if baseData and not string.nilorempty(baseData.ruleKey) then
		TipsFacade.instance:openRulesView(baseData.ruleKey)
	end
end

function TabFrameWorkShowMainView:_onClickBtnClose()
	self._tabFrameWorkShow._headTabId = nil
	self._tabFrameWorkShow._secTabId = nil

	self:close()
end

return TabFrameWorkShowMainView
