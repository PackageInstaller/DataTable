-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettitle/view/PetTitleShowSelectView.lua

module("logic.extensions.pettitle.view.PetTitleShowSelectView", package.seeall)

local PetTitleShowSelectView = class("PetTitleShowSelectView", TableViewComponent)

function PetTitleShowSelectView:ctor()
	PetTitleShowSelectView.super.ctor(self)
end

function PetTitleShowSelectView:_getPath()
	return {
		cellPath = "bg/petTitleCell",
		viewPath = "bg/petTitleView"
	}
end

function PetTitleShowSelectView:_cellSize(view, index)
	return 125, 125
end

function PetTitleShowSelectView:unbindEvents()
	PetTitleShowSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PetTitleShowSelectView:bindEvents()
	PetTitleShowSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PetTitleShowSelectView:buildUI()
	PetTitleShowSelectView.super.buildUI(self)

	self._btnClose = self:getBtn("closeBtn")
	self._emptyText = self:getGo("bg/emptyText")
end

function PetTitleShowSelectView:onExit()
	PetTitleShowSelectView.super.onExit(self)
end

function PetTitleShowSelectView:onEnter()
	PetTitleShowSelectView.super.onEnter(self)

	local params = self:getOpenParam()

	self._petMo = params[1]
	self._callback = params[2]
	self._curPetTitleId = self._petMo:getPetTitleId()

	local array = PetTitleModel.instance:getTitleMoArrayByRaceId(self._petMo.raceId)

	table.sort(array, function(moA, moB)
		return StringUtil.CompareTwoNumber(moA:getGainTime(), moB:getGainTime(), true)
	end)
	goutil.setActive(self._emptyText, #array == 0)

	if #array > 0 then
		table.insert(array, false)
	end

	self:updateListData(array)
end

function PetTitleShowSelectView:_updateCell(view, cell, data)
	GameUtil.rmClickHandler(GameUtil.asBtn(cell))

	local item = goutil.findChild(cell, "item")
	local remove = goutil.findChild(cell, "remove")
	local selectText = goutil.findChild(cell, "selectText")

	MaterialMgr.resetAll(item)

	local function callback()
		if data == false then
			GameUtil.callBack(self._callback, -1)
		else
			GameUtil.callBack(self._callback, data:getDefineId())
		end

		self:close()
	end

	if data == false then
		goutil.setActive(remove, true)
		goutil.setActive(selectText, false)
		GameUtil.addClickHandler(GameUtil.asBtn(cell), callback, self)
	else
		goutil.setActive(remove, false)
		goutil.setActive(selectText, data:getDefineId() == self._curPetTitleId)

		local proxy = MaterialMgr.setCell(data:getMatType(), data:getDefineId(), item)

		if proxy then
			proxy.binder:setGray(false)
			proxy:setAutoTips(false)
			proxy.binder:setClick(callback)
		end
	end
end

function PetTitleShowSelectView:_clearTableview(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(GameUtil.asBtn(cell))
end

return PetTitleShowSelectView
