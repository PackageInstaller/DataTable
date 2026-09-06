-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionScoreMyScheduleView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionScoreMyScheduleView", package.seeall)

local YouthArenaThirdChampionScoreMyScheduleView = class("YouthArenaThirdChampionScoreMyScheduleView", ViewComponent)
local STATE_PREPARE = 1
local STATE_BATTLE = 2
local STATE_END = 3
local RESULT_STATE_WIN = 0
local RESULT_STATE_LOSE = 1
local VIEW_GROUP_ID = 1
local BUFF_VIEWED_KEY = "YouthArenaThirdBuffViewed_%s_%s"
local BATTLE_MODE_TEXT = {
	[YouthArenaThirdEnum.BattleMode.One] = "1v1",
	[YouthArenaThirdEnum.BattleMode.Three] = "3v3"
}

function YouthArenaThirdChampionScoreMyScheduleView:ctor()
	YouthArenaThirdChampionScoreMyScheduleView.super.ctor(self)
end

function YouthArenaThirdChampionScoreMyScheduleView:buildUI()
	YouthArenaThirdChampionScoreMyScheduleView.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")
	self._hide = self:getGo("modelCam/bg/hide")
	self._rolePointLeft = self:getGo("modelCam/bg/hide/rolePoint_1")
	self._rolePointRight = self:getGo("modelCam/bg/hide/rolePoint_2")
	self._com = self:getGo("com")
	self._knockout = self:getGo("knockout")
	self._txtKnockout = self:getTxt("knockout/txt")
	self._txtScheduleTime = self:getTxt("com/scheduleTime/txt")
	self._battleMode = self:getGo("com/battleMode")
	self._txtBattleMode = self:getTxt("com/battleMode/txt")
	self._cellLeft = self:_buildRoleCell(self:getGo("com/leftRole"), self._rolePointLeft)
	self._cellRight = self:_buildRoleCell(self:getGo("com/rightRole"), self._rolePointRight)
	self._rankScroller = ScrollerList.create(self:getGo("com/rankCol/scrView"), self:getGo("com/rankCol/scrCell"), GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._btnReport = self:getGo("com/btns/btnReport")
	self._btnScoreRule = self:getGo("com/btns/btnScoreRule")
	self._btnBuff = self:getGo("com/btns/btnBuff")
	self._bubbleBuff = goutil.findChild(self._btnBuff, "bubble")
	self._btnFmt = self:getGo("com/btns/btnFmt")
end

function YouthArenaThirdChampionScoreMyScheduleView:bindEvents()
	YouthArenaThirdChampionScoreMyScheduleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnReport, self._onClickBtnReport, self)
	GameUtil.addClickHandler(self._btnScoreRule, self._onClickBtnScoreRule, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	GameUtil.addClickHandler(self._btnFmt, self._onClickBtnFmt, self)
end

function YouthArenaThirdChampionScoreMyScheduleView:unbindEvents()
	YouthArenaThirdChampionScoreMyScheduleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnReport)
	GameUtil.rmClickHandler(self._btnScoreRule)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnFmt)
end

function YouthArenaThirdChampionScoreMyScheduleView:onEnter()
	YouthArenaThirdChampionScoreMyScheduleView.super.onEnter(self)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetInfoRes, self._handleGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3MyKnockoutInfoRes, self._handleMyKnockoutInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetKnockoutScheduleRes, self._handleGetScheduleRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3NotifyStepChangeRes, self._handleStepChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._curState = nil
	self._mode = 0
	self._nextUpdateTime = 0
	self._nextShowTime = 0
	self._hasGetInfoRes = false
	self._hasMyKnockoutInfoRes = false
	self._scheduleRoundId = 0
	self._rankList = {}
	self._rankMap = {}

	self:_showEmpty()
	self:_sendMyKnockoutInfoReq()
end

