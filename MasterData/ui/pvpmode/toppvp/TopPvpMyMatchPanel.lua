-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpMyMatchPanel.lua

local strClassName = "TopPvpMyMatchPanel"
local TopPvpMyMatchPanel = Class(strClassName, UIControls.Panel)
local ResBPPvpShow = require("ClientData/ResBPPvpShow")
local ResBPPvpRound = require("ClientData/ResBPPvpRound")
local PVPCommon = require("Logic/PVP/PVPCommon")

function TopPvpMyMatchPanel:ctor(...)
	self:initUI()
end

local stageDesc = {
	Lang.get(76412),
	Lang.get(79912),
	Lang.get(79913),
	Lang.get(79914),
	Lang.get(79915),
	Lang.get(79916)
}
local rankDesc = {
	"64",
	"32",
	"16",
	"8",
	"4",
	"2",
	"1"
}

function TopPvpMyMatchPanel:initUI(...)
	self.txtPlayerName = UIControls.Label(self, self.mPath .. "/SelfInfoPanel/TextPlayerName")
	self.txtPower = UIControls.Label(self, self.mPath .. "/SelfInfoPanel/TextPower")
	self.textRankingSuffix = UIControls.Label(self, self.mPath .. "/SelfInfoPanel/RankPanel/Text")
	self.txtNum = UIControls.Label(self, self.mPath .. "/SelfInfoPanel/RankPanel/TextNum")
	self.txtRankNone = UIControls.Label(self, self.mPath .. "/SelfInfoPanel/TextRankNone")
	self.btnBPTeam = UIControls.Button(self, self.mPath .. "/SelfInfoPanel/BtnBPTeam")

	self.btnBPTeam:addEventClick(self.onBtnBPTeamClick)

	self.btnRecord = UIControls.Button(self, self.mPath .. "/SelfInfoPanel/BtnRecord")

	self.btnRecord:addEventClick(self.onBtnRecordClick)

	self.btnChallenge = UIControls.Button(self, self.mPath .. "/SelfInfoPanel/BtnChallenge")

	self.btnChallenge:addEventClick(self.onBtnChallengeClick)

	self.btnChallengeDis = UIControls.Button(self, self.mPath .. "/SelfInfoPanel/BtnChallengeDis")

	self.btnChallengeDis:addEventClick(self.onBtnChallengeDisClick)

	self.iconAbsent = UIControls.Image(self, self.mPath .. "/SelfInfoPanel/BtnBPTeam/IconAbsent")
	self.iconNew = UIControls.Image(self, self.mPath .. "/SelfInfoPanel/BtnBPTeam/IconNew")
	self.panelMatchInfo = UIControls.Image(self, self.mPath .. "/MatchInfoPanel")
	self.txtStage = UIControls.Label(self, self.mPath .. "/MatchInfoPanel/StagePanel/TextStage")
	self.txtTime = UIControls.Label(self, self.mPath .. "/MatchInfoPanel/TextTime")
	self.txtMatchTips = UIControls.Label(self, self.mPath .. "/MatchInfoPanel/TextMatchTips")
	self.txtRivalPlayerName = UIControls.Label(self, self.mPath .. "/MatchInfoPanel/BgRival/TextPlayerName")
	self.txtRivalPower = UIControls.Label(self, self.mPath .. "/MatchInfoPanel/BgRival/TextPower")
	self.btnRivalHead = UIControls.PlayerHeadGridChild(self, self.mPath .. "/MatchInfoPanel/BgRival/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.bgEliminated = UIControls.Image(self, self.mPath .. "/BgEliminated")
	self.bgEnd = UIControls.Image(self, self.mPath .. "/BgEnd")
	self.bgRivalWaiting = UIControls.Image(self, self.mPath .. "/MatchInfoPanel/BgRivalWaiting")
	self.bgRival = UIControls.Image(self, self.mPath .. "/MatchInfoPanel/BgRival")
end

function TopPvpMyMatchPanel:refreshUI()
	local actData = CurAvatar:getTopPVPActivityData()
	local actId = CurAvatar:getTopPVPActivityOpId()

	if actData then
		local areaId = actData:getMyknockoutAreaId()

		if actId then
			RPC.bPPvpKnockoutRoomInfoGet(actId, areaId, actData.myKnockoutRoomId)
		end
	end
end

function TopPvpMyMatchPanel:refershRedDot()
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		self.iconAbsent:setVisible(actData:checkBpPoolAbsentRedDot())
		self.iconNew:setVisible(actData:checkBpPoolSetRedDot())
	end
end

function TopPvpMyMatchPanel:getCommByUid(uid)
	if not uid then
		return
	end

	for index, comm in pairs(self.comm) do
		if comm.uid == tostring(uid) then
			return comm
		end
	end
end

function TopPvpMyMatchPanel:setCommData()
	local uids = {}

	for index, one in pairs(self.roomData.knockout_member) do
		if one.uid then
			table.insert(uids, tostring(one.uid))
		end
	end

	self.comm = {}
	self.uidVisMap = {}

	local function setCommFun(infos)
		for _, info in pairs(infos) do
			for i, player in pairs(self.roomData.knockout_member) do
				if tostring(player.uid) == info.uid then
					self.comm[i] = info.commInfo
					self.comm[i].power = info.power
				end
			end
		end

		self:setCommshow()
	end

	CurAvatar:_getRoleInfosCheck(uids, Const.ROLECOMM_GET_TPYE.SIMPLE_PERSONAL, setCommFun)
end

function TopPvpMyMatchPanel:setCommshow(...)
	local myUid = CurAvatar.uid
	local rivalUid

	for index, one in pairs(self.roomData.knockout_member) do
		if one.uid ~= myUid then
			rivalUid = one.uid
		end
	end

	local myComm = self:getCommByUid(myUid)

	if myComm then
		local power = myComm.power

		if power then
			self.txtPower:setText(power)
		end
	end

	local rivalComm = self:getCommByUid(rivalUid)

	if rivalComm then
		local power = rivalComm.power

		if power then
			self.txtRivalPower:setText(power)
		end

		local name = utils.GetPlayerName(rivalComm.name)

		self.txtRivalPlayerName:setText(name)
		self.btnRivalHead:setCommInfo(rivalComm, true, self)
	end
end

function TopPvpMyMatchPanel:getMyknockoutRank(...)
	local rank = math.floor(self.roomId % 100 / 10)

	if rank == 6 and self.roomData then
		local myIndex

		for index, player in pairs(self.roomData.knockout_member) do
			if player.uid == CurAvatar.uid then
				myIndex = index
			end
		end

		if myIndex == self.roomData.winner then
			rank = 7
		end
	end

	return rank
end

function TopPvpMyMatchPanel:setData(room_info, comm)
	self:refershRedDot()

	local actData = CurAvatar:getTopPVPActivityData()

	self.roomData = room_info
	self.roomId = room_info.room_id

	self:setCommData()
	self:setCommshow()

	local myIndex

	for index, one in pairs(room_info.knockout_member) do
		if one.uid == CurAvatar.uid then
			myIndex = index
		end
	end

	self.txtPlayerName:setText(CurAvatar.name)
	self.iconAbsent:setVisible(actData:checkBpPoolAbsentRedDot())
	self.iconNew:setVisible(actData:checkBpPoolSetRedDot())

	local roomId = room_info.room_id

	if roomId then
		local nowRound = math.floor(roomId % 100 / 10)

		if nowRound and nowRound <= #ResBPPvpRound then
			self.txtStage:setText(utils.format(Lang.get(90276), ResBPPvpRound[nowRound].round_name))
		end
	end

	local state = actData:getTopPvpStage()
	local flag = actData.stateMap[state] == "KnockoutRoomPoolPrepare"

	self.txtTime:setVisible(flag)

	if flag then
		local remainTime = actData:getCurStageRemainTime()

		if remainTime and remainTime > 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, remainTime, false, Lang.get(79958))
		end
	end

	self.txtMatchTips:setVisible(not flag and actData.stateMap[state] ~= "KnockoutRoomSettle")
	self.txtMatchTips:setText(Lang.get(76471))

	local flag1 = actData.stateMap[state] == "KnockoutRoomPrepare" or actData.stateMap[state] == "KnockoutBPPoolSync" or actData.stateMap[state] == "KnockoutRoomChoose" and room_info.winner == 0
	local flag3 = true

	if room_info.winner == 0 then
		flag3 = false
	else
		local timer_id = room_info.state.timer_id
		local roomStage = actData:getKnockoutRoomStage(timer_id)

		if roomStage and actData.knockoutStateMap[roomStage] == "Fight" and room_info.round_time and #room_info.round_time ~= 0 then
			flag3 = utils.IsSyncBattlePassed(room_info.state.start_time, room_info.round_time)
		end
	end

	local flag2 = flag1 or room_info.state.timer_id ~= 0 and not flag3

	self.btnChallenge:setVisible(flag2)
	self.btnChallengeDis:setVisible(not flag2)

	local round = actData:getKnockoutRound()

	if actData:checkKnockoutEnd() then
		self:setEndShow()
	else
		self.bgEnd:setVisible(false)

		if actData:checkKnockoutNowRoundQualification() then
			if actData.stateMap[state] == "KnockoutRoomFight" then
				local roomStage

				if room_info.winner and room_info.winner ~= 0 then
					local roomStage = actData:getKnockoutRoomStage(room_info.state.timer_id)

					if actData.knockoutStateMap[roomStage] == "Fight" and room_info.round_time and #room_info.round_time == 3 then
						local startTime = room_info.state.start_time
						local round_time = room_info.round_time
						local cannotQuery = utils.IsSyncBattlePassed(startTime, round_time)

						if cannotQuery then
							if room_info.winner == myIndex then
								self.bgRivalWaiting:setVisible(true)
								self.bgRival:setVisible(false)
								self.txtRankNone:setVisible(true)
								self.txtNum:setVisible(false)
							else
								self:setEliminateShow()
							end

							local roomId = room_info.room_id
							local rank = math.floor(roomId % 100 / 10)

							if rank == 6 then
								self:setEndShow()
							end
						else
							self:setOrginShow()
						end
					elseif actData.knockoutStateMap[roomStage] == "Fight" then
						if room_info.winner == myIndex then
							self.bgRivalWaiting:setVisible(true)
							self.bgRival:setVisible(false)
							self.txtRankNone:setVisible(true)
							self.txtNum:setVisible(false)
						else
							self:setEliminateShow()
						end

						local roomId = room_info.room_id
						local rank = math.floor(roomId % 100 / 10)

						if rank == 6 then
							self:setEndShow()
						end
					else
						self:setOrginShow()
					end
				else
					self:setOrginShow()
				end
			elseif actData.stateMap[state] == "KnockoutRoomSettle" then
				if room_info.winner and room_info.winner ~= 0 then
					if room_info.winner ~= myIndex then
						self:setEliminateShow()
					else
						self.bgRivalWaiting:setVisible(true)
						self.bgRival:setVisible(false)

						local roomId = room_info.room_id
						local rank = math.floor(roomId % 100 / 10)

						if rank == 6 then
							self:setEndShow()
						end
					end
				else
					self:setOrginShow()
				end
			else
				self:setOrginShow()
			end
		else
			self:setEliminateShow()
		end
	end
