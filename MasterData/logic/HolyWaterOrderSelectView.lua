-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderSelectView.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderSelectView", package.seeall)

local HolyWaterOrderSelectView = class("HolyWaterOrderSelectView", TableViewComponent)

function HolyWaterOrderSelectView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function HolyWaterOrderSelectView:ctor()
	HolyWaterOrderSelectView.super.ctor(self)

	self._preOffset = nil
	self._curViewDatas = {}
	self._currSearching = nil
end

function HolyWaterOrderSelectView:buildUI()
	HolyWaterOrderSelectView.super.buildUI(self)

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
	self._tableviewRect = self:getGo("tableview"):GetComponent(goutil.Type_RectTransform)
end

function HolyWaterOrderSelectView:bindEvents()
	HolyWaterOrderSelectView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnCancel:AddClickListener(self.close, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._InputC_Search_Clear:AddClickListener(self.onClearSearchClick, self)
	self._filterButton:AddClickListener(self._onClickFilter, self)
	self._sortButton:AddClickListener(self._onClickSort, self)
end

function HolyWaterOrderSelectView:unbindEvents()
	HolyWaterOrderSelectView.super.unbindEvents(self)
	self._inputSearch:RemoveOnValueChanged()
	self._InputC_Search_Clear:RemoveClickListener()
	self._filterButton:RemoveClickListener()
	self._sortButton:RemoveClickListener()
end

function HolyWaterOrderSelectView:onEnter()
	HolyWaterOrderSelectView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HolyWaterOrderSelectPetsRes, self._onSelectPetsRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._viewType = params[2]
	self._isClickSure = false
	self._selectedPetIds = {}

	self._tableview:SetOffset(1, false)

	self._cfgActivity = HolyWaterOrderConfig.instance:getActivityCfg(self._activityId)

	if self._cfgActivity then
		self._maxNum = self._cfgActivity.selectPetNum or 0
	end

	if self._viewType == HolyWaterOrderModel.SelectPet then
		Framework.TransformUtil.SetAnchoredPos(self._tableviewRect, -588, 226)
		self:_updateGameObject(true)
		self:_updateSelectNum()

		if BagPetsController.instance:getReady() then
			self:updateFilterData()
		end
	elseif self._viewType == HolyWaterOrderModel.LookOverPet then
		Framework.TransformUtil.SetAnchoredPos(self._tableviewRect, -588, 180)
		self:_updateGameObject(false)
		self:updateFilterData()
	end
end

function HolyWaterOrderSelectView:_updateGameObject(isShow)
	goutil.setActive(self._selectNumGo, isShow)
	goutil.setActive(self._btnSure.gameObject, isShow)
	goutil.setActive(self._btnCancel.gameObject, isShow)

	self._txtTitle.text = isShow and "选择精灵" or "查看精灵"
end

function HolyWaterOrderSelectView:onExit()
	HolyWaterOrderSelectView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyWaterOrderSelectPetsRes, self._onSelectPetsRes, self)

	self._inputSearch.input.text = ""
end

function HolyWaterOrderSelectView:_onSelectPetsRes()
	local activityId = self._activityId

	self:close()
	UIStateManager.instance:push(ViewName.HolyWaterOrderChallengeView, activityId)
end

function HolyWaterOrderSelectView:_onClickSure()
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

			HolyWaterOrderAgent.instance:sendPM_HolyWaterOrderSelectPetsReq(self._activityId, petIds)
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
	else
		self:_oneKeySelectPets()
	end
end

function HolyWaterOrderSelectView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_RefreshPetList()
	end
end

function HolyWaterOrderSelectView:onClearSearchClick()
	self._inputSearch.input.text = ""
end

function HolyWaterOrderSelectView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function HolyWaterOrderSelectView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._filterButton.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function HolyWaterOrderSelectView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._sortButton.gameObject)
	local arr = self:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self.onRefreshPetSort, self))
end

function HolyWaterOrderSelectView:SetNextSort(idx)
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

	GameUtil.saveUserData(HolyWaterOrderModel.SortKey, self._sortValue)
end

function HolyWaterOrderSelectView:GetSortState()
	if self._sortValue == nil then
		self._sortValue = GameUtil.getUserData(HolyWaterOrderModel.SortKey)

		if self._sortValue == nil then
			self._sortValue = {}

			for i = 1, #BagModel.SORT_NAME do
				self._sortValue[i] = i == 1 and 1 or 0
			end
		end
	end

	return self._sortValue
end

