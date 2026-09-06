-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/view/feiniyaclothes/FeiNiYaClothesPopWinView.lua

module("logic.extensions.spineinterface.view.feiniyaclothes.FeiNiYaClothesPopWinView", package.seeall)

local FeiNiYaClothesPopWinView = class("FeiNiYaClothesPopWinView", ViewComponent)
local CLOTHES_CONFIG = {
	tabs = {
		{
			publicParamId = 3,
			tabSpriteName = "board_yhsy_02",
			partKey = "hair",
			items = {
				{
					spriteName = "board_yhsy_fx_03",
					publicParamValue = 0,
					eventName = MsEnum.Interaction_FeiNiYaClothes_Hair_0
				},
				{
					spriteName = "board_yhsy_fx_02",
					publicParamValue = 2,
					eventName = MsEnum.Interaction_FeiNiYaClothes_Hair_1
				},
				{
					spriteName = "board_yhsy_fx_01",
					publicParamValue = 1,
					eventName = MsEnum.Interaction_FeiNiYaClothes_Hair_2
				}
			}
		},
		{
			publicParamId = 1,
			tabSpriteName = "board_yhsy_03",
			partKey = "clothes",
			items = {
				{
					spriteName = "board_yhsy_qz_02",
					publicParamValue = 0,
					eventName = MsEnum.Interaction_FeiNiYaClothes_Clothes_0
				},
				{
					spriteName = "board_yhsy_qz_01",
					publicParamValue = 1,
					eventName = MsEnum.Interaction_FeiNiYaClothes_Clothes_1
				}
			}
		},
		{
			publicParamId = 2,
			tabSpriteName = "board_yhsy_04",
			partKey = "shoes",
			items = {
				{
					spriteName = "board_yhsy_xz_02",
					publicParamValue = 3,
					eventName = MsEnum.Interaction_FeiNiYaClothes_Shoes_0
				},
				{
					spriteName = "board_yhsy_xz_01",
					publicParamValue = 1,
					eventName = MsEnum.Interaction_FeiNiYaClothes_Shoes_1
				},
				{
					spriteName = "board_yhsy_xz_03",
					publicParamValue = 2,
					eventName = MsEnum.Interaction_FeiNiYaClothes_Shoes_2
				},
				{
					spriteName = "board_yhsy_xz_04",
					publicParamValue = 0,
					eventName = MsEnum.Interaction_FeiNiYaClothes_Shoes_3
				}
			}
		},
		{
			publicParamId = 4,
			tabSpriteName = "board_yhsy_05",
			partKey = "headwear",
			items = {
				{
					spriteName = "board_yhsy_ts_01",
					publicParamValue = 1,
					eventName = MsEnum.Interaction_FeiNiYaClothes_Headwear_0
				},
				{
					spriteName = "board_yhsy_ts_03",
					publicParamValue = 2,
					eventName = MsEnum.Interaction_FeiNiYaClothes_Headwear_1
				},
				{
					spriteName = "board_yhsy_ts_02",
					publicParamValue = 0,
					eventName = MsEnum.Interaction_FeiNiYaClothes_Headwear_2
				},
				{
					spriteName = "board_yhsy_ts_04",
					toggleOnValue = 1,
					toggleParamId = 5,
					eventName = MsEnum.Interaction_FeiNiYaClothes_Headwear_3,
					offEventName = MsEnum.Interaction_FeiNiYaClothes_Headwear_3_Off
				}
			}
		}
	}
}

