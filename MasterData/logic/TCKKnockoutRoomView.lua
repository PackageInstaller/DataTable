-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKKnockoutRoomView.lua

module("logic.extensions.teenchampionking.view.TCKKnockoutRoomView", package.seeall)

local TCKKnockoutRoomView = class("TCKKnockoutRoomView", ViewComponent)

function TCKKnockoutRoomView:ctor()
	TCKKnockoutRoomView.super.ctor(self)
end

local STATE_READY = 2
local STATE_PREPARE = 3
local STATE_WAIT = 4
local STATE_END = 5

function TCKKnockoutRoomView:unbindEvents()
	TCKKnockoutRoomView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnAdjust)
	GameUtil.rmClickHandler(self._btnInvite)
	GameUtil.rmClickHandler(self._btnRoom)
	GameUtil.rmClickHandler(self._btnTog)
end

function TCKKnockoutRoomView:bindEvents()
	TCKKnockoutRoomView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnAdjust, self._onClickBtnAdjust, self)
	GameUtil.addClickHandler(self._btnInvite, self._onClickBtnInvite, self)
	GameUtil.addClickHandler(self._btnRoom, self._onClickBtnRoom, self)
	GameUtil.addClickHandler(self._btnTog, self._onClickBtnTog, self)
end

function TCKKnockoutRoomView:buildUI()
	TCKKnockoutRoomView.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")
	self._rolePoint_1 = self:getGo("modelCam/bg/hide/rolePoint_1")
	self._rolePoint_2 = self:getGo("modelCam/bg/hide/rolePoint_2")
	self._cellLeft = self:buildRoleCell(self:getGo("com/leftRole"), self._rolePoint_1)
	self._cellRight = self:buildRoleCell(self:getGo("com/rightRole"), self._rolePoint_2)
	self._knockout = self:getGo("knockout")
	self._txtKnockout = self:getTxt("knockout/txt")
	self._hide = self:getGo("modelCam/bg/hide")
	self._com = self:getGo("com")
	self._tagOffline = self:getGo("com/rightRole/tagOffline")
	self._tagOnline = self:getGo("com/rightRole/tagOnline")
	self._txtOpenTime = self:getTxt("com/txtOpenTime")
	self._btnAdjust = self:getGo("com/btnAdjust")
	self._btnInvite = self:getGo("com/btnInvite")
	self._txtBtnInvite = self:getTxt("com/btnInvite/txt")
	self._btnRoom = self:getGo("com/btnRoom")
	self._txtBtnRoom = self:getTxt("com/btnRoom/txt")
	self._txtTips = self:getTxt("com/txtTips")
	self._imgTitleChange = self:getGo("com/imgTitle"):GetComponent("UIImageSpriteChange")
	self._tipsWait = self:getGo("com/tipsWait")
	self._btnTog = self:getGo("com/togSwitch/btnTog")
	self._markTog = self:getGo("com/togSwitch/btnTog/mark")
end

function TCKKnockoutRoomView:buildRoleCell(go, rolePoint)
	local cell = {}

	cell.go = go
	cell.infoCom = goutil.findChild(cell.go, "infoCom")
	cell.txtPower = goutil.findChildTextComponent(cell.go, "infoCom/txtPower")
	cell.txtNameShow = goutil.findChildTextComponent(cell.go, "infoCom/txtNameShow")
	cell.head = goutil.findChild(cell.go, "head")
	cell.result = goutil.findChild(cell.go, "result")
	cell.resultChange = cell.result:GetComponent("UIImageSpriteChange")
	cell.avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	cell.avatar:setParent(rolePoint.transform)
	cell.avatar:setLayer(SceneLayer.UI3D_Value)

	cell.tagReady = goutil.findChild(cell.go, "tagReady")

	return cell
end

