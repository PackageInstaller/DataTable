-- chunkname: @IQIGame\\UI\\VirtualPhoto\\VirtualPhotoElementLayerPanel.lua

local VirtualPhotoElementLayerItem = require("IQIGame.UI.VirtualPhoto.VirtualPhotoElementLayerItem")
local m = {
	DragViewHeight = 0,
	ElementItems = {},
	DelegateOnBeginDrags = {},
	DelegateOnDrags = {},
	DelegateOnEndDrags = {}
}

function m.New(view, rootCanvas)
	local obj = Clone(m)

	obj:Init(view, rootCanvas)

	return obj
end

function m:Init(view, rootCanvas)
	self.View = view
	self.RootCanvas = rootCanvas

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	for i = 1, 5 do
		local item = VirtualPhotoElementLayerItem.New(UnityEngine.Object.Instantiate(self.ElementItemPrefab), i, function(index)
			self:OnToggleOn(index)
		end, function(index)
			self:OnDelete(index)
		end)

		item.View.transform:SetParent(self.ElementItemGrid.transform, false)

		self.ElementItems[i] = item
		self.DelegateOnBeginDrags[i] = function(baseEventData)
			self:OnBeginDrag(baseEventData, i)
		end
		self.DelegateOnDrags[i] = function(baseEventData)
			self:OnDrag(baseEventData, i)
		end
		self.DelegateOnEndDrags[i] = function(baseEventData)
			self:OnEndDrag(baseEventData, i)
		end
	end

	self.DragViewHeight = self.DragView.transform.rect.h
	self.DragMousePosition = self.DragView.transform.position

	self:AddListeners()
end

function m:AddListeners()
	for i = 1, #self.ElementItems do
		local item = self.ElementItems[i]

		LuaCodeInterface.AddEventTriggerHandler(item.View, UnityEngine.EventSystems.EventTriggerType.BeginDrag, self.DelegateOnBeginDrags[i])
		LuaCodeInterface.AddEventTriggerHandler(item.View, UnityEngine.EventSystems.EventTriggerType.Drag, self.DelegateOnDrags[i])
		LuaCodeInterface.AddEventTriggerHandler(item.View, UnityEngine.EventSystems.EventTriggerType.EndDrag, self.DelegateOnEndDrags[i])
	end

	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function m:RemoveListeners()
	for i = 1, #self.ElementItems do
		local item = self.ElementItems[i]

		LuaCodeInterface.RemoveEventTriggerHandler(item.View, UnityEngine.EventSystems.EventTriggerType.BeginDrag, self.DelegateOnBeginDrags[i])
		LuaCodeInterface.RemoveEventTriggerHandler(item.View, UnityEngine.EventSystems.EventTriggerType.Drag, self.DelegateOnDrags[i])
		LuaCodeInterface.RemoveEventTriggerHandler(item.View, UnityEngine.EventSystems.EventTriggerType.EndDrag, self.DelegateOnEndDrags[i])
	end

	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function m:Show(elementControllers, onSelect, onDelete, onLayerChange)
	self.ElementControllers = elementControllers
	self.OnSelectCallback = onSelect
	self.OnDeleteCallback = onDelete
	self.OnLayerChangeCallback = onLayerChange

	self:RefreshAllItems()
	self.View:SetActive(true)
	self.DragView:SetActive(false)
end

function m:RefreshAllItems()
	for i = 1, #self.ElementItems do
		local item = self.ElementItems[i]

		item:SetData(self.ElementControllers[i])
	end
end

function m:Hide()
	self.ElementControllers = nil

	self.View:SetActive(false)
end

function m:OnToggleOn(index)
	self.OnSelectCallback(self.ElementControllers[index].Id)
end

function m:OnDelete(index)
	self.OnDeleteCallback(self.ElementControllers[index].Id)
	self:RefreshAllItems()
end

function m:OnBeginDrag(baseEventData, index)
	self.DragView:SetActive(true)

	local elementController = self.ElementControllers[index]
	local toggleHelper = self.DragView:GetComponentInChildren(typeof(IQIGame.Onigao.Game.ToggleHelperComponent))
	local texts = {}

	texts[1] = tostring(index)
	texts[2] = VirtualPhotoEditUIApi:GetString("ElementLayer_TypeName", elementController.CfgVirtualPhotoElementData.Type)
	texts[3] = elementController.CfgVirtualPhotoElementData.Name

	toggleHelper:SetTexts(texts)

	local toggle = self.DragView:GetComponentInChildren(typeof(UnityEngine.UI.Toggle))

	toggle.isOn = elementController.IsSelected
	self.DragView.transform.position = self:GetMousePos()

	local item = self.ElementItems[index]

	item:SetDragging(true)
end

function m:OnDrag(baseEventData, index)
	self.DragView.transform.position = self:GetMousePos()

	local currentIndex = -1

	for i = #self.ElementItems, 1, -1 do
		local item = self.ElementItems[i]

		if not item.IsDragging and item.HasData and self.DragView.transform.anchoredPosition.y < item.View.transform.anchoredPosition.y - self.DragViewHeight / 2 and currentIndex == -1 then
			currentIndex = i
		end

		item:HideLine()
	end

	local showLineItem

	if currentIndex == -1 then
		for i = 1, #self.ElementItems do
			local item = self.ElementItems[i]

			if not item.IsDragging and item.HasData then
				showLineItem = item

				showLineItem:ShowLine(true)

				break
			end
		end
	else
		showLineItem = self.ElementItems[currentIndex]

		showLineItem:ShowLine(false)
	end

	self.DragNewIndex = 0

	if showLineItem ~= nil then
		for i = 1, #self.ElementItems do
			local item = self.ElementItems[i]

			if not item.IsDragging then
				self.DragNewIndex = self.DragNewIndex + 1

				if item == showLineItem then
					if not item.TopInsertNoticeLine.activeSelf then
						self.DragNewIndex = self.DragNewIndex + 1
					end

					break
				end
			end
		end
	end
end

function m:OnEndDrag(baseEventData, index)
	if self.DragNewIndex > 0 then
		local controller = self.ElementControllers[index]

		table.remove(self.ElementControllers, index)
		table.insert(self.ElementControllers, self.DragNewIndex, controller)
	end

	self.DragView:SetActive(false)
	self:RefreshAllItems()
	self.OnLayerChangeCallback()

	self.DragNewIndex = nil
end

function m:GetMousePos()
	local toPoint = self.RootCanvas.worldCamera:ScreenToWorldPoint(UnityEngine.Input.mousePosition)

	self.DragMousePosition.x = toPoint.x
	self.DragMousePosition.y = toPoint.y

	return self.DragMousePosition
end

function m:OnClickCloseBtn()
	self:Hide()
end

function m:Dispose()
	self:RemoveListeners()

	for i = 1, #self.ElementItems do
		local item = self.ElementItems[i]

		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.RootCanvas = nil
	self.OnSelectCallback = nil
	self.OnDeleteCallback = nil
	self.OnLayerChangeCallback = nil
end

return m