function FeiNiYaClothesPopWinView:buildUI()
	FeiNiYaClothesPopWinView.super.buildUI(self)

	self._windowRootGo = self:getGo("windowRoot")
	self._windowRootRect = self._windowRootGo:GetComponent(goutil.Type_RectTransform)
	self._viewRootRect = self.mainGO:GetComponent(goutil.Type_RectTransform)
	self._tabScrollerGo = self:getGo("windowRoot/tabCol/scrView")
	self._tabCellTemplate = self:getGo("windowRoot/tabCol/scrCell")

	GameUtil.SetActive(self._tabCellTemplate, false)

	self._bgGo = self:getGo("windowRoot/bg")
	self._customInput = UICustomInput.Get(self._windowRootGo)
	self._clothesCells = {}
	self._selectedIndexByPartKey = {}
	self._toggleSelectedByKey = {}
	self._tabScrollerList = ScrollerList.create(self._tabScrollerGo, self._tabCellTemplate, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	local clothesViewGo = self:getGo("windowRoot/clothesView")
	local clothesCellGos = GameUtil.getChildren(clothesViewGo)

	for _, mainGo in ipairs(clothesCellGos) do
		local bgGo = goutil.findChild(mainGo, "bg")
		local bgImage = bgGo and bgGo:GetComponent(ComponentType.Image)

		if bgImage then
			bgImage.raycastTarget = true
		end

		local cell = {
			go = mainGo,
			clickGo = bgGo or mainGo,
			iconChange = GameUtil.getUIImageSpriteChange(goutil.findChild(mainGo, "icon")),
			tagSelected = goutil.findChild(mainGo, "tagSelected")
		}

		table.insert(self._clothesCells, cell)
	end
end

function FeiNiYaClothesPopWinView:bindEvents()
	FeiNiYaClothesPopWinView.super.bindEvents(self)

	for idx, cell in ipairs(self._clothesCells) do
		GameUtil.addClickHandler(cell.clickGo, GameUtil.handler(self._onClickClothes, self, idx))
	end

	self._customInput:AddListener(self._onCustomInputCallback, self)

	self._beginDragHandler = BeginDragHandler.Get(self._windowRootGo):AddLuaHandler(function(_go, eventData)
		self:_onBeginDragWindow(eventData)
	end)
	self._dragHandler = DragHandler.Get(self._windowRootGo):AddLuaHandler(function(_go, eventData)
		self:_onDragWindow(eventData)
	end)
	self._endDragHandler = EndDragHandler.Get(self._windowRootGo):AddLuaHandler(function(_go, eventData)
		self:_onEndDragWindow(eventData)
	end)
end

function FeiNiYaClothesPopWinView:unbindEvents()
	FeiNiYaClothesPopWinView.super.unbindEvents(self)
	self._customInput:RemoveListener()

	if self._beginDragHandler then
		BeginDragHandler.Get(self._windowRootGo):RemoveLuaHandler(self._beginDragHandler)

		self._beginDragHandler = nil
	end

	if self._dragHandler then
		DragHandler.Get(self._windowRootGo):RemoveLuaHandler(self._dragHandler)

		self._dragHandler = nil
	end

	if self._endDragHandler then
		EndDragHandler.Get(self._windowRootGo):RemoveLuaHandler(self._endDragHandler)

		self._endDragHandler = nil
	end

	for _, cell in ipairs(self._clothesCells) do
		GameUtil.rmClickHandler(cell.clickGo)
	end
end

function FeiNiYaClothesPopWinView:onEnter()
	FeiNiYaClothesPopWinView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._spineInterfaceComp = params[1]
	self._curTabIndex = self:_getTabIndexByPartKey(params[2]) or 1

	table.clear(self._selectedIndexByPartKey)
	table.clear(self._toggleSelectedByKey)

	for _, tabData in ipairs(CLOTHES_CONFIG.tabs) do
		self._selectedIndexByPartKey[tabData.partKey] = self:_getSelectedIndexByTabData(tabData)

		for idx, itemData in ipairs(tabData.items) do
			if itemData.toggleParamId then
				self._toggleSelectedByKey[self:_getToggleKey(tabData, itemData, idx)] = self:_getToggleSelectedByItemData(itemData)
			end
		end
	end

	self._tabScrollerList:reloadData(CLOTHES_CONFIG.tabs)
	self:_refreshClothesView()
end

function FeiNiYaClothesPopWinView:onExit()
	FeiNiYaClothesPopWinView.super.onExit(self)
	self._tabScrollerList:dispose()

	self._spineInterfaceComp = nil
	self._isDraggingWindow = false
	self._dragOffsetX = nil
	self._dragOffsetY = nil
end

function FeiNiYaClothesPopWinView:destroyUI()
	FeiNiYaClothesPopWinView.super.destroyUI(self)

	self._tabScrollerList = nil
	self._tabScrollerGo = nil
	self._tabCellTemplate = nil
	self._clothesCells = nil
	self._selectedIndexByPartKey = nil
	self._toggleSelectedByKey = nil
	self._bgGo = nil
	self._customInput = nil
	self._windowRootGo = nil
	self._windowRootRect = nil
	self._viewRootRect = nil
end

function FeiNiYaClothesPopWinView:_updateTabCell(view, cell, tabData)
	local go = cell.gameObject
	local tabIndex = cell.index + 1
	local iconChange = GameUtil.getUIImageSpriteChange(goutil.findChild(go, "icon"))

	if iconChange then
		iconChange:ChangeSprite(tabData.tabSpriteName)
	end

	GameUtil.SetActive(go, true)
	GameUtil.SetActive(goutil.findChild(go, "tagSelected"), tabIndex == self._curTabIndex)
	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, GameUtil.handler(self._onClickTab, self, tabIndex))
