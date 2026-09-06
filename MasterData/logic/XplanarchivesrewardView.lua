-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xplanarchives/view/XplanarchivesrewardView.lua

module("logic.extensions.xplanarchives.view.XplanarchivesrewardView", package.seeall)

local XplanarchivesrewardView = class("XplanarchivesrewardView", ViewComponent)

function XplanarchivesrewardView:ctor()
	XplanarchivesrewardView.super.ctor(self)
end

function XplanarchivesrewardView:unbindEvents()
	XplanarchivesrewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function XplanarchivesrewardView:bindEvents()
	XplanarchivesrewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function XplanarchivesrewardView:buildUI()
	XplanarchivesrewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtDesc = self:getTxt("txtDesc")
end

function XplanarchivesrewardView:onExit()
	XplanarchivesrewardView.super.onExit(self)
	self._scrollerList:dispose()
end

function XplanarchivesrewardView:onEnter()
	XplanarchivesrewardView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.XPlanArchivesGainPrizeRes, self._updateUI, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._progressCfgs = XplanarchivesConfig.instance:getProgressCfgs(self._activityId)

	self:_updateUI()
end

function XplanarchivesrewardView:_onClickbtnClose()
	self:close()
end

function XplanarchivesrewardView:_updateCell(view, cell, cfg, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goItem1 = goutil.findChild(cell.gameObject, "item1")
	local goItem2 = goutil.findChild(cell.gameObject, "item2")
	local goReceive = goutil.findChild(cell.gameObject, "receive")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local arr = string.split(cfg.prize, "#")
	local isGain = XplanarchivesModel.instance:isGainPrize(self._activityId, cfg.prizeId)
	local canGain = XplanarchivesModel.instance:canGainPrize(self._activityId, cfg.prizeId)

	goutil.setActive(goReceive, isGain)
	goutil.setActive(btn.gameObject, canGain)
	goutil.setActive(goItem1, arr[1])
	goutil.setActive(goItem2, arr[2])
	MaterialMgr.resetAll(goItem1)
	MaterialMgr.resetAll(goItem2)
	MaterialMgr.setCellByCfg(arr[1], goItem1)

	if arr[2] then
		MaterialMgr.setCellByCfg(arr[2], goItem2)
	end

	txtDesc.text = string.format("累计收集情报%s份", cfg.need)

	btn:AddClickListener(function()
		XPlanArchivesAgent.instance:sendPM_XPlanArchivesGainPrizeReq(self._activityId, cfg.prizeId)
	end)
end

function XplanarchivesrewardView:_clearCell(cell)
	local goItem1 = goutil.findChild(cell.gameObject, "item1")
	local goItem2 = goutil.findChild(cell.gameObject, "item2")

	MaterialMgr.resetAll(goItem1)
	MaterialMgr.resetAll(goItem2)
end

function XplanarchivesrewardView:_updateUI()
	local cfgs = {}
	local isGainCfgs = {}

	for i, cfg in ipairs(self._progressCfgs) do
		local isGain = XplanarchivesModel.instance:isGainPrize(self._activityId, cfg.prizeId)

		if isGain then
			table.insert(isGainCfgs, cfg)
		else
			table.insert(cfgs, cfg)
		end
	end

	table.insertto(cfgs, isGainCfgs)
	self._scrollerList:reloadData(cfgs)
	self:_updateDesc()
end

function XplanarchivesrewardView:_updateDesc()
	local count = XplanarchivesModel.instance:getProgress(self._activityId)

	self._txtDesc.text = string.format("当前已收集情报：<color=green>%s</color>", count)
end

return XplanarchivesrewardView
