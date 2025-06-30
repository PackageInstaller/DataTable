-- chunkname: @IQIGame\\UI\\QueTip\\QueTipUnlockFunctionView.lua

local QueTipUnlockFunctionView = {}

function QueTipUnlockFunctionView.New(go)
	local obj = Clone(QueTipUnlockFunctionView)

	obj:Initialize(go)

	return obj
end

function QueTipUnlockFunctionView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go
	self.imgIcon = self.goIcon:GetComponent("Image")
	self.tfIconName = self.goIconName:GetComponent("Text")
	self.tfDesc = self.goDesc:GetComponent("Text")
end

function QueTipUnlockFunctionView:Open(id)
	self.cfgData = CfgFunctionTypeTable[id]

	self.goView:SetActive(true)

	local path = UIGlobalApi.ImagePath .. "/" .. self.cfgData.Icon

	AssetUtil.LoadImage(self, path, self.imgIcon)

	self.tfIconName.text = QueueTipUIApi:GetString("unlockFunctionIconName", self.cfgData.Name)
	self.tfDesc.text = QueueTipUIApi:GetString("unlockFunctionDesc", self.cfgData.Dec)
end

function QueTipUnlockFunctionView:Close()
	self.goView:SetActive(false)
end

function QueTipUnlockFunctionView:OnHide()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return QueTipUnlockFunctionView
