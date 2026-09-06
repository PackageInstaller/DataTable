-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationRightView.lua

module("logic.extensions.formation.view.FormationRightView", package.seeall)

local All = "all"
local FormationRightView = class("FormationRightView", TableViewComponent)

function FormationRightView:ctor()
	FormationRightView.super.ctor(self)
	NotifyDispatcher.extend(self)

	self._curViewDatas = {}
	self._JobSelected = All
	self._AttrSelected = All
	self._TagSelected = All
	self._SearchText = nil
	self._Character = nil
	self._dragging = false
	self.uiCamera = goutil.find("UICamera"):GetComponent(typeof(UnityEngine.Camera))
end

function FormationRightView:buildUI()
	self._Nego_Right = self:getGo("Nego_Right")

	local _Nego_Right = self._Nego_Right

	self._Nego_Character = self:getGo("Nego_Character")

	local rootType = self._viewPresentor:attachToWhichRoot()
	local currentRoot = ViewMgr.instance:getRoot(rootType)
	local nextRoot = ViewMgr.instance:getRoot(rootType + 1)
	local currentRootCanvas = currentRoot and currentRoot:GetComponent(ComponentType.Canvas)
	local nextRootCanvas = nextRoot and nextRoot:GetComponent(ComponentType.Canvas)

	self._characterSortingOrder = not goutil.isNil(nextRootCanvas) and nextRootCanvas.sortingOrder - 1 or not goutil.isNil(currentRootCanvas) and currentRootCanvas.sortingOrder + 50 or UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO) + 50

	if self._Nego_Character then
		local characterCanvas = goutil.addComponentOnce(self._Nego_Character, ComponentType.Canvas)

		characterCanvas.overrideSorting = true
		characterCanvas.sortingOrder = self._characterSortingOrder
	end

	self._characterEffect = self:getGo("characterEffect")
	self._SrlC_Pet = goutil.findChild(_Nego_Right, "SrlC_Pet"):GetComponent("ScrollRect")
	self._tableview = self._SrlC_Pet.gameObject:GetComponent("UITableview")
	self._tableCell = self:getGo("Cell")

	local _Nego_Popup = goutil.findChild(_Nego_Right, "Nego_Popup")

	self._Btn_Attr = goutil.findChild(_Nego_Popup, "Btn_Attr"):GetComponent("UIChangeGroup")
	self._InputC_Search = goutil.findChild(_Nego_Right, "InputC_Search"):GetComponent("InputField")
	self.btnClear = goutil.findChild(_Nego_Right, "InputC_Search/BtnClear")
	self._Nego_PetTips = goutil.findChild(_Nego_Right, "Nego_PetTips")
	self._sortButton = self:getBtn("Nego_Right/btnSort")

	self:registCallbacks()
end

function FormationRightView:destroyUI()
	FormationRightView.super.destroyUI(self)
end

function FormationRightView:bindEvents()
	self:_bindUIEvents()
end

function FormationRightView:_bindUIEvents()
	GameUtil.asBtn(self._Btn_Attr):AddClickListener(self._OnClickAttr, self)
	GameUtil.asBtn(self.btnClear):AddClickListener(self.clearSearch, self)
	self._sortButton:AddClickListener(self._onClickSort, self)

	self._onInputSearchValueChangedHandler = InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):AddLuaHandler(function(go, text)
		self:_OnSearchTextChanged(text)
	end)
end

function FormationRightView:unbindEvents()
	self:_unbindUIEvents()
end

function FormationRightView:_unbindUIEvents()
	InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):RemoveLuaHandler(self._onInputSearchValueChangedHandler)
	GameUtil.asBtn(self.btnClear):RemoveClickListener()
	GameUtil.asBtn(self._Btn_Attr):RemoveClickListener()
	self._sortButton:RemoveClickListener()
end

