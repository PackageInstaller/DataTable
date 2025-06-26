-- chunkname: @IQIGame\\UI\\GuildDevelopBuyEffectUI.lua

local GuildDevelopBuyEffectUI = {
	isFunds = false,
	maxDays = 0,
	effectEndTime = 0
}

GuildDevelopBuyEffectUI = Base:Extend("GuildDevelopBuyEffectUI", "IQIGame.Onigao.UI.GuildDevelopBuyEffectUI", GuildDevelopBuyEffectUI)

require("IQIGame.UIExternalApi.GuildDevelopBuyEffectUIApi")

function GuildDevelopBuyEffectUI:OnInit()
	UGUIUtil.SetText(self.TextTip, GuildDevelopBuyEffectUIApi:GetString("TextTip"))
	UGUIUtil.SetTextInChildren(self.BuyEffectBtn, GuildDevelopBuyEffectUIApi:GetString("BuyEffectBtn"))

	function self.DelegateOnBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateOnBuyEffectBtn()
		self:OnBuyEffect()
	end

	function self.DelegateGuildUpdateBuilding()
		self:OnGuildUpdateBuilding()
	end
end

function GuildDevelopBuyEffectUI:GetPreloadAssetPaths()
	return nil
end

function GuildDevelopBuyEffectUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildDevelopBuyEffectUI:IsManualShowOnOpen(userData)
	return false
end

function GuildDevelopBuyEffectUI:GetBGM(userData)
	return nil
end

function GuildDevelopBuyEffectUI:OnOpen(userData)
	self.buildCid = userData
	self.timer = Timer.New(function()
		self:ShowCD()
	end, 1, -1)

	self:UpdateView()
end

function GuildDevelopBuyEffectUI:OnClose(userData)
	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil
end

function GuildDevelopBuyEffectUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose)
	self.BuyEffectBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnBuyEffectBtn)
	EventDispatcher.AddEventListener(EventID.GuildUpdateBuildingEvent, self.DelegateGuildUpdateBuilding)
end

function GuildDevelopBuyEffectUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose)
	self.BuyEffectBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBuyEffectBtn)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateBuildingEvent, self.DelegateGuildUpdateBuilding)
end

function GuildDevelopBuyEffectUI:OnPause()
	return
end

function GuildDevelopBuyEffectUI:OnResume()
	return
end

function GuildDevelopBuyEffectUI:OnCover()
	return
end

function GuildDevelopBuyEffectUI:OnReveal()
	return
end

function GuildDevelopBuyEffectUI:OnRefocus(userData)
	return
end

function GuildDevelopBuyEffectUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildDevelopBuyEffectUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildDevelopBuyEffectUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildDevelopBuyEffectUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildDevelopBuyEffectUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function GuildDevelopBuyEffectUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function GuildDevelopBuyEffectUI:OnBuyEffect()
	if not self.isFunds then
		return
	end

	local cd = self.effectEndTime - PlayerModule.GetServerTime()

	if self.maxDays > 0 and cd > self.maxDays * 24 * 3600 then
		NoticeModule.ShowNotice(21066504)

		return
	end

	GuildModule.BuyBuildingEffect(self.buildCid)
end

function GuildDevelopBuyEffectUI:OnGuildUpdateBuilding()
	self:UpdateView()
end

function GuildDevelopBuyEffectUI:UpdateView()
	self.timer:Stop()

	self.maxDays = 0

	if self.buildCid then
		local buildLv, buildMaxLv = GuildModule.GetBuildingLevel(self.buildCid)
		local cfgGuildBuildingLevelUpData = GuildModule.GetBuildingLevelData(self.buildCid, buildLv)
		local cfgGuildBuildingData = CfgGuildBuildingTable[self.buildCid]

		UGUIUtil.SetText(self.TextTitle, cfgGuildBuildingData.Name)

		local path = UIGlobalApi.GetImagePath(cfgGuildBuildingData.Url)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.TextContent, cfgGuildBuildingLevelUpData.TimeLimitEffect)

		self.isFunds = GuildModule.guildPOD.fund >= cfgGuildBuildingLevelUpData.TimeLimitEffectCost

		UGUIUtil.SetText(self.TextCostName, GuildDevelopBuyEffectUIApi:GetString("TextCostName", CfgItemTable[Constant.ItemID.GUILD_FUNDS].Name, self.isFunds))
		UGUIUtil.SetText(self.TextCostNum, GuildDevelopBuyEffectUIApi:GetString("TextCostNum", GuildModule.guildPOD.fund, cfgGuildBuildingLevelUpData.TimeLimitEffectCost, self.isFunds))

		local buildData = GuildModule.GetBuildingData(self.buildCid)

		if buildData then
			self.effectEndTime = buildData.buyEffectExpTime
		end

		local cd = self.effectEndTime - PlayerModule.GetServerTime()

		if cd < 0 then
			UGUIUtil.SetText(self.TextEffectState, GuildDevelopBuyEffectUIApi:GetString("TextEffectState", false))
			self.TextEffectTime:SetActive(false)
		else
			self:ShowCD()
			self.timer:Start()
		end

		if cfgGuildBuildingLevelUpData.TimeLimitEffectType > 0 then
			self.maxDays = CfgGuildEffectTypeTable[cfgGuildBuildingLevelUpData.TimeLimitEffectType].MaxDays
		end
	end
end

function GuildDevelopBuyEffectUI:ShowCD()
	local ratingTime = self.effectEndTime - PlayerModule.GetServerTime()

	if ratingTime > 0 then
		self.TextEffectTime:SetActive(true)

		local elapsedTimeStr = ""

		if ratingTime >= 86400 then
			elapsedTimeStr = getTimeDurationText(ratingTime, 1)
		elseif ratingTime >= 3600 then
			elapsedTimeStr = getTimeDurationText(ratingTime, 2)
		else
			elapsedTimeStr = getTimeDurationText(ratingTime, 3)
		end

		UGUIUtil.SetText(self.TextEffectState, GuildDevelopBuyEffectUIApi:GetString("TextEffectState", true))
		UGUIUtil.SetText(self.TextEffectTime, GuildDevelopBuyEffectUIApi:GetString("TextEffectTime", elapsedTimeStr))
	else
		self.timer:Stop()
		self.TextEffectTime:SetActive(false)
		UGUIUtil.SetText(self.TextEffectState, GuildDevelopBuyEffectUIApi:GetString("TextEffectState", false))
	end
end

return GuildDevelopBuyEffectUI