function YouthArenaThirdChampionScoreMyScheduleView:onExit()
	YouthArenaThirdChampionScoreMyScheduleView.super.onExit(self)
	LightMgr.instance:setLightForNormalScene()
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	removetimer(self._updateTimer, self)
	self:_clearRoleCell(self._cellLeft)
	self:_clearRoleCell(self._cellRight)
end

function YouthArenaThirdChampionScoreMyScheduleView:destroyUI()
	YouthArenaThirdChampionScoreMyScheduleView.super.destroyUI(self)

	if self._rankScroller then
		self._rankScroller:dispose()

		self._rankScroller = nil
	end

	if self._cellLeft and self._cellLeft.avatar then
		AvatarsMgrNew.instance:removeAvatar(self._cellLeft.avatar)

		self._cellLeft.avatar = nil
	end

	if self._cellRight and self._cellRight.avatar then
		AvatarsMgrNew.instance:removeAvatar(self._cellRight.avatar)

		self._cellRight.avatar = nil
	end
end

function YouthArenaThirdChampionScoreMyScheduleView:_buildRoleCell(go, rolePoint)
	local cell = {}

	cell.go = go
	cell.rolePoint = rolePoint
	cell.head = goutil.findChild(go, "head")
	cell.txtName = goutil.findChildTextComponent(go, "txtName")
	cell.txtPower = goutil.findChildTextComponent(go, "txtPower")
	cell.rank = goutil.findChild(go, "rank")
	cell.rankChange = cell.rank and cell.rank:GetComponent("UIImageSpriteChange")
	cell.txtRank = goutil.findChildTextComponent(go, "rank/txt")
	cell.txtScore = goutil.findChildTextComponent(go, "score/txt")
	cell.result = goutil.findChild(go, "result")
	cell.resultChange = cell.result and cell.result:GetComponent("UIImageSpriteChange")
	cell.avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	cell.avatar:setParent(rolePoint.transform)
	cell.avatar:setLayer(SceneLayer.UI3D_Value)

	return cell
end

function YouthArenaThirdChampionScoreMyScheduleView:_clearRoleCell(cell)
	if not cell then
		return
	end

	if cell.head then
		HeadItemController.instance:resetHeadCell(cell.head)
	end

	if cell.txtName then
		cell.txtName.text = ""
	end

	if cell.txtPower then
		cell.txtPower.text = "0"
	end

	if cell.txtRank then
		goutil.setActive(cell.txtRank.gameObject, true)

		cell.txtRank.text = "--"
	end

	if cell.rankChange then
		cell.rankChange:SetState(3)
	end

	if cell.txtScore then
		cell.txtScore.text = "积分:0"
	end

	if cell.result then
		goutil.setActive(cell.result, false)
	end

	if cell.avatar then
		cell.avatar:setVisible(false)
	end
end

function YouthArenaThirdChampionScoreMyScheduleView:_showEmpty()
	removetimer(self._updateTimer, self)

	self._scheduleRoundId = 0

	self:_refreshRankList({})
	self:_clearRoleCell(self._cellLeft)
	self:_clearRoleCell(self._cellRight)
	goutil.setActive(self._com, false)
	goutil.setActive(self._knockout, false)
	goutil.setActive(self._hide, false)
	self:_setBuffBubbleActive(false)
end

