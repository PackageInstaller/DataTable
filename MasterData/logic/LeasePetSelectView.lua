-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/lease/LeasePetSelectView.lua

module("logic.extensions.tutorsystem.view.lease.LeasePetSelectView", package.seeall)

local LeasePetSelectView = class("LeasePetSelectView", ViewComponent)

function LeasePetSelectView:ctor()
	LeasePetSelectView.super.ctor(self)
end

function LeasePetSelectView:buildUI()
	LeasePetSelectView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._attrCol = goutil.findChild(self.mainGO, "attrCol")
	self._petScrollerview = goutil.findChild(self.mainGO, "petCol/petScrollerview")
	self._petScrollercell = goutil.findChild(self.mainGO, "petCol/petScrollercell")
	self._petScrollList = ScrollerList.create(self._petScrollerview, self._petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._selectEff = nil
	self._filterButton = self:getBtn("btnFilter")
	self._sortButton = self:getBtn("btnSort")
	self._sortBtnGo = self:getGo("btnSort")

	local RaceFilterGo = self:getGo("RaceFilter")

	self._raceFilter = ItemFilterExt.New(RaceFilterGo, 1, 7, false, "Cell", "Mark")
end

function LeasePetSelectView:bindEvents()
	LeasePetSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	self._filterButton:AddClickListener(self._onClickFilter, self)
	self._sortButton:AddClickListener(self._onClickSort, self)
	self._raceFilter:bindEvents()
	self._raceFilter:setValueChanged(self.updateFilterData, self)
end

function LeasePetSelectView:unbindEvents()
	LeasePetSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
	self._filterButton:RemoveClickListener()
	self._sortButton:RemoveClickListener()
	self._raceFilter:unbindEvents()
end

function LeasePetSelectView:destroyUI()
	LeasePetSelectView.super.destroyUI(self)
end

function LeasePetSelectView:onEnter()
	LeasePetSelectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._studentUserId = params[1]
	self._slotId = checknumber(params[2])

	if checknumber(self._studentUserId) == 0 or self._slotId == 0 then
		FloatWordMgr.instance:show("缺少传入参数")
		self:close()

		return
	end

	self._selectPetId = 0

	self:_onSetUI()
	self:_onUpdate()
end

function LeasePetSelectView:onExit()
	LeasePetSelectView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._selectEff)

	self._selectEff = nil

	self._petScrollList:dispose()
end

function LeasePetSelectView:_onSetUI()
	return
end

function LeasePetSelectView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function LeasePetSelectView:_onUpdateData()
	self:_updatePetData()
end

function LeasePetSelectView:_onUpdateUI()
	self:_updatePlaneUI()

	if BagPetsController.instance:getReady() then
		self:updateFilterData()
	end
end

function LeasePetSelectView:_updatePlaneUI()
	GameUtil.SetActive(self._btnSure, self._selectPetId ~= 0)
	GameUtil.SetActive(self._btnCancel, self._selectPetId ~= 0)
end

function LeasePetSelectView:updateFilterData(starList, jobList, rareList)
	local data = PetFilterMgr.instance:getFilterData(PetFilterMgr.TYPE_PETVIEW)

	self._raceFilter:initData(data.raceSelectList)
	self._raceFilter:initActiveList(data.raceActiveList)
	self._raceFilter:initClickAble(data.raceClickAble)
	self:_RefreshPetList()
end

function LeasePetSelectView:_RefreshPetList(force)
	self._curViewDatas = {}
	self._allPets = BagPetsController.instance:getBagPets()

	for k, v in pairs(self._allPets) do
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end

	local names, opt = BagModel.instance:GetSortParms()

	ArraySort.sortOn(self._curViewDatas, names, opt)
	BagModel.instance:setCurPetViewList(self._curViewDatas)

	self._curViewDatas = self:_doCustomFilter(self._curViewDatas)

	self:_updatePetScrollerList()
end

function LeasePetSelectView:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)

	return (self:_isMatch(petCo, pet.rare, pet.curFaceId))
end

function LeasePetSelectView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, cfg, rare, skinId)
end

