-- chunkname: @IQIGame\\UI\\ChallengeWorldBossTipsUI.lua

local ChallengeWorldBossTipsUI = Base:Extend("ChallengeWorldBossTipsUI", "IQIGame.Onigao.UI.ChallengeWorldBossTipsUI", {
	MonsterHeadCells = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterHeadCell = require("IQIGame.UI.Common.MonsterHeadCell")

function ChallengeWorldBossTipsUI:OnInit()
	UGUIUtil.SetText(self.TextBossTipTitle1, ChallengeWorldBossTipUIApi:GetString("TextBossTipTitle1"))

	self.MonsterHeadCellPool = UIObjectPool.New(10, function()
		return MonsterHeadCell.__New(UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetMonsterHeadCellAssetPath())))
	end, function(cell)
		cell:Dispose()
	end)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end
end

function ChallengeWorldBossTipsUI:GetPreloadAssetPaths()
	return nil
end

function ChallengeWorldBossTipsUI:GetOpenPreloadAssetPaths(userData)
	local paths = {}

	table.insert(paths, UIGlobalApi.GetMonsterHeadCellAssetPath())

	return paths
end

function ChallengeWorldBossTipsUI:IsManualShowOnOpen(userData)
	return false
end

function ChallengeWorldBossTipsUI:GetBGM(userData)
	return nil
end

function ChallengeWorldBossTipsUI:OnOpen(userData)
	self:UpdateView()
end

function ChallengeWorldBossTipsUI:OnClose(userData)
	return
end

function ChallengeWorldBossTipsUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function ChallengeWorldBossTipsUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function ChallengeWorldBossTipsUI:OnPause()
	return
end

function ChallengeWorldBossTipsUI:OnResume()
	return
end

function ChallengeWorldBossTipsUI:OnCover()
	return
end

function ChallengeWorldBossTipsUI:OnReveal()
	return
end

function ChallengeWorldBossTipsUI:OnRefocus(userData)
	return
end

function ChallengeWorldBossTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChallengeWorldBossTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChallengeWorldBossTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChallengeWorldBossTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChallengeWorldBossTipsUI:OnDestroy()
	for i, v in pairs(self.MonsterHeadCells) do
		self.MonsterHeadCellPool:Release(v)
	end

	self.MonsterHeadCells = {}

	self.MonsterHeadCellPool:Dispose()
end

function ChallengeWorldBossTipsUI:UpdateView()
	for i, v in pairs(self.MonsterHeadCells) do
		v.goView:SetActive(false)
		v.goView.transform:SetParent(self.UIController.transform, false)
		self.MonsterHeadCellPool:Release(v)
	end

	self.MonsterHeadCells = {}

	local cfgBoss = ChallengeWorldBossModule.GetWorldBossData()
	local cfgMonster = CfgMonsterTable[cfgBoss.Monster]

	UGUIUtil.SetText(self.TextBossTipTitle2, ChallengeWorldBossTipUIApi:GetString("TextBossTipTitle2", cfgMonster.Name))

	local cfgMonsterTeam = CfgMonsterTeamTable[cfgBoss.MonsterTeam]

	self:ShowMonsterCell(cfgMonsterTeam.TeamUnit, self.MonsterList.transform)

	local nextCfgBoss = ChallengeWorldBossModule.GetNextWorldBossData()
	local nextCfgMonster = CfgMonsterTable[nextCfgBoss.Monster]

	UGUIUtil.SetText(self.TextBossTipTitle3, ChallengeWorldBossTipUIApi:GetString("TextBossTipTitle3", nextCfgMonster.Name))

	local nexCfgMonsterTeam = CfgMonsterTeamTable[nextCfgBoss.MonsterTeam]

	self:ShowMonsterCell(nexCfgMonsterTeam.TeamUnit, self.MonsterListNext.transform)
end

function ChallengeWorldBossTipsUI:ShowMonsterCell(monsters, transform)
	for i = 1, #monsters do
		local monsterID = monsters[i]
		local state = 0

		if monsterID > 0 and not CfgMonsterTable[monsterID].NotShowInUI then
			state = i < 6 and 1 or 2

			local monsterHeadCell = self.MonsterHeadCellPool:Obtain()

			monsterHeadCell.goView:SetActive(true)
			monsterHeadCell.goView.transform:SetParent(transform, false)
			monsterHeadCell:SetData(monsterID, state)

			function monsterHeadCell.clickHandler(monsterID)
				self:OnClickMonsterCell(monsterID)
			end

			table.insert(self.MonsterHeadCells, monsterHeadCell)
		end
	end
end

function ChallengeWorldBossTipsUI:OnClickMonsterCell(monsterID)
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = monsterID
	})
end

function ChallengeWorldBossTipsUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.ChallengeWorldBossTipsUI)
end

return ChallengeWorldBossTipsUI
