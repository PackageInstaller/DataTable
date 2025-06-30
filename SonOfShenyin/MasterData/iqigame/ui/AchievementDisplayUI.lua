-- chunkname: @IQIGame\\UI\\AchievementDisplayUI.lua

local AchievementDisplayUI = {}

AchievementDisplayUI = Base:Extend("AchievementDisplayUI", "IQIGame.Onigao.UI.AchievementDisplayUI", AchievementDisplayUI)

local AchievementDisplayItemClass = require("IQIGame.UI.Achievement.AchievementDisplayItem")
local AchievementDisplayEditItemClass = require("IQIGame.UI.Achievement.AchievementDisplayEditItem")
local DropDownUIClass = require("IQIGame.UI.Common.DropDownUI")
local AchievementDisplayDetailTipClass = require("IQIGame.UI.Achievement.AchievementDisplayDetailTip")
local unitRow = 29
local unitColumn = 29

function AchievementDisplayUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
end

function AchievementDisplayUI:InitMembers()
	self.AchievementItemScrollViewCell = {}
	self.editItemList = {}
	self.smallShadowPosList = {}
	self.middleShadowPosList = {}
	self.bigShadowPosList = {}
	self.currentEditItem = nil
	self.isDirty = false
	self.containerObjectName = "ItemRaycastContainer"
	self.dragRaycastTargetName = "buttonDetail"
	self.editItemName = "imageItem"
	self.dropDownHasText = {
		AchievementApi:TextAll(),
		AchievementApi:TextHas(),
		(AchievementApi:TextNotHas())
	}
	self.dropDownIconText = {
		AchievementApi:TextAll(),
		AchievementApi:TextBigIcon(),
		AchievementApi:TextMiddleIcon(),
		(AchievementApi:TextSmallIcon())
	}
	self.currentHasType = Constant.AchievementDisplayHasSelectType.All
	self.currentIconType = Constant.AchievementDisplayIconSelectType.All
end

function AchievementDisplayUI:InitComponent()
	local AchievementItemScroll = self.AchievementItemScroll:GetComponent("ScrollAreaList")

	function AchievementItemScroll.onRenderCell(gridCell)
		self:OnAchievementItemScrollRenderGridCell(gridCell)
	end

	self.buttonTrue = self.buttonTrue:GetComponent("Button")
	self.buttonCancel = self.buttonCancel:GetComponent("Button")
	self.ItemRaycastContainerRect = self.ItemRaycastContainer:GetComponent("RectTransform")
	self.smallShadow = self.smallShadow:GetComponent("RectTransform")
	self.middleShadow = self.middleShadow:GetComponent("RectTransform")
	self.bigShadow = self.bigShadow:GetComponent("RectTransform")
	self.dropDownHas = DropDownUIClass.New(self.dropDownHas, function(selectIndex)
		self:OnDropDownHasClick(selectIndex)
	end, nil)

	self.dropDownHas:InitDropdownData(self.dropDownHasText)

	self.dropDownIcon = DropDownUIClass.New(self.dropDownIcon, function(selectIndex)
		self:OnDropDownIconClick(selectIndex)
	end, nil)

	self.dropDownIcon:InitDropdownData(self.dropDownIconText)

	self.ItemsEventTriggerListener = UGUIUtil.GetEventTriggerListener(self.AchievementItemScroll)

	local tempOffsetX = 0
	local tempOffsetY = 0

	for i = 1, 36 do
		tempOffsetY = 0

		for j = 1, 14 do
			if i + 4 <= 37 and j + 5 <= 15 then
				table.insert(self.smallShadowPosList, Vector2.New(self.smallShadow.anchoredPosition.x + tempOffsetX, self.smallShadow.anchoredPosition.y + tempOffsetY))
			end

			if i + 5 <= 37 and j + 6 <= 15 then
				table.insert(self.middleShadowPosList, Vector2.New(self.middleShadow.anchoredPosition.x + tempOffsetX, self.middleShadow.anchoredPosition.y + tempOffsetY))
			end

			if i + 6 <= 37 and j + 7 <= 15 then
				table.insert(self.bigShadowPosList, Vector2.New(self.bigShadow.anchoredPosition.x + tempOffsetX, self.bigShadow.anchoredPosition.y + tempOffsetY))
			end

			tempOffsetY = tempOffsetY - unitColumn
		end

		tempOffsetX = tempOffsetX + unitRow
	end

	self.buttonTrueSet = {}
	self.buttonTrueSet.button = self.buttonTrue

	LuaCodeInterface.BindOutlet(self.buttonTrue.gameObject, self.buttonTrueSet)

	self.AchievementDisplayDetailTip = AchievementDisplayDetailTipClass.New(self.DetailParent, self)

	self.AchievementDisplayDetailTip:Close()

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function AchievementDisplayUI:InitDelegate()
	function self.buttonReturnDelegate()
		self:OnButtonReturnClick()
	end

	function self.buttonHomeDelegate()
		self:OnButtonHomeClick()
	end

	function self.onItemDragDelegate(gameObject, eventData, currentRayCastGameObject)
		self:OnItemDrag(gameObject, eventData, currentRayCastGameObject)
	end

	function self.onItemBeginDragDelegate(gameObject, eventData, currentRayCastGameObject)
		self:OnItemBeginDrag(gameObject, eventData, currentRayCastGameObject)
	end

	function self.onItemEndDragDelegate(gameObject, eventData, currentRayCastGameObject)
		self:OnItemEndDrag(gameObject, eventData, currentRayCastGameObject)
	end

	function self.OnItemClickDelegate(gameObject, eventData)
		self:OnItemClick(gameObject, eventData)
	end

	function self.buttonTrueDelegate()
		self:OnButtonTrueClick()
	end

	function self.buttonCancelDelegate()
		self:OnButtonCancelClick()
	end

	function self.sortByEditItemDelegate(list)
		self:SortByEditItem(list)
	end

	function self.ItemRaycastContainerDelegate()
		self:OnItemRaycastContainerClick()
	end

	function self.saveSucceedDelegate()
		self:saveSucceed()
	end
