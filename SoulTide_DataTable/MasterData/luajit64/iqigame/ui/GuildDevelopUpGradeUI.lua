-- chunkname: @IQIGame\\UI\\GuildDevelopUpGradeUI.lua

local GuildDevelopUpGradeUI = {
	isFunds = false,
	isCondition = false
}

GuildDevelopUpGradeUI = Base:Extend("GuildDevelopUpGradeUI", "IQIGame.Onigao.UI.GuildDevelopUpGradeUI", GuildDevelopUpGradeUI)

require("IQIGame.UIExternalApi.GuildDevelopUpGradeUIApi")

function GuildDevelopUpGradeUI:OnInit()
	UGUIUtil.SetText(self.TextTip, GuildDevelopUpGradeUIApi:GetString("TextTip"))
	UGUIUtil.SetTextInChildren(self.UpdateBtn, GuildDevelopUpGradeUIApi:GetString("UpdateBtnLabel"))
	UGUIUtil.SetText(self.TextMax, GuildDevelopUpGradeUIApi:GetString("TextMax"))

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateUpdateBtn()
		self:OnBtnUpdate()
	end

	function self.DelegateGuildUpdateBuilding()
		self:OnGuildUpdateBuilding()
	end
end

function GuildDevelopUpGradeUI:GetPreloadAssetPaths()
	return nil
end

function GuildDevelopUpGradeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildDevelopUpGradeUI:IsManualShowOnOpen(userData)
	return false
end

function GuildDevelopUpGradeUI:GetBGM(userData)
	return nil
end

function GuildDevelopUpGradeUI:OnOpen(userData)
	self.buildCid = userData

	self:UpdateView()
end

function GuildDevelopUpGradeUI:OnClose(userData)
	return
end

function GuildDevelopUpGradeUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.UpdateBtn:GetComponent("Button").onClick:AddListener(self.DelegateUpdateBtn)
	EventDispatcher.AddEventListener(EventID.GuildUpdateBuildingEvent, self.DelegateGuildUpdateBuilding)
end

function GuildDevelopUpGradeUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.UpdateBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateUpdateBtn)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateBuildingEvent, self.DelegateGuildUpdateBuilding)
end

function GuildDevelopUpGradeUI:OnPause()
	return
end

function GuildDevelopUpGradeUI:OnResume()
	return
end

function GuildDevelopUpGradeUI:OnCover()
	return
end

function GuildDevelopUpGradeUI:OnReveal()
	return
end

function GuildDevelopUpGradeUI:OnRefocus(userData)
	return
end

function GuildDevelopUpGradeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildDevelopUpGradeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildDevelopUpGradeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildDevelopUpGradeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildDevelopUpGradeUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function GuildDevelopUpGradeUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function GuildDevelopUpGradeUI:OnBtnUpdate()
	if not self.isCondition then
		NoticeModule.ShowNotice(21066502)

		return
	end

	if not self.isFunds then
		NoticeModule.ShowNotice(21047002)

		return
	end

	GuildModule.UpBuildingLevel(self.buildCid)
end

function GuildDevelopUpGradeUI:OnGuildUpdateBuilding()
	self:UpdateView()
end

function GuildDevelopUpGradeUI:UpdateView()
	if self.buildCid then
		local buildLv, buildMaxLv = GuildModule.GetBuildingLevel(self.buildCid)
		local nextBuildLv = buildLv + 1

		if buildMaxLv < nextBuildLv then
			nextBuildLv = buildMaxLv
		end

		local cfgGuildBuildingLevelUpData = GuildModule.GetBuildingLevelData(self.buildCid, buildLv)
		local cfgNextBuildLevelUpdate = GuildModule.GetBuildingLevelData(self.buildCid, nextBuildLv)
		local cfgGuildBuildingData = CfgGuildBuildingTable[self.buildCid]

		UGUIUtil.SetText(self.TextTitle, cfgGuildBuildingData.Name)
		UGUIUtil.SetText(self.TextLevel, GuildDevelopUpGradeUIApi:GetString("TextLevel", buildLv, buildMaxLv))

		local path = UIGlobalApi.GetImagePath(cfgGuildBuildingData.Url)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.TextContent, cfgGuildBuildingLevelUpData.LevelUpEffect)

		self.isCondition = true

		for i = 1, #cfgNextBuildLevelUpdate.NeedBuildingLv, 2 do
			local buildID = cfgNextBuildLevelUpdate.NeedBuildingLv[i]
			local needLv = cfgNextBuildLevelUpdate.NeedBuildingLv[i + 1]
			local lv, maxLv = GuildModule.GetBuildingLevel(buildID)

			if self.isCondition then
				self.isCondition = needLv <= lv
			end
		end

		UGUIUtil.SetText(self.TextCondition, GuildDevelopUpGradeUIApi:GetString("TextCondition", cfgGuildBuildingLevelUpData.LockDesc, self.isCondition))

		self.isFunds = GuildModule.guildPOD.fund >= cfgNextBuildLevelUpdate.Cost

		UGUIUtil.SetText(self.TextCostName, GuildDevelopUpGradeUIApi:GetString("TextCostName", CfgItemTable[Constant.ItemID.GUILD_FUNDS].Name, self.isFunds))
		UGUIUtil.SetText(self.TextCostNum, GuildDevelopUpGradeUIApi:GetString("TextCostNum", GuildModule.guildPOD.fund, cfgNextBuildLevelUpdate.Cost, self.isFunds))
		self.UpdateBtn:SetActive(buildLv < buildMaxLv)
		self.ConditionNode:SetActive(buildLv < buildMaxLv)
		self.CostNode:SetActive(buildLv < buildMaxLv)
		self.MaxNode:SetActive(buildMaxLv <= buildLv)
	end

	local myMemberData = GuildModule.GetMySelfGuildMemberData()

	if myMemberData.position == Constant.GuildPosition.Guild_Ordinary_Members then
		self.UpdateBtn:SetActive(false)
		self.ConditionNode:SetActive(false)
		self.CostNode:SetActive(false)
		self.MaxNode:SetActive(false)
	end
end

return GuildDevelopUpGradeUI
