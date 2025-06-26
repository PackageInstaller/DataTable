-- chunkname: @IQIGame\\UI\\Battle\\BattleTeamActionsView.lua

local BattleTeamActionItemView = require("IQIGame/UI/Battle/BattleTeamActionItemView")
local BattleTeamActionsUI = {}
local DragState = {
	Dragging = 2,
	DragStart = 1,
	DragEnd = 3,
	Standby = 0
}
local min = 1
local max = 7

function BattleTeamActionsUI.New(view)
	local obj = Clone(BattleTeamActionsUI)

	obj:Init(view)

	return obj
end

function BattleTeamActionsUI:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.teamActionParentRectTransform = self.teamActionParent:GetComponent(typeof(UnityEngine.RectTransform))

	self.heroObjPrefab:SetActive(false)
	self.positionPanel:SetActive(false)
	self.heroHeadPrefab.gameObject:SetActive(false)

	self.dragState = DragState.Standby

	function self.__delegateOnBattleUnitSkinChange(battleUnitID)
		self:__RefreshBattleUnitActionItemIcon(battleUnitID)
	end

	EventDispatcher.AddEventListener(EventID.BattleUnitSkinChange, self.__delegateOnBattleUnitSkinChange)
	self.View.gameObject:SetActive(false)
end

function BattleTeamActionsUI:__InitBattleUnitActionItems()
	self.followerMonoGameObject = UnityEngine.GameObject.New("BattleTeamActionsFollower")
	self.battleUnitActions = {}

	local battleUnits = BattleTeamActionModule.battlePlayerTurnOrders

	for orderIndex, battleUnitID in pairs(battleUnits) do
		self.battleUnitActions[battleUnitID] = self:__AddBattleUnitActionItem(battleUnitID, orderIndex)
	end
end

function BattleTeamActionsUI:__RefreshBattleUnitActionItems(curBattleUnitID)
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

		local interactable = BattleTeamActionModule.CheckUnitCanSetOrder(battleUnitID)

		actionItem:SetInteractable(interactable)
		actionItem:ChangeSelect(curBattleUnitID)
	end
end

function BattleTeamActionsUI:ClearSelect()
	ForPairs(self.battleUnitActions, function(_battleUnitID, _actionItem)
		_actionItem:ChangeSelect(-1)
	end)
end

function BattleTeamActionsUI:__RefreshBattleUnitActionItemIcon(battleUnitID)
	local actionItem = self.battleUnitActions[battleUnitID]

	if actionItem == nil then
		return
	end

	actionItem:ShowIcon()
end

function BattleTeamActionsUI:__AddBattleUnitActionItem(unitID, orderIndex)
	local heroObj = UnityEngine.Object.Instantiate(self.heroHeadPrefab)

	heroObj.transform:SetParent(self.teamActionParent.transform, false)

	local battleActionOrderFollower = self.followerMonoGameObject:AddComponent(typeof(BattleActionOrderFollower))

	battleActionOrderFollower:Init(heroObj.transform, self.positionPanel.transform)

	local battleUnitAction = BattleTeamActionItemView.New(heroObj, unitID, battleActionOrderFollower)

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

function BattleTeamActionsUI:__OnActionItemBeginDrag(viewItem)
	self.dragState = DragState.Dragging
	viewItem.battleActionOrderFollower.enabled = false
end

function BattleTeamActionsUI:__OnActionItemDragging(viewItem)
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

function BattleTeamActionsUI:__OnActionItemDragEnd(viewItem)
	self.dragState = DragState.Standby

	local battleUnitOrders = {}

	for _, battleUnitAction in pairs(self.battleUnitActions) do
		battleUnitOrders[battleUnitAction.order] = battleUnitAction.battleUnitID
	end

	viewItem.battleActionOrderFollower.enabled = true

	BattleTeamActionModule.UpdatePlayerTurnOrders(battleUnitOrders)
end

function BattleTeamActionsUI:OnOpen()
	self:OnClose()
	self:__InitBattleUnitActionItems()
end

function BattleTeamActionsUI:Open(battleUnitID)
	self.View.gameObject:SetActive(true)
	self:__RefreshBattleUnitActionItems(battleUnitID)
end

function BattleTeamActionsUI:Close()
	self.View.gameObject:SetActive(false)
end

function BattleTeamActionsUI:OnClose()
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

	self.View.gameObject:SetActive(false)
end

function BattleTeamActionsUI:OnDestroy()
	EventDispatcher.RemoveEventListener(EventID.BattleUnitSkinChange, self.__delegateOnBattleUnitSkinChange)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BattleTeamActionsUI:OnSelectCaster(battleUnitID)
	for _, battleUnitAction in pairs(self.battleUnitActions) do
		if battleUnitAction.battleUnitID == battleUnitID then
			battleUnitAction.selectedFrontImage:SetActive(true)
			battleUnitAction.selectedBackImage:SetActive(true)
			self.selectSkillEffect:SetActive(false)
			self.selectSkillEffect:SetActive(true)

			self.selectSkillEffect.transform.position = battleUnitAction.gameObject.transform.position

			local scale = BattleUIApi:GetBattleTeamActionUnitItemViewScale()

			battleUnitAction.gameObject.transform.localScale = Vector3.New(scale, scale, scale)
		else
			battleUnitAction.selectedFrontImage:SetActive(false)
			battleUnitAction.selectedBackImage:SetActive(false)

			battleUnitAction.gameObject.transform.localScale = Vector3.one
		end
	end
end

function BattleTeamActionsUI:OnUpdate()
	return
end

return BattleTeamActionsUI