function FormationRightView:onEnter()
	FormationRightView.super.onEnter(self)

	self._allPetList = {}
	self._InputC_Search.text = ""
	self._JobSelected = All
	self._AttrSelected = All
	self._TagSelected = All
	self._SearchText = nil

	self:createFilterList()
	settimer(0, self._updateInputWhileDragging, self, -1)
	GlobalDispatcher:addListener(GlobalNotify.TeamChanged, self._OnTeamChanged, self, NotifyPriority.Low)
	GlobalDispatcher:addListener(GlobalNotify.FormationChanged, self._OnFormationChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationPosChanged, self._OnSeatValueChanged, self, NotifyPriority.Low)
	GlobalDispatcher:addListener(GlobalNotify.FormationHeroSkillChanged, self._OnHeroSkillChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationBagUpdate, self._OnFormationChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetChanged, self._onBagPetChange, self, NotifyPriority.High)
	GlobalDispatcher:addListener(GlobalNotify.FormationGuide_Right_Draging, self._onSetDraging, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_MakeContractRes, self.onRefreshPetLis, self)
	GlobalDispatcher:addListener(PetskinController.ChangePetSkinBodyType, self._onChangePetSkinBody, self)
	GlobalDispatcher:addListener(GlobalNotify.FormatForceEndDrag, self._OnDropSeat, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationTabModify, self._OnTeamChanged, self, NotifyPriority.Low)
	self.addGEvent(self, GlobalNotify.FormationShowRightInfo, self._onShowRightInfo, self)
	GameUtil.SetActive(self._Nego_Right, true)
	self:_setJobLabelStr()
end

function FormationRightView:onEnterFinished()
	self:onRefreshPetLis()
end

function FormationRightView:onRefreshPetLis()
	self:_initAllPetList()

	if BagPetsController.instance:getReady() then
		self:_RefreshPetList()
	end
end

function FormationRightView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.FormationTabModify, self._OnTeamChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.TeamChanged, self._OnTeamChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationChanged, self._OnFormationChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationPosChanged, self._OnSeatValueChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationHeroSkillChanged, self._OnHeroSkillChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationBagUpdate, self._OnFormationChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetChanged, self._onBagPetChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationGuide_Right_Draging, self._onSetDraging, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_MakeContractRes, self.onRefreshPetLis, self)
	GlobalDispatcher:removeListener(PetskinController.ChangePetSkinBodyType, self._onChangePetSkinBody, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormatForceEndDrag, self._OnDropSeat, self)
	FormationRightView.super.onExit(self)
	self:_resetFormCondition()
end

function FormationRightView:onExitFinished()
	removetimer(self._updateInputWhileDragging, self)

	if self._dragging and self._dragingGo then
		local data = ItemPet.Get(self._dragingGo):GetData()

		self:_OnDragPetEnded(self._dragingGo, data)
	end
end

function FormationRightView:createFilterList()
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_FMT_RIGHT)
end

function FormationRightView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	local viewPos = uiCamera:ScreenToViewportPoint(pos)

	if viewPos.x < 0.5 and viewPos.y < 0.5 then
		pos.x = pos.x - 50
		pos.y = pos.y + 120
	end

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function FormationRightView:_OnClickAttr()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._Btn_Attr.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_FMT_RIGHT, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function FormationRightView:updateFilterData(starList, jobList, rareList)
	self:_RefreshPetList()
end

function FormationRightView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_FMT_RIGHT, cfg, rare, skinId)
end

function FormationRightView:clearSearch()
	self._InputC_Search.text = ""
end

function FormationRightView:_updateInputWhileDragging()
	if self._dragging and self._dragingGo and UGUIToolHelper.IsMultiTouchDown() then
		local data = ItemPet.Get(self._dragingGo):GetData()

		self:_OnDragPetEnded(self._dragingGo, data)
	end
end

function FormationRightView:_numInView()
	return #self._curViewDatas
end

function FormationRightView:_cellSize()
	return 91, 91
end

