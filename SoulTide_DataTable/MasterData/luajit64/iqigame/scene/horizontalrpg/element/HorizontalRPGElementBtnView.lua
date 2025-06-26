-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\Element\\HorizontalRPGElementBtnView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnElement()
		self:OnBtnElement()
	end

	self.View:SetActive(false)
	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateBtnElement)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnElement)
end

function m:SetData(data)
	self.ElementData = data

	UGUIUtil.SetTextInChildren(self.View, self.ElementData:GetCfgData().ElementName)
end

function m:ShowBtnElement(top)
	self.View:SetActive(top)
end

function m:OnBtnElement()
	if self.ElementData:GetCfgData().ElementType == HorizontalRPGConstant.ElementType.HorizontalRPG_Case then
		HorizontalRPGModule.PickUpTheBox(self.ElementData.cid)
	else
		HorizontalRPGModule.TriggerElementService(HorizontalRPGConstant.ElementTriggerType.ClickElementBtn, self.ElementData.cid)
	end

	self:ShowBtnElement(false)
end

function m:Dispose()
	self:RemoveListener()

	self.ElementData = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
