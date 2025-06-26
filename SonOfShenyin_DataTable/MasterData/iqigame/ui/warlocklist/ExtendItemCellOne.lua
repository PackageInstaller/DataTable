-- chunkname: @IQIGame\\UI\\WarlockList\\ExtendItemCellOne.lua

ExtendItemCellOne = {}

function ExtendItemCellOne.New(go)
	local o = Clone(ExtendItemCellOne)

	o:Initialize(go)

	return o
end

function ExtendItemCellOne:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.BaseItemCell = ItemCell.New(go, true, true)

	self:InitComponent()
end

function ExtendItemCellOne:Dispose()
	self.BaseItemCell:Dispose()
	self:DisposeComponent()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function ExtendItemCellOne:InitComponent()
	return
end

function ExtendItemCellOne:DisposeComponent()
	self.CurOwnText = nil
	self.AllNeedText = nil
	self.ExtendAwardNumText = nil
end

function ExtendItemCellOne:SetData(itemData, needNun)
	self.BaseItemCell:SetItem(itemData)
	self.BaseItemCell:SetCustomNum(itemData.num, needNun)
end

function ExtendItemCellOne:SetAwardData(itemData, needNun)
	local cfgItemData = itemData:GetCfg()

	self.BaseItemCell:SetItem(itemData)
	self.BaseItemCell:SetNum(needNun)
end

function ExtendItemCellOne:SetItemLockState(show)
	LuaUtility.SetGameObjectShow(self.imageBlock, show)
end

function ExtendItemCellOne:SetItemAchieveState(show)
	LuaUtility.SetGameObjectShow(self.imageHadGot, show)
end

function ExtendItemCellOne:SetItemCanGetState(show)
	LuaUtility.SetGameObjectShow(self.highCanGetImg, show)
end

function ExtendItemCellOne:SetGrayState(state)
	self.BaseItemCell:SetGrayState(state)
end

function ExtendItemCellOne:Show()
	self.BaseItemCell:Show()
end

function ExtendItemCellOne:Hide()
	self.BaseItemCell:Hide()
end

function ExtendItemCellOne:OnDestroy()
	logError("ExtendItemCellOne 为废弃方法，请改用self:Dispose() 销毁组件")
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end
