-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petselect/view/PetSelectView_New.lua

module("logic.extensions.petselect.view.PetSelectView_New", package.seeall)

local All = "all"
local PetSelectView_New = class("PetSelectView_New", TableViewComponent)

function PetSelectView_New:ctor()
	PetSelectView_New.super.ctor(self)

	self._allHanlder = {}
end

function PetSelectView_New:buildUI()
	self._Btn_Close = goutil.findChild(self.mainGO, "Btn_Close")
	self._TxtC_Title = goutil.findChild(self.mainGO, "Nego_Title/TxtC_Title"):GetComponent("Text")
	self._Btn_Cancel = goutil.findChild(self.mainGO, "Btn_Cancel")
	self._Btn_Submit = goutil.findChild(self.mainGO, "Btn_Submit")
	self._InputC_Search = goutil.findChild(self.mainGO, "InputC_Search"):GetComponent("InputField")
	self.btnClear = goutil.findChild(self.mainGO, "btnClear")
	self._tableview = goutil.findChild(self.mainGO, "SrlC_Pet"):GetComponent("UITableview")
	self._tableCell = self:getPrefab(ItemPetSelect.ResPath)
	self._Nego_Empty = goutil.findChild(self.mainGO, "Nego_Empty")
	self._txtEmpty = goutil.findChildTextComponent(self.mainGO, "Nego_Empty/TxtC_Empty")
	self.comType = self:getGo("top/comType")
	self.comLvl = self:getGo("top/comLvl")
	self.comQua = self:getGo("top/comQua")
	self.comSort = self:getGo("top/comSort")
	self.txtComSort = self:getTxt("top/comSort/Text")
	self._imgSortChange = self:getGo("top/comSort/imgSort"):GetComponent(ComponentType.UIImageSpriteChange)
	self.txtType = goutil.findChildTextComponent(self.mainGO, "top/comType/text")
	self.txtLvl = goutil.findChildTextComponent(self.mainGO, "top/comLvl/text")
	self._markGo = self:getGo("Marks")
	self._tabCell = self:getGo("Marks/Btn")

	self:initBtn(self._tabCell, lang("背包"))
	self:registCallbacks()
end

function PetSelectView_New:destroyUI()
	return
end

function PetSelectView_New:bindEvents()
	self._onInputSearchValueChangedHandler = InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):AddLuaHandler(function(go, text)
		self:_OnSearchTextChanged(text)
	end)

	GameUtil.asBtn(self.btnClear):AddClickListener(self._onClickClear, self)
	GameUtil.asBtn(self.comType):AddClickListener(self._onClickType, self)
	GameUtil.asBtn(self.comLvl):AddClickListener(self._onClickLvl, self)
	GameUtil.asBtn(self.comQua):AddClickListener(self._onClickQua, self)
	GameUtil.asBtn(self.comSort):AddClickListener(self._onClickSort, self)
	GameUtil.asBtn(self._Btn_Submit):AddClickListener(self._OnClickSubmit, self)
	GameUtil.asBtn(self._Btn_Cancel):AddClickListener(self._OnClickCancel, self)
	GameUtil.asBtn(self._Btn_Close):AddClickListener(self._OnClickCancel, self)
	GlobalDispatcher:addListener(GlobalNotify.PetSelectChanged, self._CheckSelectState, self)
end

function PetSelectView_New:unbindEvents()
	GameUtil.asBtn(self.btnClear):RemoveClickListener()
	GameUtil.asBtn(self.comType):RemoveClickListener()
	GameUtil.asBtn(self.comLvl):RemoveClickListener()
	GameUtil.asBtn(self._Btn_Submit):RemoveClickListener()
	GameUtil.asBtn(self._Btn_Cancel):RemoveClickListener()
	GameUtil.asBtn(self._Btn_Close):RemoveClickListener()
	InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):RemoveLuaHandler(self._onInputSearchValueChangedHandler)
	GlobalDispatcher:removeListener(GlobalNotify.PetSelectChanged, self._CheckSelectState, self)
end

