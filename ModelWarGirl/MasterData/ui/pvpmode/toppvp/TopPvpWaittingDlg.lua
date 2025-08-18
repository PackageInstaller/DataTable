-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpWaittingDlg.lua

local strClassName = "TopPvpWaittingDlg"
local TopPvpWaittingDlg = Class(strClassName, UIControls.Window)
local ResBPPvpRoomTimer = require("ClientData/ResBPPvpRoomTimer")
local ResBPPvpMisc = require("ClientData/ResBPPvpMisc")
local CommonBulletSendPanel = require("UI/PVPMode/TopPVP/CommonBulletSendPanel")

function TopPvpWaittingDlg:ctor(...)
	self:initUI()
end

function TopPvpWaittingDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.txtTitle1 = UIControls.Label(self, "Img1/TextTitle1")
	self.txtTitle2 = UIControls.Label(self, "Img1/TextTitle2")
	self.txtTitle3 = UIControls.Label(self, "Img1/TextTitle3")
	self.txtTime1 = UIControls.Label(self, "Img2/TextTime1")
	self.txtTime2 = UIControls.Label(self, "Img2/TextTime2")
	self.img2 = UIControls.Image(self, "Img2")
	self.btnGamble = UIControls.Button(self, "BtnGamble")

	self.btnGamble:addEventClick(self.onBtnGambleClick)

	self.bulletSendPanel = CommonBulletSendPanel(self, "CommentPanel")
	self._slotsetBulletStateCb = Slot(self.setBulletStateCb, self)
	self._slotbulletSendCb = Slot(self.bulletSendCb, self)
	self.bulletSendPanel.setBulletStateCb = self._slotsetBulletStateCb
	self.bulletSendPanel.bulletSendCb = self._slotbulletSendCb
	self.bulletSendPanel.bulletSendTimeLimit = ResBPPvpMisc[1].bullet_send_cd or 15
	self.bulletSendPanel.bulletLengthLimit = ResBPPvpMisc[1].bullet_send_limit or 200
end

function TopPvpWaittingDlg:show(state, room_id)
	self.roomID = room_id

	ClientTimerManager.RemoveSecondTickUI(self.txtTime1)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime2)

	local actData = CurAvatar:getTopPVPActivityData()
	local timerId = state.timer_id
	local roomStage = actData:getKnockoutRoomStage(timerId)
	local lastTime = ResBPPvpRoomTimer[timerId].last_time
	local remainTime = lastTime + state.start_time - ClientUtils.getServerTime()

	if actData.knockoutStateMap[roomStage] == "Formation" then
		self.img2:setVisible(true)
		self.txtTitle1:setVisible(true)
		self.txtTitle2:setVisible(false)
		self.txtTitle3:setVisible(false)
		self.txtTime2:setVisible(false)
		ClientTimerManager.AddSecondTickUI(self.txtTime1, remainTime, false, "", "", nil, nil, 1)
	end

	local lastTime

	if actData.knockoutStateMap[roomStage] == "FightPrepare" or actData.knockoutStateMap[roomStage] == "FightReq" then
		self.img2:setVisible(false)
		self.txtTitle1:setVisible(false)
		self.txtTitle2:setVisible(false)
		self.txtTitle3:setVisible(true)
	end

	if actData.knockoutStateMap[roomStage] == "CountDown" then
		self.txtTitle1:setVisible(false)
		self.txtTitle2:setVisible(true)
		self.txtTitle3:setVisible(false)
		self.img2:setVisible(true)
		self.txtTime1:setVisible(false)
		self.txtTime2:setVisible(true)
		ClientTimerManager.AddSecondTickUI(self.txtTime2, remainTime, false, "", "", nil, nil, 2)
	end

	if actData then
		self.showBulletFlag = actData:getBulletSwitch()

		if self.showBulletFlag == nil then
			self.btnGamble:setVisible(true)
			self.bulletSendPanel:setBulletState(true)
		else
			self.btnGamble:setVisible(true)
			self.bulletSendPanel:setBulletState(self.showBulletFlag)
		end
	end
end

function TopPvpWaittingDlg:setBulletStateCb(sender, state)
	local actData = CurAvatar:getTopPVPActivityData()
	local maxReq = 0

	if actData then
		actData:updateBulletSwitch(state)

		maxReq = actData:getBulletMaxSeq()
	end

	self.showBulletFlag = state

	if self.showBulletFlag == true then
		if not self.timerBullet then
			local function fun()
				CHATRPC.chatPull("kMsgChannelTypeBarrage", maxReq, self.roomID)
			end

			self.timerBullet = Timer.New(fun, 5, -1)

			self.timerBullet:Start()
		end
	elseif self.timerBullet then
		if actData then
			actData:updateBulletMaxSeq(0)
		end

		self.timerBullet:Stop()

		self.timerBullet = nil
	end
end

function TopPvpWaittingDlg:bulletSendCb(sender, content)
	local actId = CurAvatar:getTopPVPActivityOpId()
	local data = {}

	data.content = content
	data.gid = self.roomID
	data.channel = "kMsgChannelTypeBarrage"

	RPC.bPPvpKnockouotChatReq(actId, data)

	sender.preSendTime = ClientUtils.getServerTime()

	sender:_closeBulletEdit()
end

function TopPvpWaittingDlg:onBtnGambleClick()
	UIManager.getUI("topPvpGambleSimpleDlg", true)

	local actId = CurAvatar:getTopPVPActivityOpId()

	if actId then
		RPC.bPPvpKnockoutBetInfoGet(actId)
	end
end

function TopPvpWaittingDlg:onBtnCloseClick()
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		actData:updateInKnockoutRoomId(nil)
	end

	self:setVisible(false)
end

function TopPvpWaittingDlg:destroy(...)
	local ui = UIManager.tryGetUI("avgBulletEmojiBox")

	if ui and ui:getVisible() then
		ui:setVisible(false)
	end

	TopPvpWaittingDlg.super.destroy(self)
end

return TopPvpWaittingDlg
