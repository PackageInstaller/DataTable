-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionScoreRoundView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionScoreRoundView", package.seeall)

local YouthArenaThirdChampionScoreRoundView = class("YouthArenaThirdChampionScoreRoundView", ViewComponent)
local TOP_PLAYER_COUNT = 8
local PLAYER_COUNT_PER_GROUP = 2
local GROUP_COUNT = math.ceil(TOP_PLAYER_COUNT / PLAYER_COUNT_PER_GROUP)
local VIEW_GROUP_ID = 1
local RESULT_STATE_WIN = 0
local RESULT_STATE_LOSE = 1
local BATTLE_MODE_TEXT = {
	[YouthArenaThirdEnum.BattleMode.One] = "1v1",
	[YouthArenaThirdEnum.BattleMode.Three] = "3v3"
}

function YouthArenaThirdChampionScoreRoundView:ctor()
	YouthArenaThirdChampionScoreRoundView.super.ctor(self)
end

function YouthArenaThirdChampionScoreRoundView:buildUI()
	YouthArenaThirdChampionScoreRoundView.super.buildUI(self)

	self._mask = self:getGo("mask")
	self._modelCam = self:getGo("modelCam")
	self._rolePointLeft = self:getGo("modelCam/rolePoint_1")
	self._rolePointRight = self:getGo("modelCam/rolePoint_2")
	self._battleMode = self:getGo("battleMode")
	self._txtBattleMode = self:getTxt("battleMode/txt")
	self._txtScheduleTime = self:getTxt("scheduleTime/txt")
	self._cellLeft = self:_buildRoleCell(self:getGo("leftRole"), self._rolePointLeft)
	self._cellRight = self:_buildRoleCell(self:getGo("rightRole"), self._rolePointRight)
	self._btnScoreRule = self:getGo("btns/btnScoreRule")
	self._btnReport = self:getGo("btns/btnReport")
	self._btnSwitch = self:getGo("groupCol/btnSwtich")
	self._txtBtnSwitch = self:getTxt("groupCol/btnSwtich/txt")
	self._groupListGo = self:getGo("groupCol/scrView")
	self._groupScroller = ScrollerList.create(self:getGo("groupCol/scrView"), self:getGo("groupCol/scrCell"), GameUtil.handler(self._updateGroupCell, self), GameUtil.handler(self._clearGroupCell, self))
	self._rankScroller = ScrollerList.create(self:getGo("rankCol/scrView"), self:getGo("rankCol/scrCell"), GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))

	goutil.setActive(self._groupListGo, false)
end

function YouthArenaThirdChampionScoreRoundView:bindEvents()
	YouthArenaThirdChampionScoreRoundView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnScoreRule, self._onClickBtnScoreRule, self)
	GameUtil.addClickHandler(self._btnReport, self._onClickBtnReport, self)
	GameUtil.addClickHandler(self._btnSwitch, self._onClickBtnSwitch, self)
end

function YouthArenaThirdChampionScoreRoundView:unbindEvents()
	YouthArenaThirdChampionScoreRoundView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnScoreRule)
	GameUtil.rmClickHandler(self._btnReport)
	GameUtil.rmClickHandler(self._btnSwitch)
end

function YouthArenaThirdChampionScoreRoundView:onEnter()
	YouthArenaThirdChampionScoreRoundView.super.onEnter(self)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetKnockoutScheduleRes, self._handleGetScheduleRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3NotifyStepChangeRes, self._handleStepChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._roundId = checknumber(params[2])
	self._mode = checknumber(params[3])
	self._curGroupId = 1
	self._groupIdList = {}
	self._rankList = {}
	self._curMatchInfo = nil
	self._nextShowTime = 0
	self._timerPrefix = ""

	self:_initGroupData()
	self:_refreshStaticInfo()
	self:_refreshTimeInfo()
	self:_showEmpty()
	self:_onSwitchGroup(1, true)
end

function YouthArenaThirdChampionScoreRoundView:onExit()
	YouthArenaThirdChampionScoreRoundView.super.onExit(self)
	LightMgr.instance:setLightForNormalScene()
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	removetimer(self._updateTimer, self)
	goutil.setActive(self._groupListGo, false)
	self:_clearRoleCell(self._cellLeft)
	self:_clearRoleCell(self._cellRight)
end