function FormationRightView:initCell(cell)
	local component = ItemPet.AddOnce(cell.gameObject)

	component:addListener(ItemPet.Events.Click, function(data)
		self:_onClickPet(data)
	end)

	if not self._disableDrag then
		BeginDragHandler.Get(cell.gameObject):AddLuaHandler(function(go, data)
			self:_OnDragPetBegin(go, data)
		end)
		DragHandler.Get(cell.gameObject):AddLuaHandler(function(go, data)
			self:_OnDragPetMoved(go, data)
		end)
		EndDragHandler.Get(cell.gameObject):AddLuaHandler(function(go, data)
			self:_OnDragPetEnded(go, data)
		end)
	end
end

function FormationRightView:updateForbit(data)
	local inTeam = self:getInTeam(data)
	local hasUp = false
	local hasOneHire = self:getHasHireInTeam(data)
	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(data)

	data:setPetForbit(not inTeam and (hasUp or hasOneHire or canNotUp or hasOne or canNotUpWithYuan))
end

function FormationRightView:_updateCell(view, cell, data)
	local component = ItemPet.AddOnce(cell.gameObject)

	self:updateForbit(data)
	component:Init(data)
	component:setSelected(false)

	local inTeam = self:getInTeam(data)

	component:SetInTeam(inTeam)
	component:setFormConditionLabel(self._jobLabelStr)

	local fmtMo = self:_getCurFormation()

	component:setContractTag(fmtMo:GetSummonMasterPetId(), fmtMo:GetSummonPetId())
end

function FormationRightView:getInTeam(data)
	local var_30_0 = data ~= nil and self:_getCurFormation():HasPet(data.petId) or false
	local inTeam = true

	goto label_30_0

	::label_30_0::

	return inTeam
end

function FormationRightView:getHasHireInTeam(data)
	return (self:checkHasHireInTeam(data))
end

function FormationRightView:checkHasHireInTeam(data)
	local formation = self:_getCurFormation()

	for _, petId in ipairs(formation:GetPositions()) do
		if petId > 0 then
			local pet = self:getPetMoById(petId)

			if pet and pet.isHirePet == true then
				return data.isHirePet
			end
		end
	end

	return false
end

function FormationRightView:getYuanLimit(data)
	return false
end

function FormationRightView:_getCurFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function FormationRightView:getPetMoById(petId)
	if self._curPetMap and self._curPetMap[petId] then
		return self._curPetMap[petId]
	else
		return (BagPetsController.instance:getPet(petId))
	end
end

function FormationRightView:getHasUp(data)
	if data then
		local formation = self:_getCurFormation()

		for _, petId in ipairs(formation:GetPositions()) do
			if petId > 0 then
				local pet = self:getPetMoById(petId)

				if pet and pet.raceId == data.raceId then
					return true
				end
			end
		end
	end

	return false
end

function FormationRightView:_onSetDraging(boo)
	self._dragging = boo
end

function FormationRightView:_OnDragPetBegin(go, data)
	local drag = math.abs(data.delta.y) > math.abs(data.delta.x) and self._tableview:GetScrollRect().horizontal or math.abs(data.delta.y) < math.abs(data.delta.x) and self._tableview:GetScrollRect().vertical

	if drag then
		self._dragging = true
		self._dragingGo = go

		local pet = ItemPet.Get(go):GetData()

		if pet and pet.forbit then
			self:_onForbidDragTips(pet)

			return nil
		end

		GlobalDispatcher:dispatch(GlobalNotify.FormationDragBegin, pet)
		self:_activeCharacterEffect(true)
		self:_loadCharacter(pet)
	else
		self._dragging = nil

		self._tableview:GetScrollRect():OnBeginDrag(data)
		self._tableview:OnBeginDrag(data)
	end
end

function FormationRightView:_onForbidDragTips(petData)
	local inTeam = self:getInTeam(petData)
	local hasUp = self:getHasUp(petData)

	if not inTeam and hasUp then
		-- block empty
	end

	local hasOneHire = self:getHasHireInTeam(petData)

	if hasOneHire then
		FloatWordMgr.instance:show(lang("只能同时上阵一只租借精灵哦！"))

		return
	end
