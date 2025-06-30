-- chunkname: @IQIGame\\UI\\GuildMainUI.lua

local GuildMainUI = {
	isHideUI = false,
	areaCellDic = {}
}

GuildMainUI = Base:Extend("GuildMainUI", "IQIGame.Onigao.UI.GuildMainUI", GuildMainUI)

require("IQIGame.UIExternalApi.GuildMainUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local GuildAreaCell = require("IQIGame.UI.Guild.GuildMain.GuildAreaCell")
local ChatBar = require("IQIGame.UI.Chat.ChatBar")
local GuildMainInfoView = require("IQIGame.UI.Guild.GuildMain.GuildMainInfoView")
local GuildTicketCell = require("IQIGame.UI.Guild.GuildTicketCell")

function GuildMainUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, GuildMainUIApi:GetString("TextTitle"))

	function self.DelegateOnClickBtnHideUI()
		self:OnClickBtnHideUI()
	end

	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateOnClickBtnGuide()
		self:OnClickBtnGuide()
	end

	function self.DelegateCameraChangePosEvent()
		self:OnCameraChangePosEvent()
	end

	function self.DelegateGuildUpdateEvent()
		self:OnGuildUpdateEvent()
	end

	function self.DelegateUpdateDailySupply()
		self:OnUpdateDailySupply()
	end

	function self.DelegateRedPointEvent()
		self:OnRedPointEvent()
	end

	function self.DelegateOnTaskUpdate()
		self:OnRedPointEvent()
	end

	function self.DelegateOnUpdateMissionEvent()
		self:OnRedPointEvent()
	end

	function self.DelegateOnTaskCommitResponse()
		self:OnRedPointEvent()
	end

	function self.DelegateGuildChallengeUpdateEvent()
		self:OnRedPointEvent()
	end

	function self.DelegateTrainingMemberEvent()
		self:OnRedPointEvent()
	end

	self.guildFoundTicket = GuildTicketCell.New(self.GuildFundTicket)
	self.guildPurchaseCouponsTicket = GuildTicketCell.New(self.GuildPurchaseCouponsTicket)
	self.chatBar = ChatBar.New(self.goChatBar)
	self.mainInfoView = GuildMainInfoView.New(self.GuildInfoView)

	self.AreaModule:SetActive(false)

	self.areaCellPool = UIObjectPool.New(10, function()
		local areaCell = GuildAreaCell.New(UnityEngine.Object.Instantiate(self.AreaModule))

		return areaCell
	end, function(cell)
		cell:Dispose()
	end)
end

function GuildMainUI:GetPreloadAssetPaths()
	return nil
end

function GuildMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildMainUI:IsManualShowOnOpen(userData)
	return false
end

function GuildMainUI:GetBGM(userData)
	return nil
end

function GuildMainUI:OnOpen(userData)
	self.isHideUI = false

	self:UpdateView()
	self.guildFoundTicket:RefreshData(Constant.ItemID.GUILD_FUNDS)
	self.guildPurchaseCouponsTicket:RefreshData(Constant.ItemID.GUILD_PURCHASE_COUPONS)
	self.chatBar:Refresh()
	self:ShowSate()
end

function GuildMainUI:OnClose(userData)
	self.chatBar:OnHide()
end

function GuildMainUI:OnAddListeners()
	self.BtnHideUI:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnHideUI)
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnGuide)
	EventDispatcher.AddEventListener(EventID.GuildCameraChangePosEvent, self.DelegateCameraChangePosEvent)
	EventDispatcher.AddEventListener(EventID.GuildUpdateEvent, self.DelegateGuildUpdateEvent)
	EventDispatcher.AddEventListener(EventID.UpdateDailySupply, self.DelegateUpdateDailySupply)
	EventDispatcher.AddEventListener(EventID.GuildUpdateRedPointEvent, self.DelegateRedPointEvent)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.AddEventListener(EventID.GuildUpdateMissionEvent, self.DelegateOnUpdateMissionEvent)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.AddEventListener(EventID.GuildChallengeUpdateEvent, self.DelegateGuildChallengeUpdateEvent)
	EventDispatcher.AddEventListener(EventID.GuildUpdateTrainingMemberEvent, self.DelegateTrainingMemberEvent)
end

function GuildMainUI:OnRemoveListeners()
	self.BtnHideUI:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnHideUI)
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnGuide)
	EventDispatcher.RemoveEventListener(EventID.GuildCameraChangePosEvent, self.DelegateCameraChangePosEvent)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateEvent, self.DelegateGuildUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailySupply, self.DelegateUpdateDailySupply)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateRedPointEvent, self.DelegateRedPointEvent)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateMissionEvent, self.DelegateOnUpdateMissionEvent)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.RemoveEventListener(EventID.GuildChallengeUpdateEvent, self.DelegateGuildChallengeUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateTrainingMemberEvent, self.DelegateTrainingMemberEvent)
end

function GuildMainUI:OnPause()
	return
end

function GuildMainUI:OnResume()
	return
end

function GuildMainUI:OnCover()
	return
end

function GuildMainUI:OnReveal()
	return
end

function GuildMainUI:OnRefocus(userData)
	return
end

function GuildMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildMainUI:OnDestroy()
	for i, v in pairs(self.areaCellDic) do
		self.areaCellPool:Release(v)
	end

	self.areaCellDic = {}

	self.areaCellPool:Dispose()
	self.chatBar:OnDestroy()
	self.mainInfoView:Dispose()
	self.guildFoundTicket:Dispose()

	self.guildFoundTicket = nil

	self.guildPurchaseCouponsTicket:Dispose()

	self.guildPurchaseCouponsTicket = nil
end

function GuildMainUI:OnClickBtnHideUI()
	self.isHideUI = not self.isHideUI

	self:ShowSate()
end

function GuildMainUI:ShowSate()
	self.Outer:SetActive(not self.isHideUI)
	self.Root:SetActive(not self.isHideUI)
end

function GuildMainUI:OnClickBtnBack()
	GuildModule.ExitGuild()
end

function GuildMainUI:OnClickBtnGuide()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 11000)
end

function GuildMainUI:OnGuildUpdateEvent()
	self.mainInfoView:UpdateView()
end

function GuildMainUI:OnUpdateDailySupply()
	self:UpdateView()
	self:OnRedPointEvent()
end

function GuildMainUI:UpdateView()
	self.mainInfoView:UpdateView()

	for i, v in pairs(self.areaCellDic) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.areaCellPool:Release(v)
	end

	self.areaCellDic = {}

	for k, v in pairs(GuildModule.guildAreaDic) do
		local areaCell = self.areaCellPool:Obtain()

		areaCell.View.transform:SetParent(self.AreaNode.transform, false)
		areaCell.View:SetActive(true)
		areaCell:SetData(v)
		areaCell:RefreshPos()
		table.insert(self.areaCellDic, areaCell)
	end
end

function GuildMainUI:OnRedPointEvent()
	for i, v in pairs(self.areaCellDic) do
		v:RefreshRedPoint()
	end
end

function GuildMainUI:OnCameraChangePosEvent()
	for i, v in pairs(self.areaCellDic) do
		v:RefreshPos()
	end
end

return GuildMainUI