function YouthArenaThirdChampionScoreMyScheduleView:_refreshProtocolInfo()
	local subMo = self:_getSubMo()

	if not subMo then
		self:_showEmpty()

		return
	end

	local myInfo = subMo:getMyKnockoutInfo()
	local curRoundId = self:_getCurRoundId()
	local playerRoundId = self:_getPlayerRoundId()
	local battleRoundId = checknumber(myInfo and myInfo.roundId)

	if curRoundId <= 0 then
		self:_showEmpty()

		return
	end

	if self:_isBeforeChampionScoreRound(curRoundId) then
		self:_refreshStatusTips(lang("冠军积分赛暂未开始"))

		return
	end

	if not self:_isPlayerInChampionScoreRound(playerRoundId) then
		self:_refreshEliminatedTips(playerRoundId)

		return
	end

	if self:_isPlayerEliminatedInChampionScore(playerRoundId, curRoundId) then
		self:_refreshEliminatedTips(playerRoundId)

		return
	end

	if self:_isAfterChampionScoreRound(curRoundId) then
		self:_refreshStatusTips(lang("冠军积分赛已结束"))

		return
	end

	if not myInfo or battleRoundId ~= curRoundId or not self:_isChampionScoreRound(battleRoundId) then
		self:_refreshStatusTips(lang("暂无赛程"))

		return
	end

	self._mode = self:_getBattleModeByRoundId(battleRoundId)

	if self._mode <= 0 then
		self:_refreshStatusTips(lang("暂无赛程"))

		return
	end

	goutil.setActive(self._com, true)
	goutil.setActive(self._knockout, false)
	goutil.setActive(self._hide, true)
	GameUtil.setUIGroupIdx(self._battleMode, self._mode == YouthArenaThirdEnum.BattleMode.One and 0 or 1)

	self._txtBattleMode.text = BATTLE_MODE_TEXT[self._mode] or ""
	self._scheduleRoundId = battleRoundId

	self:_refreshRankList(self:_getTop8ScoreMatchPlayers(battleRoundId))
	self:_refreshRoleInfo(self._cellLeft, myInfo.myDetail)
	self:_refreshRoleInfo(self._cellRight, myInfo.opponent)
	self:_refreshState(myInfo)
	self:_refreshBuffBubble()
	self:_sendScheduleReq(battleRoundId)
end

function YouthArenaThirdChampionScoreMyScheduleView:_refreshRoleInfo(cell, detail)
	if not cell then
		return
	end

	self:_clearRoleCell(cell)

	if not detail then
		return
	end

	local playerHeadInfo = detail.headInfo
	local headInfo = playerHeadInfo and playerHeadInfo.headInfo

	if not headInfo or checknumber(headInfo.userId) <= 0 then
		return
	end

	HeadItemController.instance:setHeadCellByInfo(cell.head, headInfo, true)

	cell.txtName.text = string.format("s%03d-%s", checknumber(headInfo.areaId), headInfo.userName or "")
	cell.txtPower.text = tostring(checknumber(detail.zdl))

	if self._rankMap then
		local rankInfo = self._rankMap[checknumber(headInfo.userId)]
		local rank = checknumber(rankInfo and rankInfo.rank)
		local var_12_1

		if rankInfo then
			::label_12_0::

			var_12_1 = rankInfo.info and rankInfo.info.score
		end

		local score = checknumber(var_12_1)
		local isTop3 = rank >= 1 and rank <= 3

		goutil.setActive(cell.txtRank.gameObject, not isTop3)

		cell.txtRank.text = not isTop3 and (rank > 0 and tostring(rank) or "--") or ""
		cell.txtScore.text = string.format("积分:%s", score)

		if cell.rankChange then
			cell.rankChange:SetState((isTop3 or nil) and (rank - 1 or 3))
		end

		local skId = DressModel.instance:getSkeIdByGender(detail.gender)
		local mo = DressModel.instance:getAvatarPlayerMo(skId, (not detail.clothes or nil) and {}, 0)

		cell.avatar:updateByMo(mo)
		cell.avatar:setVisible(true)
	end
end

function YouthArenaThirdChampionScoreMyScheduleView:_refreshRankList(list)
	self._rankList = {}
	self._rankMap = {}

	for rank, info in ipairs(list or {}) do
		local data = {
			rank = rank,
			info = info
		}

		table.insert(self._rankList, data)

		local var_13_0

		if info then
			::label_13_0::

			var_13_0 = info.headInfo and info.headInfo.userId
		end

		local userId = checknumber(var_13_0)

		if userId > 0 then
			self._rankMap[userId] = data
		end
	end

	self._rankScroller:reloadData(self._rankList)
