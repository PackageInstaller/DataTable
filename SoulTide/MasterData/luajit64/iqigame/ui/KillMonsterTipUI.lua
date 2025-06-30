-- chunkname: @IQIGame\\UI\\KillMonsterTipUI.lua

local KillMonsterTipUI = Base:Extend("KillMonsterTipUI", "IQIGame.Onigao.UI.KillMonsterTipUI", {})

function KillMonsterTipUI:OnInit()
	UGUIUtil.SetText(self.TextKillRank, ChallengeWorldBossDetailUIApi:GetString("TextKillRank"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end
end

function KillMonsterTipUI:GetPreloadAssetPaths()
	return nil
end

function KillMonsterTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function KillMonsterTipUI:IsManualShowOnOpen(userData)
	return false
end

function KillMonsterTipUI:GetBGM(userData)
	return nil
end

function KillMonsterTipUI:OnOpen(userData)
	self.cfgWorldBoss = userData

	self:UpDateView()
end

function KillMonsterTipUI:OnClose(userData)
	return
end

function KillMonsterTipUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function KillMonsterTipUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function KillMonsterTipUI:OnPause()
	return
end

function KillMonsterTipUI:OnResume()
	return
end

function KillMonsterTipUI:OnCover()
	return
end

function KillMonsterTipUI:OnReveal()
	return
end

function KillMonsterTipUI:OnRefocus(userData)
	return
end

function KillMonsterTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function KillMonsterTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function KillMonsterTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function KillMonsterTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function KillMonsterTipUI:OnDestroy()
	return
end

function KillMonsterTipUI:UpDateView()
	if self.cfgWorldBoss then
		self.RewardMould:SetActive(false)

		for i = 1, self.SortReward.transform.childCount - 1 do
			local obj = self.SortReward.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		for i = 1, #self.cfgWorldBoss.KillReward, 2 do
			local itemId = self.cfgWorldBoss.KillReward[i]
			local itemNum = self.cfgWorldBoss.KillReward[i + 1]
			local obj = UnityEngine.Object.Instantiate(self.RewardMould)

			obj.transform:SetParent(self.SortReward.transform, false)
			obj:SetActive(true)

			local itemCell = ItemCell.PackageOrReuseView(self, obj.transform:GetChild(0).gameObject)

			itemCell:SetItem(CfgItemTable[itemId])
			itemCell:SetNum(itemNum)
		end
	end
end

function KillMonsterTipUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.KillMonsterTipUI)
end

return KillMonsterTipUI
