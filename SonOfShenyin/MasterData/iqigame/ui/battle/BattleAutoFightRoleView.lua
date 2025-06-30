-- chunkname: @IQIGame\\UI\\Battle\\BattleAutoFightRoleView.lua

local RoleItemView = {
	battleUnitID = 0
}

function RoleItemView.New(view, battleUnitID, battleActionOrderFollower)
	local obj = Clone(RoleItemView)

	obj:__Init(view, battleUnitID, battleActionOrderFollower)

	return obj
end

function RoleItemView:__Init(view, battleUnitID, battleActionOrderFollower)
	self.gameObject = view

	self.gameObject:SetActive(true)

	self.battleUnitID = battleUnitID
	self.battleActionOrderFollower = battleActionOrderFollower
	self.rectTransform = self.gameObject:GetComponent(typeof(UnityEngine.RectTransform))

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.iconGrayComponent = self.gameObject:GetComponent("GrayComponent")
	self.autoFightAnim = self.autoAnimRoot:GetComponent(typeof(UnityEngine.Animation))

	self:ShowIcon()
	self:ShowSkillIcon()

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)

	self.gameObject.name = battleUnitData.monsterConfigID

	self:__InitDelegate()
	self:__AddListener()
end

function RoleItemView:__InitDelegate()
	function self.delegateOnClick()
		if not BattleModule.EnableBattleMessageLogic then
			return
		end

		local aiTypeValue = self.aiTypeValue == BattleConstant.UnitAIType.Close and BattleConstant.UnitAIType.Open or BattleConstant.UnitAIType.Close

		self:UpdateAIType(aiTypeValue)
	end

	function self.delegateOnBattleUnitAITypeChange(battleUnitID, aiTypeValue)
		self:__OnBattleUnitAITypeChange(battleUnitID, aiTypeValue)
	end

	function self.delegateOnLongDown()
		if self.OnDragBeginEvent == nil then
			return
		end

		self.OnDragBeginEvent(self)
	end

	function self.delegateOnLongDownClick()
		if self.OnDragEvent ~= nil then
			self.OnDragEvent(self)
		end
	end

	function self.delegateOnLongDownEnd()
		if self.OnDragEndEvent == nil then
			return
		end

		self.OnDragEndEvent(self)
	end
end

function RoleItemView:__AddListener()
	local longButton = self.gameObject:GetComponent(typeof(LongButton))

	longButton.delay = 0.3
	longButton.clickInterval = 0.03

	longButton.onClick:AddListener(self.delegateOnClick)
	longButton.onLongDown:AddListener(self.delegateOnLongDown)
	longButton.onLongDownClick:AddListener(self.delegateOnLongDownClick)

	longButton.onLongDownEnd = self.delegateOnLongDownEnd

	EventDispatcher.AddEventListener(EventID.BattleUnitAITypeChange, self.delegateOnBattleUnitAITypeChange)
end

function RoleItemView:__RemoveListener()
	local longButton = self.gameObject:GetComponent(typeof(LongButton))

	longButton.onClick:RemoveListener(self.delegateOnClick)
	longButton.onLongDown:RemoveListener(self.delegateOnLongDown)
	longButton.onLongDownClick:RemoveListener(self.delegateOnLongDownClick)

	longButton.onLongDownEnd = nil

	EventDispatcher.RemoveEventListener(EventID.BattleUnitAITypeChange, self.delegateOnBattleUnitAITypeChange)
end

function RoleItemView:__OnBattleUnitAITypeChange(battleUnitID, aiTypeValue)
	if self.battleUnitID ~= battleUnitID then
		return
	end

	self:UpdateAIType(aiTypeValue)
end

