-- chunkname: @IQIGame\\UI\\Guild\\GuildIntroduce\\GuildRecommendRenderCell.lua

local m = {}
local GuildHeadCell = require("IQIGame.UI.Guild.GuildMain.GuildHeadCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateApplyBtn()
		self:OnApplyBtn()
	end

	UGUIUtil.SetTextInChildren(self.ApplyBtn, GuildIntroduceUIApi:GetString("ApplyBtn"))
	UGUIUtil.SetText(self.ApplyText, GuildIntroduceUIApi:GetString("ApplyText"))
	UGUIUtil.SetText(self.TextLV, GuildIntroduceUIApi:GetString("TextLV"))

	self.guildHeadCell = GuildHeadCell.New(self.GuildHeadCell)

	self:AddListener()
end

function m:AddListener()
	self.ApplyBtn:GetComponent("Button").onClick:AddListener(self.DelegateApplyBtn)
end

function m:RemoveListener()
	self.ApplyBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateApplyBtn)
end

function m:SetData(data)
	self.guildData = data

	self:UpdateView()
end

function m:UpdateView()
	UGUIUtil.SetText(self.GuildName, self.guildData.name)
	UGUIUtil.SetText(self.GuildLv, GuildIntroduceUIApi:GetString("GuildLv", self.guildData.level))
	UGUIUtil.SetText(self.GuildPresident, GuildIntroduceUIApi:GetString("GuildPresident", self.guildData.leaderName))
	UGUIUtil.SetText(self.GuildAuditType, GuildIntroduceUIApi:GetString("GuildAuditType", self.guildData.auditType))
	UGUIUtil.SetText(self.GuildMembers, GuildIntroduceUIApi:GetString("GuildMembers", self.guildData.memberNum, self.guildData.memberMaxNum))
	UGUIUtil.SetText(self.GuildActivityPolicy, GuildIntroduceUIApi:GetString("GuildActivityPolicy", self.guildData.policy))

	local avatarFrame = self.guildData.avatarFrame

	if avatarFrame == 0 then
		avatarFrame = GuildModule.GetGuildDefaultAvatarFrame()
	end

	local headIcon = self.guildData.headIcon

	if headIcon == 0 then
		headIcon = GuildModule.GetGuildDefaultHeadIcon()
	end

	self.guildHeadCell:SetData(headIcon, avatarFrame)

	local isApply = GuildModule.CheckIsApply(self.guildData.id)

	self.ApplyBtn:SetActive(not isApply)
	self.Requested:SetActive(isApply)
end

function m:OnApplyBtn()
	if self.guildData.memberNum >= self.guildData.memberMaxNum then
		NoticeModule.ShowNotice(21066606)

		return
	end

	GuildModule.ApplyGuild(self.guildData.id)
end

function m:Dispose()
	self.guildHeadCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
