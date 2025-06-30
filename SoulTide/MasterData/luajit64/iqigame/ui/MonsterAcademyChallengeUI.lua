-- chunkname: @IQIGame\\UI\\MonsterAcademyChallengeUI.lua

local MonsterAcademyChallengeUI = {
	isHaveMonster = false,
	currentLayer = 0,
	monsterTowers = {},
	monsterTowerCells = {}
}

MonsterAcademyChallengeUI = Base:Extend("MonsterAcademyChallengeUI", "IQIGame.Onigao.UI.MonsterAcademyChallengeUI", MonsterAcademyChallengeUI)

require("IQIGame.UIExternalApi.MonsterAcademyChallengeUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterAcademyPlayerHeadView = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyPlayerHeadView")
local MonsterAcademyTowerMonsterCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyTower.MonsterAcademyTowerMonsterCell")

function MonsterAcademyChallengeUI:OnInit()
	UGUIUtil.SetText(self.TitleText, MonsterAcademyChallengeUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.BtnExploreLabel, MonsterAcademyChallengeUIApi:GetString("BtnExploreLabel"))

	function self.DelegateOnClickBtnExplore()
		self:OnClickBtnExplore()
	end

	function self.DelegateOnClickExitBtn()
		self:OnClickExitBtn()
	end

	function self.delegateUpdateTowerEvent()
		self:OnUpdateTowerEvent()
	end

	self.playerHeadView = MonsterAcademyPlayerHeadView.New(self.PlayerInformation)

	self.MonsterModule:SetActive(false)

	self.monsterTowerPool = UIObjectPool.New(5, function()
		local cell = MonsterAcademyTowerMonsterCell.New(UnityEngine.Object.Instantiate(self.MonsterModule))

		return cell
	end, function(cell)
		cell:Dispose()
	end)

	self.BtnExplore:SetActive(false)
end

function MonsterAcademyChallengeUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyChallengeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyChallengeUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyChallengeUI:GetBGM(userData)
	return nil
end

function MonsterAcademyChallengeUI:OnOpen(userData)
	self.currentLayer = MonsterAcademyModule.GetTowerLayer()

	self:UpdateView()
end

function MonsterAcademyChallengeUI:OnClose(userData)
	return
end

function MonsterAcademyChallengeUI:OnAddListeners()
	self.BtnExplore:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnExplore)
	self.ExitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExitBtn)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateTowerEvent, self.delegateUpdateTowerEvent)
end

function MonsterAcademyChallengeUI:OnRemoveListeners()
	self.BtnExplore:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnExplore)
	self.ExitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExitBtn)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateTowerEvent, self.delegateUpdateTowerEvent)
end

function MonsterAcademyChallengeUI:OnPause()
	return
end

function MonsterAcademyChallengeUI:OnResume()
	return
end

function MonsterAcademyChallengeUI:OnCover()
	return
end

function MonsterAcademyChallengeUI:OnReveal()
	return
end

function MonsterAcademyChallengeUI:OnRefocus(userData)
	return
end

function MonsterAcademyChallengeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyChallengeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyChallengeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyChallengeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyChallengeUI:OnDestroy()
	self.playerHeadView:Dispose()

	for i, v in pairs(self.monsterTowerCells) do
		self.monsterTowerPool:Release(v)
	end

	self.monsterTowerCells = {}

	self.monsterTowerPool:Dispose()
end

function MonsterAcademyChallengeUI:OnClickBtnExplore()
	if self.isHaveMonster then
		return
	end

	self:ShowNextLayer()
end

function MonsterAcademyChallengeUI:OnUpdateTowerEvent()
	self:UpdateView()
end

function MonsterAcademyChallengeUI:UpdateView()
	self.playerHeadView:UpdateView()

	self.monsterTowers = {}

	for i, v in pairsCfg(CfgGalgameMonstertowerTable) do
		if v.Group == MonsterAcademyModule.GlobalCid and v.Num == self.currentLayer then
			table.insert(self.monsterTowers, v.Id)
		end
	end

	table.sort(self.monsterTowers, function(a, b)
		return a < b
	end)
	UGUIUtil.SetText(self.TextLayer, MonsterAcademyChallengeUIApi:GetString("TextLayer", self.currentLayer))

	for i, v in pairs(self.monsterTowerCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.monsterTowerPool:Release(v)
	end

	self.monsterTowerCells = {}
	self.isHaveMonster = false

	for i = 1, #self.monsterTowers do
		local id = self.monsterTowers[i]

		if table.indexOf(MonsterAcademyModule.SaveDataDetailPOD.towerRecord, id) == -1 then
			self.isHaveMonster = true

			local transform = self["Point" .. i]
			local cell = self.monsterTowerPool:Obtain()

			cell.View:SetActive(true)

			if transform then
				cell.View.transform:SetParent(transform.transform, false)
			else
				logError("第" .. self.currentLayer .. "层怪物配置错误，每层只有4个怪物放置点")
			end

			cell:SetData(id, self.currentLayer)
			table.insert(self.monsterTowerCells, cell)
		end
	end

	if not self.isHaveMonster then
		self:ShowNextLayer()
	end
end

function MonsterAcademyChallengeUI:ShowNextLayer()
	self.currentLayer = self.currentLayer + 1

	local maxLayer = 1

	for i, v in pairsCfg(CfgGalgameMonstertowerTable) do
		if maxLayer < v.Num and v.Group == MonsterAcademyModule.GlobalCid then
			maxLayer = v.Num
		end
	end

	if maxLayer < self.currentLayer then
		return
	end

	self:UpdateView()
end

function MonsterAcademyChallengeUI:OnClickExitBtn()
	UIModule.Close(Constant.UIControllerName.MonsterAcademyChallengeUI)
end

return MonsterAcademyChallengeUI
