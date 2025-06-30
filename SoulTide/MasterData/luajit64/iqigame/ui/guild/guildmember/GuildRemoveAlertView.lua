-- chunkname: @IQIGame\\UI\\Guild\\GuildMember\\GuildRemoveAlertView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.RemoveTitleText, GuildMemberAppointUIApi:GetString("RemoveTitleText"))
	UGUIUtil.SetTextInChildren(self.RemoveCancelBtn, GuildMemberAppointUIApi:GetString("RemoveCancelBtnLabel"))
	UGUIUtil.SetTextInChildren(self.RemoveSureBtn, GuildMemberAppointUIApi:GetString("RemoveSureBtnLabel"))

	function self.DelegateCancelBtn()
		self:OnCancelBtn()
	end

	function self.DelegateSureBtn()
		self:OnSureBtn()
	end
end

function m:AddListener()
	self.RemoveCancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateCancelBtn)
	self.RemoveSureBtn:GetComponent("Button").onClick:AddListener(self.DelegateSureBtn)
end

function m:RemoveListener()
	self.RemoveCancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCancelBtn)
	self.RemoveSureBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateSureBtn)
end

function m:OnCancelBtn()
	if self.callBackCloseUI then
		self.callBackCloseUI()
	end
end

function m:OnSureBtn()
	if self.memberData then
		GuildModule.RemoveMember(self.memberData.player.pid)
	end

	if self.callBackCloseUI then
		self.callBackCloseUI()
	end
end

function m:SetData(data)
	self.memberData = data

	UGUIUtil.SetText(self.RemoveContentText, GuildMemberAppointUIApi:GetString("RemoveContentText", self.memberData.player.pName))
end

function m:Open()
	self.View:SetActive(true)
	self:AddListener()
end

function m:Close()
	self.View:SetActive(false)
	self:RemoveListener()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.callBackCloseUI = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
