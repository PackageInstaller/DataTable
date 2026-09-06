-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKPetSelectView.lua

module("logic.extensions.teenchampionking.view.TCKPetSelectView", package.seeall)

local TCKPetSelectView = class("TCKPetSelectView", ViewComponent)
local SORTKEY = "TCKPetSelectView_SortKey"

function TCKPetSelectView:ctor()
	TCKPetSelectView.super.ctor(self)
end

function TCKPetSelectView:unbindEvents()
	TCKPetSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSwitch)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._InputC_Search_Clear)
	GameUtil.rmClickHandler(self._filterButton)
	GameUtil.rmClickHandler(self._sortButton)
	GameUtil.rmClickHandler(self._btnTog)
	self._inputSearch:RemoveOnValueChanged()
end

function TCKPetSelectView:bindEvents()
	TCKPetSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSwitch, self._onClickSwitch, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._InputC_Search_Clear, self._onClearSearchClick, self)
	GameUtil.addClickHandler(self._filterButton, self._onClickFilter, self)
	GameUtil.addClickHandler(self._sortButton, self._onClickSort, self)
	GameUtil.addClickHandler(self._btnTog, self._onClickBtnTog, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
end

function TCKPetSelectView:buildUI()
	TCKPetSelectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSwitch = self:getGo("btnSwitch")
	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
	self._contractPetChange = self._btnSwitch:GetComponent("UIImageSpriteChange")
	self._contactPetIcon = self:getGo("btnSwitch/IconBg/Icon")
	self._txtSelectNum = self:getTxt("txtSelectNum")
	self._inputSearch = self:getInput("InputC_Search")
	self._InputC_Search_Clear = self:getGo("InputC_Search/BtnClear")
	self._filterButton = self:getGo("btnFilter")
	self._sortButton = self:getGo("btnSort")
	self._txtSure = self:getTxt("btnSure/txt")

	local tablecellGo = self:getGo("tablecell")
	local tableviewGo = self:getGo("tableview")

	self._tableview = ScrollerList.create(tableviewGo, tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnTog = self:getGo("togSwitch/btnTog")
	self._markTog = self:getGo("togSwitch/btnTog/mark")
end

function TCKPetSelectView:onExit()
	TCKPetSelectView.super.onExit(self)
	self._tableview:dispose()
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_PETVIEW)
	uGuiUtil.clearImage(self._contactPetIcon)

	if self._needSysn then
		TeenChampionKingController.instance:selectPets(self._activityId, self._lastSelectPetIds, self._isUseSysProperty)
	end
end

function TCKPetSelectView:onEnter()
	TCKPetSelectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_TCKSelectPets, self._onSelectPetsRes, self)
	self.addGEvent(self, GlobalNotify.PM_TCKChangeConract, self._onChangeConract, self)

	self._needSysn = true
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 501001
	end

	self._curSummonMasterId = TeenChampionKingController.instance:getSummonMasterId(self._activityId)
	self._curSummonMonsterId = TeenChampionKingController.instance:getSummonMonsterId(self._activityId)
	self._inputSearch.input.text = ""
	self._curSearchStr = self._inputSearch.input.text

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function TCKPetSelectView:_updateUIByCfg()
	self._maxNum = 0
	self._actCfg = TeenChampionKingConfig.instance:getActCfg(self._activityId)

	if self._actCfg then
		self._maxNum = self._actCfg.selectPetCount
	end

	self._systemPetCfgs = TeenChampionKingConfig.instance:getSystemPets()
	self._sysPets = {}
	self._sysPetMap = {}

	for _, cfg in ipairs(self._systemPetCfgs) do
		local powerPetMo = FightingPowerPetMo.New()

		powerPetMo:fromChallengeCreepCo(cfg)

		powerPetMo.isSupportedPet = true
		self._sysPetMap[cfg.creepsId] = powerPetMo

		table.insert(self._sysPets, powerPetMo)
	end
end

function TCKPetSelectView:_updateUIByInfo()
	self._isUseSysProperty = false
	self._lastSelectPetIds = {}
	self._selectedPetIdMap = {}
	self._selectedRaceIdMap = {}

	local info = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	if info then
		self._isUseSysProperty = info.useSysProperty

		if not info.selectPetIds then
			self._lastSelectPetIds = info.selectPetIds

			for _, petId in ipairs(info.selectPetIds) do
				self._selectedPetIdMap[petId] = true

				local petMo = self:_getPetMo(petId)

				if petMo then
					self._selectedRaceIdMap[petMo.raceId] = true
				end
			end
		end
	end

	self._tableview:reloadData({})

	if BagPetsController.instance:getReady() then
		self:_initGetInfo()
		self:_refreshView(true, true)
	end