end

function FeiNiYaClothesPopWinView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function FeiNiYaClothesPopWinView:_getCurTabData()
	return CLOTHES_CONFIG.tabs[self._curTabIndex]
end

function FeiNiYaClothesPopWinView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function FeiNiYaClothesPopWinView:_onBeginDragWindow(eventData)
	if self._windowRootGo == nil or self._viewRootRect == nil then
		return
	end

	local localPos = goutil.screenToLocalPos(eventData.position, self._viewRootRect)
	local anchoredPos = GameUtil.getAnchoredPos(self._windowRootGo)

	self._dragOffsetX = anchoredPos.x - localPos.x
	self._dragOffsetY = anchoredPos.y - localPos.y
	self._isDraggingWindow = true
end

function FeiNiYaClothesPopWinView:_onDragWindow(eventData)
	if not self._isDraggingWindow or self._dragOffsetX == nil or self._dragOffsetY == nil then
		return
	end

	local localPos = goutil.screenToLocalPos(eventData.position, self._viewRootRect)
	local posX, posY = self:_getClampedWindowPos(localPos.x + self._dragOffsetX, localPos.y + self._dragOffsetY)

	GameUtil.setAnchoredPos(self._windowRootGo, posX, posY)
end

function FeiNiYaClothesPopWinView:_onEndDragWindow(eventData)
	self._isDraggingWindow = false
	self._dragOffsetX = nil
	self._dragOffsetY = nil
end

function FeiNiYaClothesPopWinView:_getClampedWindowPos(posX, posY)
	local parentWidth = goutil.getWidth(self._viewRootRect)
	local parentHeight = goutil.getHeight(self._viewRootRect)
	local windowWidth = goutil.getWidth(self._windowRootRect)
	local windowHeight = goutil.getHeight(self._windowRootRect)

	if windowWidth == nil or windowWidth <= 0 then
		windowWidth = GameUtil.getWidth(self._bgGo) or 0
	end

	if windowHeight == nil or windowHeight <= 0 then
		windowHeight = GameUtil.getHeight(self._bgGo) or 0
	end

	local minX = -parentWidth / 2 + windowWidth / 2
	local maxX = parentWidth / 2 - windowWidth / 2
	local minY = -parentHeight / 2 + windowHeight / 2
	local maxY = parentHeight / 2 - windowHeight / 2

	if maxX < minX then
		maxX = minX
		minX = maxX
	end

	if maxY < minY then
		maxY = minY
		minY = maxY
	end

	return math.max(minX, math.min(maxX, posX)), math.max(minY, math.min(maxY, posY))
end

function FeiNiYaClothesPopWinView:_getTabIndexByPartKey(partKey)
	if string.nilorempty(partKey) then
		return nil
	end

	for idx, tabData in ipairs(CLOTHES_CONFIG.tabs) do
		if tabData.partKey == partKey then
			return idx
		end
	end

	return nil