end

function AchievementDisplayUI:OnAddListeners()
	self.buttonTrue.onClick:AddListener(self.buttonTrueDelegate)
	self.buttonCancel.onClick:AddListener(self.buttonCancelDelegate)
	self.ItemRaycastContainer:GetComponent("Button").onClick:AddListener(self.ItemRaycastContainerDelegate)

	self.ItemsEventTriggerListener._onDrag = self.ItemsEventTriggerListener._onDrag + self.onItemDragDelegate
	self.ItemsEventTriggerListener._onBeginDrag = self.ItemsEventTriggerListener._onBeginDrag + self.onItemBeginDragDelegate
	self.ItemsEventTriggerListener._onEndDrag = self.ItemsEventTriggerListener._onEndDrag + self.onItemEndDragDelegate
	self.ItemsEventTriggerListener.onPointerClick = self.ItemsEventTriggerListener.onPointerClick + self.OnItemClickDelegate

	EventDispatcher.AddEventListener(EventID.AchievementDisplayUISortByEditItem, self.sortByEditItemDelegate)
	EventDispatcher.AddEventListener(EventID.AchievementDisplayUISortSaveSucceed, self.saveSucceedDelegate)
	self.commonReturnBtn:RegisterReturnEvent(self.buttonReturnDelegate)
	self.commonReturnBtn:RegisterBackHomeEvent(self.buttonHomeDelegate)
end

function AchievementDisplayUI:OnRemoveListeners()
	self.buttonTrue.onClick:RemoveListener(self.buttonTrueDelegate)
	self.buttonCancel.onClick:RemoveListener(self.buttonCancelDelegate)
	self.ItemRaycastContainer:GetComponent("Button").onClick:RemoveListener(self.ItemRaycastContainerDelegate)

	self.ItemsEventTriggerListener._onDrag = self.ItemsEventTriggerListener._onDrag - self.onItemDragDelegate
	self.ItemsEventTriggerListener._onBeginDrag = self.ItemsEventTriggerListener._onBeginDrag - self.onItemBeginDragDelegate
	self.ItemsEventTriggerListener._onEndDrag = self.ItemsEventTriggerListener._onEndDrag - self.onItemEndDragDelegate
	self.ItemsEventTriggerListener.onPointerClick = self.ItemsEventTriggerListener.onPointerClick - self.OnItemClickDelegate

	EventDispatcher.RemoveEventListener(EventID.AchievementDisplayUISortByEditItem, self.sortByEditItemDelegate)
	EventDispatcher.RemoveEventListener(EventID.AchievementDisplayUISortSaveSucceed, self.saveSucceedDelegate)
