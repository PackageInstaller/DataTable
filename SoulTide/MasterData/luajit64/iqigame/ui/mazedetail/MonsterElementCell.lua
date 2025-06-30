-- chunkname: @IQIGame\\UI\\MazeDetail\\MonsterElementCell.lua

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

	if self.MainLabel ~= nil then
		UGUIUtil.SetText(self.MainLabel, MiscApi:GetString("MonsterElementCellMainLabel"))
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

function m:SetData(elementType, mainWeakElementType)
	self.elementType = elementType

	AssetUtil.LoadImage(self, MiscApi:GetString("SoulDamageTypeIcon", elementType, true), self.Icon:GetComponent("Image"))

	local elementNameText = MiscApi:GetString("SoulDamageType", elementType)

	UGUIUtil.SetText(self.NameText, elementNameText)

	if self.MainViewNameText ~= nil then
		UGUIUtil.SetText(self.MainViewNameText, elementNameText)
	end

	local isMainType = mainWeakElementType ~= nil and elementType == mainWeakElementType

	if self.NormalView ~= nil then
		self.NormalView:SetActive(not isMainType)
	end

	if self.MainWeakView ~= nil then
		self.MainWeakView:SetActive(isMainType)
	end
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
