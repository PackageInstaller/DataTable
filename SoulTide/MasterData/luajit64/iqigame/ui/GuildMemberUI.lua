-- chunkname: @IQIGame\\UI\\GuildMemberUI.lua

local GuildMemberUI = {
	memberCellPool = {},
	members = {}
}

GuildMemberUI = Base:Extend("GuildMemberUI", "IQIGame.Onigao.UI.GuildMemberUI", GuildMemberUI)

require("IQIGame.UIExternalApi.GuildMemberUIApi")

local GuildMemberCell = require("IQIGame.UI.Guild.GuildMember.GuildMemberCell")

function GuildMemberUI:OnInit()
	UGUIUtil.SetText(self.TitleText, GuildMemberUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.CloseBtn, GuildMemberUIApi:GetString("CloseBtnLabel"))
	UGUIUtil.SetTextInChildren(self.ExamineBtn, GuildMemberUIApi:GetString("ExamineBtnLabel"))

	self.ContentGrid:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end

	function self.DelegateOnCloseBtn()
		self:OnCloseBtn()
	end

	function self.DelegateUpdateGuildAuditList()
		self:OnUpdateGuildAuditList()
	end

	function self.DelegateExamineBtn()
		self:OnExamineBtn()
	end

	function self.DelegateQuitGuildBtn()
		self:OnQuitGuildBtn()
	end

	function self.DelegateUpdateMembersEvent()
		self:OnUpdateMembersEvent()
	end

	function self.DelegateGuildUpdateEvent()
		self:OnGuildUpdateEvent()
	end

	function self.DelegateOnPlayerHeadFrameLoaded()
		self:OnPlayerHeadFrameLoaded()
	end
end

function GuildMemberUI:GetPreloadAssetPaths()
	return nil
end

function GuildMemberUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildMemberUI:IsManualShowOnOpen(userData)
	return false
end

function GuildMemberUI:GetBGM(userData)
	return nil
end

function GuildMemberUI:OnOpen(userData)
	self:UpdateView()
end

function GuildMemberUI:OnClose(userData)
	return
end

function GuildMemberUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCloseBtn)
	self.ExamineBtn:GetComponent("Button").onClick:AddListener(self.DelegateExamineBtn)
	self.QuitGuildBtn:GetComponent("Button").onClick:AddListener(self.DelegateQuitGuildBtn)
	EventDispatcher.AddEventListener(EventID.GuildUpdateAuditList, self.DelegateUpdateGuildAuditList)
	EventDispatcher.AddEventListener(EventID.GuildUpdateMembersEvent, self.DelegateUpdateMembersEvent)
	EventDispatcher.AddEventListener(EventID.GuildUpdateEvent, self.DelegateGuildUpdateEvent)
	EventDispatcher.AddEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
end

function GuildMemberUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseBtn)
	self.ExamineBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateExamineBtn)
	self.QuitGuildBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateQuitGuildBtn)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateAuditList, self.DelegateUpdateGuildAuditList)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateMembersEvent, self.DelegateUpdateMembersEvent)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateEvent, self.DelegateGuildUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
end

function GuildMemberUI:OnPause()
	return
end

function GuildMemberUI:OnResume()
	return
end

function GuildMemberUI:OnCover()
	return
end

function GuildMemberUI:OnReveal()
	return
end

function GuildMemberUI:OnRefocus(userData)
	return
end

function GuildMemberUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildMemberUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildMemberUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildMemberUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildMemberUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.memberCellPool) do
		v:Dispose()
	end
end

function GuildMemberUI:OnCloseBtn()
	UIModule.CloseSelf(self)
end

function GuildMemberUI:OnRenderGridCell(cell)
	local memberData = self.members[cell.index + 1]

	if memberData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local insID = cell.gameObject:GetInstanceID()
	local memberCell = self.memberCellPool[insID]

	if memberCell == nil then
		memberCell = GuildMemberCell.New(cell.gameObject)
		self.memberCellPool[insID] = memberCell
	end

	memberCell:SetData(memberData, self.myMemberData)
end

function GuildMemberUI:UpdateView()
	self.members = GuildModule.guildPOD.members

	table.sort(self.members, function(a, b)
		if a.position == b.position then
			return a.activeNum > b.activeNum
		end

		return a.position > b.position
	end)

	self.myMemberData = GuildModule.GetMySelfGuildMemberData()

	local isLeader = self.myMemberData.position == Constant.GuildPosition.Guild_President or self.myMemberData.position == Constant.GuildPosition.Guild_Vice_President

	self.ExamineBtn:SetActive(isLeader)

	if isLeader then
		GuildModule.GetAuditList()
	end

	self.ContentGrid:GetComponent("ScrollAreaList"):Refresh(#self.members)
	self:RefreshMemberCount()
end

function GuildMemberUI:RefreshMemberCount()
	UGUIUtil.SetText(self.NumText, GuildMemberUIApi:GetString("NumText", GuildModule.guildPOD.base.memberNum, GuildModule.guildPOD.base.memberMaxNum))
	UGUIUtil.SetTextInChildren(self.QuitGuildBtn, GuildMemberUIApi:GetString("QuitGuildBtnLabel", GuildModule.guildPOD.base.memberNum))
end

function GuildMemberUI:OnUpdateGuildAuditList()
	local isRed = GuildModule.auditList and #GuildModule.auditList > 0

	self.ExamineTag:SetActive(isRed)
end

function GuildMemberUI:OnExamineBtn()
	UIModule.Open(Constant.UIControllerName.GuildMemberManageUI, Constant.UILayer.UI)
end

function GuildMemberUI:OnQuitGuildBtn()
	if GuildModule.guildPOD.base.memberNum > 1 then
		NoticeModule.ShowNotice(21066608, function()
			GuildModule.Quit()
		end, nil)
	else
		NoticeModule.ShowNotice(21066710, function()
			if GuildModule.guildPOD.base.memberNum == 1 then
				GuildModule.Quit()
			else
				NoticeModule.ShowNotice(21066711)
			end
		end, nil)
	end
end

function GuildMemberUI:OnUpdateMembersEvent()
	self:UpdateView()
end

function GuildMemberUI:OnGuildUpdateEvent()
	self:RefreshMemberCount()
end

function GuildMemberUI:OnPlayerHeadFrameLoaded()
	local mask = self.ContentGrid:GetComponent(typeof(UnityEngine.UI.RectMask3D))

	mask:SetDirtyTarget()
end

return GuildMemberUI
