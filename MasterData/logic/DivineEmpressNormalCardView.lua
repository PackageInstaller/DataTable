-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressNormalCardView.lua

module("logic.extensions.divineempress.view.DivineEmpressNormalCardView", package.seeall)

local DivineEmpressNormalCardView = class("DivineEmpressNormalCardView", ViewComponent)

function DivineEmpressNormalCardView:ctor()
	DivineEmpressNormalCardView.super.ctor(self)
end

function DivineEmpressNormalCardView:unbindEvents()
	DivineEmpressNormalCardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineEmpressNormalCardView:bindEvents()
	DivineEmpressNormalCardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineEmpressNormalCardView:buildUI()
	DivineEmpressNormalCardView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._buffTableCell = self:getGo("buffTableCell")
	self._buffTableView = self:getGo("buffTableView")
	self._buffTabelList = ScrollerList.create(self._buffTableView, self._buffTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineEmpressNormalCardView:onExit()
	DivineEmpressNormalCardView.super.onExit(self)
end

function DivineEmpressNormalCardView:onEnter()
	DivineEmpressNormalCardView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local normalBuffCfgs = DivineEmpressConfig.instance:getNormalBuffCfgs(self._activityId)

	self._buffTabelList:reloadData(normalBuffCfgs)
end

function DivineEmpressNormalCardView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtIndex = goutil.findChildTextComponent(go, "txtIndex")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local bgColorChange = goutil.findChildComponent(go, "bg", ComponentType.UIImageColorChange)

	txtIndex.text = data.buffId
	txtDesc.text = data.desc

	if data.buffId % 2 == 0 then
		bgColorChange:SetState(1)
	else
		bgColorChange:SetState(0)
	end
end

function DivineEmpressNormalCardView:_clearCell(cell)
	return
end

return DivineEmpressNormalCardView
