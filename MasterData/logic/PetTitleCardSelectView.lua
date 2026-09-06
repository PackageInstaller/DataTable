-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/PetTitleCardSelectView.lua

module("logic.extensions.roleinfo.view.PetTitleCardSelectView", package.seeall)

local PetTitleCardSelectView = class("PetTitleCardSelectView", TableViewComponent)

function PetTitleCardSelectView:ctor()
	PetTitleCardSelectView.super.ctor(self)
end

function PetTitleCardSelectView:_getPath()
	return {
		cellPath = "bg/petTitleCell",
		viewPath = "bg/petTitleView"
	}
end

function PetTitleCardSelectView:_cellSize(view, index)
	return 125, 125
end

function PetTitleCardSelectView:unbindEvents()
	PetTitleCardSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PetTitleCardSelectView:bindEvents()
	PetTitleCardSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PetTitleCardSelectView:buildUI()
	PetTitleCardSelectView.super.buildUI(self)

	self._btnClose = self:getBtn("closeBtn")
	self._emptyText = self:getGo("bg/emptyText")
end

function PetTitleCardSelectView:onExit()
	PetTitleCardSelectView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PetTitleModelInit, self._updatePetTitleData, self)
	GlobalDispatcher:removeListener(GlobalNotify.PetTitleModelChange, self._updatePetTitleData, self)
end

function PetTitleCardSelectView:onEnter()
	PetTitleCardSelectView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local petTitles = params[1]

	self._curIndex = checknumber(params[2])
	self._curPetTitleId = petTitles[self._curIndex] or 0
	self._callback = params[3]
	self._petTitles = {}

	for i, v in ipairs(petTitles) do
		table.insert(self._petTitles, v)
	end

	PetTitleController.instance:reqServerData()
	GlobalDispatcher:addListener(GlobalNotify.PetTitleModelInit, self._updatePetTitleData, self)
	GlobalDispatcher:addListener(GlobalNotify.PetTitleModelChange, self._updatePetTitleData, self)
end

function PetTitleCardSelectView:_updatePetTitleData()
	local arrayT = PetTitleModel.instance:getTitleArray()
	local array = {}
	local hasMap = {}

	for i, v in ipairs(self._petTitles) do
		hasMap[v] = true
	end

	for i, v in ipairs(arrayT) do
		if not hasMap[v:getDefineId()] then
			table.insert(array, v)
		end
	end

	table.sort(array, function(moA, moB)
		return StringUtil.CompareTwoNumber(moA:getGainTime(), moB:getGainTime(), true)
	end)
	goutil.setActive(self._emptyText, #array == 0)

	if self._curPetTitleId > 0 then
		table.insert(array, 1, false)
	end

	self:updateListData(array)
end

function PetTitleCardSelectView:_updateCell(view, cell, data)
	GameUtil.rmClickHandler(GameUtil.asBtn(cell))

	local remove = goutil.findChild(cell, "remove")

	MaterialMgr.resetAll(cell.gameObject)

	local function callback()
		if data == false then
			table.remove(self._petTitles, self._curIndex)
		elseif self._curPetTitleId > 0 then
			self._petTitles[self._curIndex] = data:getDefineId()
		else
			table.insert(self._petTitles, data:getDefineId())
		end

		GameUtil.callBack(self._callback, self._petTitles)
		self:close()
	end

	if data == false then
		goutil.setActive(remove, true)
		GameUtil.addClickHandler(GameUtil.asBtn(cell), callback, self)
	else
		goutil.setActive(remove, false)

		local proxy = MaterialMgr.setCell(data:getMatType(), data:getDefineId(), cell.gameObject)

		if proxy then
			proxy.binder:setGray(false)
			proxy:setAutoTips(false)
			proxy.binder:setClick(callback)
		end
	end
end

function PetTitleCardSelectView:_clearTableview(cell)
	MaterialMgr.resetAll(cell.gameObject)
	GameUtil.rmClickHandler(GameUtil.asBtn(cell))
end

return PetTitleCardSelectView
