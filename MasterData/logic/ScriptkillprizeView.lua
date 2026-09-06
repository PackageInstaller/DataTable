-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillprizeView.lua

module("logic.extensions.scriptkill.view.ScriptkillprizeView", package.seeall)

local ScriptkillprizeView = class("ScriptkillprizeView", ViewComponent)

function ScriptkillprizeView:ctor()
	ScriptkillprizeView.super.ctor(self)
end

function ScriptkillprizeView:unbindEvents()
	ScriptkillprizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ScriptkillprizeView:bindEvents()
	ScriptkillprizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ScriptkillprizeView:buildUI()
	ScriptkillprizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._itemcell = self:getGo("itemcell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function ScriptkillprizeView:onExit()
	ScriptkillprizeView.super.onExit(self)
	self._scrollList:dispose()
end

function ScriptkillprizeView:onEnter()
	ScriptkillprizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self._rewardScroller = {}

	self:_refreshUI()
end

function ScriptkillprizeView:_refreshUI()
	local cfg = ScriptKillConfig.instance:getSuspectPrizeCfgList(self._activityId) or {}
	local list = {}

	for i, v in pairs(cfg) do
		table.insert(list, v)
	end

	ArraySort.sortOn(list, "hitNum", ArraySort.DESCENDING)
	self._scrollList:reloadData(list)
end

function ScriptkillprizeView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local rewardViewGo = goutil.findChild(cell, "rewardView")
	local rewardView = self._rewardScroller[cell]

	if rewardView == nil then
		rewardView = ScrollerList.create(rewardViewGo, self._itemcell, GameUtil.handler(self._updateRewarCell, self), GameUtil.handler(self._clearRewardCell, self))

		rewardView:dragNotifyParent()
	end

	self._rewardScroller[cell] = rewardView
	txtDesc.text = langPara("正确%s次", data.hitNum)

	local prizeData = string.split(data.prize, "#") or {}

	rewardView:reloadData(prizeData)
end

function ScriptkillprizeView:clearCell(cell)
	local rewardView = self._rewardScroller[cell]

	if rewardView then
		rewardView:dispose()
	end
end

function ScriptkillprizeView:_updateRewarCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function ScriptkillprizeView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

return ScriptkillprizeView
