-- chunkname: @IQIGame\\UI\\Formation\\ItemCell\\FormationBoxCell.lua

local m = {
	iterationTime = 0.1,
	BoxIndex = 0,
	isCannotDrag = false,
	onDraging = false,
	cumulativeTime = 0,
	limitTime = 0.1,
	canRemove = false
}

function m.New(view, mainUIController, boxIndex)
	local obj = Clone(m)

	obj:Init(view, mainUIController, boxIndex)

	return obj
end

function m:Init(view, mainUIController, boxIndex)
	self.View = view
	self.MainUIController = mainUIController
	self.BoxIndex = boxIndex

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnBeginDrag(go, eventData, eventData_go)
		self:OnBeginDrag(go, eventData, eventData_go)
	end

	function self.DelegateOnDrag(go, eventData, eventData_go)
		self:OnDrag(go, eventData, eventData_go)
	end

	function self.DelegateOnEndDrag(go, eventData, eventData_go)
		self:OnEndDrag(go, eventData, eventData_go)
	end

	function self.DelegateLongClick()
		self:NotifyOpenRoleDetailsPanel()
	end

	function self.DelegateOnPointerDown(go, eventData)
		self:OnPointerDown(go, eventData)
	end

	function self.DelegateOnPointerUp(go, eventData)
		self:OnPointerUp(go, eventData)
	end

	function self.DelegateOnClickGodownBtn()
		self:OnClickGodownBtn()
	end

	function self.DelegateOnExChangeBoxDataEvent(isExChange, index)
		self:OnExChangeBoxDataEvent(isExChange, index)
	end

	function self.DelegateOnHeroAttrChangeEvent(heros)
		self:OnHeroAttrChangeEvent()
	end

	function self.__delegateOnShowFormationBoxCellCanDragEffect(_cellIndex, _canDrag)
		self:__OnShowFormationBoxCellCanDragEffect(_cellIndex, _canDrag)
	end

	self.eventTrigger = UGUIUtil.GetEventTriggerListener(self.HeroRoot)
	self.eventTrigger._onBeginDrag = self.eventTrigger._onBeginDrag + self.DelegateOnBeginDrag
	self.eventTrigger._onDrag = self.eventTrigger._onDrag + self.DelegateOnDrag
	self.eventTrigger._onEndDrag = self.eventTrigger._onEndDrag + self.DelegateOnEndDrag
	self.eventTrigger.onPointerDown = self.eventTrigger.onPointerDown + self.DelegateOnPointerDown
	self.eventTrigger.onPointerUp = self.eventTrigger.onPointerUp + self.DelegateOnPointerUp
	self.eventTrigger.onLongWaitTime = 0.4
	self.eventTrigger.onPointerLongClick = self.eventTrigger.onPointerLongClick + self.DelegateLongClick
	self.HeroRootRectTransform = self.HeroRoot:GetComponent("RectTransform")
	self.LastPosition = self.HeroRoot.transform.localPosition

	self:InitAboutBoxInfo()
	self:AddListeners()
	self.UnSelectEffectRoot.gameObject:SetActive(false)
	self.SelectEffectRoot.gameObject:SetActive(false)
end

function m:AddListeners()
	self.GodownBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGodownBtn)
	EventDispatcher.AddEventListener(EventID.ExChangeBoxDataEvent, self.DelegateOnExChangeBoxDataEvent)
	EventDispatcher.AddEventListener(EventID.RoleUpdateData, self.DelegateOnHeroAttrChangeEvent)
	EventDispatcher.AddEventListener(EventID.ShowFormationBoxCellCanDragEffect, self.__delegateOnShowFormationBoxCellCanDragEffect)
end

function m:RemoveListeners()
	self.GodownBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGodownBtn)
	EventDispatcher.RemoveEventListener(EventID.ExChangeBoxDataEvent, self.DelegateOnExChangeBoxDataEvent)
	EventDispatcher.RemoveEventListener(EventID.RoleUpdateData, self.DelegateOnHeroAttrChangeEvent)
	EventDispatcher.RemoveEventListener(EventID.ShowFormationBoxCellCanDragEffect, self.__delegateOnShowFormationBoxCellCanDragEffect)
end

function m:InitAboutBoxInfo()
	self.OtherInfoPanel:GetComponent("SortedComponentOrder").UIRootCanvas = self.MainUIController.gameObject:GetComponent("Canvas")
end

function m:SetData(heroData, showTroopType)
	self.HeroInfoParent:SetActive(heroData ~= nil)

	if heroData ~= nil then
		if self.heroData == heroData then
			return
		end

		self:OnHideEntity()
	else
		self:OnHideEntity()
	end

	self.showTroopType = showTroopType
	self.heroData = heroData
	self.isCannotDrag = self.heroData == nil or self.heroData.isTempHeroData

	if self.heroData ~= nil then
		if self.heroData.isHelpHeroData then
			FormationModule.HelpHeroIndex = self.BoxIndex
		end

		self:LoadHeroEntity()
	end

	self:SetHeroInfo()
end

