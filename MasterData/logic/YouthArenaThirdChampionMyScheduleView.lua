-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionMyScheduleView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionMyScheduleView", package.seeall)

local YouthArenaThirdChampionMyScheduleView = class("YouthArenaThirdChampionMyScheduleView", ViewComponent)
local STATE_PREPARE = 1
local STATE_BATTLE = 2
local STATE_END = 3
local RESULT_STATE_WIN = 0
local RESULT_STATE_LOSE = 1
local BUFF_VIEWED_KEY = "YouthArenaThirdBuffViewed_%s_%s"

function YouthArenaThirdChampionMyScheduleView:ctor()
	YouthArenaThirdChampionMyScheduleView.super.ctor(self)
end

function YouthArenaThirdChampionMyScheduleView:buildUI()
	YouthArenaThirdChampionMyScheduleView.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")
	self._hide = self:getGo("modelCam/bg/hide")
	self._rolePointLeft = self:getGo("modelCam/bg/hide/rolePoint_1")
	self._rolePointRight = self:getGo("modelCam/bg/hide/rolePoint_2")
	self._com = self:getGo("com")
	self._knockout = self:getGo("knockout")
	self._txtKnockout = self:getTxt("knockout/txt")
	self._txtScheduleTime = self:getTxt("com/scheduleTime/txt")
	self._tagBattleMode1 = self:getGo("com/battleMode1/tagSelect")
	self._tagBattleMode2 = self:getGo("com/battleMode2/tagSelect")
	self._cellLeft = self:_buildRoleCell(self:getGo("com/leftRole"), self._rolePointLeft)
	self._cellRight = self:_buildRoleCell(self:getGo("com/rightRole"), self._rolePointRight)
	self._btnReport = self:getGo("com/btns/btnReport")
	self._btnScoreRule = self:getGo("com/btns/btnScoreRule")
	self._btnBuff = self:getGo("com/btns/btnBuff")
	self._bubbleBuff = goutil.findChild(self._btnBuff, "bubble")
	self._btnFmt = self:getGo("com/btns/btnFmt")
end

function YouthArenaThirdChampionMyScheduleView:bindEvents()
	YouthArenaThirdChampionMyScheduleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnReport, self._onClickBtnReport, self)
	GameUtil.addClickHandler(self._btnScoreRule, self._onClickBtnScoreRule, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	GameUtil.addClickHandler(self._btnFmt, self._onClickBtnFmt, self)
end

function YouthArenaThirdChampionMyScheduleView:unbindEvents()
	YouthArenaThirdChampionMyScheduleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnReport)
	GameUtil.rmClickHandler(self._btnScoreRule)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnFmt)
end

function YouthArenaThirdChampionMyScheduleView:onEnter()
	YouthArenaThirdChampionMyScheduleView.super.onEnter(self)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetInfoRes, self._handleGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3MyKnockoutInfoRes, self._handleMyKnockoutInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3NotifyStepChangeRes, self._handleStepChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._curState = nil
	self._nextUpdateTime = 0
	self._nextShowTime = 0
	self._hasMyKnockoutInfoRes = false

	self:_showEmpty()
	self:_sendMyKnockoutInfoReq()
end

function YouthArenaThirdChampionMyScheduleView:onExit()
	YouthArenaThirdChampionMyScheduleView.super.onExit(self)
	LightMgr.instance:setLightForNormalScene()
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	removetimer(self._updateTimer, self)
	self:_clearRoleCell(self._cellLeft)
	self:_clearRoleCell(self._cellRight)
end

function YouthArenaThirdChampionMyScheduleView:destroyUI()
	YouthArenaThirdChampionMyScheduleView.super.destroyUI(self)

	if self._cellLeft and self._cellLeft.avatar then
		AvatarsMgrNew.instance:removeAvatar(self._cellLeft.avatar)

		self._cellLeft.avatar = nil
	end

	if self._cellRight and self._cellRight.avatar then
		AvatarsMgrNew.instance:removeAvatar(self._cellRight.avatar)

		self._cellRight.avatar = nil
	end
end

function YouthArenaThirdChampionMyScheduleView:_buildRoleCell(go, rolePoint)
	local cell = {}

	cell.go = go
	cell.rolePoint = rolePoint
	cell.head = goutil.findChild(go, "head")
	cell.txtName = goutil.findChildTextComponent(go, "txtName")
	cell.txtPower = goutil.findChildTextComponent(go, "txtPower")
	cell.result = goutil.findChild(go, "result")
	cell.resultChange = cell.result and cell.result:GetComponent("UIImageSpriteChange")
	cell.avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	cell.avatar:setParent(rolePoint.transform)
	cell.avatar:setLayer(SceneLayer.UI3D_Value)

	return cell
