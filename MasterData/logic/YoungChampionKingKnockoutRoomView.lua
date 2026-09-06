-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingKnockoutRoomView.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingKnockoutRoomView", package.seeall)

local YoungChampionKingKnockoutRoomView = class("YoungChampionKingKnockoutRoomView", ViewComponent)
local STATE_PREVIEW = 1
local STATE_READY = 2
local STATE_PREPARE = 3
local STATE_WAIT = 4
local STATE_END = 5

function YoungChampionKingKnockoutRoomView:ctor()
	YoungChampionKingKnockoutRoomView.super.ctor(self)
end

function YoungChampionKingKnockoutRoomView:unbindEvents()
	YoungChampionKingKnockoutRoomView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnForm)
	GameUtil.rmClickHandler(self._btnInvite)
	GameUtil.rmClickHandler(self._btnRoom)
end

function YoungChampionKingKnockoutRoomView:bindEvents()
	YoungChampionKingKnockoutRoomView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnForm, self._onClickBtnForm, self)
	GameUtil.addClickHandler(self._btnInvite, self._onClickBtnInvite, self)
	GameUtil.addClickHandler(self._btnRoom, self._onClickBtnRoom, self)
end

function YoungChampionKingKnockoutRoomView:buildUI()
	YoungChampionKingKnockoutRoomView.super.buildUI(self)

	self._knockout = self:getGo("knockout")
	self._txtKnockout = self:getTxt("knockout/txt")
	self._com = self:getGo("com")
	self._cellMyRole = self:buildRoleCell(self:getGo("com/myRole"))
	self._cellEnemyRole = self:buildRoleCell(self:getGo("com/enemyRole"))
	self._tagOnline = self:getGo("com/enemyRole/tagOnline")
	self._tagOffline = self:getGo("com/enemyRole/tagOffline")
	self._txtOpenTime = self:getTxt("com/txtOpenTime")
	self._btnForm = self:getGo("com/btnForm")
	self._btnInvite = self:getGo("com/btnInvite")
	self._txtBtnInvite = self:getTxt("com/btnInvite/txt")
	self._btnRoom = self:getGo("com/btnRoom")
	self._txtBtnRoom = self:getTxt("com/btnRoom/txt")
	self._txtTips = self:getTxt("com/txtTips")
	self._imgTitleChange = self:getGo("com/bg/imgTitle"):GetComponent("UIImageSpriteChange")
	self._tipsWait = self:getGo("com/tipsWait")
end

function YoungChampionKingKnockoutRoomView:buildRoleCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.infoCom = goutil.findChild(cell.go, "infoCom")
	cell.txtPower = goutil.findChildTextComponent(cell.go, "infoCom/txtPower")
	cell.txtNameShow = goutil.findChildTextComponent(cell.go, "infoCom/txtNameShow")
	cell.head = goutil.findChild(cell.go, "head")
	cell.result = goutil.findChild(cell.go, "result")
	cell.resultChange = cell.result:GetComponent("UIImageSpriteChange")
	cell.role = goutil.findChild(cell.go, "role")
	cell.photoEff = AvatarPhotoShow.Get(cell.role)

	cell.photoEff:setRawWidthAndHeight(1280, 720)
	cell.photoEff:setCameraPosition(0, 1, -2)
	cell.photoEff:setCamSize(2.2)

	cell.avatar = nil
	cell.tagReady = goutil.findChild(cell.go, "tagReady")
	cell.colMark = goutil.findChild(cell.go, "colMark")
	cell.markList = {}

	for i = 1, 3 do
		local cellMark = {}

		cellMark.go = goutil.findChild(cell.go, "colMark/mark_" .. i)
		cellMark.mark = goutil.findChild(cellMark.go, "mark")
		cellMark.change = goutil.findChildComponent(cellMark.go, "mark", "UIImageSpriteChange")
		cell.markList[i] = cellMark
	end

	return cell
end

