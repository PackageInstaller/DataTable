-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreExBossFormationUIController.lua

local json = require("Util.json")
local DualTeamBossRankFormationCell = require("IQIGame.UI.DualTeamExplore.DualTeamBossChallenge.DualTeamBossRankFormationCell")
local DualTeamExploreExBossFormationUIController = {}

function DualTeamExploreExBossFormationUIController.New(uiController)
	local obj = Clone(DualTeamExploreExBossFormationUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreExBossFormationUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreExBossFormationUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreExBossFormationUIController:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.playerHead = PlayerHeadUI.New(self.PlayerHead)
	self.formationCell1 = DualTeamBossRankFormationCell.New(self.FormationNode1)
	self.formationCell2 = DualTeamBossRankFormationCell.New(self.FormationNode2)
end

function DualTeamExploreExBossFormationUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreExBossFormationUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreExBossFormationUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreExBossFormationUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreExBossFormationUIController:OnOpen(userData)
	self.userData = userData[1]
	self.rankingPOD = userData[2]

	self:UpdateView()
end

function DualTeamExploreExBossFormationUIController:OnClose(userData)
	return
end

function DualTeamExploreExBossFormationUIController:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function DualTeamExploreExBossFormationUIController:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function DualTeamExploreExBossFormationUIController:OnPause()
	return
end

function DualTeamExploreExBossFormationUIController:OnResume()
	return
end

function DualTeamExploreExBossFormationUIController:OnCover()
	return
end

function DualTeamExploreExBossFormationUIController:OnReveal()
	return
end

function DualTeamExploreExBossFormationUIController:OnRefocus(userData)
	return
end

function DualTeamExploreExBossFormationUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreExBossFormationUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreExBossFormationUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreExBossFormationUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreExBossFormationUIController:OnDestroy()
	if self.playerHead then
		self.playerHead:Dispose()
	end

	self.formationCell1:Dispose()
	self.formationCell2:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreExBossFormationUIController:UpdateView()
	local str = IQIGame.Onigao.Game.GZipUtil.DecompressString(self.userData)
	local userDataTab = json.decode(str)
	local posFormationTab = {}

	for i, v in pairs(userDataTab) do
		local prefabList = {}

		for k, formationSoulPrefabPOD in pairs(v.soulPrefabs) do
			prefabList[tonumber(k)] = formationSoulPrefabPOD
		end

		posFormationTab[i] = prefabList
	end

	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]
	local cfgBoss1 = CfgDualTeamExploreEXBossTable[cfgDualTeamExploreControlData.ExBoss1]
	local cfgBoss2 = CfgDualTeamExploreEXBossTable[cfgDualTeamExploreControlData.ExBoss2]

	self.formationCell1:SetData(cfgBoss1, posFormationTab[1])
	self.formationCell2:SetData(cfgBoss2, posFormationTab[2])

	if self.rankingPOD then
		UGUIUtil.SetText(self.TextPlayerName, self.rankingPOD.name)

		if self.playerHead then
			self.playerHead:SetData(self.rankingPOD.headIcon, self.rankingPOD.pLv, self.rankingPOD.avatarFrame)
		end
	end
end

function DualTeamExploreExBossFormationUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return DualTeamExploreExBossFormationUIController
