-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglipetselectView.lua

module("logic.extensions.mimengli.view.MimenglipetselectView", package.seeall)

local MimenglipetselectView = class("MimenglipetselectView", ViewComponent)
local TYPE_SELECT_PET = 1
local TYPE_LOOKOVER_PET = 2
local SORT_KEY = "MimenglipetselectView_SortKey"

function MimenglipetselectView:buildUI()
	MimenglipetselectView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnCancel = self:getBtn("btnCancel")
	self._btnSure = self:getBtn("btnSure")
	self._txtTitle = self:getTxt("txtTitle")
	self._selectNumGo = self:getGo("selectNum")
	self._txtNum = self:getTxt("selectNum/txtNum")
	self._inputSearch = self:getInput("InputC_Search")
	self._InputC_Search_Clear = self:getBtn("InputC_Search/BtnClear")
	self._filterButton = self:getBtn("btnFilter")
	self._sortButton = self:getBtn("btnSort")
	self._sortBtnGo = self:getGo("btnSort")
	self._txtSure = self:getTxt("btnSure/txt")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
	self._tableviewRect = self._tableview:GetComponent(goutil.Type_RectTransform)
end

function MimenglipetselectView:bindEvents()
	MimenglipetselectView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnCancel:AddClickListener(self.close, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._InputC_Search_Clear:AddClickListener(self.onClearSearchClick, self)
	self._filterButton:AddClickListener(self._onClickFilter, self)
	self._sortButton:AddClickListener(self._onClickSort, self)
end

function MimenglipetselectView:unbindEvents()
	MimenglipetselectView.super.unbindEvents(self)
	self._inputSearch:RemoveOnValueChanged()
	self._InputC_Search_Clear:RemoveClickListener()
	self._filterButton:RemoveClickListener()
	self._sortButton:RemoveClickListener()
end

function MimenglipetselectView:onExit()
	MimenglipetselectView.super.onExit(self)

	self._inputSearch.input.text = ""

	self._scrollList:dispose()
end

function MimenglipetselectView:onEnter()
	MimenglipetselectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = params[1]
	self._viewType = params[2]

	if self._viewType == nil then
		self._viewType = TYPE_SELECT_PET
	end

	local cfgList = MiMengLiConfig.instance:getBuffTagCfgList(self._activityId) or {}

	self._buffIdxMap = {}

	for i, v in ipairs(cfgList) do
		local arr = string.split(v.job or "", "#")

		for j, key in ipairs(arr) do
			self._buffIdxMap[key] = v.tagType
		end
	end

	self._isClickSure = false
	self._currSearching = nil
	self._selectedPetIds = {}

	self._scrollList:MoveCellToBegin(0, false)

	self._cfgActivity = MiMengLiConfig.instance:getActivityCfgById(self._activityId) or {}
	self._maxNum = checknumber(self._cfgActivity.selectPetCount)

	if self._viewType == TYPE_SELECT_PET then
		Framework.TransformUtil.SetAnchoredPos(self._tableviewRect, -588, 226)
		self:_updateGameObject(true)
		self:_updateSelectNum()

		if BagPetsController.instance:getReady() then
			self:updateFilterData()
		end
	elseif self._viewType == TYPE_LOOKOVER_PET then
		Framework.TransformUtil.SetAnchoredPos(self._tableviewRect, -588, 180)
		self:_updateGameObject(false)
		self:updateFilterData()
	end
end

function MimenglipetselectView:_updateGameObject(isShow)
	goutil.setActive(self._selectNumGo, isShow)
	goutil.setActive(self._btnSure.gameObject, isShow)
	goutil.setActive(self._btnCancel.gameObject, isShow)

	self._txtTitle.text = isShow and "选择精灵" or "查看精灵"
end

function MimenglipetselectView:_onSelectPetsRes()
	self:close()
end

function MimenglipetselectView:_onClickSure()
	if self._isClickSure then
		return
	end

	local petIds = {}

	for id, v in pairs(self._selectedPetIds) do
		table.insert(petIds, id)
	end

	local count = #petIds

	if count > 0 then
		local text = ""

		text = count >= self._maxNum and "挑战过程中无法更换精灵，是否确认进入挑战？" or "选择精灵少于可选择上限，是否确认进入挑战？"

		local function okFunc()
			self._isClickSure = true

			MiMengLiController.instance:sendSelectPets(self._activityId, petIds)
			self:close()
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
	else
		self:_oneKeySelectPets()
	end
end

function MimenglipetselectView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_RefreshPetList()
	end
end

function MimenglipetselectView:onClearSearchClick()
	self._inputSearch.input.text = ""
end

function MimenglipetselectView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function MimenglipetselectView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._filterButton.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function MimenglipetselectView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._sortButton.gameObject)
	local arr = self:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self.onRefreshPetSort, self))
end

function MimenglipetselectView:SetNextSort(idx)
	self._sortValue = self:GetSortState()

	local v = self._sortValue[idx]

	v = v + 1

	local vArr = BagModel.SORT_VALUE[idx]

	v = v % #vArr

	if idx ~= #BagModel.SORT_VALUE then
		for i = 1, #BagModel.SORT_VALUE - 1 do
			self._sortValue[i] = 0
		end
	end

	self._sortValue[idx] = v

	GameUtil.saveUserData(SORT_KEY, self._sortValue)
end