function YoungChampionKingKnockoutRoomView:onExit()
	YoungChampionKingKnockoutRoomView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._cellMyRole.head)
	HeadItemController.instance:resetHeadCell(self._cellEnemyRole.head)
	self._cellMyRole.photoEff:clear()
	self._cellEnemyRole.photoEff:clear()

	self._cellMyRole.avatar = nil
	self._cellEnemyRole.avatar = nil

	removetimer(self._updateTimer, self)
	removetimer(self._updateInviteTimer, self)

	if YoungChampionKingModel.instance:getUserIdIsReady(RoleModel.instance:getUserId()) then
		YoungChampionKingController.instance:sendPM_YCKKnockoutLeaveRoomReq()
	end
end

function YoungChampionKingKnockoutRoomView:onEnter()
	YoungChampionKingKnockoutRoomView.super.onEnter(self)

	self._activityId = YoungChampionKingModel.instance:getCurActId()

	YoungChampionKingController.instance:sendPM_YCKMyKnockoutInfoReq(self._activityId)
	goutil.setActive(self._com, true)
	goutil.setActive(self._knockout, false)
	YoungChampionKingController.instance:sendPM_YCKGetDefenseForamtionReq()
	YoungChampionKingController.instance:sendPM_YCKKnockoutGetFormationReq()

	local curCardInfo = RoleModel.instance.myCardInfo

	if not curCardInfo then
		PlayerAgent.instance:sendGetMyDisplayCardInfoReq(function(msg)
			self._isReqingRoleInfo = false

			RoleModel.instance:setMyCardInfo(msg)
			self:_updateMyRole()
		end, nil, function()
			self._isReqingRoleInfo = false
		end)
	else
		self:_updateMyRole()
	end

	self.addGEvent(self, GlobalNotify.PM_YCKStepChange, self._onStepChange, self)
	self.addGEvent(self, GlobalNotify.PM_YCKMyKnockoutInfoRes, self._updateUIByInfoNew, self)
	self.addGEvent(self, GlobalNotify.PM_YCKKnockoutRoomStausUpdate, self._updateRoomStatus, self)
	self.addGEvent(self, GlobalNotify.PM_YCKKnockoutJoinRoomError, self._onJoinRoomError, self)

	local timeForbid = checknumber(YoungChampionKingConfig.instance:getCommonValue("KNOCKOUT_BATTLE_START_TIME"))

	self._txtTips.text = string.format("战斗时间剩余%s分钟时，双方不可准备进入战斗，未准备一方进入战斗托管", timeForbid / 60)
	self._timerInvite = -1
	self._txtBtnInvite.text = "发送邀请"

	GameUtil.SetGray(self._btnInvite, false)
end

function YoungChampionKingKnockoutRoomView:_onStepChange(newStep)
	YoungChampionKingController.instance:sendPM_YCKMyKnockoutInfoReq(self._activityId)
end

