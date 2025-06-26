-- chunkname: @IQIGame\\UI\\GashaponHistoryList\\GashRewardCell.lua

local GashRewardCell = {}

function GashRewardCell.New(view)
	local obj = Clone(GashRewardCell)

	obj:Init(view)

	return obj
end

function GashRewardCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfName = self.goName:GetComponent("Text")
	self.itemCell = ItemCell.PackageOrReuseView(self, self.goItem, true, true)
	self.goSignGot:GetComponent("Text").text = GashaponHistoryListUIApi:GetString("cellSignGot")
end

function GashRewardCell:Refresh(cfgData)
	local cfgItemData = CfgItemTable[cfgData.Reward[1]]

	self.tfName.text = GashaponHistoryListUIApi:GetString("cellName", cfgItemData.Name)

	self.goSignGot:SetActive(FurnitureGashaponModule.CheckisGotFurniture(cfgData.Id))
	self.itemCell:SetItemByCID(cfgItemData.Id)
end

function GashRewardCell:OnHide()
	return
end

function GashRewardCell:OnDestroy()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return GashRewardCell