end

function YouthArenaThirdChampionMyScheduleView:_clearRoleCell(cell)
	if not cell then
		return
	end

	if cell.head then
		HeadItemController.instance:resetHeadCell(cell.head)
	end

	if cell.avatar then
		cell.avatar:setVisible(false)
	end
end

function YouthArenaThirdChampionMyScheduleView:_showEmpty()
	goutil.setActive(self._com, false)
	goutil.setActive(self._knockout, false)
	goutil.setActive(self._hide, false)
	self:_setBuffBubbleActive(false)
end

function YouthArenaThirdChampionMyScheduleView:_refreshProtocolInfo()
	local subMo = self:_getSubMo()

	if not subMo then
		self:_showEmpty()

		return
	end

	local knockoutInfo = subMo:getMyKnockoutInfo()
	local curRoundId = self:_getCurRoundId()
	local playerRoundId = self:_getPlayerRoundId()
	local battleRoundId = checknumber(knockoutInfo and knockoutInfo.roundId)

	if curRoundId <= 0 then
		self:_showEmpty()

		return
	end

	if curRoundId < YouthArenaThirdEnum.ChampionRoundId.KnockoutStart then
		self:_refreshStatusTips(lang("冠军淘汰赛暂未开始"))

		return
	end

	if playerRoundId < YouthArenaThirdEnum.ChampionRoundId.KnockoutStart then
		self:_refreshEliminatedTips(playerRoundId)

		return
	end

	if self:_isPlayerEliminatedInChampionKnockout(playerRoundId, curRoundId) then
		self:_refreshEliminatedTips(playerRoundId)

		return
	end

	if curRoundId > YouthArenaThirdEnum.ChampionRoundId.KnockoutEnd and playerRoundId > YouthArenaThirdEnum.ChampionRoundId.KnockoutEnd then
		self:_refreshStatusTips(lang("恭喜您晋级冠军积分赛"))

		return
	end

	if not knockoutInfo or battleRoundId ~= curRoundId then
		self:_refreshStatusTips(lang("暂无赛程"))

		return
	end

	goutil.setActive(self._com, true)
	goutil.setActive(self._knockout, false)
	goutil.setActive(self._hide, true)
	self:_refreshBattleMode()
	self:_refreshRoleInfo(self._cellLeft, knockoutInfo.myDetail)
	self:_refreshRoleInfo(self._cellRight, knockoutInfo.opponent)
	self:_refreshState(knockoutInfo)
	self:_refreshBuffBubble()
end

function YouthArenaThirdChampionMyScheduleView:_refreshBattleMode()
	local curStepCfg = self:_getCurStepCfg()
	local isThree = curStepCfg and curStepCfg.mode == "MODE_3V3"

	goutil.setActive(self._tagBattleMode1, not isThree)
	goutil.setActive(self._tagBattleMode2, isThree)
end

function YouthArenaThirdChampionMyScheduleView:_refreshRoleInfo(cell, detail)
	if not cell or not detail then
		self:_clearRoleCell(cell)

		return
	end

	local playerHeadInfo = detail.headInfo
	local headInfo = playerHeadInfo and playerHeadInfo.headInfo

	if headInfo then
		HeadItemController.instance:resetHeadCell(cell.head)
		HeadItemController.instance:setHeadCellByInfo(cell.head, headInfo, true)

		cell.txtName.text = string.format("s%03d-%s", checknumber(headInfo.areaId), headInfo.userName or "")
	else
		cell.txtName.text = ""
	end

	cell.txtPower.text = tostring(checknumber(detail.zdl))

	local skId = DressModel.instance:getSkeIdByGender(detail.gender)
	local mo = DressModel.instance:getAvatarPlayerMo(skId, (not detail.clothes or nil) and {}, 0)

	cell.avatar:updateByMo(mo)
	cell.avatar:setVisible(true)
end

function YouthArenaThirdChampionMyScheduleView:_refreshState(knockoutInfo)
	local curStepCfg = self:_getCurStepCfg()
	local result = knockoutInfo and knockoutInfo.result
	local winPlayerId = checknumber(result and result.winPlayerId)

	self._curState = winPlayerId > 0 and STATE_END or curStepCfg and checkbool(curStepCfg.canSetForm) and STATE_PREPARE or STATE_BATTLE

	self:_refreshResult(knockoutInfo)
	self:_refreshTimeInfo()
end

