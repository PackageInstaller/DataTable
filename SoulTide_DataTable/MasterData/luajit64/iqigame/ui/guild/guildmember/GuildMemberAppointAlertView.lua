-- chunkname: @IQIGame\\UI\\Guild\\GuildMember\\GuildMemberAppointAlertView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.AppointTitleText, GuildMemberAppointUIApi:GetString("AppointTitleText"))
	UGUIUtil.SetTextInChildren(self.AppointPresidentBtn, GuildMemberAppointUIApi:GetString("AppointPresidentBtnLabel"))
	UGUIUtil.SetTextInChildren(self.AppointVicePresidentBtn, GuildMemberAppointUIApi:GetString("AppointVicePresidentBtnLabel"))
	UGUIUtil.SetTextInChildren(self.AppointMemberBtn, GuildMemberAppointUIApi:GetString("AppointMemberBtnLabel"))

	function self.DelegateAppointPresidentBtn()
		self:OnAppointPresidentBtn()
	end

	function self.DelegateAppointVicePresidentBtn()
		self:OnAppointVicePresidentBtn()
	end

	function self.DelegateAppointMemberBtn()
		self:OnAppointMemberBtn()
	end
end

function m:AddListener()
	self.AppointPresidentBtn:GetComponent("Button").onClick:AddListener(self.DelegateAppointPresidentBtn)
	self.AppointVicePresidentBtn:GetComponent("Button").onClick:AddListener(self.DelegateAppointVicePresidentBtn)
	self.AppointMemberBtn:GetComponent("Button").onClick:AddListener(self.DelegateAppointMemberBtn)
end

function m:RemoveListener()
	self.AppointPresidentBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateAppointPresidentBtn)
	self.AppointVicePresidentBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateAppointVicePresidentBtn)
	self.AppointMemberBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateAppointMemberBtn)
end

function m:OnAppointPresidentBtn()
	NoticeModule.ShowNotice(21066605, function()
		self:AppointMemberPosition(Constant.GuildPosition.Guild_President)
	end, nil, self, self.memberData.player.pName)
end

function m:OnAppointVicePresidentBtn()
	self:AppointMemberPosition(Constant.GuildPosition.Guild_Vice_President)
end

function m:OnAppointMemberBtn()
	self:AppointMemberPosition(Constant.GuildPosition.Guild_Ordinary_Members)
end

function m:AppointMemberPosition(position)
	GuildModule.AppointPosition(self.memberData.player.pid, position)

	if self.callBackCloseUI then
		self.callBackCloseUI()
	end
end

function m:SetData(data)
	self.memberData = data

	self.AppointPresidentBtn:SetActive(self.memberData.position ~= Constant.GuildPosition.Guild_President)
	self.AppointVicePresidentBtn:SetActive(self.memberData.position ~= Constant.GuildPosition.Guild_Vice_President)
	self.AppointMemberBtn:SetActive(self.memberData.position ~= Constant.GuildPosition.Guild_Ordinary_Members)

	local vicePresidentNum = GuildModule.GetMembersCountByPosition(Constant.GuildPosition.Guild_Vice_President)
	local isFull = vicePresidentNum >= GuildModule.vicePresidentMaxNum

	self.AppointVicePresidentBtn:GetComponent("GrayComponent"):SetGray(isFull)

	self.AppointVicePresidentBtn:GetComponent("Button").interactable = not isFull

	UGUIUtil.SetText(self.AppointContentText, GuildMemberAppointUIApi:GetString("AppointContentText", self.memberData.player.pName))
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