function LeasePetSelectView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function LeasePetSelectView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._filterButton.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function LeasePetSelectView:_doCustomFilter(petMoList)
	local hirePetInfos = TutorSystemModel.instance:getHirePetInfoListInTeaLease(self._studentUserId)
	local hasHirePetIdList = {}

	for _, info in ipairs(hirePetInfos) do
		hasHirePetIdList[info.petId] = true
	end

	local sameRaceIdList = {}

	for _, info in ipairs(hirePetInfos) do
		sameRaceIdList[info.petView.raceId] = true
	end

	local zdlMap = {}
	local moList = {}

	for _, petMo in pairs(petMoList) do
		local petId = petMo:getPetId()
		local raceId = petMo:getDefineId()
		local zdl = petMo:getFightingPower()
		local isNotHasHire = hasHirePetIdList[petId] ~= true
		local isNotSameRaceId = sameRaceIdList[raceId] ~= true

		if not zdlMap[raceId] then
			local curMaxZdl = -1
			local isMaxZdl = curMaxZdl < zdl

			zdlMap[raceId] = curMaxZdl < zdl and zdl or curMaxZdl

			if isNotHasHire and isNotSameRaceId and isMaxZdl then
				table.insert(moList, petMo)
			end
		end
	end

	return moList
end

function LeasePetSelectView:onRefreshPetSort(idx, onResetCallback)
	BagModel.instance:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, BagModel.instance:GetSortState())

	local names, opt = BagModel.instance:GetSortParms()

	ArraySort.sortOn(self._curViewDatas, names, opt)
	BagModel.instance:setCurPetViewList(self._curViewDatas)

	self._curViewDatas = self:_doCustomFilter(self._curViewDatas)

	self:_updatePetScrollerList()
end

function LeasePetSelectView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._sortButton.gameObject)
	local arr = BagModel.instance:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self.onRefreshPetSort, self))
end

function LeasePetSelectView:_updatePetData()
	return
end

function LeasePetSelectView:_updatePetScrollerList()
	self._petScrollList:reloadData(self._curViewDatas)
end

function LeasePetSelectView:_updatePetCell(view, cell, petMo, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local txtLevel = goutil.findChildTextComponent(mainGo, "level/txt")
	local txtZdl = goutil.findChildTextComponent(mainGo, "zdl/txt")

	txtLevel.text = petMo:getPetLv() .. "级"
	txtZdl.text = petMo:getFightingPower()

	local isSelected = self._selectPetId == petMo.petId

	self:_setMatSelect(petMo.curFaceId, item, isSelected)

	if isSelected then
		self:_addClickEff(item)
	else
		self:_clearClickEff()
	end

	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickPetCell, self, mainGo, petMo))
end

function LeasePetSelectView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnSelect)
end

function LeasePetSelectView:_onClickPetCell(mainGo, petMo)
	local item = goutil.findChild(mainGo, "item")

	if self._selectPetId == petMo.petId then
		self._selectPetId = 0
	else
		self._selectPetId = petMo.petId

		self:_addClickEff(item)
	end

	self:_updatePlaneUI()
	self:_updatePetScrollerList()
end

function LeasePetSelectView:_setMatSelect(faceId, go, isSelected)
	local matStr = string.format("%s:%s:%s", MatType.Pet, faceId, 0)
	local proxy = MaterialMgr.setCellByCfg(matStr, go)

	proxy.binder:setAutoTips(false)
	proxy.binder:setSelected(isSelected)
	proxy.binder:setLvl(0)
end

function LeasePetSelectView:_addClickEff(go)
	if go == nil then
		return
	end

	local effGo = go
	local path = "fx_ui_zhuangbeijiemian/fx_ui_fangru_zhuangbei"
	local pathName = path .. ".prefab"

	local function func(_, eff)
		eff:setParent(effGo.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)
	end

	self:_clearClickEff()

	self._selectEff = UIEffectManager.instance:playEffect(self, pathName, effGo, 0, 0, false, false, nil, func, nil)
end

function LeasePetSelectView:_clearClickEff()
	UIEffectManager.instance:stopEffect(self._selectEff)

	self._selectEff = nil
end

function LeasePetSelectView:_onClickSure()
	if checknumber(self._selectPetId) == 0 then
		FloatWordMgr.instance:show("未选择精灵")

		return
	end

	TutorSystemController.instance:sendTutorTeacherSetHirePetReq(self._studentUserId, self._slotId, self._selectPetId)
	self:close()
end

return LeasePetSelectView
