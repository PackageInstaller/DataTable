-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiBattleResultlView.lua

module("logic.extensions.divinejiclg.view.DivineJiBattleResultlView", package.seeall)

local DivineJiBattleResultlView = class("DivineJiBattleResultlView", ViewComponent)

function DivineJiBattleResultlView:ctor()
	DivineJiBattleResultlView.super.ctor(self)
end

function DivineJiBattleResultlView:buildUI()
	DivineJiBattleResultlView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._table = self:getGo("table")
	self._row = self:getGo("table/row")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineJiBattleResultlView:bindEvents()
	DivineJiBattleResultlView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineJiBattleResultlView:unbindEvents()
	DivineJiBattleResultlView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineJiBattleResultlView:onExit()
	DivineJiBattleResultlView.super.onExit(self)
	self._scrollerList:dispose()
end

function DivineJiBattleResultlView:onEnter()
	DivineJiBattleResultlView.super.onEnter(self)

	self._info = self:getFirstParam()

	if not self._info then
		self:close()

		return
	end

	self._raceInfo = self._info.raceInfo
	self._targetPetCount = 0

	for i, v in ipairs(self._raceInfo) do
		if v.isTargetRace > 0 then
			self._targetPetCount = self._targetPetCount + 1
		end
	end

	self:refreshTable()
	self._scrollerList:setCenterMode(true)
	self._scrollerList:reloadData(self._raceInfo)
end

function DivineJiBattleResultlView:refreshTable()
	local txtCol1 = goutil.findChildTextComponent(self._row, "col_1/txt")
	local txtCol2 = goutil.findChildTextComponent(self._row, "col_2/txt")
	local txtCol3 = goutil.findChildTextComponent(self._row, "col_3/txt")
	local txtCol4 = goutil.findChildTextComponent(self._row, "col_4/txt")

	txtCol1.text = self._info.baseScore
	txtCol2.text = self._targetPetCount
	txtCol3.text = self._info.factor
	txtCol4.text = self._info.finalScore
end

function DivineJiBattleResultlView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local tag = goutil.findChild(cell, "tag")

	MaterialMgr.setCell(MatType.Pet, data.raceId, item)
	goutil.setActive(tag, data.isTargetRace > 0)
end

function DivineJiBattleResultlView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function DivineJiBattleResultlView:close()
	if self._info.passExtremeClg then
		UIJumper.instance:removeTopState(ViewName.DivineJiExtremeClgView)
		CustomFmtController.instance:showCommonPassViewWithJump(self._info.changeSetId)
	end

	BattleController.instance:endBattle()
	DivineJiBattleResultlView.super.close(self)
end

return DivineJiBattleResultlView
