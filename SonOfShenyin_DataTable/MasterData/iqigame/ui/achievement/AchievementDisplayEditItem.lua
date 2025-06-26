-- chunkname: @IQIGame\\UI\\Achievement\\AchievementDisplayEditItem.lua

local AchievementDisplayEditItem = {}

function AchievementDisplayEditItem.New(go, mainView)
	local o = Clone(AchievementDisplayEditItem)

	o:Initialize(go, mainView)

	return o
end

function AchievementDisplayEditItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function AchievementDisplayEditItem:InitComponent()
	self.rectTransform = self.gameObject:GetComponent("RectTransform")
	self.ItemsEventTriggerListener = UGUIUtil.GetEventTriggerListener(self.gameObject)
end

function AchievementDisplayEditItem:InitDelegate()
	function self.onItemDragDelegate(gameObject, eventData, currentRayCastGameObject)
		self:OnItemDrag(gameObject, eventData, currentRayCastGameObject)
	end

	function self.onItemBeginDragDelegate(gameObject, eventData, currentRayCastGameObject)
		self:OnItemBeginDrag(gameObject, eventData, currentRayCastGameObject)
	end

	function self.onItemEndDragDelegate(gameObject, eventData, currentRayCastGameObject)
		self:OnItemEndDrag(gameObject, eventData, currentRayCastGameObject)
	end

	function self.onItemClickDelegate(gameObject, eventData)
		self:OnItemClick(gameObject, eventData)
	end
end

function AchievementDisplayEditItem:AddListener()
	self.ItemsEventTriggerListener._onDrag = self.ItemsEventTriggerListener._onDrag + self.onItemDragDelegate
	self.ItemsEventTriggerListener._onBeginDrag = self.ItemsEventTriggerListener._onBeginDrag + self.onItemBeginDragDelegate
	self.ItemsEventTriggerListener._onEndDrag = self.ItemsEventTriggerListener._onEndDrag + self.onItemEndDragDelegate
	self.ItemsEventTriggerListener.onPointerClick = self.ItemsEventTriggerListener.onPointerClick + self.onItemClickDelegate
end

function AchievementDisplayEditItem:RemoveListener()
	if self.ItemsEventTriggerListener then
		self.ItemsEventTriggerListener._onDrag = self.ItemsEventTriggerListener._onDrag - self.onItemDragDelegate
		self.ItemsEventTriggerListener._onBeginDrag = self.ItemsEventTriggerListener._onBeginDrag - self.onItemBeginDragDelegate
		self.ItemsEventTriggerListener._onEndDrag = self.ItemsEventTriggerListener._onEndDrag - self.onItemEndDragDelegate
		self.ItemsEventTriggerListener.onPointerClick = self.ItemsEventTriggerListener.onPointerClick - self.onItemClickDelegate
	end
end

function AchievementDisplayEditItem:OnDestroy()
	self:RemoveListener()
end

function AchievementDisplayEditItem:SetNonEdit()
	self.isEdit = false
end

function AchievementDisplayEditItem:Refresh(Data, isDrag)
	self.Data = Data

	self:EnableInteractive()
	self:SetNonEdit()
	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(self.Data.BigIcon), self.imageItem:GetComponent("Image"), function()
		LuaUtility.SetImageNativeSizeWithGameObject(self.imageItem)
	end)
end

function AchievementDisplayEditItem:GetRect()
	return self.rectTransform
end

function AchievementDisplayEditItem:SetSelect()
	self.isEdit = true
end

function AchievementDisplayEditItem:EnableInteractive()
	self.imageItem:GetComponent("Image").raycastTarget = true
end

function AchievementDisplayEditItem:UnAbleInteractive()
	self.imageItem:GetComponent("Image").raycastTarget = false
end

function AchievementDisplayEditItem:DestroySelf()
	self.mainView:RemoveEditItem(self)
	self:OnDestroy()
	LuaUtility.SetGameObjectShow(self.mainView.settingButtonsRoot, false)
	self.mainView:HideCurrentShadow()
	GameObject.Destroy(self.gameObject)
end

function AchievementDisplayEditItem:UpSibling()
	local currentSibling = self.gameObject.transform:GetSiblingIndex()

	if currentSibling >= self.mainView.ItemRaycastContainer.transform.childCount then
		return
	end

	self.gameObject.transform:SetSiblingIndex(currentSibling + 1)
end

function AchievementDisplayEditItem:DownSibling()
	local currentSibling = self.gameObject.transform:GetSiblingIndex()

	if currentSibling <= 3 then
		return
	end

	self.gameObject.transform:SetSiblingIndex(currentSibling - 1)
end

function AchievementDisplayEditItem:SetParent(parentTrans)
	self.gameObject.transform:SetParent(parentTrans)
end

function AchievementDisplayEditItem:SetAnchorPosition(posX, posY)
	LuaUtility.SetAnchoredPositionWithRectTransform(self.rectTransform, posX, posY)
end

function AchievementDisplayEditItem:SetSibling(index)
	self.gameObject.transform:SetSiblingIndex(index + 3)
end

function AchievementDisplayEditItem:SetPosWithShadowPos(shadowPos)
	LuaUtility.SetAnchoredPositionWithRectTransform(self.rectTransform, shadowPos.x, shadowPos.y)
end

function AchievementDisplayEditItem:OnItemBeginDrag(gameObject, eventData, currentRayCastGameObject)
	if not self.isEdit then
		return
	end

	self.mainView:SetCurrentEditItem(self)
	self:UnAbleInteractive()
end

function AchievementDisplayEditItem:OnItemDrag(gameObject, eventData, currentRayCastGameObject)
	if not self.isEdit then
		return
	end

	LuaUtility.ScreenPointToWorldPointInRectangle(self.rectTransform, eventData)
	self.mainView:ShowShadow(self.mainView.currentEditItem, eventData)
end

function AchievementDisplayEditItem:OnItemEndDrag(gameObject, eventData, currentRayCastGameObject)
	if not self.isEdit then
		return
	end

	if currentRayCastGameObject and currentRayCastGameObject.name == self.mainView.containerObjectName or currentRayCastGameObject.name == self.mainView.editItemName then
		self:SetPosWithShadowPos(self.mainView.currentShowShadow.anchoredPosition)
		self.mainView:SetDirty(true)
	else
		self.mainView:SetNonEditItem()
		self:DestroySelf()
		self.mainView:SetDirty(true)
	end

	self:EnableInteractive()
	self.mainView:RefreshBaseInfo()
end

function AchievementDisplayEditItem:OnItemClick(gameObject, eventData)
	if self.mainView.currentEditItem and self.mainView.currentEditItem.Data.Id == self.Data.Id then
		return
	end

	self.mainView:SetCurrentEditItem(self)
	self.mainView:HideCurrentShadow()
	self.mainView:ShowShadowWithEditItem(self)
end

return AchievementDisplayEditItem
