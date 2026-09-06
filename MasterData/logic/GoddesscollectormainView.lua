-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectormainView.lua

module("logic.extensions.goddesscollector.view.GoddesscollectormainView", package.seeall)

local GoddesscollectormainView = class("GoddesscollectormainView", TableViewComponent)

function GoddesscollectormainView:ctor()
	GoddesscollectormainView.super.ctor(self)
end

function GoddesscollectormainView:unbindEvents()
	GoddesscollectormainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRule:RemoveClickListener()
end

function GoddesscollectormainView:bindEvents()
	GoddesscollectormainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnRule:AddClickListener(self._onClickbtnRule, self)
end

function GoddesscollectormainView:buildUI()
	GoddesscollectormainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._containerGo = self:getGo("container")
	self._timeTxt = goutil.findChildTextComponent(self.mainGO, "time/timeTxt")
end

function GoddesscollectormainView:onExit()
	GoddesscollectormainView.super.onExit(self)
	GlobalDispatcher:removeListener(GoddesscollectorController.PM_GoddessCollectorGetInfoRes, self._PM_GoddessCollectorGetInfoRes, self)
	GlobalDispatcher:removeListener(GoddesscollectorController.PM_GoddessCollectorGainPrizeRes, self.reloadData, self)
	GlobalDispatcher:removeListener(GoddesscollectorController.PM_GoddessCollectorVerifyPetsRes, self.reloadData, self)
end

function GoddesscollectormainView:onEnter()
	GoddesscollectormainView.super.onEnter(self)
	GoddesscollectorModel.instance:clearWholeLifeDot()

	self._activityType = GameEnum.ActivityType.GODDESS_COLLECTOR

	local cfg = ActivityDefineController.instance:getActivityCfgByType(self._activityType)

	self._activityId = 0

	if cfg then
		self._activityId = cfg.activityId
	end

	if self._activityId <= 0 then
		self:close()

		return
	end

	GoddesscollectorModel.instance:setActivityId(self._activityId)
	GlobalDispatcher:addListener(GoddesscollectorController.PM_GoddessCollectorGetInfoRes, self._PM_GoddessCollectorGetInfoRes, self)
	GlobalDispatcher:addListener(GoddesscollectorController.PM_GoddessCollectorGainPrizeRes, self.reloadData, self)
	GlobalDispatcher:addListener(GoddesscollectorController.PM_GoddessCollectorVerifyPetsRes, self.reloadData, self)
	GoddessCollectorAgent.instance:sendPM_GoddessCollectorGetInfoReq(self._activityId)
	self:_initTabs()
	self:_setActTime()
end

function GoddesscollectormainView:_onClickbtnClose()
	if GoddesscollectorController.instance:isPlayVarifyAnim() then
		FloatWordMgr.instance:show("正在验证中")

		return
	end

	self._curTabId = false

	self:close()
end

function GoddesscollectormainView:_onClickbtnRule()
	TipsFacade.instance:openRulesView("goddesscollectormainview")
end

function GoddesscollectormainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function GoddesscollectormainView:_updateCell(view, cell, cfg)
	local uiChange = cell.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local redPoint = goutil.findChild(cell.gameObject, "redPoint")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local isRed = GoddesscollectorModel.instance:checkRedDotByType(cfg.redPointType)

	goutil.setActive(redPoint, isRed)
	goutil.setActive(goSelect, cfg.id == self._curTabId)
	uiChange:SetState(cfg.id - 1)
	btn:AddClickListener(function()
		self:_switchTab(cfg.id)
	end)
end

function GoddesscollectormainView:_clearTableview(cell)
	return
end

function GoddesscollectormainView:_initTabs()
	local tabCfgs = GoddesscollectorConfig.instance:getTabCfgs()

	self._curViewDatas = tabCfgs

	if not self._curTabId then
		local jumpTabId = checknumber(self:getFirstParam())

		self._curTabId = jumpTabId > 0 and jumpTabId or tabCfgs[1].id
	end

	self:_switchTab(self._curTabId, true)
end

function GoddesscollectormainView:_switchTab(tabId, force)
	if GoddesscollectorController.instance:isPlayVarifyAnim() then
		FloatWordMgr.instance:show("正在验证中")

		return
	end

	if not force and self._curTabId == tabId then
		return
	end

	self._curTabId = tabId

	local tabCfg = self._curViewDatas[self._curTabId]

	if tabCfg.viewName then
		self:showTabAt(self._containerGo, tabCfg.viewName)
	end

	self:reloadData()
end

function GoddesscollectormainView:_PM_GoddessCollectorGetInfoRes(status)
	if status == 0 and self._curTabId then
		self:_switchTab(self._curTabId, true)
	end
end

function GoddesscollectormainView:_setActTime()
	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	local sDate = GameUtil.time2date(stime)
	local eDate = GameUtil.time2date(etime)
	local startTime = string.format("%s.%s %s:00", sDate.month, sDate.day, sDate.hour)
	local endTime = string.format("%s.%s %s:00", eDate.month, eDate.day, eDate.hour)

	self._timeTxt.text = string.format("活动时间：%s - %s", startTime, endTime)
end

return GoddesscollectormainView
