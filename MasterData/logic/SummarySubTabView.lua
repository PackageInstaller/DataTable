-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/SummarySubTabView.lua

module("logic.extensions.bonus.view.SummarySubTabView", package.seeall)

local SummarySubTabView = class("SummarySubTabView", ViewComponent)

function SummarySubTabView:ctor()
	SummarySubTabView.super.ctor(self)
end

function SummarySubTabView:bindEvents()
	SummarySubTabView.super.bindEvents(self)
end

function SummarySubTabView:unbindEvents()
	SummarySubTabView.super.unbindEvents(self)
end

function SummarySubTabView:buildUI()
	SummarySubTabView.super.buildUI(self)
end

function SummarySubTabView:init()
	self:initTabId()
	self:reloadCfgs()
end

function SummarySubTabView:buildBtnJump()
	for _, cfg in pairs(self._cfgs) do
		self.btnJump[cfg.id] = self:getGo("con" .. cfg.id .. "/btnJump")

		GameUtil.addClickHandler(self.btnJump[cfg.id], GameUtil.handler(self._onJump, self, cfg))
	end
end

function SummarySubTabView:onEnter()
	SummarySubTabView.super.onEnter(self)

	local data = self:getFirstParam()

	self.activityId = nil

	if data then
		self.activityId = data.activityId
	end

	self:init()

	self.btnJump = {}

	self:buildBtnJump()
end

function SummarySubTabView:onExit()
	SummarySubTabView.super.onExit(self)

	for i, v in pairs(self.btnJump) do
		GameUtil.rmClickHandler(v)
	end
end

function SummarySubTabView:thisActId()
	if self.activityId then
		return self.activityId
	else
		return ActivitySummaryController.instance:getActivityId()
	end
end

function SummarySubTabView:initTabId()
	local name = self:thisViewName()
	local allTab = XiaonuoBirthConfig.instance:getTabList(self:thisActId())

	for i, v in ipairs(allTab) do
		if v.viewname == name then
			self._tabId = v.id

			return
		end
	end

	printError("告诉开发：override SummarySubTabView.thisViewName 或者 SummarySubTabView.initTabId")
end

function SummarySubTabView:getTabId()
	return self._tabId
end

function SummarySubTabView:thisViewName()
	return self._viewPresentor.viewName
end

function SummarySubTabView:reloadCfgs()
	self._cfgs = XiaonuoBirthConfig.instance:getBgAndJumpCfg(self:thisActId(), self:getTabId()) or {}
end

function SummarySubTabView:_onJump(cfg)
	print(cfg.tab .. "  " .. cfg.id .. "  " .. cfg.jumpTo)

	if GameUtil.checkIsInTimePeriod(cfg.actStartTime, cfg.actEndTime) then
		GotoMgr.gotoByString(cfg.jumpTo)
		SurveyController.instance:reportBehavior(200654, cfg.tab, cfg.id)
	else
		FloatWordMgr.instance:show(cfg.offlineTip)
	end
end

return SummarySubTabView
