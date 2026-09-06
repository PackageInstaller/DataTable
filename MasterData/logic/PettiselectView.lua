-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettimemachine/view/PettiselectView.lua

module("logic.extensions.pettimemachine.view.PettiselectView", package.seeall)

local PettiselectView = class("PettiselectView", TableViewComponent)

function PettiselectView:ctor()
	PettiselectView.super.ctor(self)
end

function PettiselectView:buildUI()
	self._Btn_Close = goutil.findChild(self.mainGO, "btnClose")
	self._TxtC_Title = goutil.findChild(self.mainGO, "Nego_Title/TxtC_Title"):GetComponent("Text")
	self._Btn_Cancel = goutil.findChild(self.mainGO, "Btn_Cancel")
	self._Btn_Submit = goutil.findChild(self.mainGO, "Btn_Submit")
	self.comFilter = goutil.findChild(self.mainGO, "comFilter")
	self.comAll = goutil.findChild(self.mainGO, "comAll")
	self._InputC_Search = goutil.findChild(self.mainGO, "InputC_Search"):GetComponent("InputField")
	self.btnClear = goutil.findChild(self.mainGO, "btnClear")
	self._tableview = goutil.findChild(self.mainGO, "SrlC_Pet"):GetComponent("UITableview")
	self._tableCell = goutil.findChild(self.mainGO, "cell")

	GameUtil.SetActive(self._tableCell, false)

	self._Nego_Empty = goutil.findChild(self.mainGO, "Nego_Empty")
	self.comLvl = self:getGo("top/comLvl")
	self.comSort = self:getGo("top/comSort")
	self.txtLvl = goutil.findChildTextComponent(self.mainGO, "top/comLvl/text")

	self:registCallbacks()
end

function PettiselectView:destroyUI()
	return
end

function PettiselectView:bindEvents()
	self._onInputSearchValueChangedHandler = InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):AddLuaHandler(function(go, text)
		self:_OnSearchTextChanged(text)
	end)

	GameUtil.asBtn(self.btnClear):AddClickListener(self._onClickClear, self)
	GameUtil.asBtn(self._Btn_Submit):AddClickListener(self._OnClickSubmit, self)
	GameUtil.asBtn(self._Btn_Cancel):AddClickListener(self._OnClickCancel, self)
	GameUtil.asBtn(self._Btn_Close):AddClickListener(self._OnClickCancel, self)
	GameUtil.asBtn(self.comLvl):AddClickListener(self._onClickLvl, self)
	GameUtil.asBtn(self.comSort):AddClickListener(self._onClickSort, self)
	GlobalDispatcher:addListener(GlobalNotify.PetSelectChanged, self._CheckSelectState, self)
end

function PettiselectView:unbindEvents()
	GameUtil.asBtn(self.btnClear):RemoveClickListener()
	GameUtil.asBtn(self._Btn_Submit):RemoveClickListener()
	GameUtil.asBtn(self._Btn_Cancel):RemoveClickListener()
	GameUtil.asBtn(self._Btn_Close):RemoveClickListener()
	GameUtil.asBtn(self.comLvl):RemoveClickListener()
	GameUtil.asBtn(self.comSort):RemoveClickListener()
	InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):RemoveLuaHandler(self._onInputSearchValueChangedHandler)
	GlobalDispatcher:removeListener(GlobalNotify.PetSelectChanged, self._CheckSelectState, self)
end

function PettiselectView:onEnter()
	PettiselectView.super.onEnter(self)
	self:createFilterList()

	local params = self:getOpenParam()

	self._selectedPetId = -1
	self._ispetIsNonePop = false

	self._Nego_Empty:SetActive(false)

	self._SearchText = nil
	self._curViewDatas = {}
	self.selectedLimit = 1

	local onlyoneOrCount = params[1]

	if type(onlyoneOrCount) == "boolean" then
		self._onlyOne = onlyoneOrCount

		if onlyoneOrCount == false then
			self.selectedLimit = -1
		end
	elseif type(onlyoneOrCount) == "number" then
		onlyoneOrCount = math.max(1, onlyoneOrCount)
		self._onlyOne = onlyoneOrCount == 1
		self.selectedLimit = onlyoneOrCount
	end

	self.title = params[2]

	if self.title == nil or string.len(self.title) == 0 then
		self.title = lang("请选择一只精灵")
	end

	self.filterFunc = params[3]
	self.submitFunc = params[4]
	self.cancelFunc = params[5]
	self.petIsNoneFunc = params[6]
	self.targetObj = params[7]

	self:_CheckSelectState()
	self:_RefreshPetList(true)
	self._tableview:SetOffset(0, true)
end

function PettiselectView:createFilterList()
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_SELECT_VIEW)
end

function PettiselectView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function PettiselectView:_onClickLvl()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self.comLvl)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_SELECT_VIEW, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function PettiselectView:updateFilterData(starList, jobList, rareList)
	self:_RefreshPetList()
end

function PettiselectView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_SELECT_VIEW, cfg, rare, skinId)
end

function PettiselectView:setTabSelect(cell, select)
	local group = cell.gameObject:GetComponent("UIChangeGroup")

	if select == true then
		group:SetState(0)
	else
		group:SetState(1)
	end