end

function YouthArenaThirdChampionScoreMyScheduleView:_updateRankCell(view, cell, data, tag)
	if not cell.gameObject then
		local go = cell
		local info = data and data.info
		local rank = checknumber(data and data.rank)
		local headInfo = info and info.headInfo
		local head = goutil.findChild(go, "head")
		local rankGo = goutil.findChild(go, "rank")
		local rankChange = rankGo and rankGo:GetComponent("UIImageSpriteChange")
		local txtRank = goutil.findChildTextComponent(go, "rank/txt")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local txtScore = goutil.findChildTextComponent(go, "txtScore")
		local isTop3 = rank >= 1 and rank <= 3

		HeadItemController.instance:resetHeadCell(head)

		if headInfo then
			HeadItemController.instance:setHeadCellByInfo(head, headInfo, true)
		end

		if rankChange then
			rankChange:SetState((isTop3 or nil) and (rank - 1 or 3))
		end

		goutil.setActive(txtRank.gameObject, not isTop3)

		txtRank.text = not isTop3 and (rank > 0 and tostring(rank) or "--") or ""

		if headInfo then
			txtName.text = headInfo.userName or ""
		end

		txtScore.text = string.format("积分:<color=#3ADB98>%s</color>", checknumber(info and info.score))
	end
end

function YouthArenaThirdChampionScoreMyScheduleView:_clearRankCell(cell)
	if not cell.gameObject then
		local go = cell
		local head = goutil.findChild(go, "head")

		HeadItemController.instance:resetHeadCell(head)
	end
end

function YouthArenaThirdChampionScoreMyScheduleView:_refreshState(myInfo)
	local curStepCfg = self:_getCurStepCfg()
	local result = myInfo and myInfo.result
	local winPlayerId = checknumber(result and result.winPlayerId)

	self._curState = winPlayerId > 0 and STATE_END or curStepCfg and checkbool(curStepCfg.canSetForm) and STATE_PREPARE or STATE_BATTLE

	self:_refreshResult(myInfo)
	self:_refreshTimeInfo()
end

function YouthArenaThirdChampionScoreMyScheduleView:_refreshResult(myInfo)
	local result = myInfo and myInfo.result
	local winPlayerId = checknumber(result and result.winPlayerId)
	local isShow = winPlayerId > 0

	goutil.setActive(self._cellLeft.result, isShow)
	goutil.setActive(self._cellRight.result, isShow)

	if not isShow then
		return
	end

	local myUserId = self:_getPlayerUserId(myInfo.myDetail)
	local isMyWin = myUserId > 0 and winPlayerId == myUserId

	self._cellLeft.resultChange:SetState((isMyWin or nil) and (RESULT_STATE_WIN or RESULT_STATE_LOSE))
	self._cellRight.resultChange:SetState((isMyWin or nil) and (RESULT_STATE_LOSE or RESULT_STATE_WIN))
end

function YouthArenaThirdChampionScoreMyScheduleView:_refreshTimeInfo()
	removetimer(self._updateTimer, self)

	self._nextShowTime = self:_getNextStepStartTime()
	self._nextUpdateTime = self._nextShowTime

	self:_updateTimer()

	if self._curState ~= STATE_END and self._nextUpdateTime > ServerTime.now() then
		settimer(1, self._updateTimer, self, true)
	end
end

function YouthArenaThirdChampionScoreMyScheduleView:_updateTimer()
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

function YouthArenaThirdChampionScoreMyScheduleView:_refreshStatusTips(tips)
	removetimer(self._updateTimer, self)
	goutil.setActive(self._com, false)
	goutil.setActive(self._knockout, true)
	goutil.setActive(self._hide, false)
	self:_setBuffBubbleActive(false)

	self._txtKnockout.text = tips or ""
end