function YouthArenaThirdChampionScoreRoundView:destroyUI()
	YouthArenaThirdChampionScoreRoundView.super.destroyUI(self)

	if self._groupScroller then
		self._groupScroller:dispose()

		self._groupScroller = nil
	end

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

function YouthArenaThirdChampionScoreRoundView:_buildRoleCell(go, rolePoint)
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

function YouthArenaThirdChampionScoreRoundView:_initGroupData()
	self._groupIdList = {}

	for i = 1, GROUP_COUNT do
		table.insert(self._groupIdList, i)
	end
end

function YouthArenaThirdChampionScoreRoundView:_refreshStaticInfo()
	GameUtil.setUIGroupIdx(self._battleMode, self._mode == YouthArenaThirdEnum.BattleMode.One and 0 or 1)

	self._txtBattleMode.text = BATTLE_MODE_TEXT[self._mode] or ""
end

function YouthArenaThirdChampionScoreRoundView:_showEmpty()
	self._curMatchInfo = nil

	self:_refreshMask()
	self:_refreshRankList({})
	self:_refreshMatchInfo()
end

function YouthArenaThirdChampionScoreRoundView:_refreshProtocolInfo()
	self:_refreshMask()
	self:_refreshRankList(self:_getTop8ScoreMatchPlayers())

	self._curMatchInfo = self:_getCurGroupMatchInfo()

	self:_refreshMatchInfo()

	if GameUtil.GetActive(self._groupListGo) then
		self._groupScroller:reloadData(self._groupIdList)
	end
end

function YouthArenaThirdChampionScoreRoundView:_refreshMask()
	local curRoundId = self:_getCurRoundId()
	local isEnded = curRoundId > 0 and self._roundId > 0 and curRoundId > self._roundId

	goutil.setActive(self._mask, isEnded)
end

function YouthArenaThirdChampionScoreRoundView:_refreshTimeInfo()
	removetimer(self._updateTimer, self)

	local curRoundId = self:_getCurRoundId()

	self._nextShowTime = 0
	self._timerPrefix = ""
	self._txtScheduleTime.text = ""

	if curRoundId <= 0 or self._roundId <= 0 then
		return
	end

	if curRoundId > self._roundId then
		self._txtScheduleTime.text = "本轮战斗已结束"

		return
	end

	if curRoundId < self._roundId then
		local firstStepCfg = self:_getFirstStepCfgByRoundId(self._roundId)

		self._nextShowTime = firstStepCfg and GameUtil.string2time(firstStepCfg.startTime) or 0
		self._timerPrefix = "距离本轮开始时间："
	else
		local curStepCfg = self:_getCurStepCfg()

		self._nextShowTime = self:_getNextStepStartTime()
		self._timerPrefix = curStepCfg and checkbool(curStepCfg.canSetForm) and "距离战斗开始时间：" or "距离战斗结束时间："
	end

	if self._nextShowTime <= 0 then
		return
	end

	self:_updateTimer()

	if self._nextShowTime > ServerTime.now() then
		settimer(1, self._updateTimer, self, true)
	end
end

function YouthArenaThirdChampionScoreRoundView:_updateTimer()
	local leftTime = math.max(checknumber(self._nextShowTime) - ServerTime.now(), 0)

	self._txtScheduleTime.text = self._timerPrefix .. GameUtil.FormatTimeSymbol(leftTime)

	if leftTime <= 0 then
		removetimer(self._updateTimer, self)
	end
end

function YouthArenaThirdChampionScoreRoundView:_refreshRankList(list)
	self._rankList = {}

	for rank, info in ipairs(list or {}) do
		local data = {
			rank = rank,
			info = info
		}

		table.insert(self._rankList, data)
	end

	self._rankScroller:reloadData(self._rankList)
end

function YouthArenaThirdChampionScoreRoundView:_refreshMatchInfo()
	local info = self._curMatchInfo

	self:_refreshRoleInfo(self._cellLeft, info and info.playerA)
	self:_refreshRoleInfo(self._cellRight, info and info.playerB)
	self:_refreshResult(info)
	goutil.setActive(self._btnReport, true)
end

