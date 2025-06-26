-- chunkname: @IQIGame\\UI\\Maze\\MazeHiddenMazeCell.lua

local m = {
	Index = 0,
	CostItemCid = 0,
	CostItemNum = 0
}

function m.New(view, index)
	local obj = Clone(m)

	obj:Init(view, index)

	return obj
end

function m:Init(view, index)
	self.View = view
	self.Index = index

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickItemIcon()
		self:OnClickItemIcon()
	end

	self.OriginalScale = self.View.transform.localScale:Clone()
	self.TweenScaleComponent = self.View:GetComponent("TweenScale")

	UGUIUtil.SetText(self.NameText, MazeHiddenMazeUIApi:GetString("CellNameText", self.Index))
	UGUIUtil.SetText(self.SubNameText, MazeHiddenMazeUIApi:GetString("CellSubNameText", self.Index))
	self.SearchingView:SetActive(false)
	self:AddListeners()
end

function m:AddListeners()
	self.ItemIcon:GetComponent("Button").onClick:AddListener(self.DelegateOnClickItemIcon)
end

function m:RemoveListeners()
	self.ItemIcon:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickItemIcon)
end

function m:SetData(exchangeCid, desc)
	self.CfgExchangeData = CfgExchangeTable[exchangeCid]
	self.Desc = desc

	local leftCount, costItemCid, costItemNum, nextIndex = ChurchModule.GetExchangeInfo(self.CfgExchangeData)

	self.CostItemCid = costItemCid
	self.CostItemNum = costItemNum

	local haveNum = WarehouseModule.GetItemNumByCfgID(self.CostItemCid)

	self.CostItemCfgData = CfgItemTable[self.CostItemCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.CostItemCfgData.Icon), self.ItemIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.ItemNumText, MazeHiddenMazeUIApi:GetString("MazeItemNumText", haveNum, self.CostItemNum))
end

function m:SetSelect(value)
	self.CheckView:SetActive(value)

	local scale = self.OriginalScale:Clone()

	if value then
		scale = scale * 1.2
	end

	self.View.transform.localScale = scale
end

function m:OnClickItemIcon()
	ItemModule.OpenTipByData(self.CostItemCfgData, true)
end

function m:TweenScale()
	self.TweenScaleComponent.enabled = true
end

function m:PlaySearchAnim()
	self.SearchingView:SetActive(true)
end

function m:RefreshItem()
	local haveNum = WarehouseModule.GetItemNumByCfgID(self.CostItemCid)

	UGUIUtil.SetText(self.ItemNumText, MazeHiddenMazeUIApi:GetString("MazeItemNumText", haveNum, self.CostItemNum))
end

function m:Reset(position)
	self.TweenScaleComponent:ResetToBeginning()

	self.TweenScaleComponent.enabled = false

	self.View:SetActive(true)

	self.View.transform.position = position
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.TweenScaleComponent = nil
	self.OriginalScale = nil
	self.CfgExchangeData = nil
	self.CostItemCfgData = nil
end

return m
