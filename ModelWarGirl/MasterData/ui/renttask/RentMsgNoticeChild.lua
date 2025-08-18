-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentMsgNoticeChild.lua

local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local ResClanMisc = require("ClientData/ResClanMisc")
local RENT_NOTICE = 1
local CIRCLE_INVITE = 2
local GIFTDRAW_NOTICE = 3
local RentMsgNoticeChild = Class("RentMsgNoticeChild", UIControls.Child)

function RentMsgNoticeChild:ctor(...)
	self:initUI()
end

function RentMsgNoticeChild:initUI(...)
	self.closeBtn = UIControls.Button(self, "Bg/BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.panelCaseTask = UIControls.Panel(self, "Bg/CaseTaskPanel")
	self.taskTitleTxt = UIControls.Label(self, "Bg/CaseTaskPanel/TextTitle")
	self.noticeTxt = UIControls.Label(self, "Bg/CaseTaskPanel/TextContent")
	self.playerNameTxt = UIControls.Label(self, "Bg/CaseTaskPanel/TextPlayerName")
	self.playerGenderImg = UIControls.Image(self, "Bg/CaseTaskPanel/TextPlayerName/IconSex")
	self.playerRelationImg = UIControls.Image(self, "Bg/CaseTaskPanel/TextPlayerName/ImgRelationship")
	self.playerRelationExtraImg = UIControls.Image(self, "Bg/CaseTaskPanel/TextPlayerName/ImgRelationship2")
	self.friendGiftPanel = UIControls.Panel(self, "Bg/FriendGiftPanel")
	self.giftTxt = UIControls.Label(self, "Bg/FriendGiftPanel/TextNum")
	self.denyBtn = UIControls.Button(self, "Bg/OperatingPanel/BtnDeny")

	self.denyBtn:addEventClick(self._onClickDeny)

	self.denyBtnText = UIControls.Label(self, "Bg/OperatingPanel/BtnDeny/Text")
	self.confirmBtn = UIControls.Button(self, "Bg/OperatingPanel/BtnConfirm")

	self.confirmBtn:addEventClick(self._onClickConfirm)

	self.goBtn = UIControls.Button(self, "Bg/OperatingPanel/BtnGo")

	self.goBtn:addEventClick(self._onClickGo)

	self.readBtn = UIControls.Button(self, "Bg/OperatingPanel/BtnRead")

	self.readBtn:addEventClick(self._onClickRead)

	if not RegionUtils.isJP() then
		self.panelCircleInfo = UIControls.Panel(self, "Bg/CircleInfoPanel")
		self.txtCircleName = UIControls.Label(self, "Bg/CircleInfoPanel/TextName")
		self.txtCircleLv = UIControls.Label(self, "Bg/CircleInfoPanel/TextLevelPanel/TextLevel")
		self.txtCircleActive = UIControls.Label(self, "Bg/CircleInfoPanel/CircleActivePanel/Text")
	end

	self.panelBg = UIControls.Panel(self, "Bg")
	self.countDownSlider = UIControls.Slider(self, "Bg/Slider")
	self.slotOfRefreshPlayerData = Functor(self.refreshPlayerCommonData, self, false)
	self.slotOfRefreshPlayerDataExtra = Functor(self.refreshPlayerCommonData, self, true)
	self.slotOfCountDownTimer = Slot(self._onTimerTick, self)
	self.grouponPanel = UIControls.Panel(self, "Bg/GrouponPanel")
	self.textGrouponTitle = UIControls.Label(self, "Bg/GrouponPanel/TextTitle")
	self.iconGrouponSex = UIControls.Image(self, "Bg/GrouponPanel/TextPlayerName/IconSex")
	self.textGrouponPlayerName = UIControls.Label(self, "Bg/GrouponPanel/TextPlayerName")
	self.textGroupoServer = UIControls.Label(self, "Bg/GrouponPanel/TextServer")
end

function RentMsgNoticeChild:changeNoticeShowType(showType)
	if showType == CIRCLE_INVITE then
		self.panelBg:playStateAnimator("CircleChildNews")
	elseif showType == RENT_NOTICE then
		self.panelBg:playStateAnimator("HardChildCaseTaskNews")
	elseif showType == GIFTDRAW_NOTICE then
		self.panelBg:playStateAnimator("GrouponChildNews")
	end
end

function RentMsgNoticeChild:requestNotice(recordInfo, playerComm, leftTick)
	self.noticeType = Const.RENT_NOTICE_TYPE.ReqMsg

	self:changeNoticeShowType(RENT_NOTICE)

	self.uid = recordInfo.renterUid
	self.teamId = recordInfo.teamId
	self.groupTaskId = recordInfo.groupTaskId
	self.overdueTick = recordInfo.overdueTick
	self.taskId = recordInfo.taskId

	local taskTitle = RentTaskUtils.getTaskTitle(recordInfo.taskId)

	self.taskTitleTxt:setText(taskTitle)
	self.noticeTxt:setText(string.format(RentTaskUtils.getRentNotice(6), self.teamId))

	if playerComm and playerComm.uid then
		self:_showPlayerInfo(playerComm, false)
	else
		CurAvatar:getRoleCommInfosNoTip({
			self.uid
		}, self.slotOfRefreshPlayerData)
	end

	self.friendGiftPanel:setVisible(true)
	self:_showPreviewFriend(self.overdueTick, self.taskId)
	self.denyBtn:setVisible(true)
	self.confirmBtn:setVisible(true)
	self.goBtn:setVisible(false)
	self.readBtn:setVisible(false)
	self:startCountDown(leftTick)
end

function RentMsgNoticeChild:responseNotice(recordInfo, playerComm, leftTick)
	self.noticeType = Const.RENT_NOTICE_TYPE.RespMsg

	self:changeNoticeShowType(RENT_NOTICE)

	self.uid = recordInfo.uid
	self.teamId = recordInfo.teamId
	self.groupTaskId = recordInfo.groupTaskId
	self.overdueTick = recordInfo.overdueTick

	local rentTaskData = RentTaskUtils.getGroupTaskSvrData(self.groupTaskId)

	if rentTaskData and rentTaskData.selection and rentTaskData.selection ~= 0 then
		local taskTitle = RentTaskUtils.getTaskTitle(rentTaskData.selection)

		self.taskTitleTxt:setText(taskTitle)

		self.msgInvalid = nil
	else
		self.msgInvalid = true

		self.taskTitleTxt:setText()
	end

	self.noticeTxt:setText(RentTaskUtils.getRentNotice(7))

	if playerComm and playerComm.uid then
		self:_showPlayerInfo(playerComm, true)
	else
		CurAvatar:getRoleCommInfosNoTip({
			self.uid
		}, self.slotOfRefreshPlayerDataExtra)
	end

	self.friendGiftPanel:setVisible(false)
	self.denyBtn:setVisible(false)
	self.confirmBtn:setVisible(false)
	self.goBtn:setVisible(true)
	self.readBtn:setVisible(false)
	self:startCountDown(leftTick)
end

function RentMsgNoticeChild:letterNotice(recordInfo, playerComm, leftTick)
	self.noticeType = Const.RENT_NOTICE_TYPE.Letter

	self:changeNoticeShowType(RENT_NOTICE)

	self.letterRecord = recordInfo

	self.noticeTxt:setText(RentTaskUtils.getRentNotice(8))

	if playerComm and playerComm.uid then
		self:_showPlayerInfo(playerComm, false)
	else
		CurAvatar:getRoleCommInfosNoTip({
			self.uid
		}, self.slotOfRefreshPlayerData)
	end

	local taskTitle = RentTaskUtils.getTaskTitle(recordInfo.taskId)

	self.taskTitleTxt:setText(taskTitle)
	self.giftTxt:setText("+" .. recordInfo.giftNum)
	self.friendGiftPanel:setVisible(true)
	self.denyBtn:setVisible(false)
	self.confirmBtn:setVisible(false)
	self.goBtn:setVisible(true)
	self.readBtn:setVisible(true)
	self:startCountDown(leftTick)
end

function RentMsgNoticeChild:circleInviteNotice(inviteInfo, circle, leftTick)
	self.noticeType = Const.RENT_NOTICE_TYPE.CircleInvite

	self:changeNoticeShowType(CIRCLE_INVITE)

	self.inviteInfo = inviteInfo
	self.overdueTick = inviteInfo.tick + ResClanMisc[1].invite_duetime * 3600

	self.panelCircleInfo:setVisible(true)

	if not self.gridCircle then
		self.gridCircle = UIControls.GridCircleCommonChild(self, "Bg/CircleInfoPanel/CircleHeadPanel", "System/Common/Grid/GridCircleCommon", 0, 0, true)

		self.gridCircle:setSelectCallback(Slot(self.onGridCircleClick, self))
	end

	self.circle = circle

	self.gridCircle:setCircle(self.circle)
	self.txtCircleName:setText(self.circle.name)

	if RegionUtils.isSEA() then
		self.txtCircleLv:setText(self.circle.level)
	elseif Const.REVIEW_VERSION then
		self.txtCircleLv:setText(utils.format(Lang.get(111360), self.circle.level))
	else
		self.txtCircleLv:setText(utils.format("LV.%1s", self.circle.level))
	end

	self.txtCircleActive:setText(self.circle.weekExp)
	self.friendGiftPanel:setVisible(false)
	self.denyBtn:setVisible(true)
	self.confirmBtn:setVisible(true)
	self.goBtn:setVisible(false)
	self.readBtn:setVisible(false)
	self:startCountDown(leftTick)
end

function RentMsgNoticeChild:opActGiftDrawNotice(actInfo, playerComm, leftTick)
	self.noticeType = Const.RENT_NOTICE_TYPE.GiftDrawMsg

	self:changeNoticeShowType(GIFTDRAW_NOTICE)

	self.giftDrawActInfo = actInfo

	if not self.playerGiftDrawHead then
		self.playerGiftDrawHead = UIControls.PlayerHeadGridChild(self, "Bg/GrouponPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

		self.playerGiftDrawHead:setEnable(true)
		self.playerGiftDrawHead:hideLevel()
	end

	self.playerGiftDrawHead:setCommInfo(playerComm, true, self)

	local genderImg = UIConst.getGenderImagePath(playerComm.gender)

	if genderImg and #genderImg == 2 then
		self.iconGrouponSex:setImage(genderImg[1], genderImg[2])
	end

	local strName = utils.GetPlayerName(playerComm.name)

	self.textGrouponPlayerName:setText(strName)
	self.textGroupoServer:setText(playerComm.serverName)
	self.textGrouponTitle:setText(utils.format(Lang.get(88772), actInfo.levelTitle, actInfo.round))
	self.friendGiftPanel:setVisible(false)
	self.denyBtn:setVisible(true)
	self.denyBtnText:setText(Lang.get(1757))
	self.confirmBtn:setVisible(false)
	self.goBtn:setVisible(false)
	self.readBtn:setVisible(true)
	self:startCountDown(leftTick)
end

function RentMsgNoticeChild:onGridCircleClick()
	self:_openShowCircle()
end

function RentMsgNoticeChild:_openShowCircle()
	local circle = CurAvatar:tryGetCircleDetailInfo(self.circle.gid)

	if circle or self.circle.gid == CurAvatar.circleRoleData.clangid then
		local showCircleDlg = UIManager.getUI("showCircleDlg", true)

		if circle then
			showCircleDlg:setCircle(circle)
		end
	end
end

function RentMsgNoticeChild:_showPlayerInfo(info, bebonded)
	if not self.playerHead then
		self.playerHead = UIControls.PlayerHeadGridChild(self, "Bg/CaseTaskPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

		self.playerHead:setEnable(true)
		self.playerHead:hideLevel()
	end

	self.playerHead:setCommInfo(info, true, self)

	local playerName
	local nameList = utils.splitString(info.name, "-")

	if nameList[2] == "" or nameList[2] == nil then
		playerName = info.name
	else
		playerName = nameList[2]
	end

	local nameResult, hasClip = ClientUtils.subStringByLength(playerName or "", 8)

	if hasClip then
		nameResult = nameResult .. "..."
	end

	self.playerNameTxt:setText(nameResult)

	local genderImg = UIConst.getGenderImagePath(info.gender)

	if genderImg and #genderImg == 2 then
		self.playerGenderImg:setImage(genderImg[1], genderImg[2])
	end

	if bebonded then
		RentTaskUtils.setRelationImage(self.playerRelationImg, info.uid, true, self.playerRelationExtraImg)
	else
		self.playerRelationExtraImg:setVisible(false)
		RentTaskUtils.setRelationImage(self.playerRelationImg, info.uid)
	end
end

function RentMsgNoticeChild:_showPreviewFriend(overdueTick, taskId)
	if overdueTick then
		local taskLastLong = RentTaskUtils.getTaskTimeLimit() * 3600
		local taskStartTime = overdueTick - taskLastLong
		local taskIsUp = CurAvatar:calcRentUpWeek(taskStartTime)
		local oriNum = RentTaskUtils.getTaskGiftNum(taskId, taskIsUp) or 0
		local maxNum = RentTaskUtils.getGiftWeekLimitByUp(taskIsUp)
		local nowNum = CurAvatar.rentGiftNum

		self.giftTxt:setVisible(true)
		self.giftTxt:setText("+" .. math.min(oriNum, maxNum - nowNum))

		return
	end

	self.giftTxt:setVisible(false)
end

function RentMsgNoticeChild:refreshPlayerCommonData(bebonded, infos)
	if not self.id then
		return
	end

	local info = infos[1]

	self:_showPlayerInfo(info.commInfo, bebonded)
end

function RentMsgNoticeChild:startCountDown(leftTick)
	self:stopCountDown()

	self.closeTimer = Timer.New(self.slotOfCountDownTimer, leftTick, 1)

	self.closeTimer:Start()
	self.countDownSlider:setValue(leftTick / RentMsgManager.COUNT_DOWN_TICK)
	self.countDownSlider:setValue(0, leftTick)
end

function RentMsgNoticeChild:ensureSlider()
	local sliderNowValue = self.countDownSlider:getValue()

	if sliderNowValue and sliderNowValue > 0 and sliderNowValue <= 1 then
		local leftTick = sliderNowValue * RentMsgManager.COUNT_DOWN_TICK

		self.countDownSlider:setValue(0, leftTick)
	end
end

function RentMsgNoticeChild:stopCountDown(...)
	if self.closeTimer then
		self.closeTimer:Stop()

		self.closeTimer = nil
	end
end

function RentMsgNoticeChild:clear(...)
	self:stopCountDown()
end

function RentMsgNoticeChild:_onTimerTick(...)
	RentMsgManager.closeByTickEnd(self.noticeType == Const.RENT_NOTICE_TYPE.CircleInvite)
end

function RentMsgNoticeChild:_onClickDeny(...)
	if not self:_canOpt() then
		return
	end

	if self.noticeType == Const.RENT_NOTICE_TYPE.ReqMsg then
		if self.overdueTick and ClientUtils.getServerTime() >= self.overdueTick then
			RentMsgManager.closeByOverdue()
		else
			RentTaskUtils.refuseBorrowRequest(self.groupTaskId, self.uid, self.teamId)
			RentMsgManager.closeByOperate()
		end
	elseif self.noticeType == Const.RENT_NOTICE_TYPE.CircleInvite then
		if self.overdueTick and ClientUtils.getServerTime() >= self.overdueTick then
			RentMsgManager.closeByOverdue()
		elseif self.circle then
			RPC.clanFuncRefuseInvite(self.circle.gid)
			RentMsgManager.closeByOperate()
		end
	elseif self.noticeType == Const.RENT_NOTICE_TYPE.GiftDrawMsg then
		RentMsgManager.closeByOperate()
	end
end

function RentMsgNoticeChild:_onClickConfirm(...)
	if not self:_canOpt() then
		return
	end

	if self.noticeType == Const.RENT_NOTICE_TYPE.ReqMsg then
		if self.overdueTick and ClientUtils.getServerTime() >= self.overdueTick then
			RentMsgManager.closeByOverdue()
			MsgManager.notice(RentTaskUtils.getRentNotice(15))
		else
			local status = RentTaskUtils.getOwnerRecrodStatus(self.groupTaskId, self.uid, self.teamId)

			if status == Const.RENT_APPLY_STATUS.OtherRented then
				MsgManager.notice(RentTaskUtils.getRentNotice(2))
			elseif status == Const.RENT_APPLY_STATUS.Applying then
				RentTaskUtils.acceptBorrowRequest(self.groupTaskId, self.uid, self.teamId)
			end

			RentMsgManager.closeByOperate()
		end
	elseif self.noticeType == Const.RENT_NOTICE_TYPE.CircleInvite then
		if self.overdueTick and ClientUtils.getServerTime() >= self.overdueTick then
			RentMsgManager.closeByOverdue()
			MsgManager.clientNotice(604)
		elseif self.circle then
			RPC.clanJoin(self.circle.gid, Const.CIRCLE_JOIN_TYPE_INVITE)
			RentMsgManager.closeByOperate()
		end
	end
end

function RentMsgNoticeChild:_onClickGo(...)
	if not self:_canOpt() then
		return
	end

	if self.noticeType == Const.RENT_NOTICE_TYPE.Letter then
		local letterDlg = UIManager.getUI("rentTaskReceiveLetterDlg", true)

		letterDlg:selectLetterListPanel()
		RentMsgManager.closeByOperate()
	elseif self.noticeType == Const.RENT_NOTICE_TYPE.RespMsg then
		if self.msgInvalid or not RentTaskUtils.isGroupTaskValid(self.groupTaskId) or self.overdueTick and ClientUtils.getServerTime() >= self.overdueTick then
			RentMsgManager.closeByOverdue()
		else
			local borrowDlg = UIManager.getUI("rentTeamBorrowDlg", true)

			if borrowDlg then
				local rentTaskData = RentTaskUtils.getGroupTaskSvrData(self.groupTaskId)
				local taskId = rentTaskData.selection

				if taskId and taskId ~= 0 then
					borrowDlg:setTeamBorrowInfo(self.groupTaskId, taskId)
					borrowDlg:selectNewsPanel()
				end
			end

			RentMsgManager.closeByOperate()
		end
	end
end

function RentMsgNoticeChild:_onClickRead(...)
	if not self:_canOpt() then
		return
	end

	if self.noticeType == Const.RENT_NOTICE_TYPE.Letter then
		local ui = UIManager.createUI("rentTaskLetterInfoDlg", true)

		ui:setData(self.letterRecord)

		self.letterRecord.isNew = false

		CurAvatar:checkRentNewLetterRD()
	elseif self.noticeType == Const.RENT_NOTICE_TYPE.GiftDrawMsg then
		local actId = self.giftDrawActInfo.actId
		local levelId = self.giftDrawActInfo.level

		CurAvatar:jumpToShowActivity(actId, {
			levelId
		})
		RentMsgManager.closeByOperate()
	end
end

function RentMsgNoticeChild:_onClickClose(...)
	if not self:_canOpt() then
		return
	end

	RentMsgManager.closeByForceClose(self.noticeType == Const.RENT_NOTICE_TYPE.CircleInvite)
end

function RentMsgNoticeChild:inCloseAni(skipOpt)
	self.skipOpt = skipOpt

	if skipOpt then
		self.skipOverTick = ClientUtils.getServerTime() + 2
	end
end

function RentMsgNoticeChild:_canOpt()
	if self.skipOpt and self.skipOverTick then
		return self.skipOverTick <= ClientUtils.getServerTime()
	else
		return true
	end
end

return RentMsgNoticeChild
