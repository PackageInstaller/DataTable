-- chunkname: @IQIGame\\UI\\ExploreHall\\ChallengePanelController.lua

local m = {
	TowerCid = 0,
	IsShow = false,
	ChallengeButtons = {},
	IllusionLv2DiffCells = {}
}
local ChallengeBtnController = require("IQIGame.UI.ExploreHall.ChallengeBtnController")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local IllusionMazeLv2DiffCell = require("IQIGame.UI.ExploreHall.IllusionMazeLv2DiffCell")

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.SkillTrainingLabel, ExploreHallUIApi:GetString("SkillTrainingLabel"))

	function self.delegateUpdateDailyDup()
		self:UpdateView()
	end

	for i = 0, self.DailyDupBtnNode.transform.childCount - 1 do
		local btn = ChallengeBtnController.New(self.DailyDupBtnNode.transform:GetChild(i).gameObject, function(dailyDupPOD)
			self:OnClickChallengeBtn(dailyDupPOD)
		end)

		table.insert(self.ChallengeButtons, btn)
	end

	self.IllusionLv2DiffCellPool = UIObjectPool.New(5, function()
		return IllusionMazeLv2DiffCell.New(UnityEngine.Object.Instantiate(self.Lv2DiffCellPrefab))
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
end

function m:Show()
	self.IsShow = true

	self.View:SetActive(true)
	self:AddListeners()
	self:UpdateView()
end

function m:Hide()
	self.IsShow = false

	self.View:SetActive(false)
	self:RemoveListeners()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateDailyDup)
	EventDispatcher.AddEventListener(EventID.UpdateTowerEvent, self.delegateUpdateDailyDup)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateDailyDup)
	EventDispatcher.RemoveEventListener(EventID.UpdateTowerEvent, self.delegateUpdateDailyDup)
end

function m:UpdateView()
	for i = 1, #self.ChallengeButtons do
		local btn = self.ChallengeButtons[i]
		local dailyDupPOD = DailyDupModule.GetDailyDupPOD(btn.DupCid)

		btn:SetData(dailyDupPOD)

		if dailyDupPOD ~= nil then
			local cfgDailyDupData = CfgDailyDupTable[dailyDupPOD.common.cid]

			if cfgDailyDupData.Type == Constant.ChallengeType.ChallengeTower then
				if ChallengeTowerModule.towerDailyPOD then
					local layer = ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer + 1
					local cfg

					for i, v in pairsCfg(CfgTowerFloorTable) do
						if v.Floor == layer then
							cfg = v

							break
						end
					end

					if cfg ~= nil and cfg.Unlock == 1 then
						self:SetBtnTowerFloor(btn, layer)
					else
						self:SetBtnTowerFloor(btn, layer - 1)
					end
				else
					self:SetBtnTowerFloor(btn, 1)
				end
			elseif cfgDailyDupData.Type == Constant.ChallengeType.ChallengeIllusionMaze then
				self:SetIllusionBtnDifficulty(btn)
			end
		end
	end

	if self.jumpCid ~= nil then
		self:DoJumpPanel(self.jumpCid)

		self.jumpCid = nil
	end
end

function m:SetBtnTowerFloor(btn, floor)
	UGUIUtil.SetText(btn.FloorNumText, ExploreHallUIApi:GetString("FloorNumText", floor))
end

function m:SetIllusionBtnDifficulty(btn)
	local cfgChapterDataOfLatestUnlockMaze, latestUnlockMazeData, maxChapterOrder = PlayerModule.GetLatestNormalMazeData()
	local lv1Diff, lv2Diff, maxLv2Diff = ExploreHallUIApi:GetString("IllusionDifficulty", cfgChapterDataOfLatestUnlockMaze.Order, maxChapterOrder)

	UGUIUtil.SetText(btn.Lv1DiffText, lv1Diff)
	UGUIUtil.SetText(btn.DiffLabel, ExploreHallUIApi:GetString("IllusionDifficultyLabel"))
	self:ClearIllusionLv2DiffCell()

	for i = 1, maxLv2Diff do
		local diffCell = self.IllusionLv2DiffCellPool:Obtain()

		diffCell.View:SetActive(true)
		diffCell.View.transform:SetParent(btn.Lv2DiffGrid.transform, false)
		diffCell:SetData(i <= lv2Diff)
		table.insert(self.IllusionLv2DiffCells, diffCell)
	end
end

function m:ClearIllusionLv2DiffCell(isDestroy)
	for i = 1, #self.IllusionLv2DiffCells do
		local cell = self.IllusionLv2DiffCells[i]

		cell.View:SetActive(false)

		if not isDestroy then
			cell.View.transform:SetParent(self.Host.UIController.transform, false)
		end

		self.IllusionLv2DiffCellPool:Release(cell)
	end

	self.IllusionLv2DiffCells = {}
end

function m:OnClickChallengeBtn(dailyDupPOD)
	local cfgDailyDupData = CfgDailyDupTable[dailyDupPOD.common.cid]

	if cfgDailyDupData.Type == Constant.ChallengeType.ChallengeMaterial then
		local challengeData = ChallengeModule.GetChallengeDataByID(dailyDupPOD.common.cid)

		UIModule.Open(Constant.UIControllerName.ChallengeDetailInfoUI, Constant.UILayer.UI, {
			challengeData = challengeData
		})
	elseif cfgDailyDupData.Type == Constant.ChallengeType.ChallengeTower then
		UIModule.Open(Constant.UIControllerName.ChallengeTowerDetailUI, Constant.UILayer.UI, cfgDailyDupData)
	elseif cfgDailyDupData.Type == Constant.ChallengeType.ChallengeWordBoos then
		UIModule.Open(Constant.UIControllerName.ChallengeWorldBossDetailUI, Constant.UILayer.UI, cfgDailyDupData)
	elseif cfgDailyDupData.Type == Constant.ChallengeType.ChallengeIllusionMaze then
		UIModule.Open(Constant.UIControllerName.IllusionMazeEntryUI, Constant.UILayer.UI, dailyDupPOD)
	elseif cfgDailyDupData.Type == Constant.ChallengeType.ChallengeEvilErosion then
		UIModule.Open(Constant.UIControllerName.EvilErosionUI, Constant.UILayer.UI)
	elseif cfgDailyDupData.Type == Constant.ChallengeType.ChallengeSingleWeakTower then
		UIModule.Open(Constant.UIControllerName.SingleWeakTowerFloorUI, Constant.UILayer.UI, cfgDailyDupData)
	end
end

function m:JumpPanel(cid)
	self.jumpCid = cid
end

function m:DoJumpPanel(cid)
	local dailyDupPOD = DailyDupModule.GetDailyDupPOD(cid)

	if dailyDupPOD and dailyDupPOD.common.status == 1 then
		self:OnClickChallengeBtn(dailyDupPOD)
	else
		NoticeModule.ShowNoticeNoCallback(21045013)
	end
end

function m:Dispose()
	for i = 1, #self.ChallengeButtons do
		local btn = self.ChallengeButtons[i]

		btn:Dispose()
	end

	self.ChallengeButtons = nil

	self:ClearIllusionLv2DiffCell(true)
	self.IllusionLv2DiffCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