function PetSelectView_New:onEnter()
	PetSelectView_New.super.onEnter(self)

	self._custonPetList = self:getOpenParam()[2]
	self._isNotBagPet = self._custonPetList ~= nil

	self:createFilterList()

	self._ispetIsNonePop = false

	self._Nego_Empty:SetActive(false)

	self._JobSelected = All
	self._AttrSelected = All
	self._TagSelected = All
	self._SearchText = nil
	self._curViewDatas = {}
	self.title = self:getOpenParam()[1]

	if self.title == nil or string.len(self.title) == 0 then
		self.title = lang("请选择一只精灵")
	end

	local txtEmpty = self:getOpenParam()[3]

	self._txtEmpty.text = not string.nilorempty(txtEmpty) and txtEmpty or "没有符合要求的精灵喔!"

	self:_CheckSelectState()
	self:_selectData(true)
	self:_RefreshPetList(true)
	self._tableview:SetOffset(0, true)
	self:_setTxtComSrot()
end

function PetSelectView_New:createFilterList()
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_SELECT_VIEW)
end

function PetSelectView_New:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function PetSelectView_New:_onClickLvl()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self.comLvl)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_SELECT_VIEW, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function PetSelectView_New:updateFilterData(starList, jobList, rareList)
	self:_RefreshPetList()
end

function PetSelectView_New:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_SELECT_VIEW, cfg, rare, skinId)
end

function PetSelectView_New:copyTabCell(cell, idx)
	local cp = goutil.clone(cell, "Btn" .. idx - 1)

	goutil.addChildToParent(cp, self._markGo)

	return cp
end

function PetSelectView_New:_onClickType()
	return
end

function PetSelectView_New:_onClickQua()
	return
end

function PetSelectView_New:initBtn(cell, name)
	local txt1 = goutil.findChildTextComponent(cell, "Txt")
	local txt2 = goutil.findChildTextComponent(cell, "Txt2")

	txt1.text = name
	txt2.text = name

	self:addTabCtrl(cell)
end

function PetSelectView_New:addTabCtrl(cell)
	self._tabArr = self._tabArr or {}

	table.insert(self._tabArr, cell)

	local idx = #self._tabArr

	self:setTabSelect(cell, false)

	local btnAdt = Framework.ButtonAdapter.Get(cell.gameObject)

	btnAdt:AddClickListener(function()
		self:_selectTab(idx)
	end)
end

function PetSelectView_New:_selectTab(idx)
	if self.currTabIdx ~= idx then
		if self.currTabIdx ~= nil then
			local last = self._tabArr[self.currTabIdx]

			self:setTabSelect(last, false)
		end

		self.currTabIdx = idx

		local cell = self._tabArr[idx]

		self:setTabSelect(cell, true)

		if idx == 1 then
			self:_onClickBag()
		else
			self:_onClickWarehouse()
		end
	end
end

function PetSelectView_New:setTabSelect(cell, select)
	local group = cell.gameObject:GetComponent("UIChangeGroup")

	if select == true then
		group:SetState(0)
	else
		group:SetState(1)
	end
end

function PetSelectView_New:_CheckSelectState()
	local limit = PetSelectController.instance:getSelectLimit()

	if limit == -1 or limit == 1 then
		self._TxtC_Title.text = self.title
	else
		local count = PetSelectController.instance:getSelectCount()

		self._TxtC_Title.text = self.title .. string.format(" (<color=#C54949>%s</color>/%s)", count, limit)
	end
end

function PetSelectView_New:onEnterFinished()
	return
end

function PetSelectView_New:onExit()
	PetSelectView_New.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)
	PetSelectController.instance:setNormalState()
end

function PetSelectView_New:_clearTableview(cell)
	local component = ItemPetSelect.AddOnce(cell.gameObject)

	component:OnDestroy()
end

function PetSelectView_New:onExitFinished(cell)
	return
end

function PetSelectView_New:_numInView()
	return #self._curViewDatas
end

function PetSelectView_New:_cellSize(view, id)
	return 300, 100
end

