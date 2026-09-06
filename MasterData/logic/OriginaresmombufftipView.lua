-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/view/OriginaresmombufftipView.lua

module("logic.extensions.originaresmom.view.OriginaresmombufftipView", package.seeall)

local OriginaresmombufftipView = class("OriginaresmombufftipView", ViewComponent)

function OriginaresmombufftipView:ctor()
	OriginaresmombufftipView.super.ctor(self)
end

function OriginaresmombufftipView:unbindEvents()
	OriginaresmombufftipView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function OriginaresmombufftipView:bindEvents()
	OriginaresmombufftipView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function OriginaresmombufftipView:buildUI()
	OriginaresmombufftipView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginaresmombufftipView:onExit()
	OriginaresmombufftipView.super.onExit(self)
	self._scrollerList:dispose()
end

function OriginaresmombufftipView:onEnter()
	OriginaresmombufftipView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local actCfg = OriginaresmomConfig.instance:getActCfg(self._activityId)
	local buffCfgs = OriginaresmomConfig.instance:getBuffCfgs(actCfg.energyAddBuffPlanId)

	self._totalScore = OriginaresmomModel.instance:getExtStageTotalScore(self._activityId)
	self._newBuffCfgs = table.values(buffCfgs)

	table.sort(self._newBuffCfgs, function(a, b)
		return a.startEnergy < b.startEnergy
	end)
	self._scrollerList:reloadData(self._newBuffCfgs)
end

function OriginaresmombufftipView:_onClickbtnSure()
	self:close()
end

function OriginaresmombufftipView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtDuration = goutil.findChildTextComponent(cell.gameObject, "txtDuration")
	local imgChange = goutil.findChild(cell.gameObject, "img"):GetComponent(ComponentType.UIImageColorChange)
	local goCurr = goutil.findChild(cell.gameObject, "curr")
	local nextBuffCfg = self._newBuffCfgs[cell.data + 1]
	local isCurr = false

	if nextBuffCfg then
		isCurr = self._totalScore >= data.startEnergy and self._totalScore < nextBuffCfg.startEnergy
		txtDuration.text = string.format("%s~%s", data.startEnergy, nextBuffCfg.startEnergy - 1)
	else
		isCurr = self._totalScore >= data.startEnergy
		txtDuration.text = string.format("%s及以上", data.startEnergy)
	end

	txtDesc.text = data.desc

	imgChange:SetState(isCurr and 0 or cell.data % 2 == 0 and 1 or 2)
	goutil.setActive(goCurr, isCurr)
end

function OriginaresmombufftipView:_clearCell(cell)
	return
end

return OriginaresmombufftipView
