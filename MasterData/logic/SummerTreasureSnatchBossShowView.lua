-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchBossShowView.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchBossShowView", package.seeall)

local SummerTreasureSnatchBossShowView = class("SummerTreasureSnatchBossShowView", ViewComponent)

function SummerTreasureSnatchBossShowView:ctor()
	SummerTreasureSnatchBossShowView.super.ctor(self)
end

function SummerTreasureSnatchBossShowView:unbindEvents()
	SummerTreasureSnatchBossShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SummerTreasureSnatchBossShowView:bindEvents()
	SummerTreasureSnatchBossShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SummerTreasureSnatchBossShowView:buildUI()
	SummerTreasureSnatchBossShowView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtCurStage = self:getTxt("txtCurStage")
	self._txtTip = self:getTxt("txtTip")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SummerTreasureSnatchBossShowView:onExit()
	SummerTreasureSnatchBossShowView.super.onExit(self)
	self._scrollList:dispose()

	for cell, scroll in pairs(self._scrollMap) do
		scroll:dispose()

		self._scrollMap[cell] = nil
	end
end

function SummerTreasureSnatchBossShowView:onEnter()
	SummerTreasureSnatchBossShowView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 623001
	end

	self._bossCfgs = SummerTreasureSnatchConfig.instance:getBossCfgs(self._activityId)
	self._scrollMap = {}

	self._scrollList:reloadData(self._bossCfgs)
end

function SummerTreasureSnatchBossShowView:_updateCell(view, cell, data)
	local tableviewBoss = goutil.findChild(cell, "tableviewBoss")
	local tablecell = goutil.findChild(cell, "tableviewBoss/tablecell")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local rewardScroll = self._scrollMap[cell]

	if rewardScroll == nil then
		rewardScroll = ScrollerList.create(tableviewBoss, tablecell, GameUtil.handler(self._updateCellBoss, self), GameUtil.handler(self._clearCellBoss, self))
		self._scrollMap[cell] = rewardScroll
	end

	local bossList = data

	txtName.text = string.format("第%d周", cell.index + 1)

	rewardScroll:reloadData(bossList)
	rewardScroll:dragNotifyParent()
end

function SummerTreasureSnatchBossShowView:_clearCell(cell)
	local rewardScroll = self._scrollMap[cell]

	rewardScroll:dispose()

	self._scrollMap[cell] = nil
end

function SummerTreasureSnatchBossShowView:_updateCellBoss(view, cell, data)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.setCell(MatType.Pet, data.skinId, item)
end

function SummerTreasureSnatchBossShowView:_clearCellBoss(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

return SummerTreasureSnatchBossShowView
