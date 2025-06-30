-- chunkname: @IQIGame\\UI\\PandaChallengeDetailInfoUI.lua

local PandaChallengeDetailInfoUI = {
	pandaMonsterDifficultyList = {},
	monsterDifficultyCellPool = {},
	MonsterElementCells = {},
	ItemCells = {}
}

PandaChallengeDetailInfoUI = Base:Extend("PandaChallengeDetailInfoUI", "IQIGame.Onigao.UI.PandaChallengeDetailInfoUI", PandaChallengeDetailInfoUI)

local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local PandaMonsterDifficultyCell = require("IQIGame.UI.Activity.Panda.PandaMonsterDifficultyCell")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function PandaChallengeDetailInfoUI:OnInit()
	self.moneyCellBuilder = MoneyCellsBuilder.New(self.CurrencyCom)
	self.energyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnFight()
		self:OnBtnFight()
	end

	self.scrollListPage = self.ToggleList:GetComponent("ScrollAreaListPage")

	function self.scrollListPage.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollListPage.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.Mould2))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.ItemCellPool = UIObjectPool.New(10, function()
		return MazeRewardCell.New(UnityEngine.Object.Instantiate(self.Mould1))
	end, function(cell)
		cell:Dispose()
	end)

	UGUIUtil.SetText(self.TitleName, PandaChallengeDetailInfoUIApi:GetString("TitleName"))
	UGUIUtil.SetText(self.TextTitle1, PandaChallengeDetailInfoUIApi:GetString("TextTitle1"))
	UGUIUtil.SetText(self.TextTitle2, PandaChallengeDetailInfoUIApi:GetString("TextTitle2"))
	UGUIUtil.SetText(self.TextTitle3, PandaChallengeDetailInfoUIApi:GetString("TextTitle3"))
	UGUIUtil.SetText(self.TextName, PandaChallengeDetailInfoUIApi:GetString("TextName"))
end

function PandaChallengeDetailInfoUI:GetPreloadAssetPaths()
	return nil
end

function PandaChallengeDetailInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PandaChallengeDetailInfoUI:IsManualShowOnOpen(userData)
	return false
end

function PandaChallengeDetailInfoUI:GetBGM(userData)
	return nil
end

function PandaChallengeDetailInfoUI:OnOpen(userData)
	self.operateEventID = userData[1]
	self.pandaEventCid = userData[2]

	self.moneyCellBuilder:RefreshView({
		Constant.ItemID.MONEY,
		Constant.ItemID.TREASURE
	})
	self:UpdateView()
end

function PandaChallengeDetailInfoUI:OnClose(userData)
	return
end

function PandaChallengeDetailInfoUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnFight:GetComponent("Button").onClick:AddListener(self.delegateBtnFight)
end

function PandaChallengeDetailInfoUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnFight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnFight)
end

function PandaChallengeDetailInfoUI:OnPause()
	return
end

function PandaChallengeDetailInfoUI:OnResume()
	return
end

function PandaChallengeDetailInfoUI:OnCover()
	return
end

function PandaChallengeDetailInfoUI:OnReveal()
	return
end

function PandaChallengeDetailInfoUI:OnRefocus(userData)
	return
end

function PandaChallengeDetailInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PandaChallengeDetailInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PandaChallengeDetailInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PandaChallengeDetailInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PandaChallengeDetailInfoUI:OnDestroy()
	self.moneyCellBuilder:Dispose()

	self.moneyCellBuilder = nil

	self.energyCell:Dispose()

	self.energyCell = nil

	self.FormationPanelController:Dispose()

	for i, v in pairs(self.monsterDifficultyCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	self.ItemCellPool:Dispose()
end

function PandaChallengeDetailInfoUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.PandaChallengeDetailInfoUI)
end

function PandaChallengeDetailInfoUI:UpdateView()
	self.pandaMonsterDifficultyList = {}

	local cfgPandaEvent = CfgPandaEventListTable[self.pandaEventCid]

	for i, v in pairsCfg(CfgPandaMonsterListTable) do
		if v.MonsterType == cfgPandaEvent.Parameter then
			table.insert(self.pandaMonsterDifficultyList, v)
		end
	end

	table.sort(self.pandaMonsterDifficultyList, function(a, b)
		return a.Difficulty < b.Difficulty
	end)
	self:SetDefaultDifficulty()
	self.FormationPanelController:UpdateView()
end