end

function PettiselectView:_CheckSelectState()
	self._TxtC_Title.text = self.title
end

function PettiselectView:onEnterFinished()
	return
end

function PettiselectView:onExit()
	PettiselectView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)
end

function PettiselectView:_clearTableview(cell)
	return
end

function PettiselectView:onExitFinished(cell)
	return
end

function PettiselectView:_numInView()
	return #self._curViewDatas
end

function PettiselectView:_cellSize(view, id)
	return 300, 100
end

function PettiselectView:_updateCell(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local top = goutil.findChild(cell, "top")
	local select = goutil.findChild(cell, "select")

	GameUtil.SetActive(select, self._selectedPetId == data.petId)

	local txtPower = goutil.findChildTextComponent(cell, "txtPower")

	MaterialMgr.setCellByMo(data, pet)

	txtPower.text = data:getFightingPower()

	local slotDatas = data:getStarGodPlusSlots() or {}

	for i = 1, 4 do
		local stargod = goutil.findChild(cell, "stargod_" .. i)
		local slot = slotDatas[i]

		if slot and checknumber(slot.fillerDefineId) > 0 then
			GameUtil.SetActive(stargod, true)

			local iconGo = goutil.findChild(stargod, "icon")
			local lvText = goutil.findChildTextComponent(stargod, "txtLevel")
			local nameText = goutil.findChildTextComponent(stargod, "txtName")
			local lv = StargodplusModel.instance:getSlotLv(slot.slot, slot.exp)

			lvText.text = "Lv." .. lv
			nameText.text = MaterialMgr.getMaterialsName(MatType.StarGodPlus, slot.fillerDefineId)

			MaterialMgr.setIcon(iconGo, MatType.StarGodPlus, slot.fillerDefineId)
		else
			GameUtil.SetActive(stargod, false)
		end
	end

	GameUtil.addClickHandler(top, GameUtil.handler(self.OnPetSelectChanged, self, data.petId))
end

function PettiselectView:OnPetSelectChanged(petId)
	self._selectedPetId = petId

	self._tableview:Refresh()
end

function PettiselectView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self.comSort)
	local arr = BagModel.instance:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self._RefreshPetSort, self))
end

function PettiselectView:_RefreshPetSort(idx, onResetCallback)
	BagModel.instance:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, BagModel.instance:GetSortState())

	local names, opt = BagModel.instance:GetSortParms()

	ArraySort.sortOn(self._curViewDatas, names, opt)
	self._tableview:ReloadData()
end

function PettiselectView:_RefreshPetList(canPopup)
	self._curViewDatas = {}

	local pets = BagPetsController.instance:getBagPets() or {}

	for k, v in pairs(pets) do
		if self:_PetFilter(v) then
			table.insert(self._curViewDatas, v)
		end
	end

	table.sort(self._curViewDatas, function(a, b)
		return a:getFightingPower() > b:getFightingPower()
	end)
	self._tableview:ReloadData()

	local isEmpty = #self._curViewDatas == 0

	self._Nego_Empty:SetActive(isEmpty)

	if isEmpty and canPopup and not self._ispetIsNonePop then
		self._ispetIsNonePop = true

		GameUtil.callBack(self.petIsNoneFunc)
	end
end

function PettiselectView:myFilter(pet)
	if not self.filterFunc then
		return true
	end

	if self.targetObj then
		return self.filterFunc(self.targetObj, pet)
	else
		return self.filterFunc(pet)
	end
end

function PettiselectView:_PetFilter(pet)
	if not self:myFilter(pet) then
		return false
	end

	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
	local skinName = PetSkinConfig.instance:getPetSkinName(pet.curFaceId)

	if not pet:isExist() then
		return false
	end

	if not string.nilorempty(self._SearchText) then
		local str = StringUtil.RelpaceEscapeChar(self._SearchText)
		local count = string.find(petCo.name, str)
		local count2 = string.find(skinName, str)

		if not count or not count2 then
			return false
		end
	end

	return (self:_isMatch(petCo, pet.rare, pet.curFaceId))
end

function PettiselectView:_OnClickCancel()
	GameUtil.callBack(self.cancelFunc, self.targetObj)
	self:close()
end

function PettiselectView:_OnClickSubmit()
	if self._selectedPetId > 0 then
		if self.targetObj then
			GameUtil.callBack(self.submitFunc, self.targetObj, self._selectedPetId, {
				self._selectedPetId
			})
		else
			GameUtil.callBack(self.submitFunc, self._selectedPetId, {
				self._selectedPetId
			})
		end
	end

	self:close()
end

function PettiselectView:_OnSearchTextChanged(text)
	if text ~= self._SearchText then
		self._SearchText = text

		self:_RefreshPetList()
	end
end

function PettiselectView:_onClickBag()
	self:_selectData(true)
end

function PettiselectView:_onClickWarehouse()
	self:_selectData(false)
end

function PettiselectView:_onClickClear()
	self._InputC_Search.text = ""
end

function PettiselectView:_selectData(isBag)
	self.selectBag = isBag

	self:_RefreshPetList()
end

return PettiselectView
