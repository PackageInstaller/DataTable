-- chunkname: @IQIGame\\UI\\Maze\\UI\\SubUI\\GemOperationView.lua

local gemstoneItem = require("IQIGame.UI.Maze.UI.SubUI.GemstoneItem")
local gemstoneElementItem = require("IQIGame.UI.Maze.UI.SubUI.GemstoneElementItem")
local gemItemView = {
	Index = 0,
	gemAttrItemList = {},
	gemElementItemList = {}
}

function gemItemView.New(view)
	local obj = Clone(gemItemView)

	obj:Init(view)

	return obj
end

function gemItemView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.gemImgCom = self.gemImg:GetComponent("Image")
end

function gemItemView:SetData(index, data, selectIndex)
	self.Index = index
	self.gemItemData = data
	self.gemstoneID = self.gemItemData.cid

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.gemItemData.cid].Icon), self.gemImgCom, function()
		return
	end)
	LuaUtility.SetGameObjectShow(self.equiped, self.gemItemData.tag == 1)

	if self.Index == selectIndex then
		self:SetSelectState(true)
	else
		self:SetSelectState(false)
	end

	self:CreateAttrAndElementItem()
end

function gemItemView:CreateAttrAndElementItem()
	for k, v in pairs(self.gemElementItemList) do
		v:Hide()
	end

	local gemstoneCfg = CfgMazeGemstoneTable[self.gemstoneID]
	local index = 0

	index = 0

	for i = 1, #gemstoneCfg.Element do
		if gemstoneCfg.Element[i] ~= 0 then
			index = index + 1

			if self.gemElementItemList[index] == nil then
				local obj = GameObject.Instantiate(self.ElementItemPrefab)

				obj.transform:SetParent(self.ElementParent.transform, false)

				self.gemElementItemList[index] = gemstoneElementItem.New(obj)
			end

			self.gemElementItemList[index]:Show()
			self.gemElementItemList[index]:SetData(i, gemstoneCfg.Element[i])
		end
	end
end

function gemItemView:SetSelectState(state)
	LuaUtility.SetGameObjectShow(self.selectState, state)
end

function gemItemView:Dispose()
	for k, v in pairs(self.gemAttrItemList) do
		v:Dispose()
	end

	self.gemAttrItemList = nil

	for k, v in pairs(self.gemElementItemList) do
		v:Dispose()
	end

	self.gemElementItemList = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local gemstoneDetailsView = require("IQIGame.UI.Maze.UI.SubUI.GemstoneDetailsView")
local m = {
	SelectIndex = 0,
	ElementDataList = {},
	ElementItemList = {}
}

m.GemItemView = gemItemView

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickReplaceBtn()
		self:OnClickReplaceBtn()
	end

	function self.DelegateOnClickEquipBtn()
		self:OnClickEquipBtn()
	end

	function self.DelegateOnClickDischargeBtn()
		self:OnClickDischargeBtn()
	end

	function self.DelegateWearGemstoneSuccessEvent(SeatID)
		self:WearGemstoneSuccessEvent(SeatID)
	end

	function self.DelegateRemoveGemstoneSuccessEvent(SeatID)
		self:RemoveGemstoneSuccessEvent(SeatID)
	end

	self.wrapContent = self.gemScroll:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	function self.wrapContent.onSelectedCell(cell)
		self:OnSelectedCell(cell)
	end

	self.SetaElementBGCom = self.SetaElementBG:GetComponent("Image")
	self.elementImgCom = self.elementImg:GetComponent("Image")
	self.gemstoneDetailsPanel = gemstoneDetailsView.New(self.GemDetailsPanel)

	self:AddListeners()
end

function m:AddListeners()
	self.replaceBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReplaceBtn)
	self.equipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEquipBtn)
	self.dischargeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDischargeBtn)
	EventDispatcher.AddEventListener(EventID.InOrbmentDataChangeEvent, self.DelegateWearGemstoneSuccessEvent)
	EventDispatcher.AddEventListener(EventID.InOrbmentDataChangeEvent, self.DelegateRemoveGemstoneSuccessEvent)
end

function m:RemoveListeners()
	self.replaceBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReplaceBtn)
	self.equipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEquipBtn)
	self.dischargeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDischargeBtn)
	EventDispatcher.RemoveEventListener(EventID.InOrbmentDataChangeEvent, self.DelegateWearGemstoneSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.InOrbmentDataChangeEvent, self.DelegateRemoveGemstoneSuccessEvent)