function TCKKnockoutRoomView:onExit()
	TCKKnockoutRoomView.super.onExit(self)
	LightMgr.instance:setLightForNormalScene()
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	HeadItemController.instance:resetHeadCell(self._cellLeft.head)
	HeadItemController.instance:resetHeadCell(self._cellRight.head)
	removetimer(self._updateTimer, self)
	removetimer(self._updateInviteTimer, self)

	if self._myInfo then
		local inRoomUserIds = TeenChampionKingModel.instance:getInRoomUserIds() or {}
		local inRoom = table.keyof(inRoomUserIds, checknumber(RoleModel.instance:getUserId()))

		if inRoom then
			TeenChampionKingController.instance:knockoutLeaveRoom(self._activityId, self:_getCurStepId(), self._myInfo.groupId)
		end
	end
end

function TCKKnockoutRoomView:onEnter()
	TCKKnockoutRoomView.super.onEnter(self)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)

	local params = self:getOpenParam()

	self._activityId = params and checknumber(params[1])

	if checknumber(self._activityId) <= 0 then
		self._activityId = 501001
	end

	self.addGEvent(self, GlobalNotify.PM_TCKStepChange, self._onStepChange, self)
	self.addGEvent(self, GlobalNotify.PM_TCKGetMyKnockoutInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKKnockoutRoomStausUpdate, self._updateRoomStatus, self)
	self.addGEvent(self, GlobalNotify.PM_TCKKnockoutJoinRoomError, self._onJoinRoomError, self)
	self.addGEvent(self, GlobalNotify.PM_TCKNotifyFightStart, self._enterFight, self)
	self.addGEvent(self, GlobalNotify.PM_TCKSelectPets, self._updatePetList, self)

	local timeForbid = checknumber(TeenChampionKingConfig.instance:getCommonValue("KNOCKOUT_BATTLE_START_TIME"))

	self._txtTips.text = string.format("战斗时间剩余%s分钟时，双方不可准备进入战斗，历史战力高的一方获胜", timeForbid / 60)

	goutil.setActive(self._com, true)
	goutil.setActive(self._knockout, false)
	goutil.setActive(self._hide, false)

	self._timerInvite = -1
	self._txtBtnInvite.text = "发送邀请"

	GameUtil.SetGray(self._btnInvite, false)
	self:_updatePetList()
end

function TCKKnockoutRoomView:onEnterFinished()
	TCKKnockoutRoomView.super.onEnterFinished(self)

	local curStepId = self:_getCurStepId()
	local curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, curStepId)

	if curRoundId > TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX then
		self._txtKnockout.text = "本轮比赛已结束"

		goutil.setActive(self._knockout, true)
		goutil.setActive(self._com, false)
		goutil.setActive(self._hide, false)
	else
		TeenChampionKingController.instance:getMyKnockoutInfo(self._activityId)

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
	end
end

function TCKKnockoutRoomView:destroyUI()
	TCKKnockoutRoomView.super.destroyUI(self)

	if self._cellLeft and self._cellLeft.avatar then
		AvatarsMgrNew.instance:removeAvatar(self._cellLeft.avatar)

		self._cellLeft.avatar = nil
	end

	if self._cellRight and self._cellRight.avatar then
		AvatarsMgrNew.instance:removeAvatar(self._cellRight.avatar)

		self._cellRight.avatar = nil
	end
end

function TCKKnockoutRoomView:_onStepChange(newStep)
	TeenChampionKingController.instance:getMyKnockoutInfo(self._activityId)
end

