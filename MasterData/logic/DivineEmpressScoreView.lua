-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressScoreView.lua

module("logic.extensions.divineempress.view.DivineEmpressScoreView", package.seeall)

local DivineEmpressScoreView = class("DivineEmpressScoreView", ViewComponent)

function DivineEmpressScoreView:ctor()
	DivineEmpressScoreView.super.ctor(self)
end

function DivineEmpressScoreView:unbindEvents()
	DivineEmpressScoreView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineEmpressScoreView:bindEvents()
	DivineEmpressScoreView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineEmpressScoreView:buildUI()
	DivineEmpressScoreView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._scoreTableCell = self:getGo("scoreTableCell")
	self._scoreTableView = self:getGo("scoreTableView")
	self._scoreTableList = ScrollerList.create(self._scoreTableView, self._scoreTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineEmpressScoreView:onExit()
	DivineEmpressScoreView.super.onExit(self)
end

function DivineEmpressScoreView:onEnter()
	DivineEmpressScoreView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	local scoreCfgs = DivineEmpressConfig.instance:getScoreCfgs(self._activityId)
	local list = {}

	for i, v in pairs(scoreCfgs) do
		table.insert(list, v)
	end

	list = ArraySort.sortOn(list, "scoreRange", ArraySort.NONE)

	local result = {}
	local last = 0

	for i, v in ipairs(list) do
		table.insert(result, {
			cfg = v,
			upLilmit = last,
			index = i
		})

		last = v.scoreRange + 1
	end

	self._scoreTableList:reloadData(result)
end

function DivineEmpressScoreView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local bgColorChange = goutil.findChildComponent(go, "bg", ComponentType.UIImageColorChange)
	local txtRange = goutil.findChildTextComponent(go, "txtScore")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")

	txtRange.text = string.format("%d-%d", data.upLilmit, data.cfg.scoreRange)
	txtDesc.text = langPara("破阵，且免疫次数大于等于%d", data.cfg.immunityTimes)

	if data.index % 2 == 0 then
		bgColorChange:SetState(1)
	else
		bgColorChange:SetState(0)
	end
end

function DivineEmpressScoreView:_clearCell(cell)
	return
end

return DivineEmpressScoreView