end

function FeiNiYaClothesPopWinView:_getSelectedIndexByTabData(tabData)
	if self._spineInterfaceComp == nil or tabData.publicParamId == nil then
		return 1
	end

	if self._spineInterfaceComp.getParamMoList then
		local publicParamMoList = self._spineInterfaceComp:getParamMoList(MsEnum.ParamMgrType.Public)

		if publicParamMoList == nil or publicParamMoList[tabData.publicParamId] == nil then
			return 1
		end

		local publicParamValue = self._spineInterfaceComp:getParamValue(MsEnum.ParamMgrType.Public, tabData.publicParamId)

		for idx, itemData in ipairs(tabData.items) do
			if itemData.publicParamValue ~= nil and checknumber(itemData.publicParamValue) == checknumber(publicParamValue) then
				return idx
			end
		end

		return 1
	end
end

function FeiNiYaClothesPopWinView:_getToggleKey(tabData, itemData, itemIndex)
	return string.format("%s_%s_%s", tabData.partKey, itemIndex, itemData.spriteName or "")
end

function FeiNiYaClothesPopWinView:_getToggleSelectedByItemData(itemData)
	if self._spineInterfaceComp == nil or itemData.toggleParamId == nil then
		return false
	end

	if self._spineInterfaceComp.getParamMoList then
		local publicParamMoList = self._spineInterfaceComp:getParamMoList(MsEnum.ParamMgrType.Public)

		if publicParamMoList == nil or publicParamMoList[itemData.toggleParamId] == nil then
			return false
		end

		local publicParamValue = self._spineInterfaceComp:getParamValue(MsEnum.ParamMgrType.Public, itemData.toggleParamId)

		return checknumber(publicParamValue) == checknumber(itemData.toggleOnValue)
	end
end

function FeiNiYaClothesPopWinView:_isItemSelected(tabData, itemData, itemIndex, selectedIndex)
	if itemData.toggleParamId then
		return self._toggleSelectedByKey[self:_getToggleKey(tabData, itemData, itemIndex)] == true
	end

	return itemIndex == selectedIndex
end

function FeiNiYaClothesPopWinView:_refreshClothesView()
	local tabData = self:_getCurTabData()

	if not self._selectedIndexByPartKey[tabData.partKey] then
		local selectedIndex = 1

		for idx, cell in ipairs(self._clothesCells) do
			local itemData = tabData.items[idx]

			GameUtil.SetActive(cell.go, itemData ~= nil)

			if itemData then
				if cell.iconChange then
					cell.iconChange:ChangeSprite(itemData.spriteName)
				end

				GameUtil.SetActive(cell.tagSelected, self:_isItemSelected(tabData, itemData, idx, selectedIndex))
			end
		end
	end
end

function FeiNiYaClothesPopWinView:_onClickTab(tabIndex)
	if self._curTabIndex == tabIndex then
		return
	end

	self._curTabIndex = tabIndex

	self._tabScrollerList:refresh()
	self:_refreshClothesView()
end

function FeiNiYaClothesPopWinView:_onClickClothes(clothesIndex)
	local tabData = self:_getCurTabData()
	local itemData = tabData and tabData.items[clothesIndex]

	if itemData == nil then
		return
	end

	local eventName = itemData.eventName

	if itemData.toggleParamId then
		local toggleKey = self:_getToggleKey(tabData, itemData, clothesIndex)
		local isSelected = self._toggleSelectedByKey[toggleKey] == true

		self._toggleSelectedByKey[toggleKey] = not isSelected
		eventName = isSelected and itemData.offEventName or itemData.eventName
	else
		self._selectedIndexByPartKey[tabData.partKey] = clothesIndex
	end

	self:_refreshClothesView()

	if self._spineInterfaceComp and not string.nilorempty(eventName) then
		self._spineInterfaceComp:notifyInteraction(eventName)
	end
end

return FeiNiYaClothesPopWinView