end

function TCKPetSelectView:_initGetInfo()
	goutil.setActive(self._markTog, self._isUseSysProperty)

	self._maxPetList = {}

	local raceMap = {}

	self._maxZHSPet = nil
	self._maxMatchZHSPet = nil
	self._allPets = {}

	local petList = {}
	local showPets = {}
	local allBagPets = BagPetsController.instance:getBagPets() or {}

	for i, petMo in ipairs(self._sysPets) do
		local showPet = self:_getPetMo(petMo.petId)

		table.insert(showPets, showPet)
	end

	for i, petMo in ipairs(allBagPets) do
		local showPet = self:_getPetMo(petMo.petId)

		table.insert(showPets, showPet)
	end

	self._allPets = showPets

	for k, pet in ipairs(showPets) do
		local isZhaohuan = PetSkinConfig.instance:checkHasJob(pet.curFaceId, GameEnum.CareerType.Zhaohuanshi)

		if isZhaohuan then
			if self._maxZHSPet then
				if checknumber(self._maxZHSPet:getFightingPower()) < checknumber(pet:getFightingPower()) then
					self._maxZHSPet = pet
				end
			else
				self._maxZHSPet = pet
			end
		end

		table.insert(petList, pet)
	end

	ArraySort.sortOn(petList, {
		function(petMo)
			return checknumber(petMo:getFightingPower())
		end
	}, {
		ArraySort.DESCENDING
	})

	local matchRaceIdMap = {}

	if self._maxZHSPet then
		local zhsRaceId = self._maxZHSPet:getDefineId()
		local cfgList = ContractConfig.instance:getSummonBySummonMasterId(zhsRaceId)

		for i, cfg in ipairs(cfgList) do
			matchRaceIdMap[cfg.summonRaceId] = true
		end
	end

	if self._maxZHSPet then
		if self._maxZHSPet.isSupportedPet then
			self._maxMatchZHSPet = self:_getPetMo(self._maxZHSPet.summonedPetId)

			for _, petMo in ipairs(petList) do
				local raceId = petMo.raceId

				if #self._maxPetList < self._maxNum + 2 then
					if not raceMap[raceId] then
						raceMap[raceId] = true

						table.insert(self._maxPetList, petMo)
					end
				elseif self._maxMatchZHSPet then
					break
				end
			end
		else
			for _, petMo in ipairs(petList) do
				local raceId = petMo.raceId

				if not self._maxMatchZHSPet then
					local matchZhsRaceId = petMo:getDefineId()

					if matchRaceIdMap[matchZhsRaceId] then
						self._maxMatchZHSPet = petMo
					end
				end

				if #self._maxPetList < self._maxNum + 2 then
					if not raceMap[raceId] then
						raceMap[raceId] = true

						table.insert(self._maxPetList, petMo)
					end
				elseif self._maxMatchZHSPet then
					break
				end
			end
		end
	else
		for _, petMo in ipairs(petList) do
			if #self._maxPetList < self._maxNum + 2 then
				if not raceMap[petMo.raceId] then
					raceMap[petMo.raceId] = true

					table.insert(self._maxPetList, petMo)
				end
			else
				break
			end
		end
	end

	raceMap = {}
	self._bestList = {}

	if self._maxZHSPet then
		raceMap[self._maxZHSPet.raceId] = true

		table.insert(self._bestList, self._maxZHSPet)
	end

	if self._maxMatchZHSPet then
		raceMap[self._maxMatchZHSPet.raceId] = true

		table.insert(self._bestList, self._maxMatchZHSPet)
	end

	for i, petMo in ipairs(self._maxPetList) do
		if #self._bestList < self._maxNum and not raceMap[petMo.raceId] then
			raceMap[petMo.raceId] = true

			table.insert(self._bestList, petMo)
		end
	end
end

function TCKPetSelectView:_onSelectPetsRes()
	self:close()
end

