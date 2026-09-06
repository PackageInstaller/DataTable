-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/view/OriginaresmomextresultView.lua

module("logic.extensions.originaresmom.view.OriginaresmomextresultView", package.seeall)

local OriginaresmomextresultView = class("OriginaresmomextresultView", ViewComponent)

function OriginaresmomextresultView:ctor()
	OriginaresmomextresultView.super.ctor(self)
end

function OriginaresmomextresultView:unbindEvents()
	OriginaresmomextresultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function OriginaresmomextresultView:bindEvents()
	OriginaresmomextresultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function OriginaresmomextresultView:buildUI()
	OriginaresmomextresultView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._txtNum = self:getTxt("txtNum")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginaresmomextresultView:onExit()
	OriginaresmomextresultView.super.onExit(self)
	self._scrollerList:dispose()
end

function OriginaresmomextresultView:onEnter()
	OriginaresmomextresultView.super.onEnter(self)

	local params = self:getFirstParam()
	local activityId = params.activityId
	local petBuffSignCount = params.petBuffSignCount

	if params.stageInfo then
		self._lockRaceIds = params.stageInfo.lockRaceIds or {}
	end

	local actCfg = OriginaresmomConfig.instance:getActCfg(activityId)
	local score = 0

	table.sort(petBuffSignCount, function(a, b)
		return a.right > b.right
	end)

	for i, v in ipairs(petBuffSignCount) do
		score = score + v.right * actCfg.buffEnergy
	end

	self._txtNum.text = score

	self._scrollerList:reloadData(petBuffSignCount)
end

function OriginaresmomextresultView:_onClickbtnSure()
	BattleFacade.instance:endBattle()
end

function OriginaresmomextresultView:_updateCell(view, cell, data, tag)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local txtEnergy = goutil.findChildTextComponent(cell.gameObject, "txtEnergy")
	local goLock = goutil.findChild(cell.gameObject, "lock")
	local petMo = BagPetsController.instance:getPet(data.left)
	local showLock = table.indexof(self._lockRaceIds, petMo.raceId)

	MaterialMgr.setCellByMo(petMo, goCon)

	txtEnergy.text = data.right

	goutil.setActive(goLock, showLock)
end

function OriginaresmomextresultView:_clearCell(cell)
	local goCon = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.resetAll(goCon)
end

return OriginaresmomextresultView
