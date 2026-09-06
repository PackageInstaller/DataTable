-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiScoreDescView.lua

module("logic.extensions.divinejiclg.view.DivineJiScoreDescView", package.seeall)

local DivineJiScoreDescView = class("DivineJiScoreDescView", ViewComponent)

function DivineJiScoreDescView:ctor()
	DivineJiScoreDescView.super.ctor(self)
end

function DivineJiScoreDescView:buildUI()
	DivineJiScoreDescView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._desc = self:getTxt("desc")
	self._table = self:getGo("table")
	self._row = self:getGo("table/row")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/row")
	self._scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineJiScoreDescView:bindEvents()
	DivineJiScoreDescView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineJiScoreDescView:unbindEvents()
	DivineJiScoreDescView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineJiScoreDescView:onExit()
	DivineJiScoreDescView.super.onExit(self)
	self._scrollerList:dispose()
end

function DivineJiScoreDescView:onEnter()
	DivineJiScoreDescView.super.onEnter(self)

	local param = self:getOpenParam()

	if TableUtil.isTableEmpty(param) then
		self:close()

		return
	end

	self._activityId = checknumber(param[1])
	self._stageId = checknumber(param[2])

	local activityCfg = DivineJiClgConfig.instance:getActivityCfgByActId(self._activityId)

	if activityCfg then
		self._desc.text = activityCfg.extremeClgScoreDetails or {}
	end

	self._cfg = DivineJiClgConfig.instance:getExtremeFactorPlanCfgByStageId(self._activityId, self._stageId)

	self._scrollerList:reloadData(self._cfg)
end

function DivineJiScoreDescView:_updateCell(view, cell, data)
	local txtCol1 = goutil.findChildTextComponent(cell, "col_1/txt")
	local txtCol2 = goutil.findChildTextComponent(cell, "col_2/txt")
	local left, right = data.range[1], data.range[2]

	txtCol1.text = left == right and left or left .. "-" .. right
	txtCol2.text = data.factor

	local bgColor = goutil.findChild(cell, "bg"):GetComponent("UIImageColorChange")

	bgColor:SetState(cell.index % 2)
end

function DivineJiScoreDescView:_clearCell(cell)
	return
end

return DivineJiScoreDescView
