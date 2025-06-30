-- chunkname: @IQIGame\\UI\\Guild\\GuildMain\\GuildMainInfoView.lua

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

	self.guildHeadCell = GuildHeadCell.New(self.GuildHead)

	function self.DelegateBtnSetting()
		self:OnBtnSetting()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnSetting:GetComponent("Button").onClick:AddListener(self.DelegateBtnSetting)
end

function m:RemoveListener()
	self.BtnSetting:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSetting)
end

function m:OnBtnSetting()
	UIModule.Open(Constant.UIControllerName.GuildEditUI, Constant.UILayer.UI)
end

function m:UpdateView()
	if not GuildModule.guildPOD then
		return
	end

	UGUIUtil.SetText(self.GuildName, GuildModule.guildPOD.base.name)
	UGUIUtil.SetText(self.GuildLv, GuildMainUIApi:GetString("GuildLv", GuildModule.guildPOD.base.level))
	UGUIUtil.SetText(self.GuildID, GuildMainUIApi:GetString("GuildID", GuildModule.guildPOD.base.id))
	UGUIUtil.SetText(self.GuildMembers, GuildMainUIApi:GetString("GuildMembers", GuildModule.guildPOD.base.memberNum, GuildModule.guildPOD.base.memberMaxNum))
	UGUIUtil.SetText(self.GuildType, GuildMainUIApi:GetString("GuildType", GuildModule.guildPOD.base.auditType))
	self.guildHeadCell:SetData(GuildModule.guildPOD.base.headIcon, GuildModule.guildPOD.base.avatarFrame, GuildModule.guildPOD.base.level)
end

function m:Dispose()
	self:RemoveListener()
	self.guildHeadCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