end

function TopPvpMyMatchPanel:setEndShow(...)
	self.panelMatchInfo:setVisible(false)
	self.bgEliminated:setVisible(false)
	self.bgEnd:setVisible(true)
	self.txtRankNone:setVisible(false)

	local rank = self:getMyknockoutRank()

	self.txtNum:setVisible(true)
	self.txtNum:setText(rankDesc[rank])
	self.textRankingSuffix:setVisible(rank <= 5)
	self.btnChallenge:setVisible(false)
	self.btnChallengeDis:setVisible(true)
end

function TopPvpMyMatchPanel:setEliminateShow(...)
	self.bgRival:setVisible(false)

	local rank = self:getMyknockoutRank()

	self.btnChallenge:setVisible(false)
	self.btnChallengeDis:setVisible(true)
	self.txtRankNone:setVisible(false)
	self.txtNum:setVisible(true)
	self.txtNum:setText(rankDesc[rank])
	self.textRankingSuffix:setVisible(rank <= 5)
	self.panelMatchInfo:setVisible(false)
	self.bgEliminated:setVisible(true)
end

function TopPvpMyMatchPanel:setOrginShow(...)
	self.bgRival:setVisible(true)
	self.bgRivalWaiting:setVisible(false)
	self.textRankingSuffix:setVisible(false)
	self.bgEliminated:setVisible(false)
	self.panelMatchInfo:setVisible(true)
	self.txtNum:setVisible(false)
	self.txtRankNone:setVisible(true)