function YoungChampionKingKnockoutRoomView:_updateUIByInfo()
	self._myInfo = YoungChampionKingModel.instance:getCurKnockoutInfo()

	local curStepId = YoungChampionKingModel.instance:getCurStepId()
	local curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(curStepId)
	local playerRoundId = YoungChampionKingModel.instance:getPlayerRoundId()

	if self._myInfo then
		playerRoundId = self._myInfo.roundId
	end

	if playerRoundId == YoungChampionKingEnum.Third_Place_Match_Round_Id then
		self._imgTitleChange:SetState(1)
	elseif playerRoundId == YoungChampionKingEnum.Final_Match_Round_Id then
		self._imgTitleChange:SetState(2)
	else
		self._imgTitleChange:SetState(0)
	end

	local isKnockout = playerRoundId < YoungChampionKingEnum.Common_Knockout_4To2_Id and playerRoundId < curRoundId

	if self._myInfo and not isKnockout then
		goutil.setActive(self._com, true)
		goutil.setActive(self._knockout, false)
		self:_updateOpponentPart()
		self:_updateState()
		goutil.setActive(self._tagOffline, not self._myInfo.opponentIsOnline)
		goutil.setActive(self._tagOnline, self._myInfo.opponentIsOnline)

		if self._myInfo.winPlayerId then
			goutil.setActive(self._cellEnemyRole.result, true)
			goutil.setActive(self._cellMyRole.result, true)

			local winPlayerId = checknumber(self._myInfo.winPlayerId)
			local myUserId = checknumber(RoleModel.instance:getUserId())

			self._cellMyRole.resultChange:SetState(winPlayerId == myUserId and 0 or 1)
			self._cellEnemyRole.resultChange:SetState(winPlayerId == myUserId and 1 or 0)
		else
			goutil.setActive(self._cellEnemyRole.result, false)
			goutil.setActive(self._cellMyRole.result, false)
		end

		if playerRoundId >= YoungChampionKingEnum.Third_Place_Match_Round_Id then
			goutil.setActive(self._cellMyRole.colMark, true)
			goutil.setActive(self._cellEnemyRole.colMark, true)

			if not self._myInfo.resultList then
				local resultList = {}

				for i = 1, 3 do
					local result = resultList[i]

					if result == nil then
						goutil.setActive(self._cellMyRole.markList[i].mark, false)
						goutil.setActive(self._cellEnemyRole.markList[i].mark, false)
					else
						goutil.setActive(self._cellMyRole.markList[i].mark, true)
						goutil.setActive(self._cellEnemyRole.markList[i].mark, true)
						self._cellMyRole.markList[i].change:SetState(result and 0 or 1)
						self._cellEnemyRole.markList[i].change:SetState(result and 1 or 0)
					end
				end
			end
		else
			goutil.setActive(self._cellMyRole.colMark, false)
			goutil.setActive(self._cellEnemyRole.colMark, false)
		end
	end
end

function YoungChampionKingKnockoutRoomView:_updateUIByInfoNew()
	self._myInfo = YoungChampionKingModel.instance:getCurKnockoutInfo()

	local curStepId = YoungChampionKingModel.instance:getCurStepId()
	local curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(curStepId)
	local battleRoundId = checknumber((self._myInfo or nil) and self._myInfo.roundId)

	if (battleRoundId > 0 or nil) and (battleRoundId < YoungChampionKingEnum.Common_Knockout_4To2_Id or false) and battleRoundId < curRoundId then
		if not self._myInfo then
			battleRoundId = YoungChampionKingModel.instance:getPlayerRoundId()
		end

		local roundCfg = YoungChampionKingConfig.instance:getRoundCfg(self._activityId, battleRoundId)

		goutil.setActive(self._com, false)
		goutil.setActive(self._knockout, true)

		self._txtKnockout.text = string.format("很遗憾，您止步于%s", roundCfg.roundName)
	else
		if battleRoundId == YoungChampionKingEnum.Third_Place_Match_Round_Id then
			self._imgTitleChange:SetState(1)
		elseif battleRoundId == YoungChampionKingEnum.Final_Match_Round_Id then
			self._imgTitleChange:SetState(2)
		else
			self._imgTitleChange:SetState(0)
		end

		goutil.setActive(self._com, true)
		goutil.setActive(self._knockout, false)
		self:_updateOpponentPart()
		goutil.setActive(self._tagOffline, not self._myInfo.opponentIsOnline)
		goutil.setActive(self._tagOnline, self._myInfo.opponentIsOnline)
		self:_updateStateNew()
	end
end

function YoungChampionKingKnockoutRoomView:_updateMyRole()
	local curCardInfo = RoleModel.instance.myCardInfo

	if not curCardInfo then
		return
	end

	local skId = DressModel.instance:getSkeIdByGender(RoleModel.instance:getGender())
	local mo = DressModel.instance:getAvatarPlayerMo(skId, (not curCardInfo.clothes or nil) and {}, 0)
	local avatar = self._cellMyRole.avatar

	if avatar then
		avatar:updateByMo(mo)
	else
		avatar = AvatarsMgrNew.instance:getAvatarByMo(mo)
		avatar.useType = AvatarUseType.Scene
		self._cellMyRole.avatar = avatar

		self._cellMyRole.photoEff:addShowAvatarEffect(avatar)
	end

	self._cellMyRole.txtNameShow.text = string.format("s%03d-%s", RoleModel.instance:getAreaId(), RoleModel.instance:getUserName())
	self._cellMyRole.txtPower.text = RoleModel.instance:getMaxPower()

	HeadItemController.instance:setMyHeadCell(self._cellMyRole.head)
