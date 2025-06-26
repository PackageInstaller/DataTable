-- chunkname: @IQIGame\\UI\\Common\\DamageTypeCell.lua

local DamageTypeCell = {}

function DamageTypeCell.New(view)
	local obj = Clone(DamageTypeCell)

	obj:Init(view)

	return obj
end

function DamageTypeCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.icon = self.goIcon:GetComponent("Image")
	self.btnDamage = self.goBtnSelf:GetComponent("Button")

	function self.onClickBtnDamageDelegate()
		self:OnClickBtnDamage()
	end

	self:AddListener()
end

function DamageTypeCell:Open(type, useBlack)
	self.type = type

	self.View:SetActive(true)
	AssetUtil.LoadImage(self, MiscApi:GetString("SoulDamageTypeIcon", self.type, useBlack), self.icon)
end

function DamageTypeCell:Close()
	self.View:SetActive(false)
end

function DamageTypeCell:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function DamageTypeCell:AddListener()
	self.btnDamage.onClick:AddListener(self.onClickBtnDamageDelegate)
end

function DamageTypeCell:RemoveListener()
	self.btnDamage.onClick:RemoveListener(self.onClickBtnDamageDelegate)
end

function DamageTypeCell:OnClickBtnDamage()
	UIModule.Open(Constant.UIControllerName.TypeTipsUI, Constant.UILayer.Tooltip, {
		Constant.TypeTipsType.DAMAGE,
		self.type
	})
end

return DamageTypeCell
