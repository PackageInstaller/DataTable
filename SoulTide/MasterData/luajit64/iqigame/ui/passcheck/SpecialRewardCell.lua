-- chunkname: @IQIGame\\UI\\PassCheck\\SpecialRewardCell.lua

local SpecialRewardCell = {}

function SpecialRewardCell.New(view)
	local obj = Clone(SpecialRewardCell)

	obj:Init(view)

	return obj
end

function SpecialRewardCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfLv = self.goLv:GetComponent("Text")
	self.btnSelf = self.goBtnSelf:GetComponent("Button")

	function self.onClickBtnSelfDelegate()
		self:OnClickBtnSelf()
	end

	self.itemCellBase = ItemCell.PackageOrReuseView(self, self.goRewardBase.transform:Find("CommonSlotUI").gameObject, true, true)
	self.itemCellSuper = ItemCell.PackageOrReuseView(self, self.goRewardSuper.transform:Find("CommonSlotUI").gameObject, true, true)
	self.goLvEngDesc:GetComponent("Text").text = PassCheckUIApi:GetString("rewardCellEngLvDesc")
	self.goRewardBase.transform:Find("Got/Text"):GetComponent("Text").text = PassCheckUIApi:GetString("rewardCellGotDesc")
	self.goRewardSuper.transform:Find("Got/Text"):GetComponent("Text").text = PassCheckUIApi:GetString("rewardCellGotDesc")
end

function SpecialRewardCell:Refresh(cfgRewardData)
	self.cfgRewardData = cfgRewardData

	self:ReRefresh()
end

function SpecialRewardCell:ReRefresh()
	self:RefreshMisc()
	self:RefreshReward()
end

function SpecialRewardCell:OnHide()
	return
end

function SpecialRewardCell:OnDestroy()
	self.itemCellBase:Dispose()
	self.itemCellSuper:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SpecialRewardCell:OnAddListener()
	self.btnSelf.onClick:AddListener(self.onClickBtnSelfDelegate)
end

function SpecialRewardCell:OnRemoveListener()
	self.btnSelf.onClick:RemoveListener(self.onClickBtnSelfDelegate)
end

function SpecialRewardCell:OnClickBtnSelf()
	if PassCheckModule.CheckLvExistRewardCanGet(self.cfgRewardData) then
		PassCheckModule.ReqGetReward({
			self.cfgRewardData.Id
		})
	end
end

function SpecialRewardCell:RefreshMisc()
	self.tfLv.text = PassCheckUIApi:GetString("rewardCellLv", self.cfgRewardData.SeasonLv)
end

function SpecialRewardCell:RefreshReward()
	self.itemCellBase:SetItemByCID(self.cfgRewardData.FreeReward[1], self.cfgRewardData.FreeReward[2])
	self.goRewardBase.transform:Find("Got").gameObject:SetActive(PassCheckModule.CheckRewardIsGot(self.cfgRewardData.Id, self.cfgRewardData.FreeReward[1], false))
	self.itemCellSuper:SetItemByCID(self.cfgRewardData.PayReward[1], self.cfgRewardData.PayReward[2])
	self.goRewardSuper.transform:Find("Lock").gameObject:SetActive(not PassCheckModule.CheckGotSuperPass())
	self.goRewardSuper.transform:Find("Got").gameObject:SetActive(PassCheckModule.CheckRewardIsGot(self.cfgRewardData.Id, self.cfgRewardData.PayReward[1], true))
	self.goMaskGetReward:SetActive(PassCheckModule.CheckLvExistRewardCanGet(self.cfgRewardData))
end

return SpecialRewardCell
