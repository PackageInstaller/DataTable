-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/view/OriginxingjiangbufftipView.lua

module("logic.extensions.orixingjiang.view.OriginxingjiangbufftipView", package.seeall)

local OriginxingjiangbufftipView = class("OriginxingjiangbufftipView", ViewComponent)

function OriginxingjiangbufftipView:ctor()
	OriginxingjiangbufftipView.super.ctor(self)
end

function OriginxingjiangbufftipView:unbindEvents()
	OriginxingjiangbufftipView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function OriginxingjiangbufftipView:bindEvents()
	OriginxingjiangbufftipView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function OriginxingjiangbufftipView:buildUI()
	OriginxingjiangbufftipView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(function()
		self:_onReloadFinish()
	end)
end

function OriginxingjiangbufftipView:onExit()
	OriginxingjiangbufftipView.super.onExit(self)
	self._scrollerList:dispose()
end

function OriginxingjiangbufftipView:onEnter()
	OriginxingjiangbufftipView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local actCfg = OrixingjiangConfig.instance:getActCfg(self._activityId)
	local buffCfgs = OrixingjiangConfig.instance:getBuffCfgs(self._activityId)

	self._totalScore = OrixingjiangModel.instance:getAliveTransmogNum(self._activityId)
	self._newBuffCfgs = table.values(buffCfgs)

	table.sort(self._newBuffCfgs, function(a, b)
		return a.aliveTransmogNum < b.aliveTransmogNum
	end)
	self._scrollerList:reloadData(self._newBuffCfgs)
end

function OriginxingjiangbufftipView:_onClickbtnSure()
	self:close()
end

function OriginxingjiangbufftipView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtDuration = goutil.findChildTextComponent(cell.gameObject, "txtDuration")
	local imgChange = goutil.findChild(cell.gameObject, "img"):GetComponent(ComponentType.UIImageColorChange)
	local goCurr = goutil.findChild(cell.gameObject, "curr")
	local nextBuffCfg = self._newBuffCfgs[cell.data + 1]
	local isCurr = false

	if nextBuffCfg then
		isCurr = self._totalScore >= data.aliveTransmogNum and self._totalScore < nextBuffCfg.aliveTransmogNum
		txtDuration.text = string.format("%s~%s", data.aliveTransmogNum, nextBuffCfg.aliveTransmogNum - 1)
	else
		isCurr = self._totalScore >= data.aliveTransmogNum
		txtDuration.text = string.format("%s及以上", data.aliveTransmogNum)
	end

	txtDesc.text = data.desc

	imgChange:SetState(isCurr and 0 or cell.data % 2 == 0 and 1 or 2)
	goutil.setActive(goCurr, isCurr)
end

function OriginxingjiangbufftipView:_clearCell(cell)
	return
end

function OriginxingjiangbufftipView:_onReloadFinish()
	for i = #self._newBuffCfgs, 1, -1 do
		local data = self._newBuffCfgs[i]

		if self._totalScore >= data.aliveTransmogNum then
			self._scrollerList:MoveCellToBegin(i - 1)

			break
		end
	end
end

return OriginxingjiangbufftipView
