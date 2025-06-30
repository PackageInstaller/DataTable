-- chunkname: @IQIGame\\UI\\BattleWarningUI.lua

local BattleWarningUI = Base:Extend("BattleWarningUI", "IQIGame.Onigao.UI.BattleWarningUI", {})

function BattleWarningUI:OnInit()
	self.WarningTextPart1:GetComponent("TextMeshProUGUI").text = BattleWarningUIApi:GetString("WarningTextPart1")
	self.WarningTextPart2:GetComponent("TextMeshProUGUI").text = BattleWarningUIApi:GetString("WarningTextPart2")
end

function BattleWarningUI:GetPreloadAssetPaths()
	return nil
end

function BattleWarningUI:GetOpenPreloadAssetPaths(userData)
	local cfgMonsterData = self:GetBossCfgData()

	if cfgMonsterData == nil then
		logError("BattleWarningUI 怪物中找不到IsBoss配置为true的单位，或boss怪没有配置Drawing字段")

		return nil
	end

	return {
		UIGlobalApi.GetImagePath(cfgMonsterData.Drawing)
	}
end

function BattleWarningUI:OnOpen(userData)
	self:UpdateView()

	local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.BattleWarningUI, function()
		UIModule.Close(Constant.UIControllerName.BattleWarningUI)
	end, 2)

	timer:Start()
end

function BattleWarningUI:OnClose(userData)
	ModuleTimerUtil.Stop(Constant.UIControllerName.BattleWarningUI)
end

function BattleWarningUI:OnAddListeners()
	return
end

function BattleWarningUI:OnRemoveListeners()
	return
end

function BattleWarningUI:OnPause()
	return
end

function BattleWarningUI:OnResume()
	return
end

function BattleWarningUI:OnCover()
	return
end

function BattleWarningUI:OnReveal()
	return
end

function BattleWarningUI:OnRefocus(userData)
	return
end

function BattleWarningUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BattleWarningUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleWarningUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleWarningUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleWarningUI:OnDestroy()
	return
end

function BattleWarningUI:UpdateView()
	local cfgMonsterData = self:GetBossCfgData()

	if cfgMonsterData ~= nil then
		self.MonsterNameText:GetComponent("Text").text = cfgMonsterData.Name
		self.MonsterImage:GetComponent("Image").sprite = LuaCodeInterface.ToSprite(self.UIController:GetPreloadedAsset(UIGlobalApi.GetImagePath(cfgMonsterData.Drawing)))
	else
		logError("BattleWarningUI 怪物中找不到IsBoss配置为true的单位，或boss怪没有配置Drawing字段")
	end
end

function BattleWarningUI:GetBossCfgData()
	local defendTroopPodsUnitList = BattleModule.GetDefendTroopPodsTable()

	for i, v in pairs(defendTroopPodsUnitList) do
		local cfgMonsterData = CfgMonsterTable[v.MonsterCfgId]

		if cfgMonsterData.IsBoss == true and cfgMonsterData.Drawing ~= "" and cfgMonsterData.Drawing ~= nil then
			return cfgMonsterData
		end
	end

	return nil
end

return BattleWarningUI
