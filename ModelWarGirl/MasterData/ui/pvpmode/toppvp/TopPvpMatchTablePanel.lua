-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpMatchTablePanel.lua

local TopPvpMatchTablePlayerCell = Class("TopPvpMatchTablePlayerCell", UIControls.Child)
local TopPvpReadyDlg = require("UI/PVPMode/TopPVP/TopPvpReadyDlg")
local ResBPPvpRound = require("ClientData/ResBPPvpRound")
local ResBPPvpShow = require("ClientData/ResBPPvpShow")
local ResBPPvpMisc = require("ClientData/ResBPPvpMisc")
local SHOW_MODE_SIXTY = 1
local SHOW_MODE_EIGHT = 2

function TopPvpMatchTablePlayerCell:ctor()
	self:initUI()
end

function TopPvpMatchTablePlayerCell:initUI()
	self.top1Panel = UIControls.Panel(self, "Top1Panel")
	self.otherPanel = UIControls.Panel(self, "OtherPanel")
	self.panelOtherNml = UIControls.Panel(self, "OtherPanel/NmlPanel")
	self.panelTopNml = UIControls.Panel(self, "Top1Panel/NmlPanel")
	self.btnHeadTop = UIControls.PlayerHeadGridChild(self, "Top1Panel/NmlPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnHeadOther = UIControls.PlayerHeadGridChild(self, "OtherPanel/NmlPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.mask = UIControls.Image(self, "OtherPanel/NmlPanel/Mask")
	self.txtPlayerNameOther = UIControls.Label(self, "OtherPanel/NmlPanel/TextPlayerName")
	self.txtPlayerNameTop1 = UIControls.Label(self, "Top1Panel/NmlPanel/TextPlayerName")
	self.txtNum = UIControls.Label(self, "OtherPanel/TextNum")
	self.txtTop1Num = UIControls.Label(self, "Top1Panel/TextNum")
	self.bg = UIControls.Image(self, "OtherPanel/Bg")
	self.bgTop1 = UIControls.Image(self, "Top1Panel/Bg")
	self.isTop1 = false
end

function TopPvpMatchTablePlayerCell:setPlayer(comm)
	self.bg:setVisible(false)
	self.bgTop1:setVisible(false)
	self.txtNum:setVisible(false)
	self.txtTop1Num:setVisible(false)

	if self.isTop1 then
		self.top1Panel:setVisible(true)
		self.otherPanel:setVisible(false)
		self.panelTopNml:setVisible(true)

		if comm then
			local name = utils.GetPlayerName(comm.name)

			self.txtPlayerNameTop1:setText(name)
			self.btnHeadTop:setCommInfo(comm, true, self)
		end
	else
		self.top1Panel:setVisible(false)
		self.otherPanel:setVisible(true)
		self.panelOtherNml:setVisible(true)

		if comm then
			local name = utils.GetPlayerName(comm.name)

			self.txtPlayerNameOther:setText(name)
			self.btnHeadOther:setCommInfo(comm, true, self)
		end
	end
end

function TopPvpMatchTablePlayerCell:setNil()
	self.bg:setVisible(true)
	self.bgTop1:setVisible(true)
	self.txtNum:setVisible(true)
	self.txtTop1Num:setVisible(true)
	self.panelTopNml:setVisible(false)
	self.panelOtherNml:setVisible(false)
end

function TopPvpMatchTablePlayerCell:setState(state)
	self.mask:setVisible(self.isEliminated)
end

function TopPvpMatchTablePlayerCell:setOrgin(...)
	self.mask:setVisible(false)
end

function TopPvpMatchTablePlayerCell:checkState()
	self.isTop1 = self.mParent.mode == 2 and self.index == 15

	self.top1Panel:setVisible(self.isTop1)
	self.otherPanel:setVisible(not self.isTop1)
end

local TopPvpMatchTableLineCell = Class("TopPvpMatchTableLineCell", UIControls.Child)

function TopPvpMatchTableLineCell:ctor()
	self:initUI()
end

function TopPvpMatchTableLineCell:initUI()
	self.panel = UIControls.Panel(self, "")
	self.btnReplay = UIControls.Button(self, "BtnReplay")

	self.btnReplay:addEventClick(self.onBtnReplayClick)

	self.btnLive = UIControls.Button(self, "BtnLive")

	self.btnLive:addEventClick(self.onBtnLiveClick)
end

function TopPvpMatchTableLineCell:setData(data)
	self.data = data
	self.actObj = self.mParent.actObj
end

function TopPvpMatchTableLineCell:refreshUI()
	if self.isEliminated == true then
		self.panel:playAnimator("MatchResult3" .. self.suffixName, true)

		for i = 1, 2 do
			if self.childPlayers[i] then
				self.childPlayers[i]:setState()
			end
		end
	elseif self.data.winner ~= 0 then
		local timerId = self.data.state.timer_id
		local roomStage = self.mParent.actData:getKnockoutRoomStage(timerId)
		local stageName = self.mParent.actData.knockoutStateMap[roomStage]

		if stageName == "Fight" then
			if self.data.round_time and #self.data.round_time ~= 0 then
				local startTime = self.data.state.start_time
				local cannotQuery = utils.IsSyncBattlePassed(startTime, self.data.round_time)

				if not cannotQuery then
					self.panel:playAnimator("MatchLive" .. self.suffixName)
				else
					self.panel:playAnimator("MatchResult" .. self.data.winner .. self.suffixName, true)

					for i = 1, 2 do
						if self.childPlayers[i] then
							self.childPlayers[i]:setState()
						end
					end
				end
			else
				self.panel:playAnimator("MatchResult" .. self.data.winner .. self.suffixName, true)

				for i = 1, 2 do
					if self.childPlayers[i] then
						self.childPlayers[i]:setState()
					end
				end
			end
		elseif stageName == "FightReq" or stageName == "CountDown" then
			self.panel:playAnimator("MatchLive" .. self.suffixName)
		else
			self.panel:playAnimator("MatchResult" .. self.data.winner .. self.suffixName, true)

			for i = 1, 2 do
				if self.childPlayers[i] then
					self.childPlayers[i]:setState()
				end
			end
		end
	elseif self.data.state.timer_id ~= 0 then
		self.panel:playAnimator("MatchLive" .. self.suffixName)
	else
		local nowState = self.mParent.actData:getTopPvpStage()

		if self.mParent.actData.stateMap[nowState] == "KnockoutRoomPrepare" or self.mParent.actData.stateMap[nowState] == "KnockoutBPPoolSync" then
			self.panel:playAnimator("MatchLive" .. self.suffixName)
		else
			self.panel:playAnimator("MatchOrigin")
		end
	end
end

function TopPvpMatchTableLineCell:clearCacheData(...)
	self.data = nil
	self.isEliminated = false
end

function TopPvpMatchTableLineCell:initChildState()
	if self.isEliminated == true then
		for i = 1, #self.childLines do
			self.childLines[i].isEliminated = true
		end

		for i = 1, #self.childPlayers do
			self.childPlayers[i].isEliminated = true
		end
	elseif self.data and self.data.winner ~= 0 then
		if self.data.winner == 1 then
			if self.childLines[2] then
				self.childLines[2].isEliminated = true
				self.childLines[1].isEliminated = false
			end

			if self.childPlayers[2] then
				self.childPlayers[2].isEliminated = true
				self.childPlayers[1].isEliminated = false
			end
		else
			if self.childLines[1] then
				self.childLines[1].isEliminated = true
				self.childLines[2].isEliminated = false
			end

			if self.childPlayers[1] then
				self.childPlayers[1].isEliminated = true
				self.childPlayers[2].isEliminated = false
			end
		end
	else
		for i = 1, 2 do
			if self.childLines[i] then
				self.childLines[i].isEliminated = false
			end

			if self.childPlayers[i] then
				self.childPlayers[i].isEliminated = false
			end
		end
	end
end

function TopPvpMatchTableLineCell:onBtnLiveClick()
	local cannotQuery = self.mParent.actData:checkKnockoutNowRoundQualification()

	if cannotQuery then
		local haveFormation = self.mParent.actData:checkCacheRoomInfoFormation()

		if not haveFormation then
			local desc = ResBPPvpShow[13070014].desc

			MsgManager.notice(desc)

			return
		end
	end

	local timerId = self.data.state.timer_id
	local roomStage = self.mParent.actData:getKnockoutRoomStage(timerId)
	local stageName = self.mParent.actData.knockoutStateMap[roomStage]

	if stageName == "Fight" and self.data.round_time and #self.data.round_time ~= 0 then
		local startTime = self.data.state.start_time
		local cannotQuery = utils.IsSyncBattlePassed(startTime, self.data.round_time)

		if cannotQuery then
			MsgManager.notice(Lang.get(82866))

			return
		end
	end

	RPC.bPPvpKnockoutEnterRoom(self.actObj.opId, self.mParent.nowSelect, self.data.room_id)
end

function TopPvpMatchTableLineCell:onBtnReplayClick()
	if self.data.replay_id == 0 or self.data.replay_id == "0" or #self.data.round_time == 0 then
		local desc = ResBPPvpShow[13070007].desc

		MsgManager.notice(desc)
	else
		CurAvatar.cachedOpTopPvpKnockoutReplayData = {}
		CurAvatar.cachedOpTopPvpKnockoutReplayData.member = {}

		for i = 1, 2 do
			CurAvatar.cachedOpTopPvpKnockoutReplayData.member[i] = {}
		end

		CurAvatar.cachedOpTopPvpKnockoutReplayData.room_id = self.data.room_id
		CurAvatar.cachedOpTopPvpKnockoutReplayData.replay_id = self.data.replay_id
		CurAvatar.cachedOpTopPvpKnockoutReplayData.round_time = self.data.round_time

		local comm1 = self.mParent:getCommByUid(self.data.member[1].uid)
		local comm2 = self.mParent:getCommByUid(self.data.member[2].uid)

		if self.data.first_user == 2 then
			CurAvatar.cachedOpTopPvpKnockoutReplayData.member[1].comm = comm2
			CurAvatar.cachedOpTopPvpKnockoutReplayData.member[2].comm = comm1
		else
			CurAvatar.cachedOpTopPvpKnockoutReplayData.member[1].comm = comm1
			CurAvatar.cachedOpTopPvpKnockoutReplayData.member[2].comm = comm2
		end

		RPC.pVEBattleReplay(tostring(self.data.replay_id), BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT)
	end
end

local TopPvpBtnListSectionCell = Class("TopPvpBtnListSectionCell", UIControls.Child)

function TopPvpBtnListSectionCell:ctor(...)
	self:initUI()
end

function TopPvpBtnListSectionCell:initUI(...)
	self.text = UIControls.Label(self, "Text")
	self.btnChange = UIControls.Button(self, "")

	self.btnChange:addEventClick(self.ChangeDivision)
end

function TopPvpBtnListSectionCell:setData(index)
	self.index = index

	self.text:setText(utils.format(Lang.get(90275), index))
end

function TopPvpBtnListSectionCell:ChangeDivision()
	if self.mParent.actData then
		self.mParent.nowSelect = self.index

		self.mParent:refreshUI()
	end
end

local TopPvpMatchTablePanel = Class("TopPvpMatchTablePanel", UIControls.Panel)

function TopPvpMatchTablePanel:ctor(...)
	self.actObj = self.mParent.actObj
	self.actData = self.actObj.actData

	self:initUI()
end

function TopPvpMatchTablePanel:initUI()
	self.btnReward = UIControls.Button(self, self.mPath .. "/TipsPanel/BtnReward")

	self.btnReward:addEventClick(self.onBtnRewardClick)

	self.btnGamble = UIControls.Button(self, self.mPath .. "/TipsPanel/BtnGamble")

	self.btnGamble:addEventClick(self.onBtnGambleClick)

	self.txtTime = UIControls.Label(self, self.mPath .. "/TipsPanel/TextTime")
	self.iconNew = UIControls.Image(self, self.mPath .. "/TipsPanel/BtnGamble/IconNew")
	self.imgListSection = UIControls.Image(self, self.mPath .. "/MatchSectionPanel/ListSectionPanel")

	self.imgListSection:setVisible(false)

	self.imgChampion = UIControls.Image(self, "EliminateMatchPanel/MatchTablePanel/ImgChampion")
	self.imgTitle = UIControls.Image(self, "EliminateMatchPanel/MatchTablePanel/ImgTitle")
	self.btnListSection = UIControls.Button(self, self.mPath .. "/MatchSectionPanel/BtnListSection")

	self.btnListSection:addEventClick(self.onBtnListSectionClick)

	self.btnUIClickThrough = UIControls.Button(self, self.mPath .. "/MatchSectionPanel/UIClickThrough")

	self.btnUIClickThrough:addEventClick(self.onBtnUIClickThroughClick)

	self.txtListSection = UIControls.Label(self, self.mPath .. "/MatchSectionPanel/BtnListSection/Text")
	self.imgArrowDwn = UIControls.Image(self, self.mPath .. "/MatchSectionPanel/BtnListSection/ImgArrowDwn")
	self.imgArrowUp = UIControls.Image(self, self.mPath .. "/MatchSectionPanel/BtnListSection/ImgArrowUp")
	self.listSectionOpen = nil
	self.mode = SHOW_MODE_SIXTY
	self.listSectionCells = {}

	for i = 1, 8 do
		local newCell = TopPvpBtnListSectionCell(self, self.mPath .. "/MatchSectionPanel/ListSectionPanel", "System/TopPVP/BtnListSectionCell")

		newCell:setData(i)
		newCell:setVisible(true)
		table.insert(self.listSectionCells, newCell)
	end

	self.playerCells = {}

	for i = 1, 15 do
		local newCell = TopPvpMatchTablePlayerCell(self, self.mPath .. "/PlayerPanel/Player" .. i, "System/TopPVP/TopPVPPlayerCell")

		newCell:setVisible(true)

		newCell.index = i

		table.insert(self.playerCells, newCell)
	end

	self.lineCells = {}

	for i = 1, 4 do
		local newCell = TopPvpMatchTableLineCell(self, self.mPath .. "/LinePanel/LineCell" .. i, "System/TopPVP/TopPvpMatchTableCell1")

		newCell.index = i

		newCell:setVisible(true)

		newCell.childPlayers = {}
		newCell.childLines = {}

		table.insert(newCell.childPlayers, self.playerCells[i * 2 - 1])
		table.insert(newCell.childPlayers, self.playerCells[i * 2])
		table.insert(self.lineCells, newCell)
	end

	for i = 5, 6 do
		local newCell = TopPvpMatchTableLineCell(self, self.mPath .. "/LinePanel/LineCell" .. i, "System/TopPVP/TopPvpMatchTableCell2")

		newCell.index = i

		newCell:setVisible(true)

		newCell.childPlayers = {}

		table.insert(newCell.childPlayers, self.playerCells[i * 2 - 1])
		table.insert(newCell.childPlayers, self.playerCells[i * 2])

		newCell.childLines = {}

		if i == 5 then
			table.insert(newCell.childLines, self.lineCells[1])
			table.insert(newCell.childLines, self.lineCells[2])
		end

		if i == 6 then
			table.insert(newCell.childLines, self.lineCells[3])
			table.insert(newCell.childLines, self.lineCells[4])
		end

		table.insert(self.lineCells, newCell)
	end

	local newCell = TopPvpMatchTableLineCell(self, self.mPath .. "/LinePanel/LineCell" .. 7, "System/TopPVP/TopPvpMatchTableCell3")

	newCell.index = 7

	newCell:setVisible(true)

	newCell.childLines = {}

	table.insert(newCell.childLines, self.lineCells[5])
	table.insert(newCell.childLines, self.lineCells[6])

	newCell.childPlayers = {}

	table.insert(newCell.childPlayers, self.playerCells[13])
	table.insert(newCell.childPlayers, self.playerCells[14])
	table.insert(self.lineCells, newCell)

	newCell.isEliminated = false

	for i = 1, 7 do
		if i == 3 or i == 4 or i == 6 then
			self.lineCells[i].suffixName = "Mirror"
		else
			self.lineCells[i].suffixName = ""
		end
	end
end

function TopPvpMatchTablePanel:setMode(index, actObj)
	self.mode = index

	if actObj and (not self.nowSelect or self.nowSelect == 0) then
		local qualification = self.actData:checkKnockoutNowRoundQualification()

		if qualification then
			local areaId = self.actData:getMyknockoutAreaId()

			if self.mode == 1 and areaId == 9 then
				if self.nowSelect and self.nowSelect ~= 9 then
					self.nowSelect = self.nowSelect or 1
				else
					self.nowSelect = 1
				end
			else
				self.nowSelect = areaId
			end
		else
			local areaId = self.actData:getBetKnockoutAreaId()

			if self.mode == 1 and areaId == 9 then
				if self.nowSelect and self.nowSelect ~= 9 then
					self.nowSelect = self.nowSelect or 1
				else
					self.nowSelect = 1
				end
			else
				self.nowSelect = areaId
			end
		end
	end

	if self.nowSelect > 9 or self.nowSelect < 1 then
		if self.mode == 1 then
			self.nowSelect = 1
		else
			self.nowSelect = 9
		end
	end

	if self.mode == 1 and self.nowSelect >= 9 then
		self.nowSelect = 1
	end

	self:refreshUI()
end

function TopPvpMatchTablePanel:getCommByUid(uid)
	if not uid then
		return
	end

	for index, comm in pairs(self.comms) do
		if comm.uid == tostring(uid) then
			return comm
		end
	end
end

function TopPvpMatchTablePanel:setPlayerCellData(index, data)
	if self.uidVisMap[data.member[1].uid] then
		local uid = data.member[1].uid
		local comm = self:getCommByUid(uid)

		if comm then
			self.playerCells[index * 2 - 1]:setPlayer(comm)
		end
	end

	if self.uidVisMap[data.member[2].uid] then
		local uid = data.member[2].uid
		local comm = self:getCommByUid(uid)

		if comm then
			self.playerCells[index * 2]:setPlayer(comm)
		end
	end

	if index == 7 then
		local canSet = false

		if data.winner ~= 0 then
			local timerId = data.state.timer_id
			local roomStage = self.actData:getKnockoutRoomStage(timerId)
			local stageName = self.actData.knockoutStateMap[roomStage]

			if stageName == "Fight" and data.round_time and data.round_time ~= 0 then
				local startTime = data.state.start_time
				local cannotQuery = utils.IsSyncBattlePassed(startTime, data.round_time)

				if cannotQuery then
					canSet = true
				else
					canSet = false
				end
			else
				canSet = true
			end
		else
			canSet = false
		end

		if canSet then
			local winData

			winData = data.member[data.winner]

			if self.uidVisMap[winData.uid] then
				local uid = winData.uid
				local comm = self:getCommByUid(uid)

				if comm then
					self.playerCells[15]:setPlayer(comm)
				end
			end
		else
			self.playerCells[15]:setNil()
		end
	end
end

function TopPvpMatchTablePanel:refreshUI(data)
	for i = 1, 7 do
		self.lineCells[i].panel:playAnimator("MatchOrigin")
	end

	for i = 1, 15 do
		self.playerCells[i]:setNil()
	end

	self.imgChampion:setVisible(self.mode == SHOW_MODE_EIGHT)
	self.imgTitle:setVisible(self.mode == SHOW_MODE_EIGHT)

	if self.mode == SHOW_MODE_SIXTY then
		self.txtListSection:setText(utils.format(Lang.get(90275), self.nowSelect))

		for i = 1, 8 do
			self.playerCells[i].txtNum:setText("64")
		end

		for i = 9, 12 do
			self.playerCells[i].txtNum:setText("32")
		end

		self.playerCells[13].txtNum:setText("16")
		self.playerCells[14].txtNum:setText("16")
		self.playerCells[15].txtNum:setText("8")
		self.playerCells[15]:checkState()
		self.btnListSection:setVisible(true)
		self:ChangBtnListSectionClickStage(false)
	else
		self.imgListSection:setVisible(false)

		for i = 1, 8 do
			self.playerCells[i].txtNum:setText("8")
		end

		for i = 9, 12 do
			self.playerCells[i].txtNum:setText("4")
		end

		self.playerCells[13].txtNum:setText("2")
		self.playerCells[14].txtNum:setText("2")
		self.playerCells[15].txtTop1Num:setText("1")
		self.playerCells[15]:checkState()
		self.btnListSection:setVisible(false)
	end

	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	local nowState = self.mParent.actData:getTopPvpStage()
	local nowRound = self.mParent.actData:getKnockoutRound()

	if nowRound ~= 0 then
		self.txtTime:setVisible(true)

		local remainTime = self.actData:getCurStageRemainTime()

		if remainTime and remainTime > 0 and self.actData.stateMap[nowState] == "KnockoutRoomPoolPrepare" then
			local function fun()
				self.txtTime:setText(utils.format(Lang.get(90276), ResBPPvpRound[nowRound].round_name))
			end

			local txt = utils.format(Lang.get(90277), ResBPPvpRound[nowRound].round_name)

			txt = string.gsub(txt, "rep", "%%s")

			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, remainTime, false, txt, fun)
		elseif self.actData.stateMap[nowState] == "KnockoutRoomFight" then
			self.txtTime:setText(utils.format(Lang.get(90276), ResBPPvpRound[nowRound].round_name))
		elseif self.actData.stateMap[nowState] == "KnockoutRoomSettle" then
			self.txtTime:setVisible(false)
		elseif self.actData.stateMap[nowState] == "KnockoutRoomShow" then
			self.txtTime:setText(Lang.get(82867))
		else
			self.txtTime:setVisible(false)
		end
	else
		self.txtTime:setVisible(false)
	end

	if not data then
		if self.mode == SHOW_MODE_SIXTY then
			RPC.bPPvpKnockoutGetHallData(self.actObj.opId, self.nowSelect)
		else
			RPC.bPPvpKnockoutGetHallData(self.actObj.opId, 9)
		end

		return
	end

	self:setCommData(data)
