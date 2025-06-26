-- chunkname: @IQIGame\\UI\\PassCheck\\RewardCell.lua

local RewardCell = {}

function RewardCell.New(view)
	local obj = Clone(RewardCell)

	obj:Init(view)

	return obj
end

function RewardCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfLv = self.goLv:GetComponent("Text")
	self.itemCellBase = ItemCell.PackageOrReuseView(self, self.goRewardBase.transform:Find("CommonSlotUI").gameObject, true, true)
	self.itemCellSuper = ItemCell.PackageOrReuseView(self, self.goRewardSuper.transform:Find("CommonSlotUI").gameObject, true, true)
	self.goLvEngDesc:GetComponent("Text").text = PassCheckUIApi:GetString("rewardCellEngLvDesc")
	self.goSignNow.transform:Find("Text_01"):GetComponent("Text").text = PassCheckUIApi:GetString("rewardCellNowDesc")
	self.goRewardBase.transform:Find("Got/Text"):GetComponent("Text").text = PassCheckUIApi:GetString("rewardCellGotDesc")
	self.goRewardSuper.transform:Find("Got/Text"):GetComponent("Text").text = PassCheckUIApi:GetString("rewardCellGotDesc")
end

function RewardCell:Refresh(cfgRewardData)
	self.cfgRewardData = cfgRewardData

	self:RefreshMisc()
	self:RefreshReward()
end

function RewardCell:OnHide()
	return
end

function RewardCell:OnDestroy()
	self.itemCellBase:Dispose()
	self.itemCellSuper:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function RewardCell:RefreshMisc()
	self.tfLv.text = PassCheckUIApi:GetString("rewardCellLv", self.cfgRewardData.SeasonLv)

	self.goSignLock:SetActive(self.cfgRewardData.SeasonLv > PassCheckModule.lv)
	self.goSignNow:SetActive(self.cfgRewardData.SeasonLv == PassCheckModule.lv)
	self.goSignUnlock:SetActive(self.cfgRewardData.SeasonLv <= PassCheckModule.lv)
end

function RewardCell:RefreshReward()
	local baseIsGot = PassCheckModule.CheckRewardIsGot(self.cfgRewardData.Id, self.cfgRewardData.FreeReward[1], false)
	local superIsGot = PassCheckModule.CheckRewardIsGot(self.cfgRewardData.Id, self.cfgRewardData.PayReward[1], true)

	self.itemCellBase:SetItemByCID(self.cfgRewardData.FreeReward[1], self.cfgRewardData.FreeReward[2])
	self.goRewardBase.transform:Find("Got").gameObject:SetActive(baseIsGot)
	self.itemCellSuper:SetItemByCID(self.cfgRewardData.PayReward[1], self.cfgRewardData.PayReward[2])
	self.goRewardSuper.transform:Find("Lock").gameObject:SetActive(not PassCheckModule.CheckGotSuperPass())
	self.goRewardSuper.transform:Find("Got").gameObject:SetActive(superIsGot)
	self.goMaskGetReward:SetActive(PassCheckModule.CheckLvExistRewardCanGet(self.cfgRewardData))
end

return RewardCell