function TCKKnockoutRoomView:_updateUIByInfo()
	self._myInfo = nil

	local myKnockoutInfo = TeenChampionKingModel.instance:getMyKnockoutInfo(self._activityId)

	if not myKnockoutInfo then
		return
	end

	self._myInfo = myKnockoutInfo.knockoutInfo

	local curStepId = self:_getCurStepId()
	local curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, curStepId)
	local battleRoundId = checknumber((self._myInfo or nil) and self._myInfo.roundId)
	local globalInfo = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	if (battleRoundId > 0 or nil) and battleRoundId < curRoundId then
		if not self._myInfo then
			battleRoundId = globalInfo.playerRoundId
		end

		local roundCfg = TeenChampionKingConfig.instance:getRoundCfgByRoundId(self._activityId, battleRoundId)

		goutil.setActive(self._com, false)
		goutil.setActive(self._knockout, true)
		goutil.setActive(self._hide, false)

		self._txtKnockout.text = string.format("很遗憾，您止步于%s", roundCfg.roundName)
	else
		if battleRoundId >= TeenChampionKingController.ROUND_KNOCKOUT_MIN and battleRoundId <= TeenChampionKingController.ROUND_QUARTERFINALS then
			self._imgTitleChange:SetState(0)
		elseif battleRoundId >= TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN and battleRoundId <= TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX then
			self._imgTitleChange:SetState(1)
		else
			print("未知处理：" .. battleRoundId)
		end

		goutil.setActive(self._com, true)
		goutil.setActive(self._hide, true)
		goutil.setActive(self._knockout, false)
		self:_updateOpponentPart()
		goutil.setActive(self._tagOffline, not self._myInfo.opponentIsOnline)
		goutil.setActive(self._tagOnline, self._myInfo.opponentIsOnline)
		self:_updateStateNew()
		TeenChampionKingController.instance:getKnockoutJoinRoomInfo(self._activityId, self:_getCurStepId(), self._myInfo.groupId)
	end
end

function TCKKnockoutRoomView:_updateMyRole()
	local curCardInfo = RoleModel.instance.myCardInfo

	if not curCardInfo then
		return
	end

	local avatar = self._cellLeft.avatar

	if avatar then
		local skId = DressModel.instance:getSkeIdByGender(RoleModel.instance:getGender())
		local mo = DressModel.instance:getAvatarPlayerMo(skId, (not curCardInfo.clothes or nil) and {}, 0)

		avatar:updateByMo(mo)
		avatar:setVisible(true)
	end

	self._cellLeft.txtNameShow.text = string.format("s%03d-%s", RoleModel.instance:getAreaId(), RoleModel.instance:getUserName())
	self._cellLeft.txtPower.text = RoleModel.instance:getMaxPower()

	HeadItemController.instance:setMyHeadCell(self._cellLeft.head)
end

function TCKKnockoutRoomView:_updateOpponentPart()
	if self._myInfo then
		local opponent = self._myInfo.opponent

		HeadItemController.instance:setHeadCellByInfo(self._cellRight.head, opponent.headInfo.headInfo)

		self._cellRight.txtNameShow.text = string.format("s%03d-%s", opponent.areaId, opponent.headInfo.headInfo.userName)
		self._cellRight.txtPower.text = opponent.zdl

		local avatar = self._cellRight.avatar

		if avatar then
			local skId = DressModel.instance:getSkeIdByGender(opponent.gender)
			local mo = DressModel.instance:getAvatarPlayerMo(skId, (not opponent.clothes or nil) and {}, 0)

			avatar:updateByMo(mo)
			avatar:setVisible(true)
		end
	end
end

function TCKKnockoutRoomView:_getCurStepId()
	local globalInfo = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	return (globalInfo or nil) and globalInfo.curStepId
end

