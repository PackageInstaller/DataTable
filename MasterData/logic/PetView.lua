-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/PetView.lua

module("logic.extensions.bag.panel.PetView", package.seeall)

local PetView = class("PetView", TableViewComponent)

function PetView:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "ScrollView"
	}
end

function PetView:ctor()
	PetView.super.ctor(self)

	self._preOffset = nil
	self._curViewDatas = {}
	self._currSearching = nil
end

function PetView:destroyUI()
	PetView.super.destroyUI(self)
end

function PetView:onExitFinished()
	PetView.super.onExitFinished(self)
	GlobalDispatcher:removeListener(GlobalNotify.REQ_CLOSE_PET_VIEW, self._onClickClose, self)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetsInit, self.updateList, self)

	if not UIStateManager.instance:isInStack(self._viewPresentor.viewName) then
		BagModel.instance:clearPetViewTempTopPetIds()
	end
end

function PetView:onEnterFinished()
	PetView.super.onEnterFinished(self)
end

function PetView:unbindEvents()
	PetView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._inputSearch:RemoveOnValueChanged()
	self._filterButton:RemoveClickListener()
	self._sortButton:RemoveClickListener()
	self._InputC_Search_Clear:RemoveClickListener()
	GameUtil.rmClickHandler(self._tipBtn)
	GameUtil.rmClickHandler(self._btnAwake)
	self._raceFilter:unbindEvents()
end

function PetView:bindEvents()
	PetView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._filterButton:AddClickListener(self._onClickFilter, self)
	self._sortButton:AddClickListener(self._onClickSort, self)
	self._InputC_Search_Clear:AddClickListener(self.onClearSearchClick, self)
	GameUtil.addClickHandler(self._tipBtn, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnAwake, self._onClickAwake, self)
	self._raceFilter:bindEvents()
	self._raceFilter:setValueChanged(self.updateFilterData, self)
end

function PetView:updateList()
	self:_RefreshPetList()
end

function PetView:onExit()
	PetView.super.onExit(self)
	GuideController.instance:setViewVar("bag_petmo_list", nil)

	for k, v in pairs(self._petCardItem) do
		v:dispose()
	end

	self._petCardItem = {}
end

function PetView:buildUI()
	PetView.super.buildUI(self)

	self._closeButton = self:getBtn("title/btnRtn")
	self._inputSearch = self:getInput("InputC_Search")
	self._InputC_Search_Clear = self:getBtn("InputC_Search/BtnClear")
	self._filterButton = self:getBtn("btnFilter")
	self._sortButton = self:getBtn("btnSort")
	self._sortBtnGo = self:getGo("btnSort")
	self._scrollRect = self:getGo("ScrollView"):GetComponent("ScrollRect")
	self._viewportGo = self:getGo("ScrollView/Viewport")
	self._tipBtn = self:getGo("tipBtn")
	self._txtLimit = self:getTxt("limit/Text")
	self._btnAwake = self:getGo("btnAwake")

	local RaceFilterGo = self:getGo("RaceFilter")

	self._raceFilter = ItemFilterExt.New(RaceFilterGo, 1, 7, false, "Cell", "Mark")
	self._imgSortChange = self:getGo("btnSort/imgSort"):GetComponent(ComponentType.UIImageSpriteChange)
	self.txtComSort = self:getTxt("btnSort/Text")
end

function PetView:onEnter()
	PetView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.REQ_CLOSE_PET_VIEW, self._onClickClose, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetsInit, self.updateList, self)
	self.addGEvent(self, GlobalNotify.PM_StoryPrizeTotalInfoRes, self.updateList, self)
	self.addGEvent(self, GlobalNotify.PetOneKeyAwakeSuccess, self.updateList, self)

	self._petCardItem = {}

	if BagPetsController.instance:getPetViewNeedClearOffset() then
		self._tableview:SetOffset(0, false)
	end

	if BagPetsController.instance:getReady() then
		self:updateFilterData()

		local limit = ConstConfig.instance:getPetLimltCount()
		local count = 0

		if self._curViewDatas then
			count = #self._curViewDatas

			if limit > 0 and limit <= #self._curViewDatas then
				TipsFacade.instance:openCommonTips(ConstConfig.instance:getPetLimltTips())
			end
		end

		self._txtLimit.text = limit <= count and langPara("<color=#eb4642>%s/%s</color>", count, limit) or langPara("%s/%s", count, limit)
	end

	self:_setTxtComSrot()
end