function m:SetHeroInfo()
	self.HeroInfoParent:SetActive(self.heroData ~= nil)

	if self.heroData == nil then
		self.GodownBtn:SetActive(false)
	else
		self.ElementImg.gameObject:SetActive(true)
		self.GodownBtn:SetActive(not self.heroData.isTempHeroData)
		UGUIUtil.SetText(self.LvText, self.heroData.lv)

		if self.heroData.TheType == CombatFormationModel.WarkLockType.NPC then
			self.ProfessionImg:SetActive(false)

			if CfgMonsterTable[self.heroData.MonsterId].Elements > 0 then
				AssetUtil.LoadImage(self, WarlockApi:GetElementIconPath(CfgMonsterTable[self.heroData.MonsterId].Elements), self.ElementImg:GetComponent("Image"))
			else
				self.ElementImg.gameObject:SetActive(false)
			end
		else
			self.ProfessionImg:SetActive(true)
			AssetUtil.LoadImage(self, WarlockApi:GetProfessionIconPath(CfgHeroTable[self.heroData.cid].Profession), self.ProfessionImg:GetComponent("Image"))
			AssetUtil.LoadImage(self, WarlockApi:GetElementIconPath(CfgHeroTable[self.heroData.cid].Elements), self.ElementImg:GetComponent("Image"))
		end
	end
end

function m:OnHideEntity()
	if self.heroEntity ~= nil and self.uniqueEntityID ~= nil then
		EntityUtility.HideEntitySafelyByEntityID(self.uniqueEntityID)

		self.heroEntity = nil
		self.uniqueEntityID = nil
	end
end

function m:OnBeginDrag(go, eventData, eventData_go)
	EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, true, -999)
	EventDispatcher.Dispatch(EventID.ShowFormationBoxCellCanDragEffect, -999, false)

	if UGUIUtil.GetPointEventDataInputButton(eventData) ~= 0 then
		return
	end

	if self.isCannotDrag then
		return
	end

	self.onDraging = true

	EventDispatcher.Dispatch(EventID.FormationHeroOnLongClickEvent, false)
	EventDispatcher.Dispatch(EventID.FormationDragStateChageEvent, true)

	self.HeroRoot:GetComponent("Image").enabled = false
end

function m:OnDrag(go, eventData, eventData_go)
	if UGUIUtil.GetPointEventDataInputButton(eventData) ~= 0 then
		return
	end

	if self.isCannotDrag then
		return
	end

	UGUIUtil.ScreenPointToWorldPointInRectangle(self.HeroRootRectTransform, eventData)

	if self.heroData.isTempHeroData then
		return
	end

	local index = FormationModule.CheckEndDragGridIndex(eventData_go)

	if index == -1 or eventData_go == nil then
		EventDispatcher.Dispatch(EventID.ShowFormationBoxCellCanDragEffect, -999, false)
		EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, true, -999)

		return
	end

	local intoHeroData = FormationModule.CurFormationDataList[index]

	if intoHeroData == nil then
		EventDispatcher.Dispatch(EventID.ShowFormationBoxCellCanDragEffect, index, true)
		EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, true, -999)

		return
	end

	if intoHeroData.isTempHeroData then
		EventDispatcher.Dispatch(EventID.ShowFormationBoxCellCanDragEffect, index, false)
		EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, true, -999)

		return
	end

	EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, true, index)
	EventDispatcher.Dispatch(EventID.ShowFormationBoxCellCanDragEffect, index, true)
end

function m:OnEndDrag(go, eventData, eventData_go)
	EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, true, -999)
	EventDispatcher.Dispatch(EventID.ShowFormationBoxCellCanDragEffect, -999, false)

	if UGUIUtil.GetPointEventDataInputButton(eventData) ~= 0 then
		return
	end

	if self.isCannotDrag then
		return
	end

	self.HeroRoot.transform.localPosition = self.LastPosition

	local index = FormationModule.CheckEndDragGridIndex(eventData_go)

	if index == -1 or eventData_go == nil then
		if self.heroData.isTempHeroData then
			NoticeModule.ShowNotice(49009)

			self.HeroRoot:GetComponent("Image").enabled = true

			return
		end

		if self.heroData.isHelpHeroData or self.heroData.isTempHeroData then
			-- block empty
		else
			if not self.canRemove then
				goto label_21_0
			end

			EventDispatcher.Dispatch(EventID.GoDownBattleSuccessEvent, self.heroData.cid)
		end

		FormationModule.UpdateCurFormationData(self.BoxIndex, nil)
	else
		local intoHeroData = FormationModule.CurFormationDataList[index]

		if FormationModule.GetTerrainIsCanGointo(index, true).Used == Constant.FormationGointoBattleType.BAN then
			goto label_21_0
		end

		if self.heroData.isTempHeroData then
			goto label_21_0
		end

		if intoHeroData ~= nil and intoHeroData.isTempHeroData then
			goto label_21_0
		end

		FormationModule.UpdateCurFormationData(index, self.heroData)
		FormationModule.UpdateCurFormationData(self.BoxIndex, intoHeroData)
	end

	FormationModule.NotifyFormationChange()
	EntityUtility.SetEntityVisibleByEntityID(self.uniqueEntityID, false)

	::label_21_0::

	self.HeroRoot:GetComponent("Image").enabled = true

	EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, false)

	self.onDraging = false
