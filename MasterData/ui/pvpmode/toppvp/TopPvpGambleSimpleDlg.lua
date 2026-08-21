-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpGambleSimpleDlg.lua

local ResBPPvpRoomTimer = require("ClientData/ResBPPvpRoomTimer")
local ResBPPvpShow = require("ClientData/ResBPPvpShow")
local ResBPPvpMisc = require("ClientData/ResBPPvpMisc")
local ResBPPvpRound = require("ClientData/ResBPPvpRound")
local TopPvpPlayerHeadCell = require("UI/PVPMode/TopPVP/TopPvpPlayerHeadCell")
local strClassName = "TopPvpGambleSimpleDlg"
local TopPvpGambleSimpleDlg = Class(strClassName, UIControls.Window)

function TopPvpGambleSimpleDlg:ctor()
	self:initUI()
end

function TopPvpGambleSimpleDlg:initUI(...)
	self.btnsHead = {}
	self.btnsHead[1] = TopPvpPlayerHeadCell(self, "BgPanel/LeftPlayerPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnsHead[1].playerName = UIControls.Label(self, "BgPanel/LeftPlayerPanel/TextPlayerName")

	self.btnsHead[1]:setEnable(false)

	self.btnsHead[2] = TopPvpPlayerHeadCell(self, "BgPanel/RightPlayerPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnsHead[2].playerName = UIControls.Label(self, "BgPanel/RightPlayerPanel/TextPlayerName")

	self.btnsHead[2]:setEnable(false)

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnSupportLeft = UIControls.Button(self, "BgPanel/LeftSupportPanel/BtnSupport")

	self.btnSupportLeft:addEventClick(self.onBtnSupportLeftClick)

	self.imgStateLeft = UIControls.Image(self, "BgPanel/LeftSupportPanel/ImgState")
	self.btnSupportRight = UIControls.Button(self, "BgPanel/RightSupportPanel/BtnSupport")

	self.btnSupportRight:addEventClick(self.onBtnSupportRightClick)

	self.imgStateRight = UIControls.Image(self, "BgPanel/RightSupportPanel/ImgState")
	self.txtMatch = UIControls.Label(self, "BgPanel/TextMatch")
end

function TopPvpGambleSimpleDlg:setCommData()
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

function TopPvpGambleSimpleDlg:setData(roomData)
	self.roomData = roomData

	self:setCommData()

	local actData = CurAvatar:getTopPVPActivityData()
	local betData = actData.bet
	local roomId = self.roomData.room_id
	local myRound = math.floor(roomId % 100 / 10)
	local betPos

	if betData and betData[myRound] then
		betPos = betData[myRound].bet_pos
	end

	self:setBetPostion(betPos)

	local roundName = ResBPPvpRound[myRound].round_name

	if roundName then
		if roomData.winner ~= 0 then
			self:setBetEndShow()
		else
			local timerId = roomData.state.timer_id

			if timerId == 0 then
				self:setBetingShow()
			else
				local nowstate = ResBPPvpRoomTimer[timerId].state

				if nowstate then
					local actData = CurAvatar:getTopPVPActivityData()
					local cannotState = actData.reKnockoutMap.Formation

					if cannotState < nowstate then
						self:setBetEndShow()
					else
						self:setBetingShow()
					end
				else
					self:setBetingShow()
				end
			end
		end
	end
end

function TopPvpGambleSimpleDlg:setBetingShow(...)
	local roomId = self.roomData.room_id
	local myRound = math.floor(roomId % 100 / 10)
	local roundName = ResBPPvpRound[myRound].round_name

	if roundName then
		self.txtMatch:setText(utils.format(Lang.get(90272), roundName))
	end
end

function TopPvpGambleSimpleDlg:setBetEndShow(...)
	local roomId = self.roomData.room_id
	local myRound = math.floor(roomId % 100 / 10)
	local roundName = ResBPPvpRound[myRound].round_name

	if roundName then
		self.txtMatch:setText(utils.format(Lang.get(90271), roundName))
	end

	self.btnSupportLeft:setVisible(false)
	self.btnSupportRight:setVisible(false)
end

function TopPvpGambleSimpleDlg:setBetPostion(betPos)
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

function TopPvpGambleSimpleDlg:onBtnCloseClick()
	self:setVisible(false)
end

function TopPvpGambleSimpleDlg:checkMymatch()
	for i = 1, 2 do
		if tostring(self.roomData.member[i].uid) == CurAvatar.uid then
			return true
		end
	end

	return false
end

function TopPvpGambleSimpleDlg:checkBetQualification(index)
	if tostring(self.roomData.member[index].uid) == CurAvatar.uid then
		return true
	end

	return false
end

function TopPvpGambleSimpleDlg:onBtnSupportLeftClick()
	local actData = CurAvatar:getTopPVPActivityData()
	local flag, hint = actData:checkCanChangeBetPostion()

	if not flag then
		MsgManager.notice(hint)

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

function TopPvpGambleSimpleDlg:onBtnSupportRightClick()
	local actData = CurAvatar:getTopPVPActivityData()
	local flag, hint = actData:checkCanChangeBetPostion()

	if not flag then
		MsgManager.notice(hint)

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

return TopPvpGambleSimpleDlg