function YouthArenaThirdChampionScoreRoundView:_refreshRoleInfo(cell, detail)
	if not cell then
		return
	end

	self:_clearRoleCell(cell)

	local playerHeadInfo = detail and detail.headInfo
	local headInfo = playerHeadInfo and playerHeadInfo.headInfo

	if not headInfo or checknumber(headInfo.userId) <= 0 then
		return
	end

	HeadItemController.instance:setHeadCellByInfo(cell.head, headInfo, true)

	cell.txtName.text = string.format("s%03d-%s", checknumber(headInfo.areaId), headInfo.userName or "")
	cell.txtPower.text = tostring(checknumber(detail.zdl))

	local skId = DressModel.instance:getSkeIdByGender(detail.gender)
	local mo = DressModel.instance:getAvatarPlayerMo(skId, (not detail.clothes or nil) and {}, 0)

	cell.avatar:updateByMo(mo)
	cell.avatar:setVisible(true)
end

function YouthArenaThirdChampionScoreRoundView:_clearRoleCell(cell)
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

	if cell.result then
		goutil.setActive(cell.result, false)
	end

	if cell.avatar then
		cell.avatar:setVisible(false)
	end
end

function YouthArenaThirdChampionScoreRoundView:_refreshResult(info)
	local result = info and info.result
	local winPlayerId = checknumber(result and result.winPlayerId)
	local isShow = result ~= nil and winPlayerId > 0

	goutil.setActive(self._cellLeft.result, isShow)
	goutil.setActive(self._cellRight.result, isShow)

	if not isShow then
		return
	end

	local playerAId = self:_getPlayerUserId(info.playerA)
	local isAWin = playerAId > 0 and winPlayerId == playerAId

	self._cellLeft.resultChange:SetState((isAWin or nil) and (RESULT_STATE_WIN or RESULT_STATE_LOSE))
	self._cellRight.resultChange:SetState((isAWin or nil) and (RESULT_STATE_LOSE or RESULT_STATE_WIN))
end

function YouthArenaThirdChampionScoreRoundView:_onSwitchGroup(groupId, forceReq)
	groupId = math.max(1, math.min(checknumber(groupId), GROUP_COUNT))
	self._curGroupId = groupId
	self._txtBtnSwitch.text = string.format("第%s组", GameUtil.getChineseNumber(groupId))

	goutil.setActive(self._groupListGo, false)

	local scheduleInfo = self:_getScheduleInfo()

	if scheduleInfo then
		self:_refreshProtocolInfo()
	else
		self._curMatchInfo = nil

		self:_refreshMask()
		self:_refreshMatchInfo()
	end

	if forceReq or not scheduleInfo then
		self:_sendScheduleReq()
	end
end

function YouthArenaThirdChampionScoreRoundView:_updateGroupCell(view, cell, groupId, tag)
	if not cell.gameObject then
		local go = cell
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local redPoint = goutil.findChild(go, "redPoint")
		local lock = goutil.findChild(go, "lock")
		local mark = goutil.findChild(go, "mark")
		local changeGroup = GameUtil.getUIChangeGroup(cell)

		GameUtil.rmClickHandler(go)

		txtName.text = string.format("第%s组", GameUtil.getChineseNumber(groupId))

		goutil.setActive(redPoint, false)
		goutil.setActive(lock, false)
		goutil.setActive(mark, self._curGroupId == groupId)

		if changeGroup then
			changeGroup:SetState(self._curGroupId == groupId and 1 or 0)
		end

		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickGroupCell, self, groupId))
	end
end

function YouthArenaThirdChampionScoreRoundView:_clearGroupCell(cell)
	if not cell.gameObject then
		GameUtil.rmClickHandler(cell.gameObject)
	end
end

function YouthArenaThirdChampionScoreRoundView:_onClickBtnSwitch()
	local isShow = GameUtil.GetActive(self._groupListGo)

	goutil.setActive(self._groupListGo, not isShow)

	if not isShow then
		self._groupScroller:reloadData(self._groupIdList)
	end
end

function YouthArenaThirdChampionScoreRoundView:_onClickGroupCell(groupId)
	self:_onSwitchGroup(groupId)
end

function YouthArenaThirdChampionScoreRoundView:_updateRankCell(view, cell, data, tag)
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

function YouthArenaThirdChampionScoreRoundView:_clearRankCell(cell)
	if not cell.gameObject then
		local go = cell
		local head = goutil.findChild(go, "head")

		HeadItemController.instance:resetHeadCell(head)
	end
end

