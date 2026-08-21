-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\MultiDragSwitchDlg.lua

local ResHero = require("ClientData/ResHero")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResTower = require("ClientData/ResTower")
local ResColor = require("ClientData/ResColor")
local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local strClassName = "MultiDragSwitchDlg"
local MultiDragSwitchDlg = Class(strClassName, UIControls.Window)

function MultiDragSwitchDlg:ctor()
	self:initUI()
end

local MAX_NUM = 3

function MultiDragSwitchDlg:initUI()
	self.panelFriendTeam = UIControls.Panel(self, "BgPanel/SelfInfoPanel")
	self.panelEnemyTeam = UIControls.Panel(self, "BgPanel/EnemyInfoPanel")
	self.btnHeadMine = UIControls.PlayerHeadGridChild(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHeadMine:setEnable(false)

	self.textName = UIControls.Label(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/TextName")
	self.friendCells = {}
	self.btnChanges = {}

	for index = 1, MAX_NUM do
		local newBtn = UIControls.Button(self, "BgPanel/SelfInfoPanel/TeamInfoPanel/Team" .. index .. "/BtnChange")

		newBtn.imgBg = UIControls.Image(self, "BgPanel/SelfInfoPanel/TeamInfoPanel/Team" .. index .. "/BtnChange")
		newBtn.teamIndex = index

		newBtn:addEventClick(self.onChangeTeamClick)
		table.insert(self.btnChanges, newBtn)

		local newCell = SeniorFormation(self, "BgPanel/SelfInfoPanel/TeamInfoPanel/Team" .. index, "System/AsynPVP/SeniorPVPTeamInfoCell")

		newCell:setVisible(true)
		table.insert(self.friendCells, newCell)
	end
end

function MultiDragSwitchDlg:initEnemyCell()
	self.btnHeadOther = UIControls.PlayerHeadGridChild(self, "BgPanel/EnemyInfoPanel/PlayerInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHeadOther:setEnable(false)

	self.textEnemyName = UIControls.Label(self, "BgPanel/EnemyInfoPanel/PlayerInfoPanel/TextName")
	self.enemyCells = {}

	for index = 1, MAX_NUM do
		local newCell = SeniorFormation(self, "BgPanel/EnemyInfoPanel/TeamInfoPanel/Team" .. index, "System/AsynPVP/SeniorPVPTeamInfoCell")

		newCell:setVisible(true)
		table.insert(self.enemyCells, newCell)
	end

	local otherComm

	if self.battleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP then
		if ClientUtils.record.seniorPvpCacheData and ClientUtils.record.seniorPvpCacheData.comm then
			otherComm = ClientUtils.record.seniorPvpCacheData.comm
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_OPACT_PVP then
		if ClientUtils.record.opactPvpCacheData and ClientUtils.record.opactPvpCacheData.comm then
			otherComm = ClientUtils.record.opactPvpCacheData.comm
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH and ClientUtils.record.topPvpCacheData and ClientUtils.record.topPvpCacheData.comm then
		otherComm = ClientUtils.record.topPvpCacheData.comm
	end

	if otherComm then
		self.btnHeadOther:setCommInfo(otherComm, false, self)

		local name = utils.GetPlayerName(otherComm.name)

		self.textEnemyName:setText(name)
	end
end

function MultiDragSwitchDlg:onShow(selfForms, enemyForms, battleType, teamPets)
	self.teamPets = teamPets or {}
	self.battleType = battleType
	self.nowSelect = nil

	for index, btn in ipairs(self.btnChanges) do
		btn.imgBg:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas", "BtnChangeNml")
	end

	local commInfo = CurAvatar:getMyCommInfo()

	self.btnHeadMine:setCommInfo(commInfo, false, self)
	self.textName:setText(commInfo.name)

	for index, cell in ipairs(self.friendCells) do
		cell:setFormationWithLocalFormation({
			formation = selfForms[index] or {},
			otherInfo = self.teamPets[index] or {}
		}, index)
		cell:setSideState(true)
	end

	if enemyForms then
		self.panelEnemyTeam:setVisible(true)

		if not self.enemyCells then
			self:initEnemyCell()
		end

		for index, cell in ipairs(self.enemyCells) do
			cell:setFormation(enemyForms[index] or {}, index)
			cell:setSideState(false)
			cell:setCommonHideMode()
		end
	else
		self.panelEnemyTeam:setVisible(false)
	end
end

function MultiDragSwitchDlg:onChangeTeamClick(sender)
	local clickIndex = sender.teamIndex

	if self.nowSelect then
		self:onChange(self.nowSelect, clickIndex)
	else
		self.nowSelect = clickIndex

		for index, btn in ipairs(self.btnChanges) do
			if index == clickIndex then
				btn.imgBg:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas", "BtnCancelNml")
			else
				btn.imgBg:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas", "BtnChangeSel")
			end
		end
	end
end

function MultiDragSwitchDlg:onChange(fromIndex, toIndex)
	local operaDlg = UIManager.getUI("multiDragHeroDlg", nil, false)

	if operaDlg then
		operaDlg:onChangeFormation(fromIndex, toIndex)
	end

	local operaDlg = UIManager.getUI("activityPvpDragHeroDlg", nil, false)

	if operaDlg then
		operaDlg:onChangeFormation(fromIndex, toIndex)
	end

	local operaDlg = UIManager.getUI("topPvpDragHeroDlg", nil, false)

	if operaDlg then
		operaDlg:onChangeFormation(fromIndex, toIndex)
	end

	local operaDlg = UIManager.getUI("topPvpKnockoutDragHeroDlg", nil, false)

	if operaDlg then
		operaDlg:onChangeFormation(fromIndex, toIndex)
	end
end

return MultiDragSwitchDlg
