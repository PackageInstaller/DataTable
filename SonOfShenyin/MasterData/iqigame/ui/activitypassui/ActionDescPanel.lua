-- chunkname: @IQIGame\\UI\\ActivityPassUI\\ActionDescPanel.lua

local ActionDescPanel = {}

function ActionDescPanel.New(go)
	local o = Clone(ActionDescPanel)

	o:Initialize(go)

	return o
end

function ActionDescPanel:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ActionDescPanel:InitComponent()
	self.buttonMask = self.buttonMask:GetComponent("Button")
end

function ActionDescPanel:InitDelegate()
	function self.ButtonMaskDelegate()
		self:OnButtonMaskClick()
	end
end

function ActionDescPanel:AddListener()
	self.buttonMask.onClick:AddListener(self.ButtonMaskDelegate)
end

function ActionDescPanel:RemoveListener()
	self.buttonMask.onClick:RemoveListener(self.ButtonMaskDelegate)
end

function ActionDescPanel:OnButtonMaskClick()
	self:Show(false)
end

function ActionDescPanel:Show(show)
	LuaUtility.SetGameObjectShow(self.gameObject, show)
end

function ActionDescPanel:Refresh(helpTipsId)
	local text = CfgHelpTipsTable[helpTipsId].Text

	UGUIUtil.SetText(self.textDesc, text)
end

function ActionDescPanel:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return ActionDescPanel
