-- chunkname: @IQIGame\\UI\\GuildMemberManageUI.lua

local GuildMemberManageUI = {
	auditList = {},
	memberExamineCellPool = {}
}

GuildMemberManageUI = Base:Extend("GuildMemberManageUI", "IQIGame.Onigao.UI.GuildMemberManageUI", GuildMemberManageUI)

require("IQIGame.UIExternalApi.GuildMemberManageUIApi")

local GuildMemberExamineCell = require("IQIGame.UI.Guild.GuildMember.GuildMemberExamineCell")

function GuildMemberManageUI:OnInit()
	UGUIUtil.SetText(self.TitleText, GuildMemberManageUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.NoneText, GuildMemberManageUIApi:GetString("NoneText"))
	UGUIUtil.SetText(self.NoneTipText, GuildMemberManageUIApi:GetString("NoneTipText"))
	UGUIUtil.SetTextInChildren(self.CloseBtn, GuildMemberManageUIApi:GetString("CloseBtnLabel"))
	UGUIUtil.SetTextInChildren(self.AllRefuseBtn, GuildMemberManageUIApi:GetString("AllRefuseBtnLabel"))

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end

	function self.DelegateAllRefuseBtn()
		self:OnAllRefuseBtn()
	end

	function self.DelegateOnCloseBtn()
		self:OnCloseBtn()
	end

	function self.DelegateUpdateAuditList()
		self:OnUpdateAuditList()
	end

	function self.DelegateOnPlayerHeadFrameLoaded()
		self:OnPlayerHeadFrameLoaded()
	end
end

function GuildMemberManageUI:GetPreloadAssetPaths()
	return nil
end

function GuildMemberManageUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildMemberManageUI:IsManualShowOnOpen(userData)
	return false
end

function GuildMemberManageUI:GetBGM(userData)
	return nil
end

function GuildMemberManageUI:OnOpen(userData)
	self:UpdateView()
end

function GuildMemberManageUI:OnClose(userData)
	return
end

function GuildMemberManageUI:OnAddListeners()
	self.AllRefuseBtn:GetComponent("Button").onClick:AddListener(self.DelegateAllRefuseBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCloseBtn)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnCloseBtn)
	EventDispatcher.AddEventListener(EventID.GuildUpdateAuditList, self.DelegateUpdateAuditList)
	EventDispatcher.AddEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
end

function GuildMemberManageUI:OnRemoveListeners()
	self.AllRefuseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateAllRefuseBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseBtn)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateAuditList, self.DelegateUpdateAuditList)
	EventDispatcher.RemoveEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
end

function GuildMemberManageUI:OnPause()
	return
end

function GuildMemberManageUI:OnResume()
	return
end

function GuildMemberManageUI:OnCover()
	return
end

function GuildMemberManageUI:OnReveal()
	return
end

function GuildMemberManageUI:OnRefocus(userData)
	return
end

function GuildMemberManageUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildMemberManageUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildMemberManageUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildMemberManageUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildMemberManageUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.memberExamineCellPool) do
		v:Dispose()
	end
end

function GuildMemberManageUI:OnCloseBtn()
	UIModule.CloseSelf(self)
end

function GuildMemberManageUI:OnAllRefuseBtn()
	local pidTab = {}

	for i, v in pairs(self.auditList) do
		table.insert(pidTab, v.player.pid)
	end

	if #pidTab > 0 then
		GuildModule.RefuseApply(pidTab)
	end
end

function GuildMemberManageUI:OnRenderCell(cell)
	local auditData = self.auditList[cell.index + 1]

	if auditData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local memberExamineCell = self.memberExamineCellPool[instanceID]

	if memberExamineCell == nil then
		memberExamineCell = GuildMemberExamineCell.New(cell.gameObject)
		self.memberExamineCellPool[instanceID] = memberExamineCell
	end

	memberExamineCell:SetData(auditData)
end

function GuildMemberManageUI:OnUpdateAuditList()
	self:UpdateView()
end

function GuildMemberManageUI:UpdateView()
	self.auditList = GuildModule.auditList

	table.sort(self.auditList, function(a, b)
		return a.player.pLv > b.player.pLv
	end)

	local maxNum = CfgDiscreteDataTable[6520091].Data[3]

	UGUIUtil.SetText(self.NumText, GuildMemberManageUIApi:GetString("NumText", #GuildModule.auditList, maxNum))

	local isHaveData = #self.auditList > 0

	self.ScrollArea:SetActive(isHaveData)
	self.EmptyView:SetActive(not isHaveData)
	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.auditList)
end

function GuildMemberManageUI:OnPlayerHeadFrameLoaded()
	local mask = self.ScrollArea:GetComponent(typeof(UnityEngine.UI.RectMask3D))

	mask:SetDirtyTarget()
end

return GuildMemberManageUI