function PetSelectView_New:_cellAtIndex(view, id)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local pet = self._curViewDatas[id + 1]
	local component = ItemPetSelect.AddOnce(cell.gameObject)

	component.petMo = pet
	component.isNotBagPet = self._isNotBagPet
	component.showbagpetRaceName = PetSelectController.instance:isShowbagpetRaceName()

	component:Init(pet.petId)
	component:_CheckSelectState()

	return cell
end

function PetSelectView_New:_onPetReloadFinish()
	PetSelectView_New.super._onPetReloadFinish(self)
end

function PetSelectView_New:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self.comSort)
	local arr = BagModel.instance:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self._RefreshPetSort, self))
end

function PetSelectView_New:_RefreshPetSort(idx, onResetCallback)
	BagModel.instance:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, BagModel.instance:GetSortState())
	self:_sortDatas()
	self._tableview:ReloadData()
	self:_setTxtComSrot()
end

function PetSelectView_New:_RefreshPetList(canPopup, isFirstSort)
	self._curViewDatas = {}

	local var_32_0 = self._custonPetList

	if not self._custonPetList then
		var_32_0 = BagPetsController.instance:getBagPets()

		if not var_32_0 then
			var_32_0 = {}

			local pets = var_32_0

			for k, v in pairs(pets) do
				if self:_PetFilter(v) then
					table.insert(self._curViewDatas, v)
				end
			end

			self:_sortDatas()
			self._tableview:ReloadData()

			local isEmpty = #self._curViewDatas == 0

			self._Nego_Empty:SetActive(isEmpty)

			if isEmpty and canPopup and not self._ispetIsNonePop then
				self._ispetIsNonePop = true

				PetSelectController.instance:petIsNoneFunc()
			end
		end
	end
end

function PetSelectView_New:_PetFilter(pet)
	if not PetSelectController.instance:Filter(pet) then
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

function PetSelectView_New:_OnClickCancel()
	PetSelectController.instance:OnCancel()
end

function PetSelectView_New:_OnClickSubmit()
	PetSelectController.instance:OnSubmit()
end

function PetSelectView_New:_OnSearchTextChanged(text)
	if text ~= self._SearchText then
		self._SearchText = text

		self:_RefreshPetList()
	end
end

function PetSelectView_New:_onClickBag()
	self:_selectData(true)
end

function PetSelectView_New:_onClickWarehouse()
	self:_selectData(false)
end

function PetSelectView_New:_onClickClear()
	self._InputC_Search.text = ""
end

function PetSelectView_New:_selectData(isBag)
	self.selectBag = isBag

	self:_RefreshPetList()
end

function PetSelectView_New:_sortDatas()
	if not PetSelectController.instance:customSortFunc(self._curViewDatas) then
		local names, opt = BagModel.instance:GetSortParms()

		names[1] = FormationGroupModel.checkIsInTeamByMo

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end
end

function PetSelectView_New:_setTxtComSrot()
	local isHit = false
	local sortValue = BagModel.instance:GetSortState()
	local sortState = 0

	for k, v in ipairs(sortValue) do
		local vArr = BagModel.SORT_VALUE[k]

		sortState = v

		if vArr[v + 1] ~= -1 then
			local sortName = BagModel.SORT_NAME[k]

			if sortName == "awakeLevel" then
				self.txtComSort.text = "觉醒"
				isHit = true

				break
			elseif sortName == "level" then
				self.txtComSort.text = "等级"
				isHit = true

				break
			elseif sortName == "rare" then
				self.txtComSort.text = "品质"
				isHit = true

				break
			elseif sortName == "petId" then
				self.txtComSort.text = "最新"
				isHit = true
			elseif sortName == BagModel.SORT_NAME[1] then
				self.txtComSort.text = "战力"
				isHit = true

				break
			end
		end
	end

	if not isHit then
		self.txtComSort.text = "排序"
	end

	if sortState >= 0 then
		self._imgSortChange:SetState(sortState)
	else
		self._imgSortChange:SetState(0)
	end
end

return PetSelectView_New
