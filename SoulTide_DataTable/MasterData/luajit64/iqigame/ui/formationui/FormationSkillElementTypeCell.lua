-- chunkname: @IQIGame\\UI\\FormationUI\\FormationSkillElementTypeCell.lua

local m = {
	ElementType = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickTipBtn()
		self:OnClickTipBtn()
	end
end

function m:OnObtain()
	self.View:SetActive(true)
	self:AddListeners()
end

function m:OnRelease()
	self.View:SetActive(false)
	self:RemoveListeners()
end

function m:AddListeners()
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
end

function m:RemoveListeners()
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
end

function m:SetData(elementType)
	self.ElementType = elementType

	self.Icon:SetActive(false)
	AssetUtil.LoadImage(self, MiscApi:GetString("SoulDamageTypeIcon", elementType, true), self.Icon:GetComponent("Image"), self.OnSuccess, self.OnFail, self.Icon)
end

function m:OnSuccess(assetName, asset, duration, userData)
	userData:SetActive(true)
end

function m:OnFail(assetName, status, errorMessage, userData)
	userData:SetActive(true)
end

function m:OnClickTipBtn()
	UIModule.Open(Constant.UIControllerName.ShieldTipsUI, Constant.UILayer.UI, {
		self.ElementType,
		self.View.transform
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