function PandaChallengeDetailInfoUI:SetDefaultDifficulty()
	local startIndex = 1
	local power = self.FormationPanelController:GetPower()

	for i = 1, #self.pandaMonsterDifficultyList do
		local cfg = self.pandaMonsterDifficultyList[i]

		if power >= cfg.RecPower then
			startIndex = i
		end
	end

	self.scrollListPage.startIndex = startIndex - 1

	self.scrollListPage:Refresh(#self.pandaMonsterDifficultyList)
end

function PandaChallengeDetailInfoUI:OnUpdateFormation()
	self:SetDefaultDifficulty()

	if self.selectMonsterDifficulty then
		self:ShowPower(self.FormationPanelController:GetPower(), self.selectMonsterDifficulty.RecPower)
	end
end

function PandaChallengeDetailInfoUI:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, PandaChallengeDetailInfoUIApi:GetString("RecommendPowerText", power2))
	UGUIUtil.SetText(self.TextCurrentNum, PandaChallengeDetailInfoUIApi:GetString("TextPower", power1, power2))
end

function PandaChallengeDetailInfoUI:OnRenderCell(cell)
	local cfgData = self.pandaMonsterDifficultyList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local monsterDifficultyCell = self.monsterDifficultyCellPool[instanceID]

	if monsterDifficultyCell == nil then
		monsterDifficultyCell = PandaMonsterDifficultyCell.New(cell.gameObject)
		self.monsterDifficultyCellPool[instanceID] = monsterDifficultyCell
	end

	monsterDifficultyCell:SetData(cfgData, self.operateEventID)
	monsterDifficultyCell:SetSelect(false)
end

function PandaChallengeDetailInfoUI:OnPageReachedMain(page)
	self.currentTabIndex = page.index + 1

	self:ShowSelect()
end

function PandaChallengeDetailInfoUI:ShowSelect()
	local selectCfg = self.pandaMonsterDifficultyList[self.currentTabIndex]

	for i, v in pairs(self.monsterDifficultyCellPool) do
		if v.cfgPandaMonsterListData.Id == selectCfg.Id then
			self.selectMonsterDifficulty = selectCfg

			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end

	if self.selectMonsterDifficulty then
		self:ShowPower(self.FormationPanelController:GetPower(), self.selectMonsterDifficulty.RecPower)
		UGUIUtil.SetText(self.TextDes, self.selectMonsterDifficulty.RuleDescription)

		for i, v in pairs(self.MonsterElementCells) do
			v.View.transform:SetParent(self.UIController.transform, false)
			v.View:SetActive(false)
			self.MonsterElementPool:Release(v)
		end

		self.MonsterElementCells = {}

		local tab = {}
		local cfgMonsterTeam = CfgMonsterTeamTable[self.selectMonsterDifficulty.MonsterTeam]

		for i = 1, #cfgMonsterTeam.TeamUnit do
			local monsterID = cfgMonsterTeam.TeamUnit[i]

			if monsterID > 0 then
				local cfgMonster = CfgMonsterTable[monsterID]

				if #cfgMonster.WeakType > 0 then
					for i = 1, #cfgMonster.WeakType do
						local id = cfgMonster.WeakType[i]

						if tab[id] == nil then
							local t = {}

							t.weakType = id
							t.num = 1
							tab[id] = t
						else
							tab[id].num = tab[id].num + 1
						end
					end
				end
			end
		end

		local sortTab = {}

		for i, v in pairs(tab) do
			table.insert(sortTab, v)
		end

		table.sort(sortTab, function(a, b)
			local res = false

			if a.num == b.num then
				res = a.weakType < b.weakType
			else
				res = a.num > b.num
			end

			return res
		end)

		for i = 1, #sortTab do
			local b = sortTab[i]
			local cell = self.MonsterElementPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.MonsterGrid.transform, false)
			cell:SetData(b.weakType)
			table.insert(self.MonsterElementCells, cell)
		end

		for i, v in pairs(self.ItemCells) do
			v.View.transform:SetParent(self.UIController.transform, false)
			v.View:SetActive(false)
			self.ItemCellPool:Release(v)
		end

		self.ItemCells = {}

		for i = 1, #self.selectMonsterDifficulty.RewardShow, 2 do
			local itemId = self.selectMonsterDifficulty.RewardShow[i]
			local itemNum = self.selectMonsterDifficulty.RewardShow[i + 1]
			local itemCell = self.ItemCellPool:Obtain()

			itemCell.View:SetActive(true)
			itemCell.View.transform:SetParent(self.Slot.transform, false)
			itemCell:SetData(itemId, itemNum)
			table.insert(self.ItemCells, itemCell)
		end
	end
end

function PandaChallengeDetailInfoUI:OnBtnFight()
	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice2"))

		return
	end

	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not valid then
		return
	end

	if not ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		return
	end

	local formationID = formationPOD.id

	ActivePandaModule.DoEvent(self.pandaEventCid, {
		tostring(self.selectMonsterDifficulty.Id),
		tostring(formationID)
	})
end

return PandaChallengeDetailInfoUI
