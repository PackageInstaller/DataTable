-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipBagPetListView.lua

module("logic.extensions.equipment.view.EquipBagPetListView", package.seeall)

local EquipBagPetListView = class("EquipBagPetListView", ViewComponent)

function EquipBagPetListView:buildUI()
	EquipBagPetListView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnFilter = self:getGo("infoGo/btnFilter")

	local petScrCell = self:getGo("infoGo/petCol/scrCell")
	local petScrView = self:getGo("infoGo/petCol/scrView")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function EquipBagPetListView:bindEvents()
	EquipBagPetListView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
end

function EquipBagPetListView:unbindEvents()
	EquipBagPetListView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnFilter)
end

function EquipBagPetListView:onEnter()
	EquipBagPetListView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local petId = params[1]

	self._selectPetId = petId and checknumber(petId) or self._selectPetId or 0

	self:_onUpdate()
end

function EquipBagPetListView:onExit()
	EquipBagPetListView.super.onExit(self)
	self:_onClearPetCol()
end

function EquipBagPetListView:_onUpdate()
	self._petMoList = BagPetsController.instance:getFightBagPet()

	self:_onUpdatePetColUI()
end

function EquipBagPetListView:_onUpdatePetColUI()
	self._viewPetMoList = {}

	for _, petMo in pairs(self._petMoList) do
		if self:onFilter(petMo) then
			table.insert(self._viewPetMoList, petMo)
		end
	end

	local names, opt = BagModel.instance:GetSortParms()

	ArraySort.sortOn(self._viewPetMoList, names, opt)
	self._petScrollerList:reloadData(self._viewPetMoList)

	local index = 1

	for idx, petMo in ipairs(self._viewPetMoList) do
		if self._selectPetId == petMo:getPetId() then
			index = idx

			break
		end
	end

	self._petScrollerList:MoveCellToCenter(index - 1)
end

function EquipBagPetListView:_onClearPetCol()
	self._petScrollerList:dispose()
end

function EquipBagPetListView:_updatePetCell(view, cell, petMo, tag)
	local isSelected = self._selectPetId == petMo:getPetId()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local proxy = MaterialMgr.setCell(MatType.Pet, petMo.curFaceId, item)

	if proxy then
		proxy.binder:setSelected(isSelected)
		proxy.binder:setClickCallBack(function()
			if self._selectPetId == petMo:getPetId() then
				return
			end

			local equipInfoMo
			local equipIdList = PetEquipModel.instance:getUnloadListInEquips(petMo)

			for _, equipId in ipairs(equipIdList) do
				local data = MaterialMgr.getModel(MatType.Equipment, equipId)

				if data and data:isWearEquip() then
					equipInfoMo = data

					break
				end
			end

			local onlyId = equipInfoMo and equipInfoMo:getId() or 0

			self._selectPetId = petMo:getPetId()

			self:_onUpdatePetColUI()
			GlobalDispatcher:dispatch(GlobalNotify.PET_EQUIP_SELECT, onlyId)
		end)
	end
end

function EquipBagPetListView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function EquipBagPetListView:_updateFilter(filterType)
	self:_onUpdatePetColUI()
end

function EquipBagPetListView:onFilter(petMo)
	if not petMo:isExist() then
		return false
	end

	local isHit = true

	if isHit then
		local petCo = CharacterConfig.instance:getPetCo(petMo:getDefineId())

		isHit = PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, petCo, petMo:getRare(), petMo.curFaceId)
	end

	if isHit then
		local list = PetEquipModel.instance:getUnloadListInEquips(petMo)

		isHit = #list > 0
	end

	return isHit
end

function EquipBagPetListView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function EquipBagPetListView:_onClickClose()
	self:close()
end

function EquipBagPetListView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, GameUtil.handler(self._updateFilter, self))
end

return EquipBagPetListView