function TCKKnockoutRoomView:_updateStateNew()
	if not self._myInfo then
		return
	end

	local curStepId = self:_getCurStepId()
	local curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, curStepId)
	local timeNow = ServerTime.now()
	local battleRoundId = self._myInfo.roundId
	local timeForbid = checknumber(TeenChampionKingConfig.instance:getCommonValue("KNOCKOUT_BATTLE_START_TIME"))

	self._curStage = STATE_READY

	if battleRoundId == curRoundId then
		local curStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(self._activityId, curStepId)
		local nextStepStartTime = TeenChampionKingController.instance:getStartTimeAndEndTimeByStepId(self._activityId, curStepId + 1)

		if not curStepCfg.needKnockoutRoom then
			-- block empty
		else
			local winnerId = checknumber(self._myInfo.winPlayerId)

			if winnerId > 0 then
				self._curStage = STATE_WAIT
			else
				local startTimeForbid = nextStepStartTime - timeForbid

				self._curStage = startTimeForbid < timeNow and STATE_WAIT or STATE_PREPARE
			end
		end
	else
		self._curStage = STATE_END
	end

	self._curNextStepStartTime = 0
	self._curNeedUpdateTime = 0

	if self._curStage == STATE_READY then
		self._curNextStepStartTime = TeenChampionKingController.instance:getStartTimeAndEndTimeByStepId(self._activityId, curStepId + 1)
		self._curNextUpdateTime = self._curNextStepStartTime
	elseif self._curStage == STATE_PREPARE then
		self._curNextStepStartTime = TeenChampionKingController.instance:getStartTimeAndEndTimeByStepId(self._activityId, curStepId + 1)
		self._curNextUpdateTime = self._curNextStepStartTime - timeForbid
	elseif self._curStage == STATE_WAIT then
		self._curNextStepStartTime = TeenChampionKingController.instance:getStartTimeAndEndTimeByStepId(self._activityId, curStepId + 1)
		self._curNextUpdateTime = self._curNextStepStartTime
	elseif self._curStage == STATE_END then
		-- block empty
	end

	self:_updateTimeTxt()

	if self._curStage == STATE_END then
		goutil.setActive(self._cellRight.result, true)
		goutil.setActive(self._cellLeft.result, true)

		local winnerId = checknumber(self._myInfo.winPlayerId)
		local isMyWin = winnerId == checknumber(RoleModel.instance:getUserId())

		self._cellLeft.resultChange:SetState(isMyWin and 0 or 1)
		self._cellRight.resultChange:SetState(isMyWin and 1 or 0)
	else
		goutil.setActive(self._cellLeft.result, false)
		goutil.setActive(self._cellRight.result, false)
	end
end

function TCKKnockoutRoomView:_updateTimeTxt()
	local curStepId = self:_getCurStepId()

	goutil.setActive(self._btnRoom, false)
	goutil.setActive(self._cellRight.tagReady, false)
	goutil.setActive(self._cellLeft.tagReady, false)
	goutil.setActive(self._btnInvite, false)
	goutil.setActive(self._tipsWait, false)

	self._txtOpenTime.text = ""

	removetimer(self._updateTimer, self)

	if self._curStage == STATE_READY then
		-- block empty
	elseif self._curStage == STATE_PREPARE then
		TeenChampionKingController.instance:getKnockoutJoinRoomInfo(self._activityId, curStepId, self._myInfo.groupId)
		goutil.setActive(self._btnRoom, true)
		goutil.setActive(self._btnInvite, true)
	elseif self._curStage == STATE_WAIT then
		TeenChampionKingController.instance:getKnockoutJoinRoomInfo(self._activityId, curStepId, self._myInfo.groupId)
		goutil.setActive(self._tipsWait, true)
	elseif self._curStage == STATE_END then
		self._txtOpenTime.text = "战斗结束"
	end

	self:_updateRoomStatus()

	if self._curStage ~= STATE_END then
		settimer(1, self._updateTimer, self, true)
	end
end

function TCKKnockoutRoomView:_updateTimer()
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

function TCKKnockoutRoomView:_updateRoomStatus()
	local inRoomUserIds = TeenChampionKingModel.instance:getInRoomUserIds() or {}
	local isShow = table.keyof(inRoomUserIds, checknumber(RoleModel.instance:getUserId()))

	goutil.setActive(self._cellLeft.tagReady, isShow)

	self._txtBtnRoom.text = isShow and "取消准备" or "准备"

	local opUserId = checknumber(self._myInfo.opponent.headInfo.headInfo.userId)

	isShow = table.keyof(inRoomUserIds, checknumber(opUserId))

	goutil.setActive(self._cellRight.tagReady, isShow)

	if isShow then
		goutil.setActive(self._tagOffline, false)
		goutil.setActive(self._tagOnline, true)
	end
end

