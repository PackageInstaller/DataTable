-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionQuarterfinalistsView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionQuarterfinalistsView", package.seeall)

local YouthArenaThirdChampionQuarterfinalistsView = class("YouthArenaThirdChampionQuarterfinalistsView", ViewComponent)
local VIEW_GROUP_ID = 1
local BUFF_VIEWED_KEY = "YouthArenaThirdBuffViewed_%s_%s"

function YouthArenaThirdChampionQuarterfinalistsView:ctor()
	YouthArenaThirdChampionQuarterfinalistsView.super.ctor(self)
end

function YouthArenaThirdChampionQuarterfinalistsView:buildUI()
	YouthArenaThirdChampionQuarterfinalistsView.super.buildUI(self)

	self._txtTitle = self:getTxt("title/txt")
	self._txtScheduleTime = self:getTxt("scheduleTime/txt")
	self._btnScoreRule = self:getGo("btnScoreRule")
	self._btnBuff = self:getGo("btnBuff")
	self._bubbleBuff = goutil.findChild(self._btnBuff, "bubble")
	self._tableview = ScrollerList.create(self:getGo("tableview"), self:getGo("tableview/tablecell"), GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function YouthArenaThirdChampionQuarterfinalistsView:bindEvents()
	YouthArenaThirdChampionQuarterfinalistsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnScoreRule, self._onClickBtnScoreRule, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
end

function YouthArenaThirdChampionQuarterfinalistsView:unbindEvents()
	YouthArenaThirdChampionQuarterfinalistsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnScoreRule)
	GameUtil.rmClickHandler(self._btnBuff)
end

function YouthArenaThirdChampionQuarterfinalistsView:onEnter()
	YouthArenaThirdChampionQuarterfinalistsView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetKnockoutScheduleRes, self._handleGetScheduleRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3NotifyStepChangeRes, self._handleStepChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._roundId = checknumber(params[2])
	self._groupList = {}
	self._nextStageTime = 0
	self._timerPrefix = ""

	self:_refreshStaticInfo()
	self:_refreshBuffBubble()
	self:_refreshTimeInfo()
	self:_refreshSchedule()
	self:_sendScheduleReq()
end

function YouthArenaThirdChampionQuarterfinalistsView:onExit()
	YouthArenaThirdChampionQuarterfinalistsView.super.onExit(self)
	removetimer(self._updateTimer, self)
end

function YouthArenaThirdChampionQuarterfinalistsView:destroyUI()
	YouthArenaThirdChampionQuarterfinalistsView.super.destroyUI(self)

	if self._tableview then
		self._tableview:dispose()

		self._tableview = nil
	end
end

function YouthArenaThirdChampionQuarterfinalistsView:_refreshStaticInfo()
	local roundData = YouthArenaThirdConfig.instance:getRoundData(self._activityId, self._roundId)

	if roundData then
		self._txtTitle.text = roundData.roundName or ""
	end
end

function YouthArenaThirdChampionQuarterfinalistsView:_refreshSchedule()
	self._groupList = {}

	local scheduleInfo = self:_getScheduleInfo()

	for _, matchInfo in ipairs((scheduleInfo or nil) and (scheduleInfo.groupList or {})) do
		if checknumber(matchInfo.roundId) == self._roundId then
			table.insert(self._groupList, matchInfo)
		end
	end

	table.sort(self._groupList, function(a, b)
		return checknumber(a and a.index) < checknumber(b and b.index)
	end)
	self._tableview:reloadData(self._groupList)
end