end

function YoungChampionKingKnockoutRoomView:_updateOpponentPart()
	if self._myInfo then
		local opponent = self._myInfo.opponent

		HeadItemController.instance:setHeadCellByInfo(self._cellEnemyRole.head, opponent.headInfo.headInfo)

		self._cellEnemyRole.txtNameShow.text = string.format("s%03d-%s", opponent.areaId, opponent.headInfo.headInfo.userName)
		self._cellEnemyRole.txtPower.text = opponent.zdl

		local skId = DressModel.instance:getSkeIdByGender(opponent.gender)
		local mo = DressModel.instance:getAvatarPlayerMo(skId, (not opponent.clothes or nil) and {}, 0)
		local avatar = self._cellEnemyRole.avatar

		if avatar then
			avatar:updateByMo(mo)
		else
			avatar = AvatarsMgrNew.instance:getAvatarByMo(mo)
			avatar.useType = AvatarUseType.Scene
			self._cellEnemyRole.avatar = avatar

			self._cellEnemyRole.photoEff:addShowAvatarEffect(avatar)
		end
	end
end

function YoungChampionKingKnockoutRoomView:_updateState()
	if not self._myInfo then
		return
	end

	local curStepId = YoungChampionKingModel.instance:getCurStepId()
	local curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(curStepId)
	local timeNow = ServerTime.now()
	local battleRoundId = self._myInfo.roundId
	local curStepCfg = YoungChampionKingConfig.instance:getStepCfg(self._activityId, curStepId)
	local nextStepCfg = YoungChampionKingConfig.instance:getStepCfg(self._activityId, curStepId + 1)
	local timeForbid = checknumber(YoungChampionKingConfig.instance:getCommonValue("KNOCKOUT_BATTLE_START_TIME"))

	self._curStage = STATE_READY
	self._curNextStepStartTime = not nextStepCfg and YoungChampionKingController.instance:getEndTimeByStepId(YoungChampionKingEnum.Entertainment_Step_Id) or GameUtil.string2time(nextStepCfg.startTime)
	self._curNextUpdateTime = self._curNextStepStartTime

	if curRoundId < battleRoundId then
		local cfgs = YoungChampionKingConfig.instance:getStepCfgsByRoundId(self._activityId, battleRoundId)

		self._curNextStepStartTime = GameUtil.string2time(cfgs[2].startTime)
		self._curNextUpdateTime = self._curNextStepStartTime
	elseif battleRoundId == curRoundId then
		if curStepCfg.canGuss then
			-- block empty
		elseif self:isGetCurStepWinner(curStepId) then
			self._curStage = STATE_WAIT
		else
			local startTimeForbid = self._curNextStepStartTime - timeForbid

			if startTimeForbid < timeNow then
				self._curStage = STATE_WAIT
			else
				self._curStage = STATE_PREPARE
				self._curNextUpdateTime = startTimeForbid
			end
		end
	else
		self._curStage = STATE_END
	end

	self:_updateTimeTxt()
end

