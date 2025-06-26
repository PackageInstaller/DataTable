-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreBossDetailUIController.lua

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local MonsterHeadCell = require("IQIGame.UI.Common.MonsterHeadCell")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local DualTeamExploreBossDetailUIController = {
	isFree = false,
	MonsterElementCells = {},
	MonsterHeadCells = {}
}

function DualTeamExploreBossDetailUIController.New(uiController)
	local obj = Clone(DualTeamExploreBossDetailUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreBossDetailUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreBossDetailUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreBossDetailUIController:OnInit()
	function self.DelegateOnClickChallengeBtn()
		self:OnClickChallengeBtn()
	end

	function self.DelegateOnClickBtnTip()
		self:OnClickBtnTip()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	UGUIUtil.SetText(self.TitleName, DualTeamExploreBossDetailUIApi:GetString("TitleName"))
	UGUIUtil.SetText(self.TextWeakness, DualTeamExploreBossDetailUIApi:GetString("TextWeakness"))
	UGUIUtil.SetText(self.TextChallengeBtn, DualTeamExploreBossDetailUIApi:GetString("TextChallengeBtn"))

	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)

	self.Mould:SetActive(false)

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.Mould))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.MonsterHeadCellPool = UIObjectPool.New(10, function()
		return MonsterHeadCell.__New(UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetMonsterHeadCellAssetPath())))
	end, function(cell)
		cell:Dispose()
	end)
end

function DualTeamExploreBossDetailUIController:GetPreloadAssetPaths()
	local paths = {}

	table.insert(paths, UIGlobalApi.GetMonsterHeadCellAssetPath())

	return paths
end

function DualTeamExploreBossDetailUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreBossDetailUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreBossDetailUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreBossDetailUIController:OnOpen(userData)
	self.cfgDualTeamExploreBoss = userData[1]
	self.isFree = userData[2]

	self:UpdateView()
end

function DualTeamExploreBossDetailUIController:OnClose(userData)
	return
end

function DualTeamExploreBossDetailUIController:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChallengeBtn)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function DualTeamExploreBossDetailUIController:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChallengeBtn)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function DualTeamExploreBossDetailUIController:OnPause()
	return
end

function DualTeamExploreBossDetailUIController:OnResume()
	return
end

function DualTeamExploreBossDetailUIController:OnCover()
	return
end

function DualTeamExploreBossDetailUIController:OnReveal()
	return
end

function DualTeamExploreBossDetailUIController:OnRefocus(userData)
	return
end

function DualTeamExploreBossDetailUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreBossDetailUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreBossDetailUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreBossDetailUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreBossDetailUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.FormationPanelController:Dispose()

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()

	for i, v in pairs(self.MonsterHeadCells) do
		self.MonsterHeadCellPool:Release(v)
	end

	self.MonsterHeadCells = {}

	self.MonsterHeadCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreBossDetailUIController:UpdateView()
	self.FormationPanelController:UpdateView()

	local cfgMonster = CfgMonsterTable[self.cfgDualTeamExploreBoss.Monster]

	UGUIUtil.SetText(self.TextBossName, cfgMonster.Name)

	local path = UIGlobalApi.GetImagePath(self.cfgDualTeamExploreBoss.BossBg)

	AssetUtil.LoadImage(self, path, self.ImgBoss:GetComponent("Image"))

	self.ImgBoss.transform.localPosition = Vector3(self.cfgDualTeamExploreBoss.BgPosition[1], self.cfgDualTeamExploreBoss.BgPosition[2], self.cfgDualTeamExploreBoss.BgPosition[3])
	self.ImgBoss.transform.localScale = Vector3(self.cfgDualTeamExploreBoss.BgScale[1], self.cfgDualTeamExploreBoss.BgScale[2], self.cfgDualTeamExploreBoss.BgScale[3])

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	for i = 1, #self.cfgDualTeamExploreBoss.WeakType do
		local weakType = self.cfgDualTeamExploreBoss.WeakType[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterElementGrid.transform, false)
		cell:SetData(weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	self:UpdateMonsterCells(self.cfgDualTeamExploreBoss.MonsterTeam)
end

function DualTeamExploreBossDetailUIController:UpdateMonsterCells(MonsterTeam)
	for i, v in pairs(self.MonsterHeadCells) do
		v:Dispose()
	end

	self.MonsterHeadCells = {}

	local cfgMonsterTeam = CfgMonsterTeamTable[MonsterTeam]

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local monsterID = cfgMonsterTeam.TeamUnit[i]
		local state = 0

		if monsterID > 0 and not CfgMonsterTable[monsterID].NotShowInUI then
			state = i < 6 and 1 or 2

			local monsterHeadCell = self.MonsterHeadCellPool:Obtain()

			monsterHeadCell.goView:SetActive(true)
			monsterHeadCell.goView.transform:SetParent(self.MonsterGrid.transform, false)
			monsterHeadCell:SetData(monsterID, state)

			function monsterHeadCell.clickHandler(pMonsterID)
				self:OnClickMonsterCell(pMonsterID)
			end

			table.insert(self.MonsterHeadCells, monsterHeadCell)
		end
	end
end

function DualTeamExploreBossDetailUIController:OnClickMonsterCell(monsterID)
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = monsterID
	})
end

function DualTeamExploreBossDetailUIController:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), self.cfgDualTeamExploreBoss.RecommendPower)
end

function DualTeamExploreBossDetailUIController:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, DualTeamExploreBossDetailUIApi:GetString("TextPowerNum", power2))
	UGUIUtil.SetText(self.TextCurrentNum, DualTeamExploreBossDetailUIApi:GetString("TextCurrentNum", power1, power2))
end

function DualTeamExploreBossDetailUIController:OnClickChallengeBtn()
	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, DualTeamExploreBossDetailUIApi:GetString("NoFormations"))

		return
	end

	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not formationPOD then
		return
	end

	if not valid then
		return
	end

	self.formationID = formationPOD.id

	if not self.isFree and self.cfgDualTeamExploreBoss.ChallengeBossCostTickets > DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.tickets then
		NoticeModule.ShowNotice(21057011, function()
			JumpModule.Jump(10206028)
			UIModule.Close(Constant.UIControllerName.DualTeamExploreBossDetailUI)
			UIModule.Close(Constant.UIControllerName.DualTeamExploreBossChallengeUI)
		end, nil, self)
	else
		self:ChallengeDupFun()
	end
end

function DualTeamExploreBossDetailUIController:ChallengeDupFun()
	DualTeamExploreModule.ChallengeBoss(self.formationID, self.cfgDualTeamExploreBoss.Id, self.isFree)
	self:OnClickCloseBtn()
end

function DualTeamExploreBossDetailUIController:OnClickBtnTip()
	return
end

function DualTeamExploreBossDetailUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return DualTeamExploreBossDetailUIController
