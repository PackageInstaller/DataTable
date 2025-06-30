-- chunkname: @IQIGame\\UI\\Login\\AccountTransfer\\AccountTransferView.lua

local m = {}
local AccountTransferBindingView = require("IQIGame.UI.Login.AccountTransfer.AccountTransferBindingView")
local AccountTransferCancelNoticeView = require("IQIGame.UI.Login.AccountTransfer.AccountTransferCancelNoticeView")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateBtnDisagree()
		self:OnBtnDisagree()
	end

	function self.DelegateBtnAgree()
		self:OnBtnAgree()
	end

	function self.DelegateTransferSimpleInfoEvent(response)
		self:OnTransferSimpleInfoEvent(response)
	end

	self:AddListener()
	self.View:SetActive(false)

	self.bindingView = AccountTransferBindingView.New(self.BindingNode)
	self.cancelNoticeView = AccountTransferCancelNoticeView.New(self.CancelNotice, self)
end

function m:AddListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.BtnDisagree:GetComponent("Button").onClick:AddListener(self.DelegateBtnDisagree)
	self.BtnAgree:GetComponent("Button").onClick:AddListener(self.DelegateBtnAgree)
	EventDispatcher.AddEventListener(EventID.AccountTransferSimpleInfoEvent, self.DelegateTransferSimpleInfoEvent)
end

function m:RemoveListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.BtnDisagree:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnDisagree)
	self.BtnAgree:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnAgree)
	EventDispatcher.RemoveEventListener(EventID.AccountTransferSimpleInfoEvent, self.DelegateTransferSimpleInfoEvent)
end

function m:SetData(data)
	return
end

function m:OnBtnClose()
	self:Close()
end

function m:OnTransferSimpleInfoEvent(response)
	self.bindingView:Open()
	self.bindingView:SetData(response.Id, response.name, response.level)
	self.cancelNoticeView:Close()
end

function m:OnBtnDisagree()
	self.cancelNoticeView:Open()
end

function m:OnBtnAgree()
	LoginModule.GetSimpleInfo()
end

function m:Open()
	self.View:SetActive(true)
end

function m:Close()
	self.View:SetActive(false)
	self.bindingView:Close()
	self.cancelNoticeView:Close()
end

function m:Dispose()
	self:RemoveListener()
	self.bindingView:Dispose()
	self.cancelNoticeView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
