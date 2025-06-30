-- chunkname: @IQIGame\\UI\\Maze\\UI\\SubUI\\SelectHoleView.lua

local selectElementItem = {
	Index = 0
}

function selectElementItem.New(view)
	local obj = Clone(selectElementItem)

	obj:Init(view)

	return obj
end

function selectElementItem:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.elementImgCom = self.elementImg:GetComponent("Image")
end

function selectElementItem:SetData(index, data, selectIndex)
	local type = data.type

	self.Index = index

	LuaUtility.SetGameObjectShow(self.blackBg, type ~= MazeModule.ElementEnum.Yin)
	LuaUtility.SetGameObjectShow(self.grayBg, type == MazeModule.ElementEnum.Yin)
	UGUIUtil.SetText(self.buffText, string.format(MazeApi:GetTypeTextColor(type), MazeApi:GetTypeNameAndDesc(type) .. "×" .. data.value))
	AssetUtil.LoadImage(self, WarlockApi:GetElementIconPath(type), self.elementImgCom, function()
		self.elementImgCom:SetNativeSize()
	end)

	if self.Index == selectIndex then
		self:SetSelectState(true)
	else
		self:SetSelectState(false)
	end
end

function selectElementItem:SetSelectState(state)
	LuaUtility.SetGameObjectShow(self.selectState, state)
end

function selectElementItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local m = {
	SelectIndex = 0,
	ElementDataList = {},
	ElementItemList = {}
}

m.SelectElementItem = selectElementItem

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickRestoreBtn()
		self:OnClickRestoreBtn()
	end

	function self.DelegateSelectSeatEffectSuccessEvent(SeatID)
		self:SelectSeatEffectSuccessEvent(SeatID)
	end

	function self.DelegateCancelSeatEffectSuccessEvent(SeatID)
		self:CancelSeatEffectSuccessEvent(SeatID)
	end

	self.wrapContent = self.selectScroll:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	function self.wrapContent.onSelectedCell(cell)
		self:OnSelectedCell(cell)
	end

	self.consumeGoldCell = CommonConsumeGold.New(self.Com_ConsumeGold)

	self:AddListeners()
end

function m:AddListeners()
	self.confirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.restoreBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRestoreBtn)
	EventDispatcher.AddEventListener(EventID.SelectSeatEffectSuccessEvent, self.DelegateSelectSeatEffectSuccessEvent)
	EventDispatcher.AddEventListener(EventID.CancelSeatEffectSuccessEvent, self.DelegateCancelSeatEffectSuccessEvent)
end

function m:RemoveListeners()
	self.confirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.restoreBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRestoreBtn)
	EventDispatcher.RemoveEventListener(EventID.SelectSeatEffectSuccessEvent, self.DelegateSelectSeatEffectSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.CancelSeatEffectSuccessEvent, self.DelegateCancelSeatEffectSuccessEvent)
end

function m:SetData(...)
	local arg = {
		...
	}

	self.seatId = arg[1]
	self.holeCfg = MazeModule.GetHoleCfgByHoleID(self.seatId)
	self.seatData = MazeModule.GetServerHoleData(self.seatId)
	self.ElementDataList = {}

	for i = 1, #self.holeCfg.Effect do
		if i ~= self.seatData.effectId then
			table.insert(self.ElementDataList, {
				type = i,
				value = self.holeCfg.Effect[i]
			})
		end
	end

	self.SelectIndex = 1
	self.SelectEffectId = self.ElementDataList[self.SelectIndex].type

	self:RefreshElementList()
	self:RefreshUpgradeInfo()
	self:RefreshRestoreBtnState()
	self:RefreshSelectInfoShow()
end

function m:RefreshUpgradeInfo()
	if self.holeCfg.Cost[1] ~= nil or self.holeCfg.Cost[2] ~= nil then
		self.consumeGoldCell:InitIconImg(self.holeCfg.Cost[1])
		self.consumeGoldCell:SetData(self.holeCfg.Cost[2])
	end

	LuaUtility.SetGameObjectShow(self.restoreBtn, false)
end

function m:RefreshElementList()
	self.wrapContent:Refresh(#self.ElementDataList)
end

function m:OnRenderItem(cell)
	local itemData = self.ElementDataList[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.ElementItemList[instanceId]

	if itemCell == nil then
		itemCell = self.SelectElementItem.New(cell.gameObject)
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
	self.SelectEffectId = itemData.type
end

function m:SetSelectItemsState()
	for k, v in pairs(self.ElementItemList) do
		v:SetSelectState(false)
	end
end

function m:RefreshSelectInfoShow()
	self.consumeGoldCell:InitIconImg(self.holeCfg.UpgradeCost[1])
	self.consumeGoldCell:SetData(self.holeCfg.UpgradeCost[2])
end

function m:RefreshRestoreBtnState()
	LuaUtility.SetGameObjectShow(self.restoreBtn, self.seatData.effectId ~= 0)
end

function m:SelectSeatEffectSuccessEvent()
	self:SetData(self.seatId)
end

function m:CancelSeatEffectSuccessEvent(SeatID)
	self:SetData(self.seatId)
end

function m:OnClickConfirmBtn()
	if self.SelectEffectId == nil then
		return
	end

	MazeModule.SelectSeatEffect(self.seatId, self.SelectEffectId)
end

function m:OnClickRestoreBtn()
	if self.SelectEffectId == nil then
		return
	end

	MazeModule.CancelSeatEffect(self.seatId)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.ElementItemList) do
		v:Dispose()
	end

	self.ElementItemList = {}

	self.consumeGoldCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