function YouthArenaThirdChampionScoreMyScheduleView:_refreshEliminatedTips(playerRoundId)
	removetimer(self._updateTimer, self)
	goutil.setActive(self._com, false)
	goutil.setActive(self._knockout, true)
	goutil.setActive(self._hide, false)
	self:_setBuffBubbleActive(false)

	local roundData = YouthArenaThirdConfig.instance:getRoundData(self._activityId, playerRoundId)
	local roundName = roundData and roundData.roundName

	self._txtKnockout.text = not string.nilorempty(roundName) and langPara("很遗憾，您止步于%s", roundName) or lang("很遗憾，您未进入冠军积分赛")
end

function YouthArenaThirdChampionScoreMyScheduleView:_sendScheduleReq(roundId)
	roundId = checknumber(roundId)

	if checknumber(self._activityId) <= 0 or roundId <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetKnockoutScheduleReq(self._activityId, VIEW_GROUP_ID, roundId)
end

function YouthArenaThirdChampionScoreMyScheduleView:_sendMyKnockoutInfoReq()
	if checknumber(self._activityId) <= 0 then
		return
	end

	self._hasGetInfoRes = self:_getCurStepId() > 0
	self._hasMyKnockoutInfoRes = false

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3MyKnockoutInfoReq(self._activityId)
end

function YouthArenaThirdChampionScoreMyScheduleView:_handleGetInfoRes()
	self._hasGetInfoRes = true

	if self._hasMyKnockoutInfoRes then
		self:_refreshProtocolInfo()
	end
end

function YouthArenaThirdChampionScoreMyScheduleView:_handleMyKnockoutInfoRes()
	self._hasMyKnockoutInfoRes = true

	if self._hasGetInfoRes then
		self:_refreshProtocolInfo()
	end
end

function YouthArenaThirdChampionScoreMyScheduleView:_handleGetScheduleRes()
	local roundId = checknumber(self._scheduleRoundId)
	local scheduleInfo = self:_getScheduleInfo(roundId)

	if roundId <= 0 or not scheduleInfo then
		return
	end

	self:_refreshRankList(scheduleInfo.top8ScoreMatchPlayers)

	local subMo = self:_getSubMo()
	local myInfo = subMo and subMo:getMyKnockoutInfo()

	if checknumber(myInfo and myInfo.roundId) ~= roundId then
		return
	end

	self:_refreshRoleInfo(self._cellLeft, myInfo.myDetail)
	self:_refreshRoleInfo(self._cellRight, myInfo.opponent)
	self:_refreshResult(myInfo)
end

function YouthArenaThirdChampionScoreMyScheduleView:_handleStepChange()
	self._hasGetInfoRes = false
	self._hasMyKnockoutInfoRes = false

	self:_showEmpty()
	self:_sendMyKnockoutInfoReq()
end

function YouthArenaThirdChampionScoreMyScheduleView:_getSubMo()
	if checknumber(self._activityId) <= 0 then
		return nil
	end

	return YouthArenaThirdController.instance:getSubMo(self._activityId)
end

function YouthArenaThirdChampionScoreMyScheduleView:_getScheduleInfo(roundId)
	local subMo = self:_getSubMo()

	return subMo and subMo:getKnockoutScheduleInfo(VIEW_GROUP_ID, roundId)
end

function YouthArenaThirdChampionScoreMyScheduleView:_getTop8ScoreMatchPlayers(roundId)
	local subMo = self:_getSubMo()

	return subMo and subMo:getTop8ScoreMatchPlayers(VIEW_GROUP_ID, roundId) or {}
end

function YouthArenaThirdChampionScoreMyScheduleView:_getCurStepId()
	local subMo = self:_getSubMo()

	return checknumber(subMo and subMo:getCurStepId())
end

function YouthArenaThirdChampionScoreMyScheduleView:_getCurStepCfg()
	return YouthArenaThirdConfig.instance:getStepData(self._activityId, self:_getCurStepId())
