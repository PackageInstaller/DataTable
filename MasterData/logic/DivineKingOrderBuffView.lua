-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/view/DivineKingOrderBuffView.lua

module("logic.extensions.divinekingorderclg.view.DivineKingOrderBuffView", package.seeall)

local DivineKingOrderBuffView = class("DivineKingOrderBuffView", ViewComponent)

function DivineKingOrderBuffView:ctor()
	DivineKingOrderBuffView.super.ctor(self)
end

function DivineKingOrderBuffView:unbindEvents()
	DivineKingOrderBuffView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DivineKingOrderBuffView:bindEvents()
	DivineKingOrderBuffView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function DivineKingOrderBuffView:buildUI()
	DivineKingOrderBuffView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._goEmpty = self:getGo("goEmpty")

	local cell = self:getGo("cell")
	local tab = self:getGo("tableview")

	self._tableview = ScrollerList.create(tab, cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineKingOrderBuffView:onExit()
	DivineKingOrderBuffView.super.onExit(self)
	self._tableview:dispose()
end

function DivineKingOrderBuffView:onEnter()
	DivineKingOrderBuffView.super.onEnter(self)

	self._curActId = DivineKingOrderClgModel.instance:getActivityId()

	local infos = DivineKingOrderClgModel.instance:getCurSoulInfos()
	local dataList = {}

	for _, info in pairs(infos) do
		table.insert(dataList, info)
	end

	self._tableview:reloadData(dataList)
	goutil.setActive(self._goEmpty, #dataList == 0)
end

function DivineKingOrderBuffView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	MaterialMgr.setCell(MatType.Pet, data.raceId, cell.icon)

	cell.txtNumWater.text = "x" .. data.waterSoulCount
	cell.txtDescWater.text = DivineKingOrderClgConfig.instance:getWaterBuffDesc(self._curActId, data.waterSoulCount)
	cell.txtNumKong.text = "x" .. data.kongSoulCount
	cell.txtDescKong.text = DivineKingOrderClgConfig.instance:getKongBuffDesc(self._curActId, data.kongSoulCount)
end

function DivineKingOrderBuffView:_clearCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.icon = goutil.findChild(cell.go, "icon")

	MaterialMgr.resetAll(cell.icon)

	cell.txtNumWater = goutil.findChildTextComponent(cell.go, "waterBuff/txtNum")
	cell.txtDescWater = goutil.findChildTextComponent(cell.go, "waterBuff/txtDesc")
	cell.txtNumKong = goutil.findChildTextComponent(cell.go, "kongBuff/txtNum")
	cell.txtDescKong = goutil.findChildTextComponent(cell.go, "kongBuff/txtDesc")

	return cell
end

return DivineKingOrderBuffView
