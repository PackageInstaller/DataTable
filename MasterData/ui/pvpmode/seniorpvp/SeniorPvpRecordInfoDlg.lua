-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\SeniorPVP\\SeniorPvpRecordInfoDlg.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local strClassName = "SeniorPvpRecordInfoDlg"
local SeniorPvpRecordInfoDlg = Class(strClassName, UIControls.Window)

function SeniorPvpRecordInfoDlg:ctor(...)
	self:initUI()
end

function SeniorPvpRecordInfoDlg:initUI(...)
	self.btnHeadMine = UIControls.PlayerHeadGridChild(self, "BgPanel/PlayerInfoPanel/SelfInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHeadMine:setEnable(false)

	self.btnHeadOther = UIControls.PlayerHeadGridChild(self, "BgPanel/PlayerInfoPanel/EnemyInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHeadOther:setEnable(false)

	self.txtMyName = UIControls.Label(self, "BgPanel/PlayerInfoPanel/SelfInfoPanel/TextName")
	self.txtOtherName = UIControls.Label(self, "BgPanel/PlayerInfoPanel/EnemyInfoPanel/TextName")
	self.txtScore = UIControls.Label(self, "BgPanel/TextScore")
	self.recordInfos = {}

	local path

	for i = 1, 3 do
		local info = {}

		path = "BgPanel/Record" .. i
		info.myTeam = SeniorFormation(self, path .. "/SelfTeamPanel", "System/AsynPVP/SeniorPVPTeamInfoCell")
		info.otherTeam = SeniorFormation(self, path .. "/EnemyTeamPanel", "System/AsynPVP/SeniorPVPTeamInfoCell")
		info.btnReplay = UIControls.Button(self, path .. "/BtnReplay")

		info.btnReplay:addEventClick(self.onBtnReplayClick)

		info.btnReplay.index = i
		self.recordInfos[i] = info
	end
end

function SeniorPvpRecordInfoDlg:show(replayData, reportData, battleType)
	self.replayData = replayData
	self.battleType = battleType

	local commInfo = CurAvatar:getMyCommInfo()

	self.btnHeadMine:setCommInfo(commInfo, false, self)
	self.txtMyName:setText(commInfo.name)

	if battleType == BattleConst.BATTLE_TYPE_OPACT_PVP then
		if CurAvatar.cachedOpactPvpReplayData then
			local comm = CurAvatar.cachedOpactPvpReplayData.comm

			self.btnHeadOther:setCommInfo(comm, false, self)

			local name = utils.GetPlayerName(comm.name)

			self.txtOtherName:setText(name)
		end
	elseif battleType == BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH then
		if CurAvatar.cachedOpTopPvpReplayData then
			local comm = CurAvatar.cachedOpTopPvpReplayData.comm

			self.btnHeadOther:setCommInfo(comm, false, self)

			local name = utils.GetPlayerName(comm.name)

			self.txtOtherName:setText(name)
		end
	elseif CurAvatar.cachedSeniorPvpReplayData then
		local comm = CurAvatar.cachedSeniorPvpReplayData.data.comm

		self.btnHeadOther:setCommInfo(comm, false, self)

		local name = utils.GetPlayerName(comm.name)

		self.txtOtherName:setText(name)
	end

	local isMyAttack = reportData ~= nil and reportData.attack == 1
	local myCamp, otherCamp

	if isMyAttack then
		myCamp = BattleConst.CAMP_PLAYER
		otherCamp = BattleConst.CAMP_MONSTER
	else
		myCamp = BattleConst.CAMP_MONSTER
		otherCamp = BattleConst.CAMP_PLAYER
	end

	local results = replayData[2].results
	local winNum = 0

	for i, winCamp in ipairs(results) do
		if winCamp == myCamp then
			winNum = winNum + 1
		end
	end

	self.txtScore:setText(winNum .. ":" .. #results - winNum)

	local formations = replayData[2].formations
	local pets = replayData[2].pets
	local myFormations = {}
	local myPets = {}
	local otherFormations = {}
	local otherPets = {}

	for i, info in ipairs(formations) do
		myFormations[i] = {}
		otherFormations[i] = {}

		local myData = info[myCamp]

		if myData then
			for j, hero in ipairs(myData) do
				table.insert(myFormations[i], hero)
			end
		end

		local otherData = info[otherCamp]

		if otherData then
			for j, hero in ipairs(otherData) do
				table.insert(otherFormations[i], hero)
			end
		end

		if pets[i] then
			myPets[i] = pets[i][myCamp]
			otherPets[i] = pets[i][otherCamp]
		end
	end

	for i, cell in ipairs(self.recordInfos) do
		if results[i] then
			local isMyWin = results[i] == myCamp

			cell.myTeam:setHeros(myFormations[i], i, not isMyWin)
			cell.myTeam:setPet(myPets[i], not isMyWin)
			cell.myTeam:setResultState(isMyWin)
			cell.otherTeam:setHeros(otherFormations[i], i, isMyWin)
			cell.otherTeam:setPet(otherPets[i], isMyWin)
			cell.otherTeam:setResultState(not isMyWin)
		else
			cell.btnReplay:setVisible(false)
		end
	end
end

function SeniorPvpRecordInfoDlg:onBtnReplayClick(sender)
	if not CurAvatar:isBattleVersionMatch(self.replayData[1].control.version) then
		MsgManager.clientNotice(178)

		return
	end

	local index = sender.index

	CurAvatar:onTeamPvpReplay(self.replayData[1], index)
end

return SeniorPvpRecordInfoDlg