end

function YouthArenaThirdChampionScoreMyScheduleView:_getCurBuffStepCfg()
	return YouthArenaThirdConfig.instance:getBuffStepDataByStepData(self._activityId, self:_getCurStepCfg())
end

function YouthArenaThirdChampionScoreMyScheduleView:_getCurRoundId()
	local stepCfg = self:_getCurStepCfg()

	return checknumber(stepCfg and stepCfg.roundId)
end

function YouthArenaThirdChampionScoreMyScheduleView:_getPlayerRoundId()
	local subMo = self:_getSubMo()

	return checknumber(subMo and subMo:getPlayerRoundId())
end

function YouthArenaThirdChampionScoreMyScheduleView:_getNextStepStartTime()
	local curStepId = self:_getCurStepId()
	local nextStepCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, curStepId + 1)

	if nextStepCfg and not string.nilorempty(nextStepCfg.startTime) then
		return GameUtil.string2time(nextStepCfg.startTime)
	end

	local actDefineCfg = ActivityDefineConfig.instance:getCfgByActivitYId(self._activityId)

	return actDefineCfg and GameUtil.string2time(actDefineCfg.endTime) or 0
end

function YouthArenaThirdChampionScoreMyScheduleView:_getPlayerUserId(detail)
	local playerHeadInfo = detail and detail.headInfo
	local headInfo = playerHeadInfo and playerHeadInfo.headInfo

	return checknumber(headInfo and headInfo.userId)
end

function YouthArenaThirdChampionScoreMyScheduleView:_getBattleModeByRoundId(roundId)
	local roundData = YouthArenaThirdConfig.instance:getRoundData(self._activityId, roundId)
	local roundType = roundData and roundData.roundType

	if roundType == YouthArenaThirdEnum.RoundType.Top8ScoreMatch1v1 then
		return YouthArenaThirdEnum.BattleMode.One
	elseif roundType == YouthArenaThirdEnum.RoundType.Top8ScoreMatch3v3 then
		return YouthArenaThirdEnum.BattleMode.Three
	end

	return 0
end

function YouthArenaThirdChampionScoreMyScheduleView:_isChampionScoreRound(roundId)
	local roundData = YouthArenaThirdConfig.instance:getRoundData(self._activityId, roundId)

	return roundData ~= nil and YouthArenaThirdController.instance:isChampionScoreRoundType(roundData.roundType)
end

function YouthArenaThirdChampionScoreMyScheduleView:_isPlayerInChampionScoreRound(playerRoundId)
	local minRoundId = self:_getChampionScoreRoundRange()

	return minRoundId > 0 and minRoundId <= checknumber(playerRoundId)
end

function YouthArenaThirdChampionScoreMyScheduleView:_isPlayerEliminatedInChampionScore(playerRoundId, curRoundId)
	playerRoundId = checknumber(playerRoundId)
	curRoundId = checknumber(curRoundId)

	if playerRoundId <= 0 or curRoundId <= 0 then
		return false
	end

	if not self:_isPlayerInChampionScoreRound(playerRoundId) then
		return false
	end

	local _, maxRoundId = self:_getChampionScoreRoundRange()

	if maxRoundId <= 0 then
		return false
	end

	return playerRoundId < math.min(curRoundId, maxRoundId)
end

function YouthArenaThirdChampionScoreMyScheduleView:_getChampionScoreRoundRange()
	local minRoundId = 0
	local maxRoundId = 0

	for _, roundData in pairs(YouthArenaThirdConfig.instance:getRoundDatas(self._activityId) or {}) do
		if YouthArenaThirdController.instance:isChampionScoreRoundType(roundData.roundType) then
			local roundId = checknumber(roundData.roundId)

			if roundId > 0 then
				minRoundId = minRoundId <= 0 and roundId or math.min(minRoundId, roundId)
				maxRoundId = math.max(maxRoundId, roundId)
			end
		end
	end

	return minRoundId, maxRoundId