end

function AchievementDisplayUI:OnOpen(userData)
	self:Refresh()
end

function AchievementDisplayUI:OnClose(userData)
	for i = #self.editItemList, 1, -1 do
		self.editItemList[i]:DestroySelf()
	end

	self.editItemList = {}
end

function AchievementDisplayUI:OnDestroy()
	self.commonReturnBtn:Dispose()
end

function AchievementDisplayUI:GetPreloadAssetPaths()
	return nil
end

function AchievementDisplayUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AchievementDisplayUI:IsManualShowOnOpen(userData)
	return false
end

function AchievementDisplayUI:GetBGM(userData)
	return nil
end

function AchievementDisplayUI:OnPause()
	return
end

function AchievementDisplayUI:OnResume()
	return
end

function AchievementDisplayUI:OnCover()
	return
end

function AchievementDisplayUI:OnReveal()
	return
end

function AchievementDisplayUI:OnRefocus(userData)
	return
end

function AchievementDisplayUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AchievementDisplayUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AchievementDisplayUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AchievementDisplayUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AchievementDisplayUI:OnButtonReturnClick()
	if self.isDirty then
		NoticeModule.ShowNotice(70002, function()
			self:OnButtonTrueClick()
			UIModule.Close(Constant.UIControllerName.AchievementDisplayUI)
		end, function()
			UIModule.Close(Constant.UIControllerName.AchievementDisplayUI)
		end)
	else
		UIModule.Close(Constant.UIControllerName.AchievementDisplayUI)
	end
end

function AchievementDisplayUI:OnButtonHomeClick()
	if self.isDirty then
		NoticeModule.ShowNotice(70002, function()
			self:OnButtonTrueClick()
			UIModule.CloseAllUIFrom({
				Constant.UIControllerName.MainUI
			})
		end, function()
			UIModule.CloseAllUIFrom({
				Constant.UIControllerName.MainUI
			})
		end)
	else
		UIModule.CloseAllUIFrom({
			Constant.UIControllerName.MainUI
		})
	end
end

function AchievementDisplayUI:OnItemBeginDrag(gameObject, eventData, currentRayCastGameObject)
	if currentRayCastGameObject.name ~= self.dragRaycastTargetName then
		return
	end

	local itemViewCellTransform = currentRayCastGameObject.transform.parent
	local viewCell = self.AchievementItemScrollViewCell[itemViewCellTransform.gameObject:GetInstanceID()]

	if viewCell:GetUsed() then
		return
	end

	viewCell:SetUsed()
	viewCell:SetChose()

	self.currentViewCell = viewCell

	local ItemEditorObject = GameObject.Instantiate(self.ItemEditorImagePrefab, self.ItemRaycastContainer.transform)

	ItemEditorObject.transform.position = itemViewCellTransform.position
	self.AchievementItemScroll:GetComponent("ScrollAreaList").enableDrag = false

	local dragItem = AchievementDisplayEditItemClass.New(ItemEditorObject, self)

	dragItem:Refresh(viewCell.Data, true)
	dragItem:UnAbleInteractive()

	self.currentDragItem = dragItem
end

function AchievementDisplayUI:OnItemDrag(gameObject, eventData, currentRayCastGameObject)
	if not self.currentDragItem then
		return
	end

	LuaUtility.ScreenPointToWorldPointInRectangle(self.currentDragItem:GetRect(), eventData)
	self:ShowShadow(self.currentDragItem, eventData)
end

function AchievementDisplayUI:OnItemEndDrag(gameObject, eventData, currentRayCastGameObject)
	if currentRayCastGameObject and currentRayCastGameObject.name == self.containerObjectName or currentRayCastGameObject.name == self.editItemName then
		if self.currentDragItem then
			if #self.editItemList >= CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.AchievementDisplayMaxCount) then
				NoticeModule.ShowNotice(70004)

				if self.currentDragItem then
					self.currentDragItem:DestroySelf()
				end

				if self.currentViewCell then
					self.currentViewCell:SetNonUse()
				end

				return
			end

			self:AddEditItemByList(self.currentDragItem)
			self.currentDragItem:SetPosWithShadowPos(self.currentShowShadow.anchoredPosition)
			self.currentDragItem:Refresh(CfgUtil.GetItemCfgDataWithID(self.currentDragItem.Data.Id))
			self:SetCurrentEditItem(self.currentDragItem)
		end
	else
		if self.currentDragItem then
			self.currentDragItem:DestroySelf()
		end

		if self.currentViewCell then
			self.currentViewCell:SetNonUse()
		end
	end

	self.currentDragItem = nil
	self.currentViewCell = nil
	self.AchievementItemScroll:GetComponent("ScrollAreaList").enableDrag = true

	self:RefreshBaseInfo()
