-- chunkname: @IQIGame\\UI\\Library\\LibraryMonsterWeakCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnComponent = self.View:GetComponent("Button")

	function self.delegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	if self.btnComponent then
		self.btnComponent.onClick:AddListener(self.delegateBtnSelf)
	end
end

function m:RemoveListener()
	if self.btnComponent then
		self.btnComponent.onClick:RemoveListener(self.delegateBtnSelf)
	end
end

function m:SetData(elementType)
	self.elementType = elementType

	AssetUtil.LoadImage(self, MiscApi:GetString("SoulDamageTypeIcon", elementType, true), self.Icon:GetComponent("Image"))
end

function m:OnBtnSelf()
	UIModule.Open(Constant.UIControllerName.ShieldTipsUI, Constant.UILayer.UI, {
		self.elementType,
		self.View.transform
	})
end

function m:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