function RoleItemView:UpdateAIType(aiTypeValue, onlyRefresh)
	if not onlyRefresh then
		if self.aiTypeValue == aiTypeValue then
			return
		end

		if not BattleModule.SetAiTypeByRecordData(self.battleUnitID, aiTypeValue, false) then
			return
		end
	end

	self.aiTypeValue = aiTypeValue

	if self.aiTypeValue == BattleConstant.UnitAIType.Open then
		self.selectRoot.gameObject:SetActive(true)
		self.selectBottomRoot.gameObject:SetActive(true)
		self.iconGrayComponent:SetGray(false)
		self.autoFightAnim:Play()
	else
		self.selectRoot.gameObject:SetActive(false)
		self.selectBottomRoot.gameObject:SetActive(false)
		self.iconGrayComponent:SetGray(true)
		self.autoFightAnim:Stop()
	end
end

function RoleItemView:SetOrder(order)
	self.order = order

	self.battleActionOrderFollower:SetOrder(order)
end

function RoleItemView:SetPosition(position)
	self.gameObject.transform.position = position
end

function RoleItemView:ShowIcon()
	local headIconPath = BattleModule.GetBattleUnitHeadIcon(self.battleUnitID)

	AssetUtil.LoadImage(self, headIconPath, self.headIcon:GetComponent(typeof(UnityEngine.UI.Image)))
end

function RoleItemView:ShowSkillIcon()
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)
	local skillData = battleUnitData:GetSkillBySkillType(Constant.SkillType.TYPE_ULTIMATE)
	local skillConfig = CfgSkillTable[skillData.skillCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(skillConfig.Icon), self.skillIcon:GetComponent("Image"))
end

function RoleItemView:Dispose()
	self:__RemoveListener()

	self.iconGrayComponent = nil
	self.autoFightAnim = nil
	self.rectTransform = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	UnityEngine.Object.Destroy(self.battleActionOrderFollower)
	UnityEngine.Object.Destroy(self.gameObject)

	self.gameObject = nil
end

local RoleView = {}

RoleView.DragStateConst = {
	Dragging = 2,
	DragStart = 1,
	DragEnd = 3,
	Standby = 0
}

function RoleView.New(view)
	local obj = Clone(RoleView)

	obj:__Init(view)

	return obj
end

function RoleView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.teamActionParentRectTransform = self.teamActionParent:GetComponent(typeof(UnityEngine.RectTransform))

	self.positionPanel:SetActive(false)
	self.heroHeadPrefab.gameObject:SetActive(false)

	self.dragState = self.DragStateConst.Standby

	function self.__delegateOnBattleUnitSkinChange(battleUnitID)
		self:__RefreshBattleUnitActionItemIcon(battleUnitID)
	end

	EventDispatcher.AddEventListener(EventID.BattleUnitSkinChange, self.__delegateOnBattleUnitSkinChange)
	self:__InitBattleUnitActionItems()
	self.gameObject.gameObject:SetActive(false)
end

function RoleView:__InitBattleUnitActionItems()
	self.followerMonoGameObject = UnityEngine.GameObject.New("BattleTeamActionsFollower")
	self.battleUnitActions = {}
end

function RoleView:__RefreshBattleUnitActionItems()
	local battleUnits = BattleTeamActionModule.battlePlayerTurnOrders

	for orderIndex, battleUnitID in pairs(battleUnits) do
		local actionItem = self.battleUnitActions[battleUnitID]

		if actionItem == nil then
			self.battleUnitActions[battleUnitID] = self:__AddBattleUnitActionItem(battleUnitID, orderIndex)
			actionItem = self.battleUnitActions[battleUnitID]
		else
			actionItem:SetOrder(orderIndex)
		end

		local target = self.positionPanel.transform:GetChild(orderIndex - 1)

		actionItem:SetPosition(target.transform.position)

		local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
		local aiTypeValue = battleUnitData:GetAIType()

		actionItem:UpdateAIType(aiTypeValue, true)
	end
end

function RoleView:ClearSelect()
	ForPairs(self.battleUnitActions, function(_battleUnitID, _actionItem)
		_actionItem:ChangeSelect(-1)
	end)
