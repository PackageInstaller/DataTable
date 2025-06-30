-- chunkname: @IQIGame\\UI\\Mall\\MallMonthCardView.lua

local MallMonthCardView = {
	IsOpen = false,
	ItemSubTypeViewMap = {},
	ItemSubTypeMallDataMap = {},
	ToggleCells = {}
}
local MonthCardGoodsView = require("IQIGame.UI.Mall.MonthCardChild.MonthCardGoodsView")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MallMonthCardToggleCell = require("IQIGame.UI.Mall.MonthCardChild.MallMonthCardToggleCell")

function MallMonthCardView.New(view, uiController)
	local obj = Clone(MallMonthCardView)

	obj:Init(view, uiController)

	return obj
end

function MallMonthCardView:Init(view, uiController)
	self.View = view
	self.UIController = uiController

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickToggle(itemSubType, isOn)
		self:OnClickToggle(itemSubType, isOn)
	end

	self.ItemSubTypeList = MallUIApi:GetString("MonthCardItemSubTypeList")
	self.TogglePool = UIObjectPool.New(3, function()
		return MallMonthCardToggleCell.New(UnityEngine.Object.Instantiate(self.TogglePrefab), self.DelegateOnClickToggle)
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
end

function MallMonthCardView:Open(cfgMallDataList)
	for i, cfgMallData in pairs(cfgMallDataList) do
		local monthCardItemCid = CfgPayTable[cfgMallData.PayMoney].GetItems[1]
		local cfgItemData = CfgItemTable[monthCardItemCid]

		if table.indexOf(self.ItemSubTypeList, cfgItemData.SubType) ~= -1 then
			self.ItemSubTypeMallDataMap[cfgItemData.SubType] = cfgMallData
		end
	end

	self.View:SetActive(true)
	self:OnAddListener()
	self:Refresh()

	self.IsOpen = true
end

function MallMonthCardView:Close()
	self.View:SetActive(false)

	self.IsOpen = false
end

function MallMonthCardView:OnUpdate(elapseSeconds, realElapseSeconds)
	if not self.IsOpen then
		return
	end

	for itemSubType, view in pairs(self.ItemSubTypeViewMap) do
		view:OnUpdate(elapseSeconds, realElapseSeconds)
	end

	self:RefreshSignBought()
end

function MallMonthCardView:OnHide()
	for i, v in pairs(self.ItemSubTypeViewMap) do
		v:OnHide()
	end

	self:OnRemoveListener()
end

function MallMonthCardView:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.ItemSubTypeViewMap) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function MallMonthCardView:OnAddListener()
	return
end

function MallMonthCardView:OnRemoveListener()
	return
end

function MallMonthCardView:ShowTabView(itemSubType)
	self:SetInteractable(false)

	local viewController = self.ItemSubTypeViewMap[itemSubType]

	if viewController == nil then
		local viewPrefabPath = MallUIApi:GetString("MonthCardPrefabPath", itemSubType)
		local viewPrefab = self.UIController:GetPreloadedAsset(viewPrefabPath)

		if viewPrefab ~= nil then
			self:OnViewAssetLoaded(viewPrefab, itemSubType)
		else
			AssetUtil.LoadAsset(self, viewPrefabPath, function(this, assetName, asset, duration, userData)
				self:OnViewAssetLoaded(asset, userData)
			end, nil, itemSubType)
		end
	else
		self:OpenViewAfterAssetPrepared(itemSubType)
	end
end

function MallMonthCardView:OnViewAssetLoaded(viewPrefab, itemSubType)
	local view = UnityEngine.Object.Instantiate(viewPrefab)

	view.transform:SetParent(self.ViewContainer.transform, false)

	local monthCardCid = self:GetMonthCardCid(itemSubType)

	self.ItemSubTypeViewMap[itemSubType] = MonthCardGoodsView.New(view, monthCardCid)

	self:OpenViewAfterAssetPrepared(itemSubType)
end

function MallMonthCardView:GetMonthCardCid(itemSubType)
	local cfgMallData = self.ItemSubTypeMallDataMap[itemSubType]
	local cfgPayData = CfgPayTable[cfgMallData.PayMoney]
	local cfgItemData = CfgItemTable[cfgPayData.GetItems[1]]
	local monthCardCid

	for i = 1, #cfgItemData.EffectTypeID do
		if cfgItemData.EffectTypeID[i] == 55 then
			local effectTypeParams = cfgItemData.EffectTypeParam[i]

			if effectTypeParams ~= nil then
				monthCardCid = effectTypeParams[1]
			end

			break
		end
	end

	if monthCardCid == nil then
		logError("Mall.Id " .. cfgMallData.Id .. "对应的月卡id为空。Mall.PayMoney -> Pay.GetItems[1] -> Item.EffectTypeId == 55 -> Item.EffectTypeParam错误。")
	end

	return monthCardCid
end

function MallMonthCardView:OpenViewAfterAssetPrepared(itemSubType)
	if self.curView ~= nil then
		self.curView:Close()
	end

	self.curView = self.ItemSubTypeViewMap[itemSubType]

	self.curView:Open(self.ItemSubTypeMallDataMap[itemSubType])
	self:SetInteractable(true)
end

function MallMonthCardView:SetInteractable(interactable)
	for i = 1, #self.ToggleCells do
		local cell = self.ToggleCells[i]

		cell:SetInteractable(interactable)
	end
end

function MallMonthCardView:RefreshSignBought()
	local cidToggleMap = {}

	for i = 1, #self.ToggleCells do
		local cell = self.ToggleCells[i]

		cell:SetBoughtFlagActive(false)

		cidToggleMap[cell.MonthCardCid] = cell
	end

	for monthCardCid, cell in pairs(cidToggleMap) do
		local ownedMonthCardMap = PlayerModule.PlayerInfo.monthCard or {}
		local expireTime = ownedMonthCardMap[monthCardCid] or 0
		local leftTime = expireTime - PlayerModule.GetServerTime()

		cell:SetBoughtFlagActive(leftTime > 0)
	end
end

function MallMonthCardView:Refresh()
	self:RefreshToggles()
	self:ShowDefaultView()
end

function MallMonthCardView:RefreshToggles()
	self:ClearToggles()

	for i = 1, #self.ItemSubTypeList do
		local subType = self.ItemSubTypeList[i]

		if self.ItemSubTypeMallDataMap[subType] ~= nil then
			local cell = self.TogglePool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.ToggleGrid.transform, false)
			cell:SetData(subType, self:GetMonthCardCid(subType))
			table.insert(self.ToggleCells, cell)
		end
	end
end

function MallMonthCardView:ClearToggles()
	for i = 1, #self.ToggleCells do
		local cell = self.ToggleCells[i]

		cell.View:SetActive(false)
		cell.View.transform:SetParent(self.View.transform, false)
		self.TogglePool:Release(cell)
	end

	self.ToggleCells = {}
end

function MallMonthCardView:ShowDefaultView()
	local defaultItemSubType = 0

	for i = 1, #self.ToggleCells do
		local cell = self.ToggleCells[i]

		cell:SetToggleValue(i == 1, true)

		if i == 1 then
			defaultItemSubType = cell.ItemSubType
		end
	end

	self:ShowTabView(defaultItemSubType)
end

function MallMonthCardView:OnClickToggle(itemSubType, isOn)
	if isOn then
		self:ShowTabView(itemSubType)
	end
end

return MallMonthCardView
