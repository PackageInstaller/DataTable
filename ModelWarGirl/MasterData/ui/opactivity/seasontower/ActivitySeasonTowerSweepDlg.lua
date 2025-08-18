-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonTower\\ActivitySeasonTowerSweepDlg.lua

local ResInfoNotice = require("ClientData/ResInfoNotice")
local strClassName = "ActivitySeasonTowerSweepDlg"
local ActivitySeasonTowerSweepDlg = Class(strClassName, UIControls.Window)

function ActivitySeasonTowerSweepDlg:ctor()
	self:initUI()
end

function ActivitySeasonTowerSweepDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickClose)

	self.textRule = UIControls.Label(self, "BgPanel/RulePanel/Text1")
	self.awardGrids = {}
	self.panelBonus1 = UIControls.Panel(self, "BgPanel/GridSpecialPanel/Icon1")
	self.textBonus1 = UIControls.Label(self, "BgPanel/GridSpecialPanel/Icon1/Text")
	self.panelBonus2 = UIControls.Panel(self, "BgPanel/GridSpecialPanel/Icon2")
	self.textBonus2 = UIControls.Label(self, "BgPanel/GridSpecialPanel/Icon2/Text")
end

function ActivitySeasonTowerSweepDlg:onShow(attrs, items, heros, equip, artifact, relic)
	self.textRule:setText(ResInfoNotice[Const.INFO_NOTICE_SEASON_TOWER_SWEEP].content)

	local clientItems = {}

	for _, item in pairs(ClientUtils.getAttrItems(attrs)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonItems(items)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonEquips(equip)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonArtifactsById(artifact)) do
		table.insert(clientItems, item)
	end

	if relic then
		for _, item in pairs(ClientUtils.getCommonRelicsById(relic)) do
			table.insert(clientItems, item)
		end
	end

	if #clientItems <= 0 then
		self:setVisible(false, nil, true)
	else
		for index, item in ipairs(clientItems) do
			local nameGridContainer = UIControls.GridNameContainerChild(self, "BgPanel/GridPanel/Content", "System/Common/Grid/GridAwardGetHolder", 0, 0, true)

			nameGridContainer:setObj(item)

			nameGridContainer.grid.mDisableWays = true

			table.insert(self.awardGrids, nameGridContainer.grid)
		end
	end
end

function ActivitySeasonTowerSweepDlg:onShowScore(score1, score2)
	if score1 > 0 then
		self.panelBonus1:setVisible(true)
		self.textBonus1:setText("+" .. score1)
	end

	if score2 > 0 then
		self.panelBonus2:setVisible(true)
		self.textBonus2:setText(string.format(Lang.get(30153), score2))
	end
end

function ActivitySeasonTowerSweepDlg:onClickClose()
	self:setVisible(false)
end

return ActivitySeasonTowerSweepDlg
