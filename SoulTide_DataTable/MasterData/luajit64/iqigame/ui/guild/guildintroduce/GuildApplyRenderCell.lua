-- chunkname: @IQIGame\\UI\\Guild\\GuildIntroduce\\GuildApplyRenderCell.lua

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
	UGUIUtil.SetTextInChildren(self.BtnCancel, GuildIntroduceUIApi:GetString("ApplyBtnCancel"))

	function self.delegateBtnCancel()
		self:OnBtnCancel()
	end

	self.guildHeadCell = GuildHeadCell.New(self.GuildHeadCell)

	self:AddListener()
end

function m:AddListener()
	self.BtnCancel:GetComponent("Button").onClick:AddListener(self.delegateBtnCancel)
end

function m:RemoveListener()
	self.BtnCancel:GetComponent("Button").onClick:RemoveListener(self.delegateBtnCancel)
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
end

function m:OnBtnCancel()
	GuildModule.CancelApplyGuild(self.guildData.id)
end

function m:Dispose()
	self.guildHeadCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
