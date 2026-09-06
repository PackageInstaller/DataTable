-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiBuffDescView.lua

module("logic.extensions.divinejiclg.view.DivineJiBuffDescView", package.seeall)

local DivineJiBuffDescView = class("DivineJiBuffDescView", ViewComponent)

function DivineJiBuffDescView:ctor()
	DivineJiBuffDescView.super.ctor(self)
end

function DivineJiBuffDescView:buildUI()
	DivineJiBuffDescView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._desc = self:getTxt("desc")
	self._table = self:getGo("table")
	self._row = self:getGo("table/row")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/row")
	self._scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineJiBuffDescView:bindEvents()
	DivineJiBuffDescView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineJiBuffDescView:unbindEvents()
	DivineJiBuffDescView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineJiBuffDescView:onExit()
	DivineJiBuffDescView.super.onExit(self)
	self._scrollerList:dispose()
end

function DivineJiBuffDescView:onEnter()
	DivineJiBuffDescView.super.onEnter(self)

	local param = self:getOpenParam()

	if TableUtil.isTableEmpty(param) then
		self:close()

		return
	end

	self._activityId = checknumber(param[1])
	self._stageId = checknumber(param[2])
	self._stageCfg = DivineJiClgConfig.instance:getExtremeSingleStageCfg(self._activityId, self._stageId)
	self._cfg = DivineJiClgConfig.instance:getExtremeStageBuffPlan(self._activityId, self._stageId)
	self._desc.text = self._stageCfg.buffDetails

	self._scrollerList:reloadData(self._cfg)
end

function DivineJiBuffDescView:_updateCell(view, cell, data)
	local txtCol1 = goutil.findChildTextComponent(cell, "col_1/txt")
	local txtCol2 = goutil.findChildTextComponent(cell, "col_2/txt")
	local txtCol3 = goutil.findChildTextComponent(cell, "col_3/txt")
	local left, right = data.range[1], data.range[2]

	txtCol1.text = self._stageCfg.attrType
	txtCol2.text = left == right and left or left .. "-" .. right
	txtCol3.text = data.buffdescription or "无buff加成"

	local bgColor = goutil.findChild(cell, "bg"):GetComponent("UIImageColorChange")

	bgColor:SetState(cell.index % 2)
end

function DivineJiBuffDescView:_clearCell(cell)
	return
end

return DivineJiBuffDescView
