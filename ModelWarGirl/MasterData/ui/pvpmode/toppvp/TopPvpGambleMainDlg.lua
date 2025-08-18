-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpGambleMainDlg.lua

local ResBPPvpMisc = require("ClientData/ResBPPvpMisc")
local ResBPPvpShow = require("ClientData/ResBPPvpShow")
local ResItem = require("ClientData/ResItem")
local ResRand = require("ClientData/ResRand")
local ResBPPvpRound = require("ClientData/ResBPPvpRound")
local TopPvpGambleRecordCell = Class("TopPvpGambleRecordCell", UIControls.Child)
local TopPvpPlayerHeadCell = require("UI/PVPMode/TopPVP/TopPvpPlayerHeadCell")
local ResBPPvpRoomTimer = require("ClientData/ResBPPvpRoomTimer")

function TopPvpGambleRecordCell:ctor()
	self:initUI()
end

function TopPvpGambleRecordCell:initUI()
	self.txtMatch = UIControls.Label(self, "TextMatch")
	self.btnsHead = {}
	self.btnsHead[1] = TopPvpPlayerHeadCell(self, "LeftPlayerPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnsHead[1].playerName = UIControls.Label(self, "LeftPlayerPanel/TextPlayerName")
	self.imgStateLeft = UIControls.Image(self, "LeftPlayerPanel/TextPlayerName/ImgState")
	self.txtResultLeft = UIControls.Label(self, "LeftPlayerPanel/TextPlayerName/TextResult")
	self.btnsHead[2] = TopPvpPlayerHeadCell(self, "RightPlayerPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnsHead[2].playerName = UIControls.Label(self, "RightPlayerPanel/TextPlayerName")
	self.imgStateRight = UIControls.Image(self, "RightPlayerPanel/TextPlayerName/ImgState")
	self.txtResultRight = UIControls.Label(self, "RightPlayerPanel/TextPlayerName/TextResult")
	self.imgResult = UIControls.Image(self, "ImgResult")
	self.btnPlayback = UIControls.Button(self, "BtnPlayback")

	self.btnPlayback:addEventClick(self.onBtnPlaybackClick)

	self.rewardPanel = UIControls.Panel(self, "RewardPanel")
	self.txtNum = UIControls.Label(self, "RewardPanel/TextNum")

	self.txtNum:setText("+2")

	self.imgIcon = UIControls.Image(self, "RewardPanel/ImgIcon")

	if self.mParent.iconPath and self.mParent.iconName then
		self.imgIcon:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/" .. elf.mParent.iconPath, self.mParent.iconName)
	end
end

function TopPvpGambleRecordCell:setData(data)
	self.data = data

	local roomId = self.data.room_id
	local round = math.floor(roomId % 100 / 10)
	local roundName = ResBPPvpRound[round].round_name

	self.txtMatch:setText(roundName)
	self.btnsHead[1]:setCommInfo(data.comm[1], true, self)

	local name1 = utils.GetPlayerName(data.comm[1].comm.name)

	self.btnsHead[1].playerName:setText(name1)
	self.btnsHead[2]:setCommInfo(data.comm[2], true, self)

	local name2 = utils.GetPlayerName(data.comm[2].comm.name)

	self.btnsHead[2].playerName:setText(name2)

	if data.winner == data.bet_pos then
		self.imgResult:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas8", "TxtResult03")
		self.rewardPanel:setVisible(true)
	else
		self.imgResult:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas8", "TxtResult04")
		self.rewardPanel:setVisible(false)
	end

	if data.bet_pos == 1 then
		self.imgStateLeft:setVisible(true)
		self.imgStateRight:setVisible(false)
	else
		self.imgStateLeft:setVisible(false)
		self.imgStateRight:setVisible(true)
	end

	if data.winner == 1 then
		self.txtResultLeft:setTextWithColor(Lang.get(76984), "QUALITYGREEN")
		self.txtResultRight:setTextWithColor(Lang.get(81139), "COLORBGRANK10")
	else
		self.txtResultLeft:setTextWithColor(Lang.get(81139), "COLORBGRANK10")
		self.txtResultRight:setTextWithColor(Lang.get(76984), "QUALITYGREEN")
	end
end

function TopPvpGambleRecordCell:onBtnPlaybackClick()
	if self.data.replay_id == 0 or self.data.replay_id == "0" then
		local desc = ResBPPvpShow[13070007].desc

		MsgManager.notice(desc)
	else
		self.data.member = {}

		if self.data.first_user == 1 then
			for i = 1, 2 do
				local data = {}

				data.comm = self.data.comm[i].comm

				table.insert(self.data.member, data)
			end
		else
			local data1 = {}

			data1.comm = self.data.comm[2].comm

			table.insert(self.data.member, data1)

			local data2 = {}

			data2.comm = self.data.comm[1].comm

			table.insert(self.data.member, data2)
		end

		CurAvatar.cachedOpTopPvpKnockoutReplayData = self.data

		RPC.pVEBattleReplay(tostring(self.data.replay_id), BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT)
	end
end

local TopPvpGambleInfoPanel = Class("TopPvpGambleInfoPanel", UIControls.Child)

function TopPvpGambleInfoPanel:ctor()
	self:initUI()
end

function TopPvpGambleInfoPanel:initUI()
	self.supportRate = UIControls.Slider(self, "SupportRate")
	self.txtMatch = UIControls.Label(self, "StatePanel/TextMatch")
	self.txtAward = UIControls.Label(self, "StatePanel/TextAward")
	self.btnAward = UIControls.Button(self, "AwardPanel/BtnAward")

	self.btnAward:addEventClick(self.onBtnAwardClick)

	self.btnsHead = {}
	self.btnsHead[1] = TopPvpPlayerHeadCell(self, "LeftPlayerPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnsHead[1].playerName = UIControls.Label(self, "LeftPlayerPanel/TextPlayerName")
	self.btnsHead[2] = TopPvpPlayerHeadCell(self, "RightPlayerPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnsHead[2].playerName = UIControls.Label(self, "RightPlayerPanel/TextPlayerName")
	self.txtRateL = UIControls.Label(self, "SupportRate/TextRateL")
	self.txtRateR = UIControls.Label(self, "SupportRate/TextRateR")
	self.btnSupportLeft = UIControls.Button(self, "LeftSupportPanel/BtnSupport")

	self.btnSupportLeft:addEventClick(self.onBtnSupportLeftClick)

	self.imgStateLeft = UIControls.Image(self, "LeftSupportPanel/ImgState")
	self.btnSupportRight = UIControls.Button(self, "RightSupportPanel/BtnSupport")

	self.btnSupportRight:addEventClick(self.onBtnSupportRightClick)

	self.imgStateRight = UIControls.Image(self, "RightSupportPanel/ImgState")
	self.iconAward = UIControls.Image(self, "AwardPanel/IconAward")
	self.txtNum = UIControls.Label(self, "AwardPanel/TextNum")
	self.btnLiveNml = UIControls.Button(self, "BtnLiveNml")

	self.btnLiveNml:addEventClick(self.onBtnLiveNmlClick)
	self.btnLiveNml:setVisible(false)

	self.btnLiveDis = UIControls.Button(self, "BtnLiveDis")

	self.btnLiveDis:addEventClick(self.onBtnLiveDisClick)
	self.btnLiveDis:setVisible(false)

	self.imgLeftState = UIControls.Image(self, "LeftPlayerPanel/ImgState")
	self.imgRightState = UIControls.Image(self, "RightPlayerPanel/ImgState")
end

function TopPvpGambleInfoPanel:setCommData()
	local uids = {}

	for index, one in pairs(self.roomData.member) do
		for k, uid in pairs(one) do
			table.insert(uids, tostring(uid))
		end
	end

	self.comm = {}

	local function setCommFun(infos)
		for _, info in pairs(infos) do
			for index, one in pairs(self.roomData.member) do
				if tostring(one.uid) == info.uid then
					local data = {}

					data.comm = info.commInfo
					data.power = info.power
					data.stage = info.stage
					self.comm[index] = data

					self.btnsHead[index]:setCommInfo(data, true, self)

					local name = utils.GetPlayerName(data.comm.name)

					self.btnsHead[index].playerName:setText(name)
				end
			end
		end
	end

	CurAvatar:_getRoleInfosCheck(uids, Const.ROLECOMM_GET_TPYE.SIMPLE_PERSONAL, setCommFun)
end

function TopPvpGambleInfoPanel:show(roomData, buleNum, redNum, rightCount)
	local betWinAward = ResBPPvpMisc[1].bet_win_award

	if betWinAward then
		local num = ResRand[betWinAward].parallel[1].num or 0

		self.txtNum:setText(num)
	end

	if self.mParent.iconPath and self.mParent.iconName then
		self.iconAward:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/" .. self.mParent.iconPath, self.mParent.iconName)
	end

	self.txtNum:setText(rightCount * 2)

	self.roomData = roomData

	self:setCommData()

	local actData = CurAvatar:getTopPVPActivityData()
	local flag, blue, red = actData:checkBetNumTime()

	if flag then
		self:setSupportRate(blue, red)
	else
		self:setSupportRate(buleNum, redNum)
	end

	local betData

	if actData then
		betData = actData.bet
	end

	local roomId = self.roomData.room_id
	local myRound = math.floor(roomId % 100 / 10)
	local betPos

	if betData then
		if betData[myRound] then
			betPos = betData[myRound].bet_pos
		end
	else
		betPos = nil
	end

	self:setBetPostion(betPos)

	local desc = ResBPPvpShow[13070009].desc

	self.txtAward:setText(desc)

	local roomId = roomData.room_id
	local round = math.floor(roomId % 100 / 10)
	local roundName = ResBPPvpRound[round].round_name

	if roundName then
		if roomData.winner ~= 0 then
			self.txtMatch:setText(utils.format(Lang.get(90271), roundName))
		else
			local timerId = roomData.state.timer_id

			if timerId == 0 then
				self.txtMatch:setText(utils.format(Lang.get(90272), roundName))
			else
				local nowstate = ResBPPvpRoomTimer[timerId].state

				if nowstate then
					local cannotState = actData.reKnockoutMap.Formation

					if cannotState < nowstate then
						self.txtMatch:setText(utils.format(Lang.get(90271), roundName))
					else
						self.txtMatch:setText(utils.format(Lang.get(90272), roundName))
					end
				else
					self.txtMatch:setText(utils.format(Lang.get(90272), roundName))
				end
			end
		end
	end

	local nowstate = actData:getTopPvpStage()

	if actData.stateMap[nowstate] == "KnockoutRoomFight" then
		if self.roomData.winner and self.roomData.winner ~= 0 then
			-- block empty
		else
			self.btnLiveNml:setVisible(true)
			self.btnLiveDis:setVisible(false)
		end
	else
		self.btnLiveNml:setVisible(false)
		self.btnLiveDis:setVisible(true)
	end

	self.inLiving = false

	if actData.stateMap[nowstate] == "KnockoutRoomFight" or actData.stateMap[nowstate] == "KnockoutRoomPrepare" or actData.stateMap[nowstate] == "KnockoutBPPoolSync" or actData.stateMap[nowstate] == "KnockoutRoomChoose" then
		local roomStage = actData:getKnockoutRoomStage(self.roomData.state.timer_id)

		if actData.knockoutStateMap[roomStage] == "Fight" then
			if self.roomData.round_time and #self.roomData.round_time == 3 then
				local startTime = self.roomData.state.start_time
				local roundTime = self.roomData.round_time
				local cannotQuery = utils.IsSyncBattlePassed(startTime, roundTime)

				if cannotQuery then
					self.inLiving = false
				else
					self.inLiving = true
				end
			else
				self.inLiving = false
			end
		else
			self.inLiving = true
		end
	else
		self.inLiving = false
	end

	self.btnLiveNml:setVisible(self.inLiving)
	self.btnLiveDis:setVisible(not self.inLiving)

	if not self.inLiving and self.roomData.winner and self.roomData.winner ~= 0 then
		self.btnSupportRight:setVisible(false)
		self.btnSupportLeft:setVisible(false)
	end

	if self.roomData.winner and self.roomData.winner ~= 0 and not self.inLiving then
		if self.roomData.winner == 1 then
			self.imgLeftState:setVisible(true)
			self.imgRightState:setVisible(false)
		else
			self.imgLeftState:setVisible(false)
			self.imgRightState:setVisible(true)
		end
	else
		self.imgLeftState:setVisible(false)
		self.imgRightState:setVisible(false)
	end
end

function TopPvpGambleInfoPanel:setSupportRate(buleNum, redNum)
	local persent

	persent = buleNum + redNum == 0 and 0.5 or buleNum / (buleNum + redNum)

	self.supportRate:setValue(persent)

	persent = persent * 100

	local leftRate = math.floor(persent * 10) / 10
	local rightRate = 100 - leftRate

	self.txtRateL:setText(utils.format(Lang.get(90273), leftRate))
	self.txtRateR:setText(utils.format(Lang.get(90273), rightRate))
end

function TopPvpGambleInfoPanel:setBetPostion(betPos)
	if betPos == 1 then
		self.btnSupportLeft:setVisible(false)
		self.btnSupportRight:setVisible(true)
		self.imgStateRight:setVisible(false)
		self.imgStateLeft:setVisible(true)
	elseif betPos == 2 then
		self.btnSupportLeft:setVisible(true)
		self.btnSupportRight:setVisible(false)
		self.imgStateRight:setVisible(true)
		self.imgStateLeft:setVisible(false)
	else
		self.imgStateRight:setVisible(false)
		self.imgStateLeft:setVisible(false)
		self.btnSupportLeft:setVisible(true)
		self.btnSupportRight:setVisible(true)
	end
end

function TopPvpGambleInfoPanel:checkBetQualification(index)
	if tostring(self.roomData.member[index].uid) == CurAvatar.uid then
		return true
	end

	return false
end

function TopPvpGambleInfoPanel:checkMymatch(...)
	for i = 1, 2 do
		if tostring(self.roomData.member[i].uid) == CurAvatar.uid then
			return true
		end
	end

	return false
end

function TopPvpGambleInfoPanel:getPreciseDecimal(nNum, n)
	if type(nNum) ~= "number" then
		return nNum
	end

	n = n or 0
	n = math.floor(n)

	if n < 0 then
		n = 0
	end

	local nDecimal = 10^n
	local nTemp = math.floor(nNum * nDecimal)
	local nRet = nTemp / nDecimal

	return nRet
end

function TopPvpGambleInfoPanel:checkNowInLiving(...)
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		self.inLiving = false

		if actData.stateMap[nowstate] == "KnockoutRoomFight" or actData.stateMap[nowstate] == "KnockoutRoomPrepare" or actData.stateMap[nowstate] == "KnockoutBPPoolSync" or actData.stateMap[nowstate] == "KnockoutRoomChoose" then
			local roomStage = actData:getKnockoutRoomStage(self.roomData.state.timer_id)

			if actData.knockoutStateMap[roomStage] == "Fight" then
				if self.roomData.round_time and #self.roomData.round_time == 3 then
					local startTime = self.roomData.state.start_time
					local roundTime = self.roomData.round_time
					local cannotQuery = utils.IsSyncBattlePassed(startTime, roundTime)

					if cannotQuery then
						self.inLiving = false
					else
						self.inLiving = true
					end
				else
					self.inLiving = false
				end
			else
				self.inLiving = true
			end
		else
			self.inLiving = false
		end

		self.btnLiveNml:setVisible(self.inLiving)
		self.btnLiveDis:setVisible(not self.inLiving)
	end

	return self.inLiving
end

function TopPvpGambleInfoPanel:onBtnLiveNmlClick()
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		local cannotQuery = actData:checkKnockoutNowRoundQualification()

		if cannotQuery then
			local haveFormation = actData:checkCacheRoomInfoFormation()

			if not haveFormation then
				local desc = ResBPPvpShow[13070014].desc

				MsgManager.notice(desc)

				return
			end
		end

		local nowstate = actData:getTopPvpStage()

		if actData.stateMap[nowstate] == "KnockoutRoomPoolPrepare" then
			local resData = ResBPPvpShow[13070016]

			if resData then
				local hint = resData.desc

				if hint then
					MsgManager.notice(hint)
				end
			end

			local actId = CurAvatar:getTopPVPActivityOpId()

			if actId then
				RPC.bPPvpKnockoutBetInfoGet(actId)
			end

			return
		end

		local actId = CurAvatar:getTopPVPActivityOpId()
		local areaId = math.floor(self.roomData.room_id % 1000 / 100)

		if areaId and areaId ~= 0 then
			self.mParent:setVisible(false)
			RPC.bPPvpKnockoutEnterRoom(actId, areaId, self.roomData.room_id)
		end
	end
end

function TopPvpGambleInfoPanel:onBtnLiveDisClick()
	if self.roomData.winner and self.roomData.winner ~= 0 then
		MsgManager.notice(Lang.get(83031))
	else
		MsgManager.notice(Lang.get(83032))
	end
end

function TopPvpGambleInfoPanel:onBtnSupportLeftClick()
	local actData = CurAvatar:getTopPVPActivityData()
	local flag, hint = actData:checkCanChangeBetPostion()

	if not flag then
		MsgManager.notice(hint)

		return
	end

	local nowstate = actData:getTopPvpStage()

	if actData.stateMap[nowstate] == "KnockoutRoomShow" then
		local desc = ResBPPvpShow[13070005].desc

		MsgManager.notice(desc)

		return
	end

	if self:checkMymatch() then
		if self:checkBetQualification(1) then
			local actId = CurAvatar:getTopPVPActivityOpId()
			local roomId = self.roomData.room_id

			RPC.bPPvpKnockoutBet(actId, roomId, 1)
		else
			local desc = ResBPPvpShow[13070013].desc

			MsgManager.notice(desc)
		end
	else
		local actId = CurAvatar:getTopPVPActivityOpId()
		local roomId = self.roomData.room_id

		RPC.bPPvpKnockoutBet(actId, roomId, 1)
		actData:updateChangeBetTime()
	end
end

function TopPvpGambleInfoPanel:onBtnSupportRightClick()
	local actData = CurAvatar:getTopPVPActivityData()
	local flag, hint = actData:checkCanChangeBetPostion()

	if not flag then
		MsgManager.notice(hint)

		return
	end

	local nowstate = actData:getTopPvpStage()

	if actData.stateMap[nowstate] == "KnockoutRoomShow" then
		local desc = ResBPPvpShow[13070005].desc

		MsgManager.notice(desc)

		return
	end

	if self:checkMymatch() then
		if self:checkBetQualification(2) then
			local actId = CurAvatar:getTopPVPActivityOpId()
			local roomId = self.roomData.room_id

			RPC.bPPvpKnockoutBet(actId, roomId, 2)
		else
			local desc = ResBPPvpShow[13070013].desc

			MsgManager.notice(desc)
		end
	else
		local actId = CurAvatar:getTopPVPActivityOpId()
		local roomId = self.roomData.room_id

		RPC.bPPvpKnockoutBet(actId, roomId, 2)
		actData:updateChangeBetTime()
	end
end

function TopPvpGambleInfoPanel:onBtnAwardClick()
	UIManager.getUI("topPvpGambleAwardTipsDlg", true)
end

local strClassName = "TopPvpGambleMainDlg"
local TopPvpGambleMainDlg = Class(strClassName, UIControls.Window)

function TopPvpGambleMainDlg:ctor()
	self:initUI()
end

function TopPvpGambleMainDlg:initUI()
	self.tabGamble = UIControls.Button(self, "BgPanel/TabGamble")

	self.tabGamble:addEventClick(self.onTabGambleClick)

	self.iconNew = UIControls.Image(self, "BgPanel/TabGamble/IconNew")
	self.tabRecord = UIControls.Button(self, "BgPanel/TabRecord")

	self.tabRecord:addEventClick(self.onTabRecordClick)

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.recordPanel = UIControls.Panel(self, "BgPanel/RecordPanel")
	self.noContentGambleRecord = UIControls.Panel(self, "BgPanel/RecordPanel/NoContent")
	self.gambleInfoPanel = UIControls.Panel(self, "BgPanel/GambleInfoPanel")
	self.noContentGambleInfo = UIControls.Image(self, "BgPanel/GambleInfoPanel/NoContent")
	self.panelGambleInfo = TopPvpGambleInfoPanel(self, "BgPanel/GambleInfoPanel", "System/TopPVP/GambleInfoPanel")
	self.Cells = {}

	for i = 1, 6 do
		local newCell = TopPvpGambleRecordCell(self, "BgPanel/RecordPanel/RecordList/Content", "System/TopPVP/TopPVPGambleRecordCell")

		table.insert(self.Cells, newCell)
	end

	local coidId = ResBPPvpMisc[1].bet_coin
	local item = ResItem[coidId]

	if item then
		self.iconPath = item.sourceIconPath
		self.iconName = item.sourceIcon
	end

	self.btnTips = UIControls.Button(self, "BgPanel/BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		self.iconNew:setVisible(actData:checkGambleBtnRedDot())
	end
end

function TopPvpGambleMainDlg:refreshRedDot(...)
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		self.iconNew:setVisible(actData:checkGambleBtnRedDot())
	end
end

function TopPvpGambleMainDlg:setGambleInfoData(roomData, buleNum, redNum, rightCount)
	self.recordPanel:setVisible(false)
	self.gambleInfoPanel:setVisible(true)
	self.tabGamble:setEnable(false)
	self.tabRecord:setEnable(true)
	self.panelGambleInfo:setVisible(true)
	self.panelGambleInfo:show(roomData, buleNum, redNum, rightCount)
	self:refreshRedDot()
end

function TopPvpGambleMainDlg:setGambleRecordData(betData)
	self.recordPanel:setVisible(true)
	self.gambleInfoPanel:setVisible(false)
	self.tabGamble:setEnable(true)
	self.tabRecord:setEnable(false)

	if betData and #betData ~= 0 then
		self.recordPanel:setVisible(true)
		self.noContentGambleRecord:setVisible(false)

		if #betData > #self.Cells then
			for i = 1, #betData - #self.Cells do
				local newCell = TopPvpGambleRecordCell(self, "BgPanel/RecordPanel/RecordList/Content")

				table.insert(self.Cells, newCell)
			end
		end

		local index = 1

		for i = 1, #betData do
			if betData[i].winner ~= 0 then
				index = index + 1

				self.Cells[i]:setData(betData[i])
				self.Cells[i]:setVisible(true)
			else
				self.Cells[i]:setVisible(false)
			end
		end

		for i = index, #self.Cells do
			if self.Cells[i] then
				self.Cells[i]:setVisible(false)
			end
		end

		if index == 1 then
			self.noContentGambleRecord:setVisible(true)
		else
			self.noContentGambleRecord:setVisible(false)
		end
	else
		self.noContentGambleRecord:setVisible(true)
	end
end

function TopPvpGambleMainDlg:onGambleEnd()
	self.recordPanel:setVisible(false)
	self.gambleInfoPanel:setVisible(true)
end

function TopPvpGambleMainDlg:onTabGambleClick()
	local actId = CurAvatar:getTopPVPActivityOpId()

	if actId then
		RPC.bPPvpKnockoutBetInfoGet(actId)
	end
end

function TopPvpGambleMainDlg:onTabRecordClick()
	self.recordPanel:setVisible(true)
	self.gambleInfoPanel:setVisible(false)

	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		local isEmpty = actData:betRecordIsEmpty()

		if isEmpty then
			local data = {}

			self:setGambleRecordData(data)
		else
			local actId = CurAvatar:getTopPVPActivityOpId()

			RPC.bPPvpKnockoutBetHistoryGet(actId)
		end
	end
end

function TopPvpGambleMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

function TopPvpGambleMainDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(367)
end

return TopPvpGambleMainDlg