end

function m:SetData(...)
	local args = {
		...
	}

	self.SeatId = args[1]

	if self.SeatId == nil or not MazeModule.InTheMaze then
		return
	end

	self.SelectGemstoneId = nil
	self.SelectIndex = 0
	self.SeatData = MazeModule.GetServerHoleData(self.SeatId)
	self.ElementDataList = MazeModule.GetGemInTempWarehouse()

	if #self.ElementDataList == 0 then
		self.SelectIndex = 0
		self.SelectGemstoneId = nil
	else
		for k, v in pairs(self.ElementDataList) do
			if v.id == self.SeatData.id then
				self.SelectIndex = k
				self.SelectGemstoneId = v.id
			end
		end
	end

	if self.SeatData.effectId ~= 0 then
		local seatCfg = CfgMazeSeatTable[self.SeatId]

		UGUIUtil.SetText(self.buffText, string.format(MazeApi:GetTypeTextColor(self.SeatData.effectId), MazeApi:GetTypeName(self.SeatData.effectId) .. MazeApi:GetElementPromptText() .. "×" .. seatCfg.Effect[self.SeatData.effectId]))
		AssetUtil.LoadImage(self, MazeApi:GetSeatElementBG(self.SeatData.effectId), self.SetaElementBGCom, function()
			self.SetaElementBGCom:SetNativeSize()
		end)
		AssetUtil.LoadImage(self, WarlockApi:GetElementIconPath(self.SeatData.effectId), self.elementImgCom)
		LuaUtility.SetGameObjectShow(self.buffTextParent, true)
	else
		LuaUtility.SetGameObjectShow(self.buffTextParent, false)
	end

	self.wrapContent.startIndex = self.SelectIndex

	self.wrapContent:Refresh(#self.ElementDataList)
	self:RefreshBottomInfoShow()
end

function m:RefreshBottomInfoShow()
	local isEquiped = MazeModule.GetSeatIsEquipedGem(self.SeatData)
	local isIdentical = self.SeatData.id == self.SelectGemstoneId

	LuaUtility.SetGameObjectShow(self.replaceBtn, isEquiped and not isIdentical)
	LuaUtility.SetGameObjectShow(self.dischargeBtn, isEquiped)
	LuaUtility.SetGameObjectShow(self.equipBtn, not isEquiped)
end

function m:OnRenderItem(cell)
	local itemData = self.ElementDataList[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.ElementItemList[instanceId]

	if itemCell == nil then
		itemCell = self.GemItemView.New(cell.gameObject)
		self.ElementItemList[instanceId] = itemCell
	end

	itemCell:SetData(cell.index + 1, itemData, self.SelectIndex)
end

function m:OnSelectedCell(cell)
	self:SetSelectItemsState()

	local itemData = self.ElementDataList[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.ElementItemList[instanceId]

	itemCell:SetSelectState(true)

	self.SelectIndex = itemCell.Index
	self.SelectGemstoneId = itemData.id

	self.gemstoneDetailsPanel:SetData(itemData)
	self.gemstoneDetailsPanel:Show()
	self:RefreshBottomInfoShow()
end

function m:SetSelectItemsState()
	for k, v in pairs(self.ElementItemList) do
		v:SetSelectState(false)
	end
end

function m:WearGemstoneSuccessEvent(SeatID)
	self:SetData(self.SeatId)
end

function m:RemoveGemstoneSuccessEvent(SeatID)
	self:SetData(self.SeatId)
end

function m:OnClickEquipBtn()
	if self.SelectGemstoneId == nil then
		NoticeModule.ShowNotice(80006)

		return
	end

	MazeModule.WearGemstone(self.SelectGemstoneId, self.SeatId)
end

function m:OnClickReplaceBtn()
	if self.SelectGemstoneId == nil then
		NoticeModule.ShowNotice(80007)

		return
	end

	MazeModule.WearGemstone(self.SelectGemstoneId, self.SeatId)
end

function m:OnClickDischargeBtn()
	if MazeModule.GetSeatIsEquipedGem(self.SeatData) then
		MazeModule.TakeOffGemstone(self.SeatId)
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
	self.gemstoneDetailsPanel:Hide()
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
	self.gemstoneDetailsPanel:Hide()
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.ElementItemList) do
		v:Dispose()
	end

	self.ElementItemList = {}
	self.SetaElementBGCom = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