function HolyWaterOrderSelectView:GetSortParms(checkIsInTeamFunc)
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

function HolyWaterOrderSelectView:onRefreshPetSort(idx, onResetCallback)
	self:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, self:GetSortState())

	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and self._curViewDatas and limit <= #self._curViewDatas then
		TipsFacade.instance:openCommonTips(ConstConfig.instance:getPetLimltTips())
	else
		local names, opt = self:GetSortParms()

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
end

function HolyWaterOrderSelectView:updateFilterData(starList, jobList, rareList)
	self:_RefreshPetList()
end

function HolyWaterOrderSelectView:_RefreshPetList()
	if self._viewType == HolyWaterOrderModel.SelectPet then
		self._curViewDatas = {}
		self._allPets = BagPetsController.instance:getBagPets()

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

		if self._preOffset then
			self._tableview:SetOffsetWithoutRefresh(self._preOffset)
		end

		self._tableview:ReloadData()

		self._preOffset = nil
	elseif self._viewType == HolyWaterOrderModel.LookOverPet then
		self:_updateLookOverPetList()
	end
end

function HolyWaterOrderSelectView:onFilter(pet)
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

function HolyWaterOrderSelectView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, cfg, rare, skinId)
end

function HolyWaterOrderSelectView:_updateCell(view, cell, data)
	local petIcon = goutil.findChild(cell, "petIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local btnSelect = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSelect")
	local imgSelect = goutil.findChild(cell, "btnSelect/img")
	local txtHp = goutil.findChildTextComponent(cell, "txtHp")

	if self._viewType == HolyWaterOrderModel.SelectPet then
		btnSelect:AddClickListener(function()
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
		end)
		goutil.setActive(imgSelect, self._selectedPetIds[data:getPetId()])
		goutil.setActive(txtHp.gameObject, false)
		goutil.setActive(btnSelect.gameObject, true)

		txtName.text = data.name

		local proxy = MaterialMgr.setCellByData(MatType.Pet, data, petIcon)

		proxy.binder:setClickCallBack(function(petCell)
			if petIcon then
				CommonTipsMgr.instance:openMaterialTips(petIcon, MatType.Pet, data:getPetId())
			end
		end)
	elseif self._viewType == HolyWaterOrderModel.LookOverPet then
		goutil.setActive(txtHp.gameObject, true)
		goutil.setActive(btnSelect.gameObject, false)

		local value = data.hp == -1 and 100 or Mathf.Clamp01(data.hp / data.petMo._maxHp) * 100

		if value > 0 and value <= 1 then
			value = 1
		end

		if value >= 30 then
			if not ColorConst.Green2 then
				local colorStr = ColorConst.Red

				txtHp.text = string.format("剩余血量：<color=#%s>%d%%</color>", colorStr, value)
				txtName.text = data.petMo.name

				local proxy = MaterialMgr.setCellByData(MatType.Pet, data.petMo, petIcon)

				proxy.binder:setClickCallBack(function(petCell)
					if petIcon then
						CommonTipsMgr.instance:openMaterialTips(petIcon, MatType.Pet, data.petMo:getPetId())
					end
				end)
			end
		end
	end
end

function HolyWaterOrderSelectView:_clearTableview(cell)
	local petIcon = goutil.findChild(cell, "petIcon")

	MaterialMgr.resetAll(petIcon)
end

function HolyWaterOrderSelectView:_getPetIdsNum()
	local count = 0

	for k, v in pairs(self._selectedPetIds) do
		if v then
			count = count + 1
		end
	end

	return count
end

function HolyWaterOrderSelectView:_updateSelectNum()
	self._txtNum.text = string.format("最多可选择：%d/%d", self:_getPetIdsNum(), self._maxNum)

	self:_updateBtnSureState()
end

function HolyWaterOrderSelectView:_updateLookOverPetList()
	local petInfoList = HolyWaterOrderModel.instance:getPetInfoList()

	self._curViewDatas = {}

	for k, v in ipairs(petInfoList) do
		if self:onFilter(v.petMo) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end

	self._tableview:SetOffsetWithoutRefresh(0)
	self._tableview:ReloadData()
end

function HolyWaterOrderSelectView:_updateBtnSureState()
	local count = self:_getPetIdsNum()

	self._txtSure.text = count == 0 and "一键选择" or "确 定"
end

function HolyWaterOrderSelectView:_oneKeySelectPets()
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

	self._tableview:ReloadData()
	self:_updateSelectNum()
end

return HolyWaterOrderSelectView
