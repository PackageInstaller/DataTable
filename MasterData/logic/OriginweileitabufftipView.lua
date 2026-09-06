-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/view/OriginweileitabufftipView.lua

module("logic.extensions.originweileita.view.OriginweileitabufftipView", package.seeall)

local OriginweileitabufftipView = class("OriginweileitabufftipView", ViewComponent)

function OriginweileitabufftipView:ctor()
	OriginweileitabufftipView.super.ctor(self)
end

function OriginweileitabufftipView:unbindEvents()
	OriginweileitabufftipView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function OriginweileitabufftipView:bindEvents()
	OriginweileitabufftipView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function OriginweileitabufftipView:buildUI()
	OriginweileitabufftipView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(function()
		self:_onReloadFinish()
	end)
end

function OriginweileitabufftipView:onExit()
	OriginweileitabufftipView.super.onExit(self)
	self._scrollerList:dispose()
end

function OriginweileitabufftipView:onEnter()
	OriginweileitabufftipView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local actCfg = OriginWeiLeiTaConfig.instance:getActCfg(self._activityId)
	local buffCfgs = OriginWeiLeiTaConfig.instance:getBuffCfgs(self._activityId)

	self._totalScore = OriginWeiLeiTaModel.instance:getTodayMaxScore(self._activityId)
	self._newBuffCfgs = table.values(buffCfgs)

	table.sort(self._newBuffCfgs, function(a, b)
		return a.progress < b.progress
	end)
	self._scrollerList:reloadData(self._newBuffCfgs)
end

function OriginweileitabufftipView:_onClickbtnSure()
	self:close()
end

function OriginweileitabufftipView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtDuration = goutil.findChildTextComponent(cell.gameObject, "txtDuration")
	local imgChange = goutil.findChild(cell.gameObject, "img"):GetComponent(ComponentType.UIImageColorChange)
	local goCurr = goutil.findChild(cell.gameObject, "curr")
	local nextBuffCfg = self._newBuffCfgs[cell.data + 1]
	local isCurr = false

	if nextBuffCfg then
		isCurr = self._totalScore >= data.progress and self._totalScore < nextBuffCfg.progress
		txtDuration.text = string.format("%s~%s", data.progress, nextBuffCfg.progress - 1)
	else
		isCurr = self._totalScore >= data.progress
		txtDuration.text = string.format("%s及以上", data.progress)
	end

	txtDesc.text = data.desc

	imgChange:SetState(isCurr and 0 or cell.data % 2 == 0 and 1 or 2)
	goutil.setActive(goCurr, isCurr)
end

function OriginweileitabufftipView:_clearCell(cell)
	return
end

function OriginweileitabufftipView:_onReloadFinish()
	for i = #self._newBuffCfgs, 1, -1 do
		local data = self._newBuffCfgs[i]

		if self._totalScore >= data.progress then
			self._scrollerList:MoveCellToBegin(i - 1)

			break
		end
	end
end

return OriginweileitabufftipView
