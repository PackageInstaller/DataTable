-- chunkname: @IQIGame\\UI\\HomeLandProcess\\HomeLandProcessRender.lua

local HomeLandProcessRender = {}
local HomeLandProcessNeedItemCell = require("IQIGame.UI.HomeLandProcess.HomeLandProcessNeedItemCell")

function HomeLandProcessRender.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.SUB_UI_MAP_ProcessRenerElement == nil then
		ui.SUB_UI_MAP_ProcessRenerElement = {}
	end

	local subUIMap = ui.SUB_UI_MAP_ProcessRenerElement
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = HomeLandProcessRender.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function HomeLandProcessRender.__New(itemCellView)
	local itemCell = Clone(HomeLandProcessRender)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandProcessRender:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)

	function self.delegateOnUpdateItem()
		self:OnUpdateItem()
	end

	self.needItemCells = {}

	for i = 1, 3 do
		local needItem = HomeLandProcessNeedItemCell.New(self["Item" .. i])

		self.needItemCells[i] = needItem
	end

	self.targetItemCell = ItemCell.New(self.TargetItem, false)

	self:AddListener()
end

function HomeLandProcessRender:AddListener()
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.delegateOnUpdateItem)
end

function HomeLandProcessRender:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.delegateOnUpdateItem)
end

function HomeLandProcessRender.DisposeIn(ui)
	if ui.SUB_UI_MAP_ProcessRenerElement == nil then
		return
	end

	for i, itemCell in pairs(ui.SUB_UI_MAP_ProcessRenerElement) do
		itemCell:Dispose()
	end

	ui.SUB_UI_MAP_ProcessRenerElement = nil
end

function HomeLandProcessRender:SetData(type, data)
	self.type = type
	self.processData = data

	self:Update()
end

function HomeLandProcessRender:Update()
	self.TextNum:SetActive(self.type == 2)
	self.ImgType1:SetActive(self.type == 1)
	self.ImgType2:SetActive(self.type == 2)

	if self.processData then
		UGUIUtil.SetText(self.TextLock, HomeLandMakeItemListUIApi:GetString("TextLock", self.processData.cfgInfo.UnlockLevel))
		self.Normal:SetActive(true)
		self.Lock:SetActive(not self.processData.unlock)

		local targetItem = CfgItemTable[self.processData.cfgInfo.ItemID]

		UGUIUtil.SetText(self.ItemName, targetItem.Name)
		self.targetItemCell:SetItemByCID(self.processData.cfgInfo.ItemID)

		local targetHave = WarehouseModule.GetItemNumByCfgID(self.processData.cfgInfo.ItemID)

		UGUIUtil.SetText(self.TextNum, HomeLandMakeItemListUIApi:GetString("TextSpend", targetHave, 1))

		for i, v in pairs(self.needItemCells) do
			v:SetItemByCID(0)
		end

		local index = 1

		for i = 1, #self.processData.cfgInfo.Props, 2 do
			local id = self.processData.cfgInfo.Props[i]
			local needNum = self.processData.cfgInfo.Props[i + 1]
			local haveNum = WarehouseModule.GetItemNumByCfgID(id)
			local needItemCell = self.needItemCells[index]

			if needItemCell then
				needItemCell:SetItemByCID(id)
				needItemCell:SetCustomNum(self.type, haveNum, needNum)
			end

			index = index + 1
		end
	end
end

function HomeLandProcessRender:OnUpdateItem()
	self:Update()
end

function HomeLandProcessRender:Clear()
	self.goView:SetActive(false)
end

function HomeLandProcessRender:Dispose()
	self:RemoveListener()
	self.targetItemCell:Dispose()

	for i, v in pairs(self.needItemCells) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.Destroy(self.goView)

	self.goView = nil
end

return HomeLandProcessRender
