-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpRecordInfoDlg.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local strClassName = "TopPvpRecordInfoDlg"
local TopPvpRecordInfoDlg = Class(strClassName, UIControls.Window)

function TopPvpRecordInfoDlg:ctor(...)
	self:initUI()
end

function TopPvpRecordInfoDlg:initUI(...)
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

		info.btnReplay:setVisible(false)

		info.btnReplay.index = i
		self.recordInfos[i] = info
	end

	self.btnBPRecord = UIControls.Button(self, "BgPanel/BtnBPRecord")

	self.btnBPRecord:addEventClick(self.onBtnBPRecordClick)
	self.btnBPRecord:setVisible(true)

	self.btnTopPVPReplay = UIControls.Button(self, "BgPanel/BtnTopPVPReplay")

	self.btnTopPVPReplay:addEventClick(self.onBtnTopPVPReplayClick)
	self.btnTopPVPReplay:setVisible(true)
end

function TopPvpRecordInfoDlg:show(replayData, reportData, battleType)
	self.replayData = replayData
	self.battleType = battleType
	self.reportData = reportData

	local comm1 = CurAvatar.cachedOpTopPvpKnockoutReplayData.member[1].comm

	self.btnHeadMine:setCommInfo(comm1, false, self)

	local name = utils.GetPlayerName(comm1.name)

	self.txtMyName:setText(name)

	local comm2 = CurAvatar.cachedOpTopPvpKnockoutReplayData.member[2].comm

	self.btnHeadOther:setCommInfo(comm2, false, self)

	local name = utils.GetPlayerName(comm2.name)

	self.txtOtherName:setText(name)

	local myCamp, otherCamp

	myCamp = BattleConst.CAMP_PLAYER
	otherCamp = BattleConst.CAMP_MONSTER

	local results = replayData[2].results
	local winNum = 0

	for i, winCamp in ipairs(results) do
		if winCamp == myCamp then
			winNum = winNum + 1
		end
	end

	self.txtScore:setText(utils.format("%1s:%2s", winNum, #results - winNum))

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

function TopPvpRecordInfoDlg:onBtnBPRecordClick()
	local actId = CurAvatar:getTopPVPActivityOpId()
	local roomId = self.reportData.room_id
	local areaId = math.floor(roomId % 1000 / 100)

	if actId and roomId and areaId then
		UIManager.getUI("topPvpBpReplayDlg", true)
		RPC.bPPvpKnockoutRoomInfoGet(actId, areaId, roomId)
	end
end

function TopPvpRecordInfoDlg:onBtnTopPVPReplayClick()
	if not CurAvatar:isBattleVersionMatch(self.replayData[1].control.version) then
		MsgManager.clientNotice(178)

		return
	end

	CurAvatar.cachedKnockOutData = {}
	CurAvatar.cachedKnockOutData.startTime = ClientUtils.getServerTime()
	CurAvatar.cachedKnockOutData.roundTime = {}

	for i = 1, #self.reportData.round_time do
		local data = {}

		data.time = self.reportData.round_time[i]

		table.insert(CurAvatar.cachedKnockOutData.roundTime, data)
	end

	CurAvatar.cachedKnockOutData.comm = {}

	for i = 1, #self.reportData.member do
		table.insert(CurAvatar.cachedKnockOutData.comm, self.reportData.member[i].comm)
	end

	CurAvatar:onEnterTopPVPKnockOutRePlay(self.replayData[1])
end

return TopPvpRecordInfoDlg