end

function FormationRightView:_OnDragPetMoved(go, data)
	if self._dragging then
		local pet = ItemPet.Get(go):GetData()

		if pet and pet.forbit then
			return nil
		end

		local pos = uGuiUtil.GetTouchWorldPosition()

		self:_setCharacterEffectPos(pos)
		self:_setCharacterPos(pos)
	else
		self._tableview:GetScrollRect():OnDrag(data)
	end
end

function FormationRightView:_OnDragPetEnded(go, data)
	if self._dragging then
		go = go or self._dragingGo

		local petMo

		if go then
			local pet = ItemPet.Get(go):GetData()

			petMo = pet

			if pet and pet.forbit then
				return nil
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.FormationDropBag)
		self:_activeCharacterEffect(false)
		self:_removeCharacter()
	elseif self._tableview and self._tableview:GetScrollRect() and data then
		self._tableview:GetScrollRect():OnEndDrag(data)
		self._tableview:OnEndDrag(data)
	end
end

function FormationRightView:_OnDropSeat()
	self:_OnDragPetEnded()
end

function FormationRightView:_loadCharacter(pet)
	self._Character = goutil.cloneAndSetParent(self._Nego_Character, self._Nego_Character.transform.parent)

	self._Character:SetActive(true)

	local characterCanvas = self._Character:GetComponent(ComponentType.Canvas)

	if not goutil.isNil(characterCanvas) then
		characterCanvas.overrideSorting = false
		characterCanvas.overrideSorting = true
		characterCanvas.sortingOrder = self._characterSortingOrder
	end

	self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()

	local modelCfg = CharactorFacade.instance:getFormationModelUIPosAndScale(pet.curFaceId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, pet.curFaceId, goutil.findChild(self._Character, "petContainer"), scale, nil, false, modelCfg[1], y)
			end
		end
	end
end

function FormationRightView:_removeCharacter()
	if not self._Character then
		return
	end

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	goutil.destroy(self._Character, true)

	self._Character = nil
	self._dragging = false
	self._dragingGo = nil
end

function FormationRightView:_setCharacterPos(pos)
	if not self._Character then
		return
	end

	self._Character.transform.position = pos
end

function FormationRightView:_RefreshPetSort(idx, onResetCallback)
	BagModel.instance:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, BagModel.instance:GetSortState())
	self:rankNow()
end

function FormationRightView:rankNow()
	if FormationController.instance:checkCanSort(self._curViewDatas) then
		local names, opt = BagModel.instance:GetSortParms(self:getPetAtCurFormationFunc())

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
end

function FormationRightView:getPetAtCurFormationFunc()
	return function(data)
		return (self:getInTeam(data) or nil) and 1
	end
end

function FormationRightView:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
	local isHit = false

	isHit = self:_isMatch(petCo, pet.rare, pet.curFaceId)

	if not string.nilorempty(self._SearchText) then
		local str = StringUtil.RelpaceEscapeChar(self._SearchText)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function FormationRightView:getAllShowPetList()
	return self._allPetList or {}
end

function FormationRightView:_initAllPetList()
	self._allPetList = BagPetsController.instance:getFightBagPet()
end

function FormationRightView:_RefreshPetList()
	self._curPetMap = {}

	self:setCurViewDatas()
	self:rankNow()
end

function FormationRightView:setCurViewDatas()
	self._curViewDatas = {}

	local pets = self:getAllShowPetList()

	for k, v in pairs(pets) do
		self._curPetMap[v.petId] = v

		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end
end

function FormationRightView:petDroped()
	GlobalDispatcher:dispatch(GlobalNotify.FormationDropBag)

	self._selectedPetId = nil
end