end

function AchievementDisplayUI:OnItemClick(gameObject, eventData)
	return
end

function AchievementDisplayUI:OnButtonTrueClick()
	if not self.isDirty then
		return
	end

	local saveList = {}
	local index = 1

	for i = 1, LuaUtility.GetChildCount(self.ItemRaycastContainer.transform) do
		local ItemTrans = LuaUtility.GetChild(self.ItemRaycastContainer.transform, i - 1)

		if ItemTrans.gameObject:CompareTag("ItemEditorImagePrefab") then
			local ItemRect = ItemTrans:GetComponent("RectTransform")
			local AchieveShowPOD = {}

			AchieveShowPOD.cid = self.editItemList[index].Data.Id
			AchieveShowPOD.layerId = i - 1
			AchieveShowPOD.x = ItemRect.anchoredPosition.x
			AchieveShowPOD.y = ItemRect.anchoredPosition.y
			AchieveShowPOD.z = 0

			table.insert(saveList, AchieveShowPOD)

			index = index + 1
		end
	end

	AchievementModule.SaveAchievementDisplay(saveList)
	self:SetNonEditItem()
end

function AchievementDisplayUI:OnButtonCancelClick()
	if #self.editItemList <= 0 then
		NoticeModule.ShowNotice(70001)

		return
	end

	for i = #self.editItemList, 1, -1 do
		self.editItemList[i]:DestroySelf()
	end

	self.editItemList = {}

	self:SetNonEditItem()
	self:RefreshBaseInfo()
	self:SetDirty(true)
end

function AchievementDisplayUI:OnDropDownHasClick(selectIndex)
	self.currentHasType = selectIndex

	self:AchievementItemScrollRefresh()
end

function AchievementDisplayUI:OnDropDownIconClick(selectIndex)
	self.currentIconType = selectIndex

	self:AchievementItemScrollRefresh()
end

function AchievementDisplayUI:OnItemRaycastContainerClick()
	self:SetNonEditItem()
end

function AchievementDisplayUI:Refresh()
	self:RecoverDisplay()
	self:AchievementItemScrollRefresh()
	self:RefreshBaseInfo()
	self:SetDirty(false)
	self:CheckChangeState()
end