function YouthArenaThirdChampionMyScheduleView:_refreshResult(knockoutInfo)
	local result = knockoutInfo and knockoutInfo.result
	local winPlayerId = checknumber(result and result.winPlayerId)
	local isShow = winPlayerId > 0

	goutil.setActive(self._cellLeft.result, isShow)
	goutil.setActive(self._cellRight.result, isShow)

	if not isShow then
		return
	end

	local myUserId = self:_getPlayerUserId(knockoutInfo.myDetail)
	local isMyWin = myUserId > 0 and winPlayerId == myUserId

	self._cellLeft.resultChange:SetState((isMyWin or nil) and (RESULT_STATE_WIN or RESULT_STATE_LOSE))
	self._cellRight.resultChange:SetState((isMyWin or nil) and (RESULT_STATE_LOSE or RESULT_STATE_WIN))
end

function YouthArenaThirdChampionMyScheduleView:_refreshTimeInfo()
	removetimer(self._updateTimer, self)

	self._nextShowTime = self:_getNextStepStartTime()
	self._nextUpdateTime = self._nextShowTime

	self:_updateTimer()

	if self._curState ~= STATE_END and self._nextUpdateTime > ServerTime.now() then
		settimer(1, self._updateTimer, self, true)
	end
end

function YouthArenaThirdChampionMyScheduleView:_updateTimer()
	if self._curState == STATE_END then
		self._txtScheduleTime.text = lang("本轮战斗已结束")

		return
	end

	local leftTime = math.max(checknumber(self._nextShowTime) - ServerTime.now(), 0)

	if self._curState == STATE_BATTLE and leftTime <= 0 then
		self._txtScheduleTime.text = lang("本轮战斗结算中")

		removetimer(self._updateTimer, self)

		return
	end

	local timeStr = GameUtil.FormatTimeSymbol(leftTime)

	self._txtScheduleTime.text = self._curState == STATE_PREPARE and langPara("距离战斗开始：%s", timeStr) or langPara("距离本轮战斗结束：%s", timeStr)

	if self._nextUpdateTime > 0 and ServerTime.now() >= self._nextUpdateTime then
		removetimer(self._updateTimer, self)
	end
end

function YouthArenaThirdChampionMyScheduleView:_refreshStatusTips(tips)
	removetimer(self._updateTimer, self)
	goutil.setActive(self._com, false)
	goutil.setActive(self._knockout, true)
	goutil.setActive(self._hide, false)
	self:_setBuffBubbleActive(false)

	self._txtKnockout.text = tips or ""
end

function YouthArenaThirdChampionMyScheduleView:_refreshEliminatedTips(playerRoundId)
	local roundData = YouthArenaThirdConfig.instance:getRoundData(self._activityId, playerRoundId)
	local roundName = roundData and roundData.roundName

	if string.nilorempty(roundName) then
		self:_refreshStatusTips(lang("很遗憾，您未进入冠军淘汰赛"))
	else
		self:_refreshStatusTips(langPara("很遗憾，您止步于%s", roundName))
	end
end

function YouthArenaThirdChampionMyScheduleView:_sendMyKnockoutInfoReq()
	if checknumber(self._activityId) <= 0 then
		return
	end

	self._hasMyKnockoutInfoRes = false

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3MyKnockoutInfoReq(self._activityId)
end

function YouthArenaThirdChampionMyScheduleView:_handleGetInfoRes()
	if self._hasMyKnockoutInfoRes then
		self:_refreshProtocolInfo()
	end
end

function YouthArenaThirdChampionMyScheduleView:_handleMyKnockoutInfoRes()
	self._hasMyKnockoutInfoRes = true

	self:_refreshProtocolInfo()
end

function YouthArenaThirdChampionMyScheduleView:_handleStepChange()
	self._hasMyKnockoutInfoRes = false

	self:_showEmpty()
	self:_sendMyKnockoutInfoReq()
end

function YouthArenaThirdChampionMyScheduleView:_getSubMo()
	if checknumber(self._activityId) <= 0 then
		return nil
	end

	return YouthArenaThirdController.instance:getSubMo(self._activityId)
end

function YouthArenaThirdChampionMyScheduleView:_getCurStepId()
	local subMo = self:_getSubMo()

	return checknumber(subMo and subMo:getCurStepId())
end

function YouthArenaThirdChampionMyScheduleView:_getCurStepCfg()
	return YouthArenaThirdConfig.instance:getStepData(self._activityId, self:_getCurStepId())
end

function YouthArenaThirdChampionMyScheduleView:_getCurBuffStepCfg()
	return YouthArenaThirdConfig.instance:getBuffStepDataByStepData(self._activityId, self:_getCurStepCfg())
end

function YouthArenaThirdChampionMyScheduleView:_getCurRoundId()
	local stepCfg = self:_getCurStepCfg()

	return checknumber(stepCfg and stepCfg.roundId)
end

