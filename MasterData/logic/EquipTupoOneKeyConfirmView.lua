-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipTupoOneKeyConfirmView.lua

module("logic.extensions.equipment.view.EquipTupoOneKeyConfirmView", package.seeall)

local EquipTupoOneKeyConfirmView = class("EquipTupoOneKeyConfirmView", ViewComponent)

function EquipTupoOneKeyConfirmView:ctor()
	EquipTupoOneKeyConfirmView.super.ctor(self)
end

function EquipTupoOneKeyConfirmView:unbindEvents()
	EquipTupoOneKeyConfirmView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function EquipTupoOneKeyConfirmView:bindEvents()
	EquipTupoOneKeyConfirmView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function EquipTupoOneKeyConfirmView:buildUI()
	EquipTupoOneKeyConfirmView.super.buildUI(self)

	self._btnCancel = self:getGo("btnCancel")
	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._tablecell = self:getGo("tablecell")
	self._resultTableview = self:getGo("resultTableview")
	self._resultTableList = ScrollerList.create(self._resultTableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._costTableview = self:getGo("costTableview")
	self._costTableList = ScrollerList.create(self._costTableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function EquipTupoOneKeyConfirmView:onExit()
	EquipTupoOneKeyConfirmView.super.onExit(self)
end

function EquipTupoOneKeyConfirmView:onEnter()
	EquipTupoOneKeyConfirmView.super.onEnter(self)

	local selectInfoList = self:getFirstParam()
	local costList = {}
	local matList = {}
	local resultConList = {}
	local coinCount = 0

	for i, v in ipairs(selectInfoList) do
		table.insert(costList, {
			type = MatType.Equipment,
			data = v.resultInfo.mainEquip
		})

		for j, costMo in ipairs(v.resultInfo.costMoList) do
			table.insert(costList, {
				type = MatType.Equipment,
				data = costMo
			})
		end

		if v.resultInfo.costItem then
			table.insert(matList, v.resultInfo.costItem)
		end

		table.insert(resultConList, {
			type = MatType.Equipment,
			data = v.resultInfo.result
		})

		for matId, matNum in pairs(v.useItem) do
			if matNum > 0 then
				table.insert(matList, string.format("%s:%s:%s", MatType.Item, matId, matNum))
			end
		end

		if v.useCoin > 0 then
			coinCount = coinCount + v.useCoin
		end
	end

	local matResult = MaterialMgr.combineItemsToList(matList)

	for i, v in ipairs(matResult) do
		table.insert(costList, {
			type = MatType.Item,
			data = v
		})
	end

	if coinCount > 0 then
		table.insert(costList, {
			type = MatType.Coin,
			data = coinCount
		})
	end

	self._resultTableList:reloadData(resultConList)
	self._costTableList:reloadData(costList)
end

function EquipTupoOneKeyConfirmView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local petIconGo = goutil.findChild(go, "petIconGo")
	local petIconCon = goutil.findChild(petIconGo, "icon")

	if data.type == MatType.Item then
		MaterialMgr.setCellByCfg(data.data, con)
		GameUtil.SetActive(petIconGo, false)
	elseif data.type == MatType.Coin then
		local proxy = MaterialMgr.setCell(MatType.Coin, 1, con)

		proxy.binder:setNum(data.data)
		GameUtil.SetActive(petIconGo, false)
	elseif data.type == MatType.Equipment then
		MaterialMgr.setCellByData(MatType.Equipment, data.data, con)
		GameUtil.SetActive(petIconGo, checknumber(data.data.equipPetId) > 0)

		if checknumber(data.data.equipPetId) > 0 then
			local petMo = BagPetsController.instance:getPet(data.data.equipPetId)

			MaterialMgr.setIcon(petIconCon, MatType.Pet, petMo.raceId)
		end
	end
end

function EquipTupoOneKeyConfirmView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function EquipTupoOneKeyConfirmView:_onClickSure()
	local selectInfoList = self:getFirstParam()
	local infoList = {}

	for i, v in ipairs(selectInfoList) do
		local info = {}

		info.mainEquipmentId = v.resultInfo.mainEquip.onlyId
		info.otherEquipmentIds = {}

		for j, costMo in ipairs(v.resultInfo.costMoList) do
			table.insert(info.otherEquipmentIds, costMo.onlyId)
		end

		info.matList = {}

		for matId, matNum in pairs(v.useItem) do
			table.insert(info.matList, {
				id = matId,
				num = matNum
			})
		end

		info.upgradeAfterBreakout = v.isMaxLevel or false

		table.insert(infoList, info)
	end

	PetEquipController.instance:sendEQM_BatchBreakoutReq(infoList)
	self:close()
end

return EquipTupoOneKeyConfirmView
