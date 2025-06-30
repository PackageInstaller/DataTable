-- chunkname: @IQIGame\\UI\\UserInfo\\ResetTalentView.lua

local ResetTalentView = {}

function ResetTalentView.New(view)
	local obj = Clone(ResetTalentView)

	obj:Init(view)

	return obj
end

function ResetTalentView:Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.Delegation_OnCloseBtnClick()
		self:Hide()
	end

	function self.Delegation_OnConfirmBtnClick()
		self:OnConfirmBtnClick()
	end

	self.commonSlotUI = ItemCell.New(self.CommonSlotUI)

	self:AddListeners()
end

function ResetTalentView:Dispose()
	self.commonSlotUI:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.Delegation_OnCloseBtnClick = nil
	self.Delegation_OnConfirmBtnClick = nil
	self.gameObject = nil
end

function ResetTalentView:AddListeners()
	self.CancelButton:GetComponent("Button").onClick:AddListener(self.Delegation_OnCloseBtnClick)
	self.MaskCloseBtn:GetComponent("Button").onClick:AddListener(self.Delegation_OnCloseBtnClick)
	self.ConfirmButton:GetComponent("Button").onClick:AddListener(self.Delegation_OnConfirmBtnClick)
end

function ResetTalentView:RemoveListeners()
	self.CancelButton:GetComponent("Button").onClick:RemoveListener(self.Delegation_OnCloseBtnClick)
	self.MaskCloseBtn:GetComponent("Button").onClick:RemoveListener(self.Delegation_OnCloseBtnClick)
	self.ConfirmButton:GetComponent("Button").onClick:RemoveListener(self.Delegation_OnConfirmBtnClick)
end

function ResetTalentView:Show()
	self.gameObject:SetActive(true)
	self:SetData()
end

function ResetTalentView:Hide()
	self.gameObject:SetActive(false)
end

function ResetTalentView:SetData()
	local cfgDatas = CfgDiscreteDataTable[89].Data

	self.itemId = cfgDatas[#cfgDatas - 1]
	self.costItemCount = cfgDatas[#cfgDatas]
	self.hasItemCount = WarehouseModule.GetItemNumByCfgID(cfgDatas[#cfgDatas - 1])

	for i = 1, #cfgDatas, 3 do
		if i == UserInfoModule.ResetTalentCount + 1 then
			self.itemId = cfgDatas[i + 1]
			self.costItemCount = cfgDatas[i + 2]
			self.hasItemCount = WarehouseModule.GetItemNumByCfgID(cfgDatas[i + 1])

			break
		end
	end

	self.commonSlotUI:SetItem(ItemData.CreateByCIDAndNumber(self.itemId))
	UGUIUtil.SetText(self.costNumText, self.costItemCount)
	UGUIUtil.SetText(self.haveNumText, self.hasItemCount)
end

function ResetTalentView:OnConfirmBtnClick()
	if self.hasItemCount < self.costItemCount then
		NoticeModule.ShowNotice(12003)

		return
	end

	UserInfoModule.ResetTalent()
	self:Hide()
end

return ResetTalentView
