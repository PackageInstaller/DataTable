-- chunkname: @IQIGame\\UI\\Mall\\MallRechargeCell.lua

local MallRechargeCell = {}

function MallRechargeCell.New(go)
	local o = Clone(MallRechargeCell)

	o:Initialize(go)

	return o
end

function MallRechargeCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.tfName = self.goName:GetComponent("Text")
	self.tfDesc = self.goDesc:GetComponent("Text")
	self.tfMoney = self.goMoney:GetComponent("Text")
	self.tfExtCount = self.goExtRewardCount:GetComponent("Text")
	self.icon = self.goIcon:GetComponent("Image")
	self.goTopDesc:GetComponent("Text").text = MallUIApi:GetString("rechargeCellTopDesc")
	self.goMoneySign:GetComponent("Text").text = MiscApi:GetString("moneySign")
	self.goExtRewardTitle:GetComponent("Text").text = MallUIApi:GetString("rechargeCellExtRewardTitle")

	self:OnAddListener()
end

function MallRechargeCell:Refresh(cfgMallData)
	self.cfgMallData = cfgMallData
	self.cfgPayData = CfgPayTable[self.cfgMallData.PayMoney]
	self.tfName.text = MallUIApi:GetString("rechargeCellName", self.cfgPayData.Name)
	self.tfDesc.text = MallUIApi:GetString("rechargeCellDesc", self.cfgPayData.Desc)
	self.tfMoney.text = MallUIApi:GetString("rechargeCellMoney", self.cfgPayData.Amount)
	self.tfExtCount.text = MallUIApi:GetString("rechargeCellExtRewardCount", self.cfgPayData.BonusPaypoint)

	AssetUtil.LoadImage(self, UIGlobalApi.GetAssetPath(self.cfgMallData.BG), self.icon)
	self.goExtRewardBlock:SetActive(PlayerModule.PlayerInfo.payExBonus[self.cfgPayData.Id])
end

function MallRechargeCell:OnHide()
	return
end

function MallRechargeCell:OnDestroy()
	self:OnRemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function MallRechargeCell:OnAddListener()
	return
end

function MallRechargeCell:OnRemoveListener()
	return
end

return MallRechargeCell