function YouthArenaThirdChampionMyScheduleView:_getPlayerRoundId()
	local subMo = self:_getSubMo()

	return checknumber(subMo and subMo:getPlayerRoundId())
end

function YouthArenaThirdChampionMyScheduleView:_isPlayerEliminatedInChampionKnockout(playerRoundId, curRoundId)
	playerRoundId = checknumber(playerRoundId)
	curRoundId = checknumber(curRoundId)

	return playerRoundId >= YouthArenaThirdEnum.ChampionRoundId.KnockoutStart and playerRoundId <= YouthArenaThirdEnum.ChampionRoundId.KnockoutEnd and playerRoundId < curRoundId
end

function YouthArenaThirdChampionMyScheduleView:_getNextStepStartTime()
	local curStepId = self:_getCurStepId()
	local nextStepCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, curStepId + 1)

	if nextStepCfg and not string.nilorempty(nextStepCfg.startTime) then
		return GameUtil.string2time(nextStepCfg.startTime)
	end

	local actDefineCfg = ActivityDefineConfig.instance:getCfgByActivitYId(self._activityId)

	return actDefineCfg and GameUtil.string2time(actDefineCfg.endTime) or 0
end

function YouthArenaThirdChampionMyScheduleView:_getPlayerUserId(detail)
	local playerHeadInfo = detail and detail.headInfo
	local headInfo = playerHeadInfo and playerHeadInfo.headInfo

	return checknumber(headInfo and headInfo.userId)
end

function YouthArenaThirdChampionMyScheduleView:_getBuffViewedKey(roundId)
	return string.format(BUFF_VIEWED_KEY, checknumber(self._activityId), checknumber(roundId))
end

function YouthArenaThirdChampionMyScheduleView:_isBuffViewed(roundId)
	return GameUtil.getUserData(self:_getBuffViewedKey(roundId)) ~= nil
end

function YouthArenaThirdChampionMyScheduleView:_markBuffViewed(roundId)
	GameUtil.saveUserData(self:_getBuffViewedKey(roundId), 1)
end

function YouthArenaThirdChampionMyScheduleView:_setBuffBubbleActive(active)
	if self._bubbleBuff then
		goutil.setActive(self._bubbleBuff, active)
	end
end

function YouthArenaThirdChampionMyScheduleView:_refreshBuffBubble()
	local buffStepCfg = self:_getCurBuffStepCfg()
	local roundId = checknumber(buffStepCfg and buffStepCfg.roundId)
	local hasBuff = buffStepCfg and not string.nilorempty(buffStepCfg.buffDesc)

	self:_setBuffBubbleActive(hasBuff and roundId > 0 and not self:_isBuffViewed(roundId))
end

function YouthArenaThirdChampionMyScheduleView:_onClickBtnReport()
	UIStateManager.instance:push(ViewName.YouthArenaThirdChampionMyReportView, self._activityId, 0)
end

function YouthArenaThirdChampionMyScheduleView:_onClickBtnScoreRule()
	local subMo = self:_getSubMo()
	local knockoutInfo = subMo and subMo:getMyKnockoutInfo()
	local roundId = checknumber(knockoutInfo and knockoutInfo.roundId)

	if roundId <= 0 then
		return
	end

	local curStepData = self:_getCurStepCfg()

	UIStateManager.instance:push(ViewName.YouthArenaThirdScoreRuleTipsView, self._activityId, roundId, (checknumber(curStepData and curStepData.roundId) == roundId and curStepData.mode == "MODE_3V3" or nil) and YouthArenaThirdEnum.BattleMode.Three)
end

function YouthArenaThirdChampionMyScheduleView:_onClickBtnBuff()
	local subMo = self:_getSubMo()
	local knockoutInfo = subMo and subMo:getMyKnockoutInfo()
	local roundId = checknumber(knockoutInfo and knockoutInfo.roundId)

	if not YouthArenaThirdConfig.instance:hasKnockoutBuffPlanDataByRound(self._activityId, roundId) then
		FloatWordMgr.instance:show("暂无加成")

		return
	end

	local curStepData = self:_getCurStepCfg()

	UIStateManager.instance:push(ViewName.YouthArenaThirdZdlBuffPopView, self._activityId, roundId, (checknumber(curStepData and curStepData.roundId) == roundId and curStepData.mode == "MODE_3V3" or nil) and YouthArenaThirdEnum.BattleMode.Three)
	self:_markBuffViewed(roundId)
	self:_refreshBuffBubble()
end

function YouthArenaThirdChampionMyScheduleView:_onClickBtnFmt()
	YouthArenaThirdController.instance:openDefenseFormationView(self._activityId, false, YouthArenaThirdEnum.BattleMode.One, self:_getCurStepId())
end

return YouthArenaThirdChampionMyScheduleView