end

function TopPvpMatchTablePanel:setCommData(data)
	local uidVisMap = {}
	local uids = {}

	for i, oneroom in pairs(data) do
		for index, one in pairs(oneroom.member) do
			for k, uid in pairs(one) do
				if not uidVisMap[uid] then
					uidVisMap[uid] = true

					table.insert(uids, tostring(uid))
				end
			end
		end
	end

	self.uidVisMap = {}
	self.comms = {}

	local function setCommFun(infos)
		for _, info in pairs(infos) do
			for index, oneroom in pairs(data) do
				for i, player in pairs(oneroom.member) do
					if tostring(player.uid) == info.uid then
						self.uidVisMap[player.uid] = true

						table.insert(self.comms, info.commInfo)
					end
				end
			end
		end

		self:onRefreshData(data)
	end

	CurAvatar:getRoleCommInfosNoTip(uids, setCommFun)
end

function TopPvpMatchTablePanel:onRefreshData(data)
	for i = 1, #self.playerCells do
		self.playerCells[i]:setOrgin()
	end

	self.playerList = {}

	for i = 1, 3 do
		self.playerList[i] = {}
	end

	for index, oneroom in pairs(data) do
		local round = math.floor(oneroom.room_id % 100 / 10)

		if round then
			if round > 3 then
				round = round - 3
			end

			table.insert(self.playerList[round], oneroom)
		end
	end

	for i = 1, 7 do
		self.lineCells[i]:clearCacheData()

		self.lineCells[i].data = nil
		self.lineCells[i].isEliminated = false
	end

	if #self.playerList[1] ~= 0 then
		for i = 1, 4 do
			if self.playerList[1][1].state and self.playerList[1][1].state ~= 0 then
				self.lineCells[i]:setData(self.playerList[1][i])
			end

			self:setPlayerCellData(i, self.playerList[1][i])
		end
	end

	if #self.playerList[2] ~= 0 then
		for i = 5, 6 do
			if self.playerList[2][1].state and self.playerList[2][1].state ~= 0 then
				self.lineCells[i]:setData(self.playerList[2][i - 4])
			end

			self:setPlayerCellData(i, self.playerList[2][i - 4])
		end
	end

	if #self.playerList[3] ~= 0 then
		if self.playerList[3][1].state and self.playerList[3][1].state ~= 0 then
			self.lineCells[7]:setData(self.playerList[3][1])
		end

		self:setPlayerCellData(7, self.playerList[3][1])
	end

	for i = #self.lineCells, 1, -1 do
		if self.lineCells[i].data then
			self.lineCells[i]:initChildState()
		end
	end

	for i = 1, #self.lineCells do
		if self.lineCells[i].data then
			self.lineCells[i]:refreshUI()
		end
	end

	local function func()
		local actData = CurAvatar:getTopPVPActivityData()

		if actData and actData.opactState and actData.opactState ~= Const.OPACT_STATE_CLOSE then
			if self.mode == SHOW_MODE_SIXTY then
				RPC.bPPvpKnockoutGetHallData(self.actObj.opId, self.nowSelect)
			else
				RPC.bPPvpKnockoutGetHallData(self.actObj.opId, 9)
			end
		else
			self.timer:Stop()

			self.timer = nil
		end
	end

	if not self.timer then
		self.timer = Timer.New(func, 10, -1)

		self.timer:Start()
	end

	self:refreshRedDot()