function TCKPetSelectView:_onChangeConract(masterId, monsterId)
	local newMasterMo = self:_getPetMo(masterId)

	if newMasterMo and newMasterMo.isSupportedPet and monsterId ~= newMasterMo.summonedPetId then
		FloatWordMgr.instance:show("助战召唤师只能契约对应的助战召唤兽")

		return
	end

	local count = self:_getCurSelectNum()

	if count >= self._maxNum and monsterId > 0 and not self._selectedPetIdMap[monsterId] then
		FloatWordMgr.instance:show("当前选中精灵数量已达上限，请调整后在切换契约")

		return
	end

	local lastSelectMonsterMo = self:_getPetMo(self._curSummonMonsterId)

	if lastSelectMonsterMo then
		local petId = lastSelectMonsterMo.petId
		local raceId = lastSelectMonsterMo.raceId

		self._selectedPetIdMap[petId] = nil
		self._selectedRaceIdMap[raceId] = nil
	end

	self._curSummonMonsterId = monsterId

	local curSelectMonsterMo = self:_getPetMo(self._curSummonMonsterId)

	if curSelectMonsterMo then
		local petId = curSelectMonsterMo.petId
		local raceId = curSelectMonsterMo.raceId

		self._selectedPetIdMap[petId] = true
		self._selectedRaceIdMap[raceId] = true
	end

	self._curSummonMasterId = masterId

	self:_refreshView(false, false)
end

function TCKPetSelectView:_refreshView(isForceFresh, isReSort)
	local curNum = self:_getCurSelectNum()

	self._txtSelectNum.text = string.format("最多可选择：%d/%d", curNum, self._maxNum)
	self._txtSure.text = curNum <= 0 and "一键选择" or "确 定"

	self:_refreshPetList(isForceFresh, isReSort)
	self:_setSummonPet()
end

function TCKPetSelectView:_setSummonPet()
	if self._curSummonMasterId > 0 and self._curSummonMonsterId > 0 then
		self._contactPetIcon:SetActive(true)
		self._contractPetChange:ChangeStateNow(0)

		local petMo = self:_getPetMo(self._curSummonMasterId)

		if petMo then
			local modelCo = CharacterConfig.instance:getModelCo(checknumber(petMo.curFaceId))
			local url = GameUrl.getCharacterIconUrl(modelCo.headName)

			uGuiUtil.setSpriteToImage(self._contactPetIcon.gameObject, nil, url)
		end
	else
		self._contactPetIcon:SetActive(false)
		self._contractPetChange:ChangeStateNow(1)
	end
end

function TCKPetSelectView:_refreshPetList(isForceFresh, isReSort)
	if isForceFresh then
		self._curDataList = self:_getCurDataList()
	else
		self._curDataList = self._curDataList or {}

		local names, opt = self:GetSortParms()

		if isReSort then
			ArraySort.sortOn(self._curDataList, names, opt)
		end
	end

	self._tableview:reloadData(self._curDataList)

	if isForceFresh then
		self._tableview:MoveCellToBegin(0)
	elseif isReSort then
		self._tableview:MoveCellToBegin(0)
	end
end

function TCKPetSelectView:_getCurDataList()
	local curDataList = {}

	if not self._allPets then
		for k, v in pairs(self._allPets) do
			if self:_isMatch(v) then
				table.insert(curDataList, v)
			end
		end

		local limit = ConstConfig.instance:getPetLimltCount()

		if limit > 0 and limit <= #curDataList then
			-- block empty
		else
			local names, opt = self:GetSortParms()

			ArraySort.sortOn(curDataList, names, opt)
		end

		return curDataList
	end
end

function TCKPetSelectView:_isMatch(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
	local isMatchFilter = PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, petCo, pet.rare, pet.curFaceId)

	if isMatchFilter then
		if not string.nilorempty(self._curSearchStr) then
			local str = StringUtil.RelpaceEscapeChar(self._curSearchStr)
			local count = string.find(petCo.name, str)

			if not count then
				return false
			end
		end

		return true
	end

	return false
end

function TCKPetSelectView:_updateCell(view, cell, data)
	local petIcon = goutil.findChild(cell, "petIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local mark = goutil.findChild(cell, "btnSelect/mark")
	local petId = data.petId
	local raceId = data:getDefineId()

	goutil.setActive(mark, self._selectedPetIdMap[petId])

	txtName.text = data:getName()

	local isZhaohuan = PetSkinConfig.instance:checkHasJob(data.curFaceId, GameEnum.CareerType.Zhaohuanshi)
	local isGray = not self._selectedPetIdMap[petId] and self._selectedRaceIdMap[raceId]
	local proxy = MaterialMgr.setCellByData(MatType.Pet, data, petIcon)

	if proxy then
		if isZhaohuan then
			proxy.binder:setContractTag(petId, -1)
		else
			proxy.binder:setContractTag(-1, -1)
		end

		proxy.binder:setAutoTips(false)
		proxy.binder:setClickCallBack(function(petCell)
			if petIcon then
				CommonTipsMgr.instance:showPetTips(data)
			end
		end)
		proxy.binder:setGray(isGray)
	end

	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickSelectPet, self, data))