function FormationRightView:_onClickPet(data)
	if data then
		if data.forbit then
			self:_onForbidDragTips(data)

			return
		end

		self._selectedPetId = data.petId

		GlobalDispatcher:dispatch(GlobalNotify.FormationClickPet)

		if data.isMyPackPet then
			local skinCfg = PetSkinConfig.instance:getPetSkinCfg(data.curFaceId)
			local isShenshi = skinCfg and checknumber(skinCfg.oracleSkillId) > 0
			local hasBookSpirit = ContractConfig.instance:getBookSpiritCfgs(data.raceId) ~= nil

			if PetSkinConfig.instance:checkHasMutiBody(data.raceId) then
				BagPetsController.instance:sendChangePetBody(data)
			elseif PetSkinConfig.instance:checkHasEleAttr(data.curFaceId, GameEnum.RaceType.Yuan) then
				local guideVal = checknumber(GuideController.instance:getOrCheckVarAndDoOnce(GuideConst.VIEW_VAR_KEY_PET_CLICK_BLOCK))

				if guideVal == 1 then
					-- block empty
				else
					UIStateManager.instance:push(ViewName.ChangeracepopView, self:_getCurFormation(), data)
				end
			elseif isShenshi then
				local list = self:getAllShowPetList()

				UIStateManager.instance:push(ViewName.OracleselectpopView, {
					data
				}, list)
			elseif hasBookSpirit then
				local list = self:getAllShowPetList()

				UIStateManager.instance:push(ViewName.BookSpiritSelectPopView, {
					data
				}, list)
			else
				CommonTipsMgr.instance:showPetTips(data)
			end
		elseif PetSkinConfig.instance:checkHasEleAttr(data.curFaceId, GameEnum.RaceType.Yuan) then
			local guideVal = checknumber(GuideController.instance:getOrCheckVarAndDoOnce(GuideConst.VIEW_VAR_KEY_PET_CLICK_BLOCK))

			if guideVal == 1 then
				-- block empty
			else
				UIStateManager.instance:push(ViewName.ChangeracepopView, self:_getCurFormation(), data)
			end
		else
			CommonTipsMgr.instance:showPetTips(data)
		end
	end
end

function FormationRightView:_OnMenuCloseAttr()
	self._Btn_Attr:SetState(0)
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnPopupClick, self._OnMenuClickAttr, self)
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseAttr, self)
end

function FormationRightView:_OnMenuClickAttr(id)
	self:_OnClickAttrItem(id)
end

function FormationRightView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._sortButton.gameObject)
	local arr = BagModel.instance:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self._RefreshPetSort, self))
end

function FormationRightView:_OnSearchTextChanged(text)
	if text ~= self._SearchText then
		self._SearchText = text

		self:_RefreshPetList()
	end
end

function FormationRightView:_OnTeamChanged()
	if FormationNewModel.instance:isRecordTeam() then
		return
	end

	self:_RefreshPetList()
end

function FormationRightView:_OnFormationChanged()
	self._tableview:Refresh()
end

function FormationRightView:_onBagPetChange(changePetIdMap)
	self:onRefreshPetLis()
end

function FormationRightView:_OnSeatValueChanged()
	self:rankNow()
end

function FormationRightView:_OnHeroSkillChanged()
	return
end

function FormationRightView:_activeCharacterEffect(isActive)
	self._characterEffect:SetActive(isActive)
end

function FormationRightView:_setCharacterEffectPos(pos)
	Framework.TransformUtil.SetPos(self._characterEffect.transform, pos.x, pos.y, pos.z)
end

function FormationRightView:_setJobLabelStr()
	self._jobLabelStr = nil

	local formCondition = MissionModel.instance:getFormCondition()

	self._jobLabelStr = FormationValidatorController.instance:getAllLabelByConditionId(formCondition)
end

function FormationRightView:_resetFormCondition()
	MissionModel.instance:setFormCondition(nil)
end

function FormationRightView:_onChangePetSkinBody()
	self:onRefreshPetLis()
end

function FormationRightView:_onShowRightInfo(bool)
	GameUtil.SetActive(self._Nego_Right, bool)
end

return FormationRightView