function AchievementDisplayUI:RefreshBaseInfo()
	LuaUtility.SetText(self.textCollections, string.format("%d/%d", #AchievementModule.GetAchievementBagHasItems(), #AchievementModule.GetAchievementBagAllItems()))
	LuaUtility.SetText(self.textHasPlaced, string.format("%d/%d", #self.editItemList, CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.AchievementDisplayMaxCount)))

	if not self.currentEditItem then
		LuaUtility.SetGameObjectShow(self.settingButtonsRoot, false)
		LuaUtility.SetGameObjectShow(self.smallShadow.gameObject, false)
		LuaUtility.SetGameObjectShow(self.middleShadow.gameObject, false)
		LuaUtility.SetGameObjectShow(self.bigShadow.gameObject, false)
	end
end

function AchievementDisplayUI:RecoverDisplay()
	local displayList = AchievementModule.GetAchievementDisplayList()

	for i = 1, #displayList do
		if i > #self.editItemList then
			local ItemEditorObject = GameObject.Instantiate(self.ItemEditorImagePrefab, self.ItemRaycastContainer.transform)
			local editItem = AchievementDisplayEditItemClass.New(ItemEditorObject, self)

			table.insert(self.editItemList, editItem)
		end

		self.editItemList[i]:Refresh(CfgUtil.GetItemCfgDataWithID(displayList[i].cid))
		self.editItemList[i]:SetAnchorPosition(displayList[i].x, displayList[i].y)
		self.editItemList[i]:SetSibling(displayList[i].layerId)
	end
end

function AchievementDisplayUI:OnAchievementItemScrollRenderGridCell(gridCell)
	local index = gridCell.index + 1
	local insID = gridCell.gameObject:GetInstanceID()
	local cfg = self.ItemDataList
	local data = cfg[index]

	if self.AchievementItemScrollViewCell[insID] == nil then
		local achievementDisplayItem = AchievementDisplayItemClass.New(gridCell.gameObject, self)

		self.AchievementItemScrollViewCell[insID] = achievementDisplayItem
	end

	self.AchievementItemScrollViewCell[insID]:Refresh(data)

	gridCell.transform.parent.gameObject.name = index
end

function AchievementDisplayUI:AchievementItemScrollRefresh()
	self.ItemDataList = AchievementModule.GetSortAchievementAllBagItemsList(self.currentHasType, self.currentIconType)

	local achievementItemScroll = self.AchievementItemScroll:GetComponent("ScrollAreaList")

	achievementItemScroll:Refresh(#self.ItemDataList)
end

function AchievementDisplayUI:SetCurrentEditItem(editItem)
	if self.currentEditItem and self.currentEditItem.Data.Id == editItem.Data.Id then
		return
	end

	if self.currentEditItem then
		self.currentEditItem:SetNonEdit()
	end

	for i = 1, #self.editItemList do
		self.editItemList[i]:UnAbleInteractive()
	end

	local viewCell = self:GetAchievementBagViewCellByItemId(editItem.Data.Id)

	viewCell:SetChose()

	self.currentEditItem = editItem

	self.currentEditItem:SetSelect()
	self.currentEditItem:EnableInteractive()
	LuaUtility.SetGameObjectShow(self.settingButtonsRoot, true)
end

function AchievementDisplayUI:SetNonEditItem()
	if self.currentEditItem then
		self.currentEditItem:SetNonEdit()

		local viewCell = self:GetAchievementBagViewCellByItemId(self.currentEditItem.Data.Id)

		viewCell:SetNonChose()
	end

	self:EnableAllEditRayCast()

	self.currentEditItem = nil

	LuaUtility.SetGameObjectShow(self.settingButtonsRoot, false)
	self:HideCurrentShadow()
end

function AchievementDisplayUI:EnableAllEditRayCast()
	for i = 1, #self.editItemList do
		self.editItemList[i]:EnableInteractive()
	end
end

function AchievementDisplayUI:ShowShadow(followItem, eventData)
	local width = self.ItemRaycastContainerRect.sizeDelta.x
	local height = self.ItemRaycastContainerRect.sizeDelta.y
	local itemPosX = followItem.rectTransform.localPosition.x
	local itemPosY = followItem.rectTransform.localPosition.y

	if itemPosX < 0 or width < itemPosX or itemPosY > 0 or itemPosY < -height then
		self:HideCurrentShadow()

		return
	end

	local iconSubType = followItem.Data.ItemSubTypes
	local preparePos = self:GetCloselyPos(iconSubType, eventData)

	if iconSubType == Constant.ItemSubType[Constant.ItemType.AchievementItem].SmallIcon then
		self.smallShadow.anchoredPosition = preparePos

		LuaUtility.SetGameObjectShow(self.smallShadow.gameObject, true)

		self.currentShowShadow = self.smallShadow
	elseif iconSubType == Constant.ItemSubType[Constant.ItemType.AchievementItem].MiddleIcon then
		self.middleShadow.anchoredPosition = preparePos

		LuaUtility.SetGameObjectShow(self.middleShadow.gameObject, true)

		self.currentShowShadow = self.middleShadow
	elseif iconSubType == Constant.ItemSubType[Constant.ItemType.AchievementItem].BigIcon then
		self.bigShadow.anchoredPosition = preparePos

		LuaUtility.SetGameObjectShow(self.bigShadow.gameObject, true)

		self.currentShowShadow = self.bigShadow
	end
end

function AchievementDisplayUI:ShowShadowWithEditItem(editItem)
	local iconSubType = editItem.Data.ItemSubTypes
	local posList

	if iconSubType == Constant.ItemSubType[Constant.ItemType.AchievementItem].SmallIcon then
		posList = self.smallShadowPosList
		self.currentShowShadow = self.smallShadow

		LuaUtility.SetGameObjectShow(self.smallShadow.gameObject, true)
	elseif iconSubType == Constant.ItemSubType[Constant.ItemType.AchievementItem].MiddleIcon then
		posList = self.middleShadowPosList
		self.currentShowShadow = self.middleShadow

		LuaUtility.SetGameObjectShow(self.middleShadow.gameObject, true)
	elseif iconSubType == Constant.ItemSubType[Constant.ItemType.AchievementItem].BigIcon then
		posList = self.bigShadowPosList
		self.currentShowShadow = self.bigShadow

		LuaUtility.SetGameObjectShow(self.bigShadow.gameObject, true)
	end

	local minDistance = 99999
	local minIndex = 0
	local centerPos = editItem.rectTransform.anchoredPosition

	for i = 1, #posList do
		local dis = Vector2.Distance(centerPos, posList[i])

		if dis < minDistance then
			minDistance = dis
			minIndex = i
		end
	end

	self.currentShowShadow.anchoredPosition = posList[minIndex]
end

function AchievementDisplayUI:GetCloselyPos(itemSubTYpe, eventData)
	local posList

	if itemSubTYpe == Constant.ItemSubType[Constant.ItemType.AchievementItem].SmallIcon then
		posList = self.smallShadowPosList
	elseif itemSubTYpe == Constant.ItemSubType[Constant.ItemType.AchievementItem].MiddleIcon then
		posList = self.middleShadowPosList
	elseif itemSubTYpe == Constant.ItemSubType[Constant.ItemType.AchievementItem].BigIcon then
		posList = self.bigShadowPosList
	end

	local minIndex = 0
	local minDistance = 999999

	for i = 1, #posList do
		local mousePos = LuaUtility.ScreenPointToLocalPointInRectangle(self.ItemRaycastContainerRect, eventData.position, GameEntry.UICamera)
		local dis = Vector2.Distance(mousePos, posList[i])

		if dis < minDistance then
			minDistance = dis
			minIndex = i
		end
	end

	return posList[minIndex]
end

function AchievementDisplayUI:HideCurrentShadow()
	if self.currentShowShadow then
		LuaUtility.SetGameObjectShow(self.currentShowShadow.gameObject, false)
	end
end

function AchievementDisplayUI:GetAchievementBagViewCellByItemId(id)
	for i, v in pairs(self.AchievementItemScrollViewCell) do
		if v.Data.Id == id then
			return v
		end
	end
end

function AchievementDisplayUI:RemoveEditItem(editItem)
	local removeIndex

	for i = 1, #self.editItemList do
		if self.editItemList[i].Data.Id == editItem.Data.Id then
			removeIndex = i

			break
		end
	end

	if removeIndex then
		self:RemoveEditItemByList(removeIndex)
	end

	for _, v in pairs(self.AchievementItemScrollViewCell) do
		if v.Data.Id == editItem.Data.Id then
			v:SetNonUse()

			break
		end
	end
end

function AchievementDisplayUI:CheckIsDisplay(ID)
	for i = 1, #self.editItemList do
		if self.editItemList[i].Data.Id == ID then
			return true
		end
	end

	return false
end

function AchievementDisplayUI:SortByEditItem(list)
	table.sort(list, function(a, b)
		if self:CheckIsDisplay(a.Id) and self:CheckIsDisplay(b.Id) then
			return a.Id < b.Id
		elseif not self:CheckIsDisplay(a.Id) and not self:CheckIsDisplay(b.Id) then
			return a.Id < b.Id
		else
			return self:CheckIsDisplay(a.Id) and true or false
		end
	end)
end

function AchievementDisplayUI:CheckChangeState()
	if self.isDirty then
		LuaUtility.SetGameObjectShow(self.buttonTrueSet.normalState, false)
		LuaUtility.SetGameObjectShow(self.buttonTrueSet.checkState, true)
	else
		LuaUtility.SetGameObjectShow(self.buttonTrueSet.normalState, true)
		LuaUtility.SetGameObjectShow(self.buttonTrueSet.checkState, false)
	end
end

function AchievementDisplayUI:SetDirty(value)
	self.isDirty = value

	self:CheckChangeState()
end

function AchievementDisplayUI:AddEditItemByList(item)
	if #self.editItemList >= CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.AchievementDisplayMaxCount) then
		return
	end

	table.insert(self.editItemList, item)
	self:SetDirty(true)
end

function AchievementDisplayUI:RemoveEditItemByList(index)
	table.remove(self.editItemList, index)
	self:SetDirty(true)
end

function AchievementDisplayUI:saveSucceed()
	self:Refresh()
end

return AchievementDisplayUI