end

function TCKPetSelectView:_clearCell(cell)
	local petIcon = goutil.findChild(cell, "petIcon")

	MaterialMgr.resetAll(petIcon)
end

function TCKPetSelectView:_getCurSelectNum()
	return table.nums(self._selectedPetIdMap)
end

function TCKPetSelectView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function TCKPetSelectView:GetSortState()
	if self._sortValue == nil then
		self._sortValue = GameUtil.getUserData(SORTKEY)

		if self._sortValue == nil then
			self._sortValue = {}

			for i = 1, #BagModel.SORT_NAME do
				self._sortValue[i] = i == 1 and 1 or 0
			end
		end
	end

	return self._sortValue
end

function TCKPetSelectView:GetSortParms(checkIsInTeamFunc)
	local parm1 = {}
	local parm2 = {}
	local sortName

	table.insert(parm1, function(petMo)
		if self._selectedPetIdMap and self._selectedPetIdMap[petMo.petId] then
			return 1
		end

		return 0
	end)
	table.insert(parm2, ArraySort.DESCENDING)

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

function TCKPetSelectView:_getNeedTogTips()
	local key = string.format("%s_togTips_%s", self._viewPresentor.viewName, self._activityId)

	return checknumber(GameUtil.getUserDayData(key)) <= 0
end

function TCKPetSelectView:_onClickSure()
	local curNum = self:_getCurSelectNum()

	if curNum <= 0 then
		self:_oneKeySelect()
	else
		local petIds = {}

		for id, v in pairs(self._selectedPetIdMap) do
			table.insert(petIds, id)
		end

		if self:_getNeedTogTips() then
			local addTips = "\n<color=#eb4642>当前未选择召唤师和契约兽，第一轮布阵将无精灵可上阵</color>"

			if self._curSummonMasterId > 0 and self._curSummonMonsterId > 0 then
				addTips = ""
			end

			TipsFacade.instance:openPopupWindowNoCancelWithTog("提示", curNum >= self._maxNum and "完成选择后，战斗中只能上阵已选的精灵，匹配前可随时进行修改" .. addTips or "上阵精灵未选满，是否确定？" .. addTips, function()
				self._needSysn = false

				TeenChampionKingController.instance:selectPets(self._activityId, petIds, self._isUseSysProperty)
				TeenChampionKingController.instance:setSummonMasterId(self._activityId, self._curSummonMasterId)
				TeenChampionKingController.instance:setSummonMonsterId(self._activityId, self._curSummonMonsterId)
			end, function()
				local key = string.format("%s_togTips_%s", self._viewPresentor.viewName, self._activityId)

				GameUtil.saveUserDayData(key, 1)
			end, "确定", "今日不再提示")

			return
		else
			self._needSysn = false

			TeenChampionKingController.instance:selectPets(self._activityId, petIds, self._isUseSysProperty)
			TeenChampionKingController.instance:setSummonMasterId(self._activityId, self._curSummonMasterId)
			TeenChampionKingController.instance:setSummonMonsterId(self._activityId, self._curSummonMonsterId)
		end
	end
end

function TCKPetSelectView:_oneKeySelect()
	for i, petMo in ipairs(self._bestList) do
		self._selectedPetIdMap[petMo.petId] = true
		self._selectedRaceIdMap[petMo.raceId] = true
	end

	if self._maxZHSPet then
		self._curSummonMasterId = self._maxZHSPet.petId
	end

	if self._maxMatchZHSPet then
		self._curSummonMonsterId = self._maxMatchZHSPet.petId
	end

	self:_refreshView(false, false)
end

function TCKPetSelectView:_onClickCancel()
	self._curSummonMasterId = 0
	self._curSummonMonsterId = 0

	table.clear(self._selectedPetIdMap)
	table.clear(self._selectedRaceIdMap)
	self:_refreshView(false, false)
end

function TCKPetSelectView:_onClearSearchClick()
	self._inputSearch.input.text = ""
end

function TCKPetSelectView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._filterButton.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, GameUtil.handler(function()
		self:_refreshPetList(true, true)
	end, self))
end

function TCKPetSelectView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._sortButton.gameObject)
	local arr = self:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self._onRefreshPetSort, self))
end

function TCKPetSelectView:SetNextSort(idx)
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

	GameUtil.saveUserData(SORTKEY, self._sortValue)
end