function PetView:_onClickHelp()
	TipsFacade.instance:openRulesView("bagSpiritLimit_rule")
end

function PetView:_onClickFilter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._filterButton.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function PetView:updateFilterData(starList, jobList, rareList)
	local data = PetFilterMgr.instance:getFilterData(PetFilterMgr.TYPE_PETVIEW)

	self._raceFilter:initData(data.raceSelectList)
	self._raceFilter:initActiveList(data.raceActiveList)
	self._raceFilter:initClickAble(data.raceClickAble)
	self:_RefreshPetList()
end

function PetView:_onClickSort()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._sortButton.gameObject)
	local arr = BagModel.instance:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self.onRefreshPetSort, self))
end

function PetView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, cfg, rare, skinId)
end

function PetView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_RefreshPetList()
	end
end

function PetView:onClearSearchClick()
	self._inputSearch.input.text = ""
end

function PetView:_updateCell(view, cell, data)
	local container = goutil.findChild(cell.gameObject, "container")
	local comp = PetShowCardExt.AddOnce(container)

	comp:setPetMo(data, self)
	comp:setClickCallBack(function()
		self:_OnClickPet(data)
		BagPetsController.instance:setPetShowTab(1)
		UIStateManager.instance:push(ViewName.PetShowView)
	end)

	self._petCardItem[container] = comp
end

function PetView:_clearTableview(cell)
	local container = goutil.findChild(cell.gameObject, "container")
	local comp = self._petCardItem[container]

	if comp then
		PetShowCardExt.AddOnce(container)

		self._petCardItem[container] = nil
	end
end

function PetView:onRefreshPetSort(idx, onResetCallback)
	BagModel.instance:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, BagModel.instance:GetSortState())

	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and self._curViewDatas and limit <= #self._curViewDatas then
		TipsFacade.instance:openCommonTips(ConstConfig.instance:getPetLimltTips())
	else
		local names, opt = self:_getSortParms()

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	BagModel.instance:setCurPetViewList(self._curViewDatas)
	self._tableview:ReloadData()
	GuideController.instance:setViewVar("bag_petmo_list", self._curViewDatas)
	self:_setTxtComSrot()
end

function PetView:_RefreshPetList(force)
	self._curViewDatas = {}
	self._allPets = BagPetsController.instance:getBagAndBorrowPets()

	for k, v in pairs(self._allPets) do
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end

	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and limit <= #self._curViewDatas then
		-- block empty
	else
		local names, opt = self:_getSortParms()

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	BagModel.instance:setCurPetViewList(self._curViewDatas)
	GuideController.instance:setViewVar("bag_petmo_list", self._curViewDatas)

	if self._preOffset then
		self._tableview:SetOffsetWithoutRefresh(self._preOffset)
	end

	self._tableview:ReloadData()

	self._preOffset = nil

	local petId = BagPetsController.instance:GetCurPetId()

	if (force or petId == nil) and #self._curViewDatas > 0 then
		local petMo = self._curViewDatas[1]

		self:_OnClickPet(petMo)
	end
end

function PetView:_getSortParms()
	local names, opt = BagModel.instance:GetSortParms()

	names[1] = FormationGroupModel.checkIsInTeamByMo

	local function isTempTopPet(petMo)
		return petMo and BagModel.instance:isPetViewTempTopPet(petMo.petId) and 1 or 0
	end

	table.insert(names, 1, isTempTopPet)
	table.insert(opt, 1, ArraySort.DESCENDING)

	return names, opt
end

function PetView:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
	local isHit = false

	isHit = self:_isMatch(petCo, pet.rare, pet.curFaceId)

	if not string.nilorempty(self._currSearching) then
		local str = StringUtil.RelpaceEscapeChar(self._currSearching)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function PetView:_OnClickPet(data)
	BagPetsController.instance:SetCurPetId((data or nil) and (data.petId or ""))
	GlobalDispatcher:dispatch(GlobalNotify.OnPetSelect, data)
	self._tableview:Refresh()
end

function PetView:_onClickClose()
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_PETVIEW)
	BagModel.instance:setCurPetViewList(nil)

	self._inputSearch.input.text = ""

	self:close()
end

function PetView:_onClickAwake()
	local moList = BagModel.instance:getAwakenablePetMoList() or {}
	local numMo = #moList

	if numMo <= 0 then
		FloatWordMgr.instance:show("当前不存在可觉醒精灵")
	else
		UIStateManager.instance:push(ViewName.PetAwakeSelectView, moList)
	end
end

function PetView:_setTxtComSrot()
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

return PetView