end

function TopPvpMatchTablePanel:onBtnRewardClick()
	UIManager.getUI("topPvpRankingAwardDlg", true):show()
end

local ResBPPvpMisc = require("ClientData/ResBPPvpMisc")

function TopPvpMatchTablePanel:onBtnGambleClick()
	UIManager.getUI("topPvpGambleMainDlg", true)
	RPC.bPPvpKnockoutBetInfoGet(self.actObj.opId)
end

function TopPvpMatchTablePanel:ChangBtnListSectionClickStage(startEdit)
	self.listSectionOpen = startEdit

	self.btnUIClickThrough:setVisible(startEdit)
	self.imgListSection:setVisible(startEdit)
	self.imgArrowUp:setVisible(startEdit)
	self.imgArrowDwn:setVisible(not startEdit)
end

function TopPvpMatchTablePanel:onBtnListSectionClick()
	if self.listSectionOpen == nil then
		self:ChangBtnListSectionClickStage(true)
	else
		self:ChangBtnListSectionClickStage(not self.listSectionOpen)
	end
end

function TopPvpMatchTablePanel:onBtnUIClickThroughClick()
	self:ChangBtnListSectionClickStage(not self.listSectionOpen)
end

function TopPvpMatchTablePanel:onOpen()
	TopPvpMatchTablePanel.super.onOpen(self)
end

function TopPvpMatchTablePanel:destroy()
	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil
end

function TopPvpMatchTablePanel:setVisible(ishow)
	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	TopPvpMatchTablePanel.super.setVisible(self, ishow)
end

function TopPvpMatchTablePanel:refreshRedDot()
	self.iconNew:setVisible(self.actData:checkGambleBtnRedDot())
end

return TopPvpMatchTablePanel