function YouthArenaThirdChampionQuarterfinalistsView:_refreshTimeInfo()
	removetimer(self._updateTimer, self)

	local curRoundId = self:_getCurRoundId()

	self._nextStageTime = 0
	self._timerPrefix = ""
	self._txtScheduleTime.text = ""

	if curRoundId <= 0 or self._roundId <= 0 then
		return
	end

	if curRoundId > self._roundId then
		self._txtScheduleTime.text = "本轮比赛已结束"

		return
	end

	local targetStepData

	if curRoundId < self._roundId then
		targetStepData = self:_getFirstStepDataByRoundId(self._roundId)
		self._timerPrefix = "距离本轮开始剩余："
	else
		local curStepData = self:_getCurStepData()

		targetStepData = YouthArenaThirdConfig.instance:getStepData(self._activityId, self:_getCurStepId() + 1)
		self._timerPrefix = curStepData and checkbool(curStepData.canSetForm) and "距离战斗开始剩余：" or "距离战斗结束剩余："
	end

	self._nextStageTime = targetStepData and GameUtil.string2time(targetStepData.startTime) or 0

	if self._nextStageTime > 0 then
		self:_updateTimer()

		if self._nextStageTime > ServerTime.now() then
			settimer(1, self._updateTimer, self, true)
		end
	end
end

function YouthArenaThirdChampionQuarterfinalistsView:_updateTimer()
	local timer = self._nextStageTime - ServerTime.now()

	if timer <= 0 then
		removetimer(self._updateTimer, self)

		timer = 0
	end

	self._txtScheduleTime.text = self._timerPrefix .. GameUtil.FormatTimeSymbol(timer)
end

function YouthArenaThirdChampionQuarterfinalistsView:_isFighting()
	local curStepData = self:_getCurStepData()

	return curStepData ~= nil and checknumber(curStepData.roundId) == self._roundId and not checkbool(curStepData.canSetForm)
end

function YouthArenaThirdChampionQuarterfinalistsView:_updateCell(view, cell, data, tag)
	if not cell.gameObject then
		local go = cell
		local txtTitle = goutil.findChildTextComponent(go, "txtTitle")
		local fight = goutil.findChild(go, "fight")
		local btnRecord = goutil.findChild(go, "btnRecord")

		if txtTitle then
			txtTitle.text = string.format("第  %s  组", checknumber(data and data.index))
		end

		self:_setOptionalActive(fight, self:_isFighting())
		self:_hideLegacyNode(go, "btnVote")
		GameUtil.rmClickHandler(btnRecord)
		self:_setOptionalActive(btnRecord, data ~= nil)

		if data then
			GameUtil.addClickHandler(btnRecord, GameUtil.handler(self._onClickBtnRecord, self, data))
		end

		local result = data and data.result
		local winPlayerId = checknumber(result and result.winPlayerId)
		local scoreA = self:_getMatchScore(result, true)
		local scoreB = self:_getMatchScore(result, false)

		self:_updateSeatCell(goutil.findChild(go, "seatCellA"), data and data.playerA, winPlayerId, scoreA)
		self:_updateSeatCell(goutil.findChild(go, "seatCellB"), data and data.playerB, winPlayerId, scoreB)
	end
end

function YouthArenaThirdChampionQuarterfinalistsView:_clearCell(cell)
	if not cell.gameObject then
		local go = cell
		local btnRecord = goutil.findChild(go, "btnRecord")

		GameUtil.rmClickHandler(btnRecord)
		self:_setOptionalActive(btnRecord, false)
		self:_clearSeatCell(goutil.findChild(go, "seatCellA"))
		self:_clearSeatCell(goutil.findChild(go, "seatCellB"))
	end
end

function YouthArenaThirdChampionQuarterfinalistsView:_updateSeatCell(go, playerInfo, winPlayerId, score)
	if not go then
		return
	end

	local cell = self:_buildSeatCell(go)
	local headInfo = self:_getHeadInfo(playerInfo)
	local userId = checknumber(headInfo and headInfo.userId)

	self:_clearSeatCellByCell(cell)

	if userId <= 0 then
		self:_setOptionalActive(cell.tagEmpty, true)

		return
	end

	if cell.head then
		HeadItemController.instance:setHeadCellByInfo(cell.head, headInfo, true)
	end

	if cell.txtName then
		cell.txtName.text = headInfo.userName or ""
	end

	if cell.txtScore then
		cell.txtScore.text = string.format("积分：%s", checknumber(score))
	end

	local isWin = winPlayerId > 0 and winPlayerId == userId
	local isFail = winPlayerId > 0 and winPlayerId ~= userId

	self:_setOptionalActive(cell.player, true)
	self:_setOptionalActive(cell.tagMy, userId == checknumber(RoleModel.instance:getUserId()))
	self:_setOptionalActive(cell.tagWin, isWin)
	self:_setOptionalActive(cell.tagFail, isFail)