end

function YouthArenaThirdChampionScoreMyScheduleView:_isBeforeChampionScoreRound(roundId)
	local minRoundId = self:_getChampionScoreRoundRange()

	return minRoundId > 0 and checknumber(roundId) > 0 and minRoundId > checknumber(roundId)
end

function YouthArenaThirdChampionScoreMyScheduleView:_isAfterChampionScoreRound(roundId)
	local _, maxRoundId = self:_getChampionScoreRoundRange()

	return maxRoundId > 0 and maxRoundId < checknumber(roundId)
end

function YouthArenaThirdChampionScoreMyScheduleView:_getBuffViewedKey(roundId)
	return string.format(BUFF_VIEWED_KEY, checknumber(self._activityId), checknumber(roundId))
end

function YouthArenaThirdChampionScoreMyScheduleView:_isBuffViewed(roundId)
	return GameUtil.getUserData(self:_getBuffViewedKey(roundId)) ~= nil
end

function YouthArenaThirdChampionScoreMyScheduleView:_markBuffViewed(roundId)
	GameUtil.saveUserData(self:_getBuffViewedKey(roundId), 1)
end

function YouthArenaThirdChampionScoreMyScheduleView:_setBuffBubbleActive(active)
	if self._bubbleBuff then
		goutil.setActive(self._bubbleBuff, active)
	end
end

function YouthArenaThirdChampionScoreMyScheduleView:_refreshBuffBubble()
	local buffStepCfg = self:_getCurBuffStepCfg()
	local roundId = checknumber(buffStepCfg and buffStepCfg.roundId)
	local hasBuff = buffStepCfg and not string.nilorempty(buffStepCfg.buffDesc)

	self:_setBuffBubbleActive(hasBuff and roundId > 0 and not self:_isBuffViewed(roundId))
end

function YouthArenaThirdChampionScoreMyScheduleView:_onClickBtnReport()
	UIStateManager.instance:push(ViewName.YouthArenaThirdChampionMyReportView, self._activityId, self._mode)
end

function YouthArenaThirdChampionScoreMyScheduleView:_onClickBtnScoreRule()
	local subMo = self:_getSubMo()
	local myInfo = subMo and subMo:getMyKnockoutInfo()
	local roundId = checknumber(myInfo and myInfo.roundId)

	if roundId <= 0 then
		return
	end

	UIStateManager.instance:push(ViewName.YouthArenaThirdScoreRuleTipsView, self._activityId, roundId, self._mode)
end

function YouthArenaThirdChampionScoreMyScheduleView:_onClickBtnBuff()
	local roundId = checknumber(self._scheduleRoundId)

	if not YouthArenaThirdConfig.instance:hasKnockoutBuffPlanDataByRound(self._activityId, roundId) then
		FloatWordMgr.instance:show("暂无加成")

		return
	end

	UIStateManager.instance:push(ViewName.YouthArenaThirdZdlBuffPopView, self._activityId, roundId, self._mode)
	self:_markBuffViewed(roundId)
	self:_refreshBuffBubble()
end

function YouthArenaThirdChampionScoreMyScheduleView:_onClickBtnFmt()
	if self._mode ~= YouthArenaThirdEnum.BattleMode.One and self._mode ~= YouthArenaThirdEnum.BattleMode.Three then
		FloatWordMgr.instance:show("当前赛程数据异常")

		return
	end

	local curStepCfg = self:_getCurStepCfg()

	if not curStepCfg or not checkbool(curStepCfg.canSetForm) then
		FloatWordMgr.instance:show("当前阶段不可调整守阵")

		return
	end

	YouthArenaThirdController.instance:openDefenseFormationView(self._activityId, false, self._mode, checknumber(curStepCfg.stepId))
end

return YouthArenaThirdChampionScoreMyScheduleView