end

function RoleView:__RefreshBattleUnitActionItemIcon(battleUnitID)
	local actionItem = self.battleUnitActions[battleUnitID]

	if actionItem == nil then
		return
	end

	actionItem:ShowIcon()
	actionItem:ShowSkillIcon()
end

function RoleView:__AddBattleUnitActionItem(unitID, orderIndex)
	local heroObj = UnityEngine.Object.Instantiate(self.heroHeadPrefab)

	heroObj.transform:SetParent(self.teamActionParent.transform, false)

	local battleActionOrderFollower = self.followerMonoGameObject:AddComponent(typeof(BattleActionOrderFollower))

	battleActionOrderFollower:Init(heroObj.transform, self.positionPanel.transform)

	local battleUnitAction = RoleItemView.New(heroObj, unitID, battleActionOrderFollower)

	battleUnitAction:SetOrder(orderIndex)

	function battleUnitAction.OnDragBeginEvent(item)
		self:__OnActionItemBeginDrag(item)
	end

	function battleUnitAction.OnDragEvent(item)
		self:__OnActionItemDragging(item)
	end

	function battleUnitAction.OnDragEndEvent(item)
		self:__OnActionItemDragEnd(item)
	end

	return battleUnitAction
end

function RoleView:__OnActionItemBeginDrag(viewItem)
	self.dragState = self.DragStateConst.Dragging
	viewItem.battleActionOrderFollower.enabled = false
end

function RoleView:__OnActionItemDragging(viewItem)
	local isInRect, localPoint = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.teamActionParentRectTransform, UnityEngine.Input.mousePosition, GameEntry.UICamera, nil)

	localPoint.y = localPoint.y - self.teamActionParentRectTransform.rect.h / 2
	localPoint.x = viewItem.rectTransform.anchoredPosition.x
	localPoint.y = math.clamp(localPoint.y, self.teamActionParentRectTransform.rect.h * -1, -35)
	viewItem.rectTransform.anchoredPosition = localPoint

	local currentAreaOrder = math.modf(math.abs(localPoint.y) / 70) + 1

	viewItem.gameObject.transform:SetSiblingIndex(currentAreaOrder - 1)
	viewItem:SetOrder(viewItem.gameObject.transform:GetSiblingIndex() + 1)

	for _, battleUnitAction in pairs(self.battleUnitActions) do
		if battleUnitAction ~= viewItem then
			battleUnitAction:SetOrder(battleUnitAction.gameObject.transform:GetSiblingIndex() + 1)
		end
	end
end

function RoleView:__OnActionItemDragEnd(viewItem)
	self.dragState = self.DragStateConst.Standby

	local battleUnitOrders = {}

	for _, battleUnitAction in pairs(self.battleUnitActions) do
		battleUnitOrders[battleUnitAction.order] = battleUnitAction.battleUnitID
	end

	viewItem.battleActionOrderFollower.enabled = true

	BattleTeamActionModule.UpdatePlayerTurnOrders(battleUnitOrders)
end

function RoleView:Show()
	self.gameObject:SetActive(true)
	self:__RefreshBattleUnitActionItems()
end

function RoleView:Hide()
	self.gameObject:SetActive(false)
end

function RoleView:__OnDispose()
	if self.battleUnitActions ~= nil then
		for _, battleUnitAction in pairs(self.battleUnitActions) do
			battleUnitAction:Dispose()
		end
	end

	self.battleUnitActions = nil

	if self.followerMonoGameObject ~= nil then
		GameObject.Destroy(self.followerMonoGameObject)
	end

	self.followerMonoGameObject = nil

	self.gameObject:SetActive(false)
end

function RoleView:Dispose()
	EventDispatcher.RemoveEventListener(EventID.BattleUnitSkinChange, self.__delegateOnBattleUnitSkinChange)
	self:__OnDispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return RoleView
