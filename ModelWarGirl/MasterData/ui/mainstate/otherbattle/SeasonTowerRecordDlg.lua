-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\OtherBattle\\SeasonTowerRecordDlg.lua

local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local VersionUtils = require("System/VersionUtils")
local strClassName = "SeasonTowerSeniorFormation"
local SeasonTowerSeniorFormation = Class(strClassName, SeniorFormation)

function SeasonTowerSeniorFormation:initUI(...)
	self.MAX_NUMBER = 6

	SeasonTowerSeniorFormation.super.initUI(self)
end

local SeasonTowerRecordDlg = Class("SeasonTowerRecordDlg", UIControls.Window)
local MAX_SHOW_NUM = 2

function SeasonTowerRecordDlg:ctor()
	self.panelHead = UIControls.PlayerHeadGridChild(self, "BgPanel/PlayerInfoPanel/SelfInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.panelHead:setVisible(true)

	self.textName = UIControls.Label(self, "BgPanel/PlayerInfoPanel/SelfInfoPanel/TextName")
	self.panelRecord = {}
	self.panelFormations = {}

	for index = 1, MAX_SHOW_NUM do
		local newPanel = UIControls.Panel(self, "BgPanel/Record" .. index)
		local newFormation = SeasonTowerSeniorFormation(self, "BgPanel/Record" .. index .. "/SelfTeamPanel", "System/SeasonTower/SeasonTowerTeamInfoCell")
		local newRepBtn = UIControls.Button(self, "BgPanel/Record" .. index .. "/BtnReplay")

		newRepBtn:addEventClick(self.onReplayBtnClick)

		newRepBtn.index = index

		table.insert(self.panelRecord, newPanel)
		table.insert(self.panelFormations, newFormation)
	end
end

function SeasonTowerRecordDlg:onShow(replayList, playerComm)
	self.playerComm = playerComm
	self.replayList = replayList

	local playerName = utils.GetPlayerName(playerComm.name)

	self.textName:setText(playerName)
	self.panelHead:setCommInfo(playerComm, true, self)

	for index, panel in ipairs(self.panelRecord) do
		local replayResult = replayList[index]

		if replayResult then
			panel:setVisible(true)

			local formations, pets = utils.getBattleFormationHero(replayResult.start_data)
			local myHeros = formations[0][BattleConst.CAMP_PLAYER]
			local myPet

			if pets and pets[0] then
				myPet = pets[0][BattleConst.CAMP_PLAYER]
			end

			local formationPanel = self.panelFormations[index]
			local isLose = replayList[index + 1] and true or false

			formationPanel:setHeros(myHeros, 1, isLose)
			formationPanel:setPet(myPet, isLose)
			formationPanel:setResultState(not isLose)
		else
			panel:setVisible(false)
		end
	end
end

function SeasonTowerRecordDlg:onReplayBtnClick(sender)
	local index = sender.index
	local repData = self.replayList[index]

	if repData.control.version ~= VersionUtils.getBattleDataVersion() then
		MsgManager.clientNotice(178)
	else
		local replayState = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

		replayState:setServerReplayData(self.replayList[index])
		GameFsm.translateState(Const.STATE_BATTLE_REPLAY)
	end
end

return SeasonTowerRecordDlg