function YouthArenaThirdChampionScoreRoundView:_sendScheduleReq()
	if self._activityId <= 0 or self._roundId <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetKnockoutScheduleReq(self._activityId, VIEW_GROUP_ID, self._roundId)
end

function YouthArenaThirdChampionScoreRoundView:_handleGetScheduleRes()
	self:_refreshProtocolInfo()
end

function YouthArenaThirdChampionScoreRoundView:_handleStepChange()
	self:_sendScheduleReq()
	self:_refreshMask()
	self:_refreshTimeInfo()
end

function YouthArenaThirdChampionScoreRoundView:_getCurGroupMatchInfo()
	local scheduleInfo = self:_getScheduleInfo()

	for _, matchInfo in ipairs((scheduleInfo or nil) and (scheduleInfo.groupList or {})) do
		if checknumber(matchInfo.roundId) == self._roundId and checknumber(matchInfo.index) == self._curGroupId then
			return matchInfo
		end
	end
end

function YouthArenaThirdChampionScoreRoundView:_getScheduleInfo()
	local subMo = self:_getSubMo()

	return subMo and subMo:getKnockoutScheduleInfo(VIEW_GROUP_ID, self._roundId)
end

function YouthArenaThirdChampionScoreRoundView:_getTop8ScoreMatchPlayers()
	local subMo = self:_getSubMo()

	return subMo and subMo:getTop8ScoreMatchPlayers(VIEW_GROUP_ID, self._roundId) or {}
end

function YouthArenaThirdChampionScoreRoundView:_getSubMo()
	if self._activityId <= 0 then
		return nil
	end

	return YouthArenaThirdController.instance:getSubMo(self._activityId)
end

function YouthArenaThirdChampionScoreRoundView:_getCurStepId()
	local subMo = self:_getSubMo()

	return checknumber(subMo and subMo:getCurStepId())
end

function YouthArenaThirdChampionScoreRoundView:_getCurStepCfg()
	return YouthArenaThirdConfig.instance:getStepData(self._activityId, self:_getCurStepId())
end

function YouthArenaThirdChampionScoreRoundView:_getCurRoundId()
	local stepCfg = self:_getCurStepCfg()

	return checknumber(stepCfg and stepCfg.roundId)
end

function YouthArenaThirdChampionScoreRoundView:_getFirstStepCfgByRoundId(roundId)
	local firstStepCfg

	for _, stepCfg in pairs(YouthArenaThirdConfig.instance:getStepDatas(self._activityId) or {}) do
		if checknumber(stepCfg.roundId) == checknumber(roundId) and (firstStepCfg == nil or checknumber(stepCfg.stepId) < checknumber(firstStepCfg.stepId)) then
			firstStepCfg = stepCfg
		end
	end

	return firstStepCfg
end

function YouthArenaThirdChampionScoreRoundView:_getNextStepStartTime()
	local nextStepCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, self:_getCurStepId() + 1)

	if nextStepCfg and not string.nilorempty(nextStepCfg.startTime) then
		return GameUtil.string2time(nextStepCfg.startTime)
	end

	local actDefineCfg = ActivityDefineConfig.instance:getCfgByActivitYId(self._activityId)

	return actDefineCfg and GameUtil.string2time(actDefineCfg.endTime) or 0
end

function YouthArenaThirdChampionScoreRoundView:_getPlayerUserId(detail)
	local playerHeadInfo = detail and detail.headInfo
	local headInfo = playerHeadInfo and playerHeadInfo.headInfo

	return checknumber(headInfo and headInfo.userId)
end

function YouthArenaThirdChampionScoreRoundView:_onClickBtnScoreRule()
	if self._activityId <= 0 or self._roundId <= 0 then
		return
	end

	UIStateManager.instance:push(ViewName.YouthArenaThirdScoreRuleTipsView, self._activityId, self._roundId, self._mode)
end

function YouthArenaThirdChampionScoreRoundView:_onClickBtnReport()
	local matchInfo = self._curMatchInfo

	if not matchInfo then
		return
	end

	UIStateManager.instance:push(ViewName.YouthArenaThirdChampionScheduleReportView, self._activityId, VIEW_GROUP_ID, self._roundId, self._mode, checknumber(matchInfo.index), checknumber(matchInfo.roundId))
end

return YouthArenaThirdChampionScoreRoundView