function TCKPetSelectView:_onRefreshPetSort(idx, onResetCallback)
	self:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, self:GetSortState())

	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and self._curViewDatas and limit <= #self._curViewDatas then
		TipsFacade.instance:openCommonTips(ConstConfig.instance:getPetLimltTips())
	else
		local names, opt = self:GetSortParms()

		ArraySort.sortOn(self._curDataList, names, opt)
	end

	self._tableview:reloadData(self._curDataList)
end

function TCKPetSelectView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._curSearchStr then
		self._curSearchStr = text

		self:_refreshPetList(true, true)
	end
end

function TCKPetSelectView:_onClickSelectPet(petData)
	local curNum = self:_getCurSelectNum()
	local petId = petData.petId
	local raceId = petData.raceId
	local isSelected = self._selectedPetIdMap[petId]

	if isSelected then
		self._selectedPetIdMap[petId] = nil
		self._selectedRaceIdMap[raceId] = nil

		if petId == self._curSummonMonsterId then
			self._curSummonMasterId = 0
			self._curSummonMonsterId = 0
		elseif petId == self._curSummonMasterId then
			self._curSummonMasterId = 0

			local lastSelectMonsterMo = self:_getPetMo(self._curSummonMonsterId)

			if lastSelectMonsterMo then
				local petId = lastSelectMonsterMo.petId
				local raceId = lastSelectMonsterMo.raceId

				self._selectedPetIdMap[petId] = nil
				self._selectedRaceIdMap[raceId] = nil
			end

			self._curSummonMonsterId = 0
		end

		self:_refreshView(false, false)
	elseif curNum < self._maxNum then
		if self._selectedRaceIdMap[raceId] then
			return
		end

		self._selectedPetIdMap[petId] = true
		self._selectedRaceIdMap[raceId] = true

		self:_refreshView(false, false)

		local isZhaohuan = PetSkinConfig.instance:checkHasJob(petData.curFaceId, GameEnum.CareerType.Zhaohuanshi)

		if self._curSummonMasterId == 0 and isZhaohuan then
			self._curSummonMasterId = petId

			self:_onClickSwitch()
		end
	else
		FloatWordMgr.instance:show("已达到最大数量")
	end
end

function TCKPetSelectView:_getPetMo(petId)
	local petMo = self._sysPetMap[petId]

	if not petMo then
		local bagPetMo = BagPetsController.instance:getPet(petId)

		if not bagPetMo then
			return nil
		end

		if self._isUseSysProperty then
			local maxPetMo = FightingPowerPetMo.getMaxPetMoByData(bagPetMo)

			for k, v in pairs(GameEnum.AttrModelType) do
				maxPetMo.attrMo.extModelBaseAttrRate[v] = checknumber(self._actCfg.sysZdlWanPercent) / 10000
			end

			maxPetMo.isMyPackPet = false

			maxPetMo:calcAllAttr()

			maxPetMo.isMyPackPet = petMo.isMyPackPet
			petMo = maxPetMo
		else
			petMo = bagPetMo:GetClone()

			petMo.attrMo:resetPublicAttr()
			petMo.attrMo:calcTotalAttrs()
			petMo:refreshAllAttr()
		end
	end

	return petMo
end

function TCKPetSelectView:_onClickSwitch()
	local zhsMos = {}

	for id, v in pairs(self._selectedPetIdMap) do
		local petMo = self:_getPetMo(id)

		if petMo then
			local isZhaohuan = PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Zhaohuanshi)

			if isZhaohuan then
				table.insert(zhsMos, petMo)
			end
		end
	end

	if #zhsMos > 0 then
		UIStateManager.instance:open(ViewName.TCKContractSelectView, zhsMos, self._allPets, self:_getPetMo(self._curSummonMasterId), 0, self._curSummonMonsterId)
	else
		FloatWordMgr.instance:show("请先选择召唤师")
	end
end

function TCKPetSelectView:_onClickBtnTog()
	local isNeedTips = TeenChampionKingController.instance:checkTogSystem(self._activityId)

	if isNeedTips and not self._isUseSysProperty then
		local title = "提示"
		local text = "勾选后，在挑战时，己方全体精灵将使用系统属性"
		local togText = "今日不再提示"

		TipsFacade.instance:openPopupWindowNoCancelWithTog(title, text, function()
			self._isUseSysProperty = not self._isUseSysProperty

			self:_initGetInfo()
			self:_refreshPetList(true, true)
		end, function()
			TeenChampionKingController.instance:saveTogSystem(self._activityId)
		end, "确定", togText)
	else
		self._isUseSysProperty = not self._isUseSysProperty

		self:_initGetInfo()
		self:_refreshPetList(true, true)
	end
end

return TCKPetSelectView
