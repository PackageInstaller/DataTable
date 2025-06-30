-- chunkname: @IQIGame\\UI\\GuildActiveRewardUI.lua

local GuildActiveRewardUI = {
	guildRewardCells = {},
	guildRewardDataTab = {}
}

GuildActiveRewardUI = Base:Extend("GuildActiveRewardUI", "IQIGame.Onigao.UI.GuildActiveRewardUI", GuildActiveRewardUI)

require("IQIGame.UIExternalApi.GuildActiveRewardUIApi")

local GuildActiveRewardCell = require("IQIGame.UI.Guild.GuildTask.GuildActiveRewardCell")

function GuildActiveRewardUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, GuildActiveRewardUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextBottom, GuildActiveRewardUIApi:GetString("TextBottom"))

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnUpdateMissionEvent()
		self:OnUpdateMissionEvent()
	end

	function self.DelegateUpdateDailySupply()
		self:OnUpdateDailySupply()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderRewardCell(cell)
	end
	self.guildRewardDataTab = {}

	for i, v in pairsCfg(CfgGuildActiveRewardTable) do
		table.insert(self.guildRewardDataTab, v)
	end

	table.sort(self.guildRewardDataTab, function(a, b)
		return a.Level > b.Level
	end)

	self.currentRewardCell = GuildActiveRewardCell.New(self.CurrentMould, true)
end

function GuildActiveRewardUI:GetPreloadAssetPaths()
	return nil
end

function GuildActiveRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildActiveRewardUI:IsManualShowOnOpen(userData)
	return false
end

function GuildActiveRewardUI:GetBGM(userData)
	return nil
end

function GuildActiveRewardUI:OnOpen(userData)
	self:UpdateView()
end

function GuildActiveRewardUI:OnClose(userData)
	return
end

function GuildActiveRewardUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.GuildUpdateMissionEvent, self.DelegateOnUpdateMissionEvent)
	EventDispatcher.AddEventListener(EventID.UpdateDailySupply, self.DelegateUpdateDailySupply)
end

function GuildActiveRewardUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateMissionEvent, self.DelegateOnUpdateMissionEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailySupply, self.DelegateUpdateDailySupply)
end

function GuildActiveRewardUI:OnPause()
	return
end

function GuildActiveRewardUI:OnResume()
	return
end

function GuildActiveRewardUI:OnCover()
	return
end

function GuildActiveRewardUI:OnReveal()
	return
end

function GuildActiveRewardUI:OnRefocus(userData)
	return
end

function GuildActiveRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildActiveRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildActiveRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildActiveRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildActiveRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for gameObject, item in pairs(self.guildRewardCells) do
		item:Dispose()
	end

	self.currentRewardCell:Dispose()
end

function GuildActiveRewardUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function GuildActiveRewardUI:OnUpdateMissionEvent()
	self:UpdateView()
end

function GuildActiveRewardUI:OnUpdateDailySupply()
	self:UpdateView()
end

function GuildActiveRewardUI:UpdateView()
	self.currentRewardData = nil

	for i = 1, #self.guildRewardDataTab do
		local data = self.guildRewardDataTab[i]

		if GuildModule.guildTaskPoints >= data.LevelNeed then
			self.currentRewardData = data

			break
		end
	end

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.guildRewardDataTab)
	self.currentRewardCell:SetData(self.currentRewardData)
end

function GuildActiveRewardUI:OnRenderRewardCell(cell)
	local item = self.guildRewardCells[cell.gameObject:GetInstanceID()]

	if item == nil then
		item = GuildActiveRewardCell.New(cell.gameObject, false)
		self.guildRewardCells[cell.gameObject:GetInstanceID()] = item
	end

	item:SetData(self.guildRewardDataTab[cell.index + 1])
end

return GuildActiveRewardUI
