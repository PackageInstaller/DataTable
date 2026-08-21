-- chunkname: @IQIGame\\UI\\BattleRoundUI.lua

local BattleRoundUI = Base:Extend("BattleRoundUI", "IQIGame.Onigao.UI.BattleRoundUI", {})
local RoundBanner = require("IQIGame.UI.Battle.RoundBanner")

function BattleRoundUI:OnInit()
	function self.DelegateOnShowNewRoundUI()
		self:OnShowNewRoundUI()
	end

	local roundBannerView = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "_BattleUI/RushRoundUI")))

	roundBannerView.transform:SetParent(self.UIController.transform, false)

	self.RoundBanner = RoundBanner.New(roundBannerView)
end

function BattleRoundUI:GetPreloadAssetPaths()
	return {
		AssetPath.Get(GlobalKey.UIPrefabPath, "_BattleUI/RushRoundUI")
	}
end

function BattleRoundUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BattleRoundUI:OnOpen(userData)
	self.RoundBanner:Close()
end

function BattleRoundUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.BattleStartRound, self.DelegateOnShowNewRoundUI)
end

function BattleRoundUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.BattleStartRound, self.DelegateOnShowNewRoundUI)
end

function BattleRoundUI:OnShowNewRoundUI()
	if BattleModule.Round == 1 then
		self:ShowRoundUI()
	end
end

function BattleRoundUI:ShowRoundUI()
	self.RoundBanner:Play(false)
	GameEntry.Sound:PlaySound(10225, Constant.SoundGroup.UI)

	local dollPODs = BattleModule.GetAttackTroopPodsTable()

	for i = 1, #dollPODs do
		local dollPOD = dollPODs[i]
		local battleUnitData = BattleModule.GetBattleUnitData(dollPOD.ID)

		if not battleUnitData.IsDead then
			local cfgMonsterData = CfgMonsterTable[dollPOD.MonsterCfgId]

			if #cfgMonsterData.BattleStartSpeak > 0 then
				local index = math.random(1, #cfgMonsterData.BattleStartSpeak)

				GameEntry.Sound:PlaySound(cfgMonsterData.BattleStartSpeak[index], Constant.SoundGroup.CHARACTER)

				break
			end
		end
	end

	if self.DelayCloseTimer ~= nil then
		self.DelayCloseTimer:Stop()

		self.DelayCloseTimer = nil
	end

	self.DelayCloseTimer = Timer.New(function()
		self.DelayCloseTimer = nil

		self.RoundBanner:Close()
	end, Constant.Battle.BattleStartEffectPlayTime)

	self.DelayCloseTimer:Start()
end

function BattleRoundUI:OnClose(userData)
	if self.DelayCloseTimer ~= nil then
		self.DelayCloseTimer:Stop()

		self.DelayCloseTimer = nil
	end
end

function BattleRoundUI:OnPause()
	return
end

function BattleRoundUI:OnResume()
	return
end

function BattleRoundUI:OnCover()
	return
end

function BattleRoundUI:OnReveal()
	return
end

function BattleRoundUI:OnRefocus(userData)
	return
end

function BattleRoundUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BattleRoundUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleRoundUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleRoundUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleRoundUI:OnDestroy()
	self.RoundBanner:Dispose()
end

return BattleRoundUI