end

function m:OnPointerDown(go, eventData)
	if UGUIUtil.GetPointEventDataInputButton(eventData) ~= 0 then
		return
	end

	self.cumulativeTime = 0
	self.timer = Timer.New(function()
		self.cumulativeTime = self.cumulativeTime + self.iterationTime
	end, self.iterationTime, -1)

	self.timer:Start()
end

function m:OnPointerUp(go, eventData)
	if UGUIUtil.GetPointEventDataInputButton(eventData) ~= 0 then
		return
	end

	if self.cumulativeTime <= self.limitTime and self.onDraging == false then
		-- block empty
	end

	if self.timer ~= nil then
		self.timer:Stop()
	end
end

function m:LoadHeroEntity()
	CoroutineUtility.StartCoroutine(function()
		self.uniqueEntityID = GameEntry.Entity:GenerateEntityID()
		self.entityID = self.heroData:GetCurSpineElementEntityID()

		GameEntry.Entity:ShowBattleElement(self.uniqueEntityID, self.entityID, 0, self.HeroParent.transform, Vector3.zero)
		CoroutineUtility.Yield(function()
			while self.heroEntity == nil do
				self.heroEntity = GameEntry.Entity:GetEntity(self.uniqueEntityID)

				CoroutineUtility.Yield()
			end

			self.HeroSpineGo = self.heroEntity.gameObject

			self:RefreshSkeleton()
		end)
	end)
end

function m:RefreshSkeleton()
	local mainCanvasOrder = self.MainUIController:GetComponent("Canvas").sortingOrder
	local boxCol = math.fmod(self.BoxIndex, 3)

	if boxCol == 0 then
		boxCol = 3
	end

	mainCanvasOrder = mainCanvasOrder + 3 + (boxCol - 1)

	local elementEntityConfig = CfgElementEntityTable[self.entityID]

	if elementEntityConfig ~= nil then
		if self.showTroopType then
			if elementEntityConfig.IsPrefabFaceToRight then
				self.isUnitFlip = false
			else
				self.isUnitFlip = true
			end
		elseif elementEntityConfig.IsPrefabFaceToRight then
			self.isUnitFlip = true
		else
			self.isUnitFlip = false
		end
	else
		self.isUnitFlip = false
	end

	EntityUtility.BattleSpineToUIShow(self.HeroSpineGo, mainCanvasOrder, self.isUnitFlip, self.heroData.MonsterId, "idle")

	self.HeroSpineGo.transform.localScale = Vector3.New(85, 85, 1)
	self.HeroSpineGo.transform.localPosition = Vector3.zero
end

function m:NotifyOpenRoleDetailsPanel()
	return
end

function m:OnClickGodownBtn()
	if self.heroData.isTempHeroData then
		NoticeModule.ShowNotice(49009)

		return
	end

	FormationModule.UpdateCurFormationData(self.BoxIndex, nil)
	FormationModule.NotifyFormationChange()
end

function m:OnExChangeBoxDataEvent(isExChange, index)
	local active = self.BoxIndex == index

	if self.heroData == nil then
		active = false
	end

	self.CanChangeEffect:SetActive(active)
end

function m:__OnShowFormationBoxCellCanDragEffect(_cellIndex, _canDrag)
	if self.BoxIndex ~= _cellIndex then
		self.UnSelectEffectRoot.gameObject:SetActive(false)
		self.SelectEffectRoot.gameObject:SetActive(false)
	else
		self.UnSelectEffectRoot.gameObject:SetActive(not _canDrag)
		self.SelectEffectRoot.gameObject:SetActive(_canDrag)
	end
end

function m:OnHeroAttrChangeEvent()
	if self.heroData == nil then
		return
	end

	if not self.heroData.isHelpHeroData and not self.heroData.isTempHeroData then
		self.heroData = WarlockModule.WarlockDataDic[self.heroData.cid]

		self:SetHeroInfo()
	end
end

function m:RefreshTerrain(isSeePlayerTeam)
	local terrainCfg = FormationModule.GetTerrainIsCanGointo(self.BoxIndex, isSeePlayerTeam)

	self.isCannotGointo = terrainCfg.Used ~= 0

	if terrainCfg.Id ~= 0 and self.isCannotGointo then
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(terrainCfg.BigTerrainImg), self.TerrainImg:GetComponent("Image"))
	end

	self:SetTerrainState(terrainCfg.Id ~= 0 and self.isCannotGointo)
	self.BanImg:SetActive(not self.isCannotGointo)
end

function m:SetTerrainState(state)
	self.TerrainImg:SetActive(state)
end

function m:LimitDragPosition()
	return
end

function m:OnClose()
	self:OnHideEntity()

	self.heroData = nil
end

function m:Dispose()
	self:OnHideEntity()

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	self.heroData = nil
	self.BoxIndex = 0
	self.HeroSpineGo = nil
	self.LastPosition = nil

	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