end

function YouthArenaThirdChampionQuarterfinalistsView:_buildSeatCell(go)
	local player = goutil.findChild(go, "player")
	local tags = goutil.findChild(go, "tags")
	local var_17_0 = {
		go = go,
		player = player
	}

	var_17_0.head = player and goutil.findChild(player, "head") or nil
	var_17_0.txtName = player and goutil.findChildTextComponent(player, "name/txt") or nil
	var_17_0.txtScore = player and goutil.findChildTextComponent(player, "score/txt") or nil
	var_17_0.tags = tags
	var_17_0.tagEmpty = tags and goutil.findChild(tags, "empty") or nil
	var_17_0.tagFail = tags and goutil.findChild(tags, "fail") or nil
	var_17_0.tagWin = tags and goutil.findChild(tags, "win") or nil
	var_17_0.tagMy = tags and goutil.findChild(tags, "my") or nil

	return var_17_0
end

function YouthArenaThirdChampionQuarterfinalistsView:_clearSeatCell(go)
	if not go then
		return
	end

	self:_clearSeatCellByCell(self:_buildSeatCell(go))
end

function YouthArenaThirdChampionQuarterfinalistsView:_clearSeatCellByCell(cell)
	if not cell then
		return
	end

	if cell.head then
		HeadItemController.instance:resetHeadCell(cell.head)
	end

	if cell.txtName then
		cell.txtName.text = ""
	end

	if cell.txtScore then
		cell.txtScore.text = ""
	end

	self:_clearTags(cell.tags)
	self:_setOptionalActive(cell.player, false)
end

function YouthArenaThirdChampionQuarterfinalistsView:_clearTags(tags)
	if not tags then
		return
	end

	local childCnt = tags.transform.childCount - 1

	for i = 0, childCnt do
		local child = tags.transform:GetChild(i)

		self:_setOptionalActive(child.gameObject, false)
	end
end

function YouthArenaThirdChampionQuarterfinalistsView:_getHeadInfo(playerInfo)
	local playerHeadInfo = playerInfo and playerInfo.headInfo
	local headInfo = playerHeadInfo and playerHeadInfo.headInfo

	return headInfo or playerHeadInfo
end

function YouthArenaThirdChampionQuarterfinalistsView:_getMatchScore(result, isPlayerA)
	if isPlayerA then
		return checknumber(result and result.score1v1A) + checknumber(result and result.score3v3A)
	end

	return checknumber(result and result.score1v1B) + checknumber(result and result.score3v3B)
end

function YouthArenaThirdChampionQuarterfinalistsView:_hideLegacyNode(parent, path)
	self:_setOptionalActive(goutil.findChild(parent, path), false)
end

function YouthArenaThirdChampionQuarterfinalistsView:_setOptionalActive(go, active)
	if go then
		goutil.setActive(go, active)
	end
end

function YouthArenaThirdChampionQuarterfinalistsView:_sendScheduleReq()
	if self._activityId <= 0 or self._roundId <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetKnockoutScheduleReq(self._activityId, VIEW_GROUP_ID, self._roundId)
end

function YouthArenaThirdChampionQuarterfinalistsView:_handleGetScheduleRes()
	self:_refreshSchedule()
end

function YouthArenaThirdChampionQuarterfinalistsView:_handleStepChange()
	self:_refreshBuffBubble()
	self:_refreshTimeInfo()
	self:_refreshSchedule()
	self:_sendScheduleReq()
end

function YouthArenaThirdChampionQuarterfinalistsView:_getScheduleInfo()
	local subMo = self:_getSubMo()

	return subMo and subMo:getKnockoutScheduleInfo(VIEW_GROUP_ID, self._roundId)
end

function YouthArenaThirdChampionQuarterfinalistsView:_getSubMo()
	if self._activityId <= 0 then
		return nil
	end

	return YouthArenaThirdController.instance:getSubMo(self._activityId)
end

function YouthArenaThirdChampionQuarterfinalistsView:_getCurStepId()
	local subMo = self:_getSubMo()

	return checknumber(subMo and subMo:getCurStepId())
