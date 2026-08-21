-- chunkname: @IQIGame\\UI\\Common\\GoSourceBtnCell.lua

local m = {
	FunctionCid = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	function self.DelegateOnClick()
		self:OnClick()
	end

	self.IconComponent = self.View.transform:Find("Image_Icon"):GetComponent("Image")
	self.TextComponent = self.View.transform:Find("Text"):GetComponent("Text")
	self.Button = self.View:GetComponent("Button")

	self.Button.onClick:AddListener(self.DelegateOnClick)
end

function m:SetData(functionCid)
	self.FunctionCid = functionCid

	local cfgFunctionData = CfgFunctionTable[functionCid]

	AssetUtil.LoadImage(self, UIGlobalApi.ImagePath .. "/" .. cfgFunctionData.Icon, self.IconComponent)

	self.TextComponent.text = GoSourceBtnCellApi:GetString("NameText", cfgFunctionData.Name)
end

function m:OnClick()
	JumpModule.Jump(self.FunctionCid)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self.Button.onClick:RemoveListener(self.DelegateOnClick)

	self.View = nil
end

return m