function MimenglipetselectView:GetSortState()
	if self._sortValue == nil then
		self._sortValue = GameUtil.getUserData(SORT_KEY)

		if self._sortValue == nil then
			self._sortValue = {}

			for i = 1, #BagModel.SORT_NAME do
				self._sortValue[i] = i == 1 and 1 or 0
			end
		end
	end

	return self._sortValue
end

function MimenglipetselectView:GetSortParms(checkIsInTeamFunc)
	local parm1 = {}
	local parm2 = {}
	local sortName

	self._sortValue = self:GetSortState()

	for k, v in ipairs(self._sortValue) do
		local vArr = BagModel.SORT_VALUE[k]

		if vArr[v + 1] ~= -1 then
			table.insert(parm1, BagModel.SORT_NAME[k])
			table.insert(parm2, vArr[v + 1])
		end
	end

	return parm1, parm2
end

function MimenglipetselectView:onRefreshPetSort(idx, onResetCallback)
	self:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, self:GetSortState())

	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and self._curViewDatas and limit <= #self._curViewDatas then
		TipsFacade.instance:openCommonTips(ConstConfig.instance:getPetLimltTips())
	else
		local names, opt = self:GetSortParms()

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._scrollList:reloadData(self._curViewDatas)
end

function MimenglipetselectView:updateFilterData(starList, jobList, rareList)
	self:_RefreshPetList()
end

function MimenglipetselectView:_RefreshPetList()
	if self._viewType == TYPE_SELECT_PET then
		self._curViewDatas = {}
		self._allPets = BagPetsController.instance:getFightBagPet()

		for k, v in pairs(self._allPets) do
			if self:onFilter(v) then
				self._curViewDatas[#self._curViewDatas + 1] = v
			end
		end

		local limit = ConstConfig.instance:getPetLimltCount()

		if limit > 0 and limit <= #self._curViewDatas then
			-- block empty
		else
			local names, opt = self:GetSortParms()

			ArraySort.sortOn(self._curViewDatas, names, opt)
		end

		self._scrollList:reloadData(self._curViewDatas)

		self._preOffset = nil
	elseif self._viewType == TYPE_LOOKOVER_PET then
		self:_updateLookOverPetList()
	end
end

function MimenglipetselectView:onFilter(pet)
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

function MimenglipetselectView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, cfg, rare, skinId)
end

function MimenglipetselectView:_updateCell(view, cell, data)
	local petIcon = goutil.findChild(cell, "petIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local imgSelect = goutil.findChild(cell, "btnSelect/img")
	local txtHp = goutil.findChildTextComponent(cell, "txtHp")
	local img = goutil.findChild(cell, "img")
	local iconGo = goutil.findChild(cell, "img/iconGo")

	GameUtil.rmClickHandler(btnSelect)

	if self._viewType == TYPE_SELECT_PET then
		GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onSelectPet, self, data, imgSelect))
		goutil.setActive(imgSelect, self._selectedPetIds[data:getPetId()])
		goutil.setActive(txtHp.gameObject, false)
		goutil.setActive(btnSelect.gameObject, true)

		txtName.text = data.name
	elseif self._viewType == TYPE_LOOKOVER_PET then
		-- block empty
	end

	local key = PetSkinConfig.instance:getFirstJobKey(data:getDefineId())
	local idx = checknumber(self._buffIdxMap[key])

	GameUtil.SetActive(img, idx > 0)
	GameUtil.setUIImageSpriteIdx(iconGo, idx - 1)

	local proxy = MaterialMgr.setCellByData(MatType.Pet, data, petIcon)

	if proxy then
		proxy.binder:setClickCallBack(function(petCell)
			if petIcon then
				CommonTipsMgr.instance:openMaterialTips(petIcon, MatType.Pet, data:getPetId())
			end
		end)
	end
end

function MimenglipetselectView:_clearTableview(cell)
	local petIcon = goutil.findChild(cell, "petIcon")

	MaterialMgr.resetAll(petIcon)
end

function MimenglipetselectView:_onSelectPet(data, imgSelect)
	if not self._selectedPetIds[data:getPetId()] then
		if self:_getPetIdsNum() < self._maxNum then
			self._selectedPetIds[data:getPetId()] = true

			goutil.setActive(imgSelect, true)
		else
			FloatWordMgr.instance:show("已达到最大数量")
		end
	else
		self._selectedPetIds[data:getPetId()] = nil

		goutil.setActive(imgSelect, false)
	end

	self:_updateSelectNum()
end

function MimenglipetselectView:_getPetIdsNum()
	local count = 0

	for k, v in pairs(self._selectedPetIds) do
		if v then
			count = count + 1
		end
	end

	return count
end

function MimenglipetselectView:_updateSelectNum()
	self._txtNum.text = string.format("最多可选择：%d/%d", self:_getPetIdsNum(), self._maxNum)

	self:_updateBtnSureState()
end

function MimenglipetselectView:_updateLookOverPetList()
	return
end

function MimenglipetselectView:_updateBtnSureState()
	local count = self:_getPetIdsNum()

	self._txtSure.text = count == 0 and "一键选择" or "确 定"
end

function MimenglipetselectView:_oneKeySelectPets()
	table.clear(self._selectedPetIds)

	for i, data in ipairs(self._curViewDatas) do
		if not self._selectedPetIds[data:getPetId()] then
			if i <= self._maxNum then
				self._selectedPetIds[data:getPetId()] = true
			else
				break
			end
		end
	end

	self._scrollList:refresh()
	self:_updateSelectNum()
end

return MimenglipetselectView