function TCKKnockoutRoomView:_onClickBtnAdjust()
	UIStateManager.instance:push(ViewName.TCKPetSelectView, self._activityId)
end

function TCKKnockoutRoomView:_onClickBtnInvite()
	if self._curStage == STATE_PREPARE and self._timerInvite <= 0 then
		local curStepId = self:_getCurStepId()

		TeenChampionKingController.instance:knockoutInviteOp(self._activityId, curStepId, self._myInfo.groupId)

		self._timerInvite = 10
		self._txtBtnInvite.text = string.format("发送邀请(%s)", self._timerInvite)

		GameUtil.SetGray(self._btnInvite, true)
		settimer(1, self._updateInviteTimer, self, true)
	end
end

function TCKKnockoutRoomView:_updateInviteTimer()
	self._timerInvite = self._timerInvite - 1
	self._txtBtnInvite.text = string.format("发送邀请(%s)", self._timerInvite)

	if self._timerInvite < 0 then
		removetimer(self._updateInviteTimer, self)

		self._txtBtnInvite.text = "发送邀请"

		GameUtil.SetGray(self._btnInvite, false)
	end
end

function TCKKnockoutRoomView:_onClickBtnRoom()
	if self._curStage == STATE_PREPARE then
		if TeenChampionKingController.instance:checkAdjustPets(self._activityId) then
			FloatWordMgr.instance:show("请先调整精灵")
			self:_onClickBtnAdjust()

			return
		end

		if #self._selectPets <= 0 then
			FloatWordMgr.instance:show("请先选择备战精灵")
			self:_onClickBtnAdjust()

			return
		end

		local inRoomUserIds = TeenChampionKingModel.instance:getInRoomUserIds() or {}
		local inRoom = table.keyof(inRoomUserIds, checknumber(RoleModel.instance:getUserId()))

		if inRoom then
			TeenChampionKingController.instance:knockoutLeaveRoom(self._activityId, self:_getCurStepId(), self._myInfo.groupId)
		else
			TeenChampionKingController.instance:knockoutJoinRoom(self._activityId, self:_getCurStepId(), self._myInfo.groupId)
		end
	end
end

function TCKKnockoutRoomView:_onJoinRoomError(status)
	if status == -26101 then
		TipsFacade.instance:openCommonTips("已进入战斗，不可准备")
	elseif status == -35 then
		TeenChampionKingController.instance:getMyKnockoutInfo(self._activityId)
		TeenChampionKingController.instance:getKnockoutJoinRoomInfo(self._activityId, self:_getCurStepId(), self._myInfo.groupId)
	end
end

function TCKKnockoutRoomView:_enterFight(msg)
	if not msg.gameStartTime then
		TeenChampionKingController.instance:tryShowMission(self._activityId, msg.gameStartTime / 1000)
	end
end

function TCKKnockoutRoomView:_updatePetList()
	self._selectPets = {}
	self._isUseSysProperty = false

	local globalInfo = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	if globalInfo then
		self._selectPets = globalInfo.selectPetIds or {}
		self._isUseSysProperty = globalInfo.useSysProperty
	end

	goutil.setActive(self._markTog, self._isUseSysProperty)
end

function TCKKnockoutRoomView:_onClickBtnTog()
	local isNeedTips = TeenChampionKingController.instance:checkTogSystem(self._activityId)

	if isNeedTips and not self._isUseSysProperty then
		local title = "提示"
		local text = "勾选后，在挑战时，己方全体精灵将使用系统属性"
		local togText = "今日不再提示"

		TipsFacade.instance:openPopupWindowNoCancelWithTog(title, text, function()
			TeenChampionKingController.instance:selectPets(self._activityId, self._selectPets, not self._isUseSysProperty)
		end, function()
			TeenChampionKingController.instance:saveTogSystem(self._activityId)
		end, "确定", togText)
	else
		TeenChampionKingController.instance:selectPets(self._activityId, self._selectPets, not self._isUseSysProperty)
	end
end

return TCKKnockoutRoomView
