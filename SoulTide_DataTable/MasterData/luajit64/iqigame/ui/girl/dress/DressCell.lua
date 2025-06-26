-- chunkname: @IQIGame\\UI\\Girl\\dress\\DressCell.lua

local DressCell = {}

function DressCell.New(view)
	local obj = Clone(DressCell)

	obj:Init(view)

	return obj
end

function DressCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnDetail = self.goBtnDetail:GetComponent("Button")

	function self.onClickBtnDetailDelegate()
		self:OnClickBtnDetail()
	end

	self.imgIcon = self.goIcon:GetComponent("Image")
	self.tfName = self.goName:GetComponent("Text")
	self.goSignWore.transform:Find("Text_01"):GetComponent("Text").text = GirlUIApi:GetString("dressViewSignWoreTxt")

	self:OnAddListener()
end

function DressCell:Refresh(dressData)
	self.dressData = dressData
	self.cfgDressData = self.dressData.cfgDressRow
	self.cfgSoulResData = CfgSoulResTable[self.cfgDressData.SoulResID]
	self.soulData = SoulModule.GetSoulData(self.cfgDressData.SoulID)

	AssetUtil.LoadImage(self, UIGlobalApi.GetHarmoniousImagePath(self.cfgDressData.CoverImage), self.imgIcon)

	self.tfName.text = GirlUIApi:GetString("dressViewDressName", self.cfgDressData.Name)

	self.goSignWore:SetActive(self.cfgDressData.Id == self.soulData.dressCid2D)

	for i = 1, 4 do
		if self["fashionTag" .. i] then
			self["fashionTag" .. i]:SetActive(self.cfgDressData.DressTag == i)
		end
	end
end

function DressCell:OnHide()
	return
end

function DressCell:OnDestroy()
	self:OnRemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function DressCell:OnAddListener()
	self.btnDetail.onClick:AddListener(self.onClickBtnDetailDelegate)
end

function DressCell:OnRemoveListener()
	self.btnDetail.onClick:RemoveListener(self.onClickBtnDetailDelegate)
end

function DressCell:OnClickBtnDetail()
	UIModule.Open(Constant.UIControllerName.GirlDressShowUI, Constant.UILayer.UI, self.cfgDressData)
end

function DressCell:SetSignSelectVisible(vs)
	self.goSignSelect:SetActive(vs)
end

return DressCell