function YoungChampionKingKnockoutRoomView:_updateStateNew()
	if not self._myInfo then
		return
	end

	local curStepId = YoungChampionKingModel.instance:getCurStepId()
	local curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(curStepId)
	local timeNow = ServerTime.now()
	local battleRoundId = self._myInfo.roundId
	local timeForbid = checknumber(YoungChampionKingConfig.instance:getCommonValue("KNOCKOUT_BATTLE_START_TIME"))

	self._curStage = STATE_READY

	if curRoundId < battleRoundId then
		self._curStage = STATE_PREVIEW
	elseif battleRoundId == curRoundId then
		local curStepCfg = YoungChampionKingConfig.instance:getStepCfg(self._activityId, curStepId)
		local nextStepStartTime = YoungChampionKingController.instance:getStartTimeByStepId(curStepId + 1)

		if curStepCfg.canGuss then
			-- block empty
		elseif battleRoundId == YoungChampionKingEnum.Third_Place_Match_Round_Id or battleRoundId == YoungChampionKingEnum.Final_Match_Round_Id then
			local curStepCfgs = YoungChampionKingConfig.instance:getStepCfgsByRoundId(self._activityId, curRoundId)
			local needWinCount = math.ceil((#curStepCfgs - 1) / 2)
			local curFightNumber = 0

			for _, cfg in ipairs(curStepCfgs) do
				if curStepId > cfg.stepId then
					curFightNumber = curFightNumber + 1
				end
			end

			local resultNum = self._myInfo.myWinCount + self._myInfo.opWinCount

			if curFightNumber <= resultNum then
				self._curStage = STATE_WAIT
			elseif needWinCount <= self._myInfo.myWinCount or needWinCount <= self._myInfo.opWinCount then
				self._curStage = STATE_END
			else
				local startTimeForbid = nextStepStartTime - timeForbid

				self._curStage = startTimeForbid < timeNow and STATE_WAIT or STATE_PREPARE
			end
		elseif self._myInfo.myWinCount > 0 or self._myInfo.opWinCount > 0 then
			self._curStage = STATE_WAIT
		else
			local startTimeForbid = nextStepStartTime - timeForbid

			self._curStage = startTimeForbid < timeNow and STATE_WAIT or STATE_PREPARE
		end
	else
		self._curStage = STATE_END
	end

	self._curNextStepStartTime = 0
	self._curNeedUpdateTime = 0

	if self._curStage == STATE_PREVIEW then
		local cfgs = YoungChampionKingConfig.instance:getStepCfgsByRoundId(self._activityId, battleRoundId)

		self._curNextStepStartTime = GameUtil.string2time(cfgs[2].startTime)
		self._curNextUpdateTime = self._curNextStepStartTime
		self._curStage = STATE_READY
	elseif self._curStage == STATE_READY then
		self._curNextStepStartTime = YoungChampionKingController.instance:getStartTimeByStepId(curStepId + 1)
		self._curNextUpdateTime = self._curNextStepStartTime
	elseif self._curStage == STATE_PREPARE then
		self._curNextStepStartTime = YoungChampionKingController.instance:getStartTimeByStepId(curStepId + 1)
		self._curNextUpdateTime = self._curNextStepStartTime - timeForbid
	elseif self._curStage == STATE_WAIT then
		self._curNextStepStartTime = YoungChampionKingController.instance:getStartTimeByStepId(curStepId + 1)
		self._curNextUpdateTime = self._curNextStepStartTime
	elseif self._curStage == STATE_END then
		-- block empty
	end

	self:_updateTimeTxt()

	if battleRoundId >= YoungChampionKingEnum.Third_Place_Match_Round_Id then
		goutil.setActive(self._cellMyRole.colMark, true)
		goutil.setActive(self._cellEnemyRole.colMark, true)

		local fightNum = self._myInfo.myWinCount + self._myInfo.opWinCount

		if self._curStage == STATE_WAIT then
			local curStepCfgs = YoungChampionKingConfig.instance:getStepCfgsByRoundId(self._activityId, curRoundId)
			local curFightNumber = 0

			for _, cfg in ipairs(curStepCfgs) do
				if curStepId > cfg.stepId then
					curFightNumber = curFightNumber + 1
				end
			end

			if fightNum == curFightNumber then
				fightNum = fightNum - 1
			end
		end

		if not self._myInfo.resultList then
			local resultList = {}

			for i = 1, 3 do
				local result = resultList[i]

				if i <= fightNum then
					goutil.setActive(self._cellMyRole.markList[i].mark, true)
					goutil.setActive(self._cellEnemyRole.markList[i].mark, true)
					self._cellMyRole.markList[i].change:SetState(result and 0 or 1)
					self._cellEnemyRole.markList[i].change:SetState(result and 1 or 0)
				else
					goutil.setActive(self._cellMyRole.markList[i].mark, false)
					goutil.setActive(self._cellEnemyRole.markList[i].mark, false)
				end
			end
		end
	else
		goutil.setActive(self._cellMyRole.colMark, false)
		goutil.setActive(self._cellEnemyRole.colMark, false)
	end

	if self._curStage == STATE_END then
		goutil.setActive(self._cellEnemyRole.result, true)
		goutil.setActive(self._cellMyRole.result, true)

		local isMyWin = self._myInfo.myWinCount > self._myInfo.opWinCount

		self._cellMyRole.resultChange:SetState(isMyWin and 0 or 1)
		self._cellEnemyRole.resultChange:SetState(isMyWin and 1 or 0)
	else
		goutil.setActive(self._cellEnemyRole.result, false)
		goutil.setActive(self._cellMyRole.result, false)
	end
end

function YoungChampionKingKnockoutRoomView:isGetCurStepWinner(stepId)
	if self._myInfo.winPlayerId then
		return true
	else
		local roundId = YoungChampionKingController.instance:getRoundIdByStepId(stepId)
		local cfgs = YoungChampionKingConfig.instance:getStepCfgsByRoundId(self._activityId, roundId)
		local num = -1

		for _, cfg in ipairs(cfgs) do
			if stepId >= cfg.stepId then
				num = num + 1
			end
		end

		local resultNum = self._myInfo.myWinCount + self._myInfo.opWinCount

		if resultNum >= 2 and (self._myInfo.myWinCount == 0 or self._myInfo.opWinCount == 0) then
			return true
		end

		if num <= resultNum and num > 0 then
			return true
		end
	end

	return false
end

function YoungChampionKingKnockoutRoomView:_updateTimeTxt()
	local curStepId = YoungChampionKingModel.instance:getCurStepId()

	goutil.setActive(self._btnRoom, false)
	goutil.setActive(self._cellEnemyRole.tagReady, false)
	goutil.setActive(self._cellMyRole.tagReady, false)
	goutil.setActive(self._btnInvite, false)
	goutil.setActive(self._tipsWait, false)

	self._txtOpenTime.text = ""

	removetimer(self._updateTimer, self)

	if self._curStage == STATE_READY then
		-- block empty
	elseif self._curStage == STATE_PREPARE then
		YoungChampionKingController.instance:sendPM_YCKKnockoutJoinRoomInfoReq(self._activityId, curStepId, self._myInfo.groupId)
		goutil.setActive(self._btnRoom, true)
		goutil.setActive(self._btnInvite, true)
	elseif self._curStage == STATE_WAIT then
		goutil.setActive(self._tipsWait, true)
	elseif self._curStage == STATE_END then
		self._txtOpenTime.text = "战斗结束"
	end

	self:_updateRoomStatus()

	if self._curStage ~= STATE_END then
		settimer(1, self._updateTimer, self, true)
	end
end

function YoungChampionKingKnockoutRoomView:_updateTimer()
	local timer = self._curNextUpdateTime - ServerTime.now()
	local showTimer = self._curNextStepStartTime - ServerTime.now()
	local timeStr = GameUtil.FormatTimeSymbol(showTimer)

	if self._curStage == STATE_READY then
		self._txtOpenTime.text = "距离开战剩余：" .. timeStr
	elseif self._curStage == STATE_PREPARE then
		self._txtOpenTime.text = "战斗剩余时间：" .. timeStr
	elseif self._curStage == STATE_WAIT then
		self._txtOpenTime.text = "战斗剩余时间：" .. timeStr
	elseif self._curStage == STATE_END then
		self._txtOpenTime.text = "战斗结束"
	end

	if timer <= 0 then
		self:_updateStateNew()
	end
end

function YoungChampionKingKnockoutRoomView:_updateRoomStatus()
	local isShow = YoungChampionKingModel.instance:getUserIdIsReady(RoleModel.instance:getUserId())

	goutil.setActive(self._cellMyRole.tagReady, isShow)

	self._txtBtnRoom.text = isShow and "取消准备" or "准备"

	local opUserId = checknumber(self._myInfo.opponent.headInfo.headInfo.userId)

	isShow = YoungChampionKingModel.instance:getUserIdIsReady(opUserId)

	goutil.setActive(self._cellEnemyRole.tagReady, isShow)

	if isShow then
		goutil.setActive(self._tagOffline, false)
		goutil.setActive(self._tagOnline, true)
	end
end

function YoungChampionKingKnockoutRoomView:_onClickBtnForm()
	if YoungChampionKingModel.instance:getUserIdIsReady(RoleModel.instance:getUserId()) then
		local tips = "确定退出准备，离开房间？"

		TipsFacade.instance:openPopupWindowWithX("提示", tips, function()
			if self._myInfo then
				local fmtMo = YoungChampionKingModel.instance:getQualifierDefenseFmtMo()

				if self._myInfo == YoungChampionKingEnum.Third_Place_Match_Round_Id or self._myInfo == YoungChampionKingEnum.Final_Match_Round_Id then
					fmtMo = YoungChampionKingModel.instance:getKnockoutDefenseFmtMo()
				end

				fmtMo:initParams(YoungChampionKingEnum.War_Zone_Start_Step_Id)
				CustomFmtController.instance:showMissionFormationView(fmtMo)
			end
		end)

		return
	end

	if self._myInfo then
		local roundId = self._myInfo.roundId
		local fmtMo = YoungChampionKingModel.instance:getQualifierDefenseFmtMo()

		if roundId == YoungChampionKingEnum.Third_Place_Match_Round_Id or roundId == YoungChampionKingEnum.Final_Match_Round_Id then
			fmtMo = YoungChampionKingModel.instance:getKnockoutDefenseFmtMo()
		end

		fmtMo:initParams(YoungChampionKingEnum.War_Zone_Start_Step_Id)
		CustomFmtController.instance:showMissionFormationView(fmtMo)
	end
end

function YoungChampionKingKnockoutRoomView:_onClickBtnInvite()
	if self._curStage == STATE_PREPARE and self._timerInvite <= 0 then
		local curStepId = YoungChampionKingModel.instance:getCurStepId()

		YoungChampionKingAgent.instance:sendPM_YCKKnockoutInviteOpReq(self._activityId, curStepId, self._myInfo.groupId)

		self._timerInvite = 10
		self._txtBtnInvite.text = string.format("发送邀请(%s)", self._timerInvite)

		GameUtil.SetGray(self._btnInvite, true)
		settimer(1, self._updateInviteTimer, self, true)
	end
end

function YoungChampionKingKnockoutRoomView:_updateInviteTimer()
	self._timerInvite = self._timerInvite - 1
	self._txtBtnInvite.text = string.format("发送邀请(%s)", self._timerInvite)

	if self._timerInvite < 0 then
		removetimer(self._updateInviteTimer, self)

		self._txtBtnInvite.text = "发送邀请"

		GameUtil.SetGray(self._btnInvite, false)
	end
end

function YoungChampionKingKnockoutRoomView:_onClickBtnRoom()
	if self._curStage == STATE_PREPARE then
		local isEnter = YoungChampionKingModel.instance:getUserIdIsReady(RoleModel.instance:getUserId())

		if not isEnter then
			local curStepId = YoungChampionKingModel.instance:getCurStepId()

			YoungChampionKingController.instance:sendPM_YCKKnockoutJoinRoomReq(self._activityId, curStepId, self._myInfo.groupId)
			SurveyController.instance:reportBehavior(201802)
		else
			YoungChampionKingController.instance:sendPM_YCKKnockoutLeaveRoomReq()
		end
	end
end

function YoungChampionKingKnockoutRoomView:_onJoinRoomError(status)
	if status == -26101 then
		TipsFacade.instance:openCommonTips("已进入战斗托管，不可准备")
	end
end

return YoungChampionKingKnockoutRoomView