end

function YouthArenaThirdChampionQuarterfinalistsView:_getCurStepData()
	return YouthArenaThirdConfig.instance:getStepData(self._activityId, self:_getCurStepId())
end

function YouthArenaThirdChampionQuarterfinalistsView:_getCurRoundId()
	local stepData = self:_getCurStepData()

	return checknumber(stepData and stepData.roundId)
end

function YouthArenaThirdChampionQuarterfinalistsView:_getFirstStepDataByRoundId(roundId)
	local targetStepData

	for _, stepData in pairs(YouthArenaThirdConfig.instance:getStepDatas(self._activityId) or {}) do
		if checknumber(stepData.roundId) == checknumber(roundId) and (targetStepData == nil or checknumber(stepData.stepId) < checknumber(targetStepData.stepId)) then
			targetStepData = stepData
		end
	end

	return targetStepData
end

function YouthArenaThirdChampionQuarterfinalistsView:_getBuffStepCfg()
	return YouthArenaThirdConfig.instance:getBuffStepDataByRoundId(self._activityId, self._roundId)
end

function YouthArenaThirdChampionQuarterfinalistsView:_getBuffViewedKey(roundId)
	return string.format(BUFF_VIEWED_KEY, checknumber(self._activityId), checknumber(roundId))
end

function YouthArenaThirdChampionQuarterfinalistsView:_isBuffViewed(roundId)
	return GameUtil.getUserData(self:_getBuffViewedKey(roundId)) ~= nil
end

function YouthArenaThirdChampionQuarterfinalistsView:_markBuffViewed(roundId)
	GameUtil.saveUserData(self:_getBuffViewedKey(roundId), 1)
end

function YouthArenaThirdChampionQuarterfinalistsView:_setBuffBubbleActive(active)
	if self._bubbleBuff then
		goutil.setActive(self._bubbleBuff, active)
	end
end

function YouthArenaThirdChampionQuarterfinalistsView:_refreshBuffBubble()
	local buffStepCfg = self:_getBuffStepCfg()
	local roundId = checknumber(buffStepCfg and buffStepCfg.roundId)
	local hasBuff = buffStepCfg and not string.nilorempty(buffStepCfg.buffDesc)

	self:_setBuffBubbleActive(hasBuff and roundId > 0 and not self:_isBuffViewed(roundId))
end

function YouthArenaThirdChampionQuarterfinalistsView:_onClickBtnRecord(matchInfo)
	if not matchInfo then
		return
	end

	UIStateManager.instance:push(ViewName.YouthArenaThirdChampionScheduleReportView, self._activityId, VIEW_GROUP_ID, self._roundId, YouthArenaThirdEnum.BattleMode.One, checknumber(matchInfo.index), checknumber(matchInfo.roundId))
end

function YouthArenaThirdChampionQuarterfinalistsView:_onClickBtnScoreRule()
	if self._activityId <= 0 or self._roundId <= 0 then
		return
	end

	local curStepData = self:_getCurStepData()

	UIStateManager.instance:push(ViewName.YouthArenaThirdScoreRuleTipsView, self._activityId, self._roundId, (checknumber(curStepData and curStepData.roundId) == self._roundId and curStepData.mode == "MODE_3V3" or nil) and YouthArenaThirdEnum.BattleMode.Three)
end

function YouthArenaThirdChampionQuarterfinalistsView:_onClickBtnBuff()
	if not YouthArenaThirdConfig.instance:hasKnockoutBuffPlanDataByRound(self._activityId, self._roundId) then
		FloatWordMgr.instance:show("暂无加成")

		return
	end

	local curStepData = self:_getCurStepData()

	UIStateManager.instance:push(ViewName.YouthArenaThirdZdlBuffPopView, self._activityId, self._roundId, (checknumber(curStepData and curStepData.roundId) == self._roundId and curStepData.mode == "MODE_3V3" or nil) and YouthArenaThirdEnum.BattleMode.Three)
	self:_markBuffViewed(self._roundId)
	self:_refreshBuffBubble()
end

return YouthArenaThirdChampionQuarterfinalistsView