end

function TopPvpMyMatchPanel:onBtnRecordClick()
	local result, hint = PVPCommon.isTopPvpEnd()

	if result then
		MsgManager.notice(hint)

		return
	end

	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		if actData.opTopPvpNextGetKnockoutReportTime > ClientUtils.getServerTime() and actData.record.opBPPvpKnockoutReports then
			UIManager.getUI("topPvpRecordDlg", true):show(BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT)
		else
			local actId = CurAvatar:getTopPVPActivityOpId()

			if actId then
				RPC.bPPvpKnockoutReportGet(actId)
			end
		end
	end
end

function TopPvpMyMatchPanel:onBtnBPTeamClick()
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		local qualification = actData:checkKnockoutQualification()

		if not qualification then
			return
		end
	end

	local qualification = CurAvatar:checkTopPvpBpSetQualification()

	if not qualification then
		local notice = ResBPPvpShow[13070003].desc or Lang.get(78455)

		MsgManager.notice(notice)
	else
		UIManager.getUI("topPvpBpTeamDlg", true)
	end
end

function TopPvpMyMatchPanel:onBtnChallengeClick()
	local actData = CurAvatar:getTopPVPActivityData()
	local state = actData:getTopPvpStage()
	local actId = CurAvatar:getTopPVPActivityOpId()
	local areaId = actData:getMyknockoutAreaId()

	RPC.bPPvpKnockoutEnterRoom(actId, areaId, actData.myKnockoutRoomId)

	local actData = CurAvatar:getTopPVPActivityData()

	if actData and self.comm and (actData.stateMap[state] == "KnockoutRoomPrepare" or actData.stateMap[state] == "KnockoutBPPoolSync") then
		UIManager.getUI("topPvpReadyDlg", true):show(self.comm)
	end
end

function TopPvpMyMatchPanel:onBtnChallengeDisClick()
	local actData = CurAvatar:getTopPVPActivityData()

	if actData:checkKnockoutNowRoundQualification() then
		if self.roomData.winner and self.roomData.winner ~= 0 then
			MsgManager.notice(Lang.get(82868))
		else
			MsgManager.notice(Lang.get(80818))
		end
	else
		local state = actData:getTopPvpStage()

		if actData.stateMap[state] == "KnockoutRoomShow" then
			MsgManager.notice(Lang.get(82867))
		else
			MsgManager.notice(Lang.get(80819))
		end
	end
end

return TopPvpMyMatchPanel
