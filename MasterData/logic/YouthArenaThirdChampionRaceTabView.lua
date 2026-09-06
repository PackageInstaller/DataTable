-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionRaceTabView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionRaceTabView", package.seeall)

local YouthArenaThirdChampionRaceTabView = class("YouthArenaThirdChampionRaceTabView", ViewComponent)
local TITLE_STATE = {
	[YouthArenaThirdEnum.TabKey.ChampionKnockout] = 0,
	[YouthArenaThirdEnum.TabKey.ChampionScoreMatch] = 1
}
local TAB_DATA_LIST = {
	{
		tabName = "1v1",
		mode = YouthArenaThirdEnum.BattleMode.One
	},
	{
		tabName = "3v3",
		mode = YouthArenaThirdEnum.BattleMode.Three
	}
}
local CHAMPION_SCORE_VIEW_GROUP_ID = 1

function YouthArenaThirdChampionRaceTabView:ctor()
	YouthArenaThirdChampionRaceTabView.super.ctor(self)
end

function YouthArenaThirdChampionRaceTabView:buildUI()
	YouthArenaThirdChampionRaceTabView.super.buildUI(self)

	self._imgTitleChange = self:getGo("imgTitle"):GetComponent("UIImageSpriteChange")
	self._txtScheduleTime = self:getTxt("scheduleTime/txt")
	self._headRoot = self:getGo("playerInfo/headRoot")
	self._txtName = self:getTxt("playerInfo/txtName")
	self._txtMyRank = self:getTxt("playerInfo/txtMyRank")
	self._txtMyScore = self:getTxt("playerInfo/txtMyScore")
	self._btnPk = self:getGo("btnPk")
	self._txtActTime = self:getTxt("opentime/txt")
	self._txtPeriod = self:getTxt("period/txt")
	self._tagBuffEmpty = self:getGo("buffCol/tagEmpty")
	self._tabScrollList = ScrollerList.create(self:getGo("buffCol/tabScrView"), self:getGo("buffCol/tabScrCell"), GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._buffScrollList = ScrollerList.create(self:getGo("buffCol/buffScrView"), self:getGo("buffCol/buffScrCell"), GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function YouthArenaThirdChampionRaceTabView:bindEvents()
	YouthArenaThirdChampionRaceTabView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPk, self._onClickBtnPk, self)
end

function YouthArenaThirdChampionRaceTabView:unbindEvents()
	YouthArenaThirdChampionRaceTabView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPk)
end

function YouthArenaThirdChampionRaceTabView:onEnter()
	YouthArenaThirdChampionRaceTabView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetInfoRes, self._refreshProtocolInfo, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3MyKnockoutInfoRes, self._handleMyKnockoutInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetKnockoutScheduleRes, self._handleScheduleRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3NotifyStepChangeRes, self._handleStepChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._tabData = params[2]
	self._modeStepId = nil
	self._curMode = nil
	self._scoreScheduleRoundId = nil
	self._knockoutScheduleViewGroupId = nil
	self._knockoutScheduleRoundId = nil

	self:_refreshStaticInfo()
	self:_refreshProtocolInfo()
	self:_sendMyKnockoutInfoReq()
	self:_sendMyKnockoutScheduleReq()
	self:_sendMyScoreScheduleReq()
end

function YouthArenaThirdChampionRaceTabView:onExit()
	YouthArenaThirdChampionRaceTabView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headRoot)
end

function YouthArenaThirdChampionRaceTabView:destroyUI()
	YouthArenaThirdChampionRaceTabView.super.destroyUI(self)

	if self._tabScrollList then
		self._tabScrollList:dispose()

		self._tabScrollList = nil
	end

	if self._buffScrollList then
		self._buffScrollList:dispose()

		self._buffScrollList = nil
	end

	self._activityId = nil
	self._tabData = nil
	self._modeStepId = nil
	self._curMode = nil
	self._scoreScheduleRoundId = nil
	self._knockoutScheduleViewGroupId = nil
	self._knockoutScheduleRoundId = nil
end

function YouthArenaThirdChampionRaceTabView:_refreshStaticInfo()
	self._txtScheduleTime.text = self:_formatScheduleTime()
	self._txtActTime.text = ActivityDefineController.instance:getActTimeDesc(YouthArenaThirdController.instance:getActivityType(), self._activityId)

	if self._imgTitleChange then
		self._imgTitleChange:SetState(TITLE_STATE[self._tabData and self._tabData.key] or 0)
	end

	self:_refreshRaceInfo()
end

function YouthArenaThirdChampionRaceTabView:_refreshProtocolInfo()
	local subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	local knockoutInfo = subMo and subMo:getMyKnockoutInfo()
	local playerDetail = knockoutInfo and knockoutInfo.myDetail
	local playerHeadInfo = playerDetail and playerDetail.headInfo
	local headInfo = playerHeadInfo and playerHeadInfo.headInfo
	local areaId, userName

	if not headInfo then
		headInfo = RoleModel.instance:getHeadInfo()
		areaId = RoleModel.instance:getAreaId()
		userName = RoleModel.instance:getUserName()
	else
		areaId = headInfo.areaId
		userName = headInfo.userName
	end

	HeadItemController.instance:resetHeadCell(self._headRoot)
	HeadItemController.instance:setHeadCellByInfo(self._headRoot, headInfo)

	self._txtName.text = string.format("s%03d-%s", checknumber(areaId), userName or "")
	self._txtMyRank.text = string.format("我的排名：%s", self:_formatMyRank(subMo, knockoutInfo))
	self._txtMyScore.text = string.format("我的积分：%s", self:_formatMyScore(subMo, knockoutInfo))

	self:_refreshRaceInfo()
end

function YouthArenaThirdChampionRaceTabView:_handleMyKnockoutInfoRes(status, msg)
	if status ~= 0 or checknumber(msg and msg.activityId) ~= checknumber(self._activityId) then
		return
	end

	self:_refreshProtocolInfo()
	self:_sendMyKnockoutScheduleReq()
	self:_sendMyScoreScheduleReq()
end

function YouthArenaThirdChampionRaceTabView:_handleScheduleRes(status, msg)
	if status ~= 0 or checknumber(msg and msg.activityId) ~= checknumber(self._activityId) then
		return
	end

	local viewGroupId = checknumber(msg and msg.viewGroupId)
	local roundId = checknumber(msg and msg.roundId)
	local isMine = self:_isChampionScoreTab() and viewGroupId == CHAMPION_SCORE_VIEW_GROUP_ID and roundId == checknumber(self._scoreScheduleRoundId) or not self:_isChampionScoreTab() and viewGroupId == checknumber(self._knockoutScheduleViewGroupId) and roundId == checknumber(self._knockoutScheduleRoundId)

	if not isMine then
		return
	end

	self:_refreshProtocolInfo()
end

function YouthArenaThirdChampionRaceTabView:_handleStepChange()
	self._scoreScheduleRoundId = nil
	self._knockoutScheduleViewGroupId = nil
	self._knockoutScheduleRoundId = nil
	self._txtMyScore.text = "我的积分：--"

	self:_refreshRaceInfo()
	self:_sendMyKnockoutInfoReq()
	self:_sendMyScoreScheduleReq()
end

function YouthArenaThirdChampionRaceTabView:_sendMyKnockoutInfoReq()
	if checknumber(self._activityId) <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3MyKnockoutInfoReq(self._activityId)
end

function YouthArenaThirdChampionRaceTabView:_sendMyKnockoutScheduleReq()
	if self:_isChampionScoreTab() then
		return
	end

	local subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	local knockoutInfo = subMo and subMo:getMyKnockoutInfo()
	local viewGroupId = self:_getMyKnockoutViewGroupId(knockoutInfo)
	local roundId = checknumber(knockoutInfo and knockoutInfo.roundId)

	if checknumber(self._activityId) <= 0 or viewGroupId <= 0 or roundId <= 0 then
		return
	end

	if subMo:getKnockoutScheduleInfo(viewGroupId, roundId) then
		return
	end

	if self._knockoutScheduleViewGroupId == viewGroupId and self._knockoutScheduleRoundId == roundId then
		return
	end

	self._knockoutScheduleViewGroupId = viewGroupId
	self._knockoutScheduleRoundId = roundId

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetKnockoutScheduleReq(self._activityId, viewGroupId, roundId)
end

function YouthArenaThirdChampionRaceTabView:_sendMyScoreScheduleReq()
	if not self:_isChampionScoreTab() then
		return
	end

	local roundId = self:_getChampionScoreRoundId()

	if checknumber(self._activityId) <= 0 or roundId <= 0 or self._scoreScheduleRoundId == roundId then
		return
	end

	self._scoreScheduleRoundId = roundId

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetKnockoutScheduleReq(self._activityId, CHAMPION_SCORE_VIEW_GROUP_ID, roundId)
end

function YouthArenaThirdChampionRaceTabView:_formatMyScore(subMo, knockoutInfo)
	if self:_isChampionScoreTab() then
		local roundId = self:_getChampionScoreRoundId()
		local scheduleInfo = subMo and subMo:getKnockoutScheduleInfo(CHAMPION_SCORE_VIEW_GROUP_ID, roundId)
		local myUserId = checknumber(RoleModel.instance:getUserId())

		for _, playerInfo in ipairs((scheduleInfo or nil) and (scheduleInfo.top8ScoreMatchPlayers or {})) do
			if myUserId > 0 then
				if myUserId == checknumber(playerInfo.headInfo and playerInfo.headInfo.userId) then
					return checknumber(playerInfo.score)
				end
			end
		end

		return "--"
	end

	local viewGroupId = self:_getMyKnockoutViewGroupId(knockoutInfo)
	local roundId = checknumber(knockoutInfo and knockoutInfo.roundId)
	local scheduleInfo = subMo and subMo:getKnockoutScheduleInfo(viewGroupId, roundId)
	local matchInfo, isPlayerA = self:_getMyKnockoutMatchInfo(scheduleInfo, roundId)
	local result = matchInfo and matchInfo.result

	if not result then
		return "--"
	end

	if isPlayerA then
		return checknumber(result.score1v1A) + checknumber(result.score3v3A)
	end

	return checknumber(result.score1v1B) + checknumber(result.score3v3B)
end

function YouthArenaThirdChampionRaceTabView:_getMyKnockoutViewGroupId(knockoutInfo)
	return YouthArenaThirdController.instance:getChampionScheduleViewGroupId(self._activityId, checknumber(knockoutInfo and knockoutInfo.roundId), checknumber(knockoutInfo and knockoutInfo.groupId))
end

function YouthArenaThirdChampionRaceTabView:_getMyKnockoutMatchInfo(scheduleInfo, roundId)
	local myUserId = tostring(RoleModel.instance:getUserId() or "")

	if string.nilorempty(myUserId) or checknumber(roundId) <= 0 then
		return nil
	end

	for _, matchInfo in ipairs((scheduleInfo or nil) and (scheduleInfo.groupList or {})) do
		if checknumber(matchInfo.roundId) == checknumber(roundId) then
			local playerAId = self:_getPlayerUserId(matchInfo.playerA)
			local playerBId = self:_getPlayerUserId(matchInfo.playerB)

			if myUserId == playerAId then
				return matchInfo, true
			elseif myUserId == playerBId then
				return matchInfo, false
			end
		end
	end
end

function YouthArenaThirdChampionRaceTabView:_getPlayerUserId(playerInfo)
	local playerHeadInfo = playerInfo and playerInfo.headInfo
	local headInfo = playerHeadInfo and playerHeadInfo.headInfo

	return tostring((headInfo or nil) and (headInfo.userId or ""))
end

function YouthArenaThirdChampionRaceTabView:_getChampionScoreRoundId()
	local subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	local knockoutInfo = subMo and subMo:getMyKnockoutInfo()
	local roundId = checknumber(knockoutInfo and knockoutInfo.roundId)

	if roundId > 0 and YouthArenaThirdController.instance:isChampionScoreRound(self._activityId, roundId) then
		return roundId
	end

	return checknumber(YouthArenaThirdController.instance:getRankChampionScoreRoundId(self._activityId))
end

function YouthArenaThirdChampionRaceTabView:_isChampionScoreTab()
	return self._tabData and self._tabData.key == YouthArenaThirdEnum.TabKey.ChampionScoreMatch
end

function YouthArenaThirdChampionRaceTabView:_formatMyRank(subMo, knockoutInfo)
	if not subMo or checknumber(subMo:getCurStepId()) <= 0 then
		return "--"
	end

	local roundId = checknumber(subMo and subMo:getPlayerRoundId())
	local rank = self:_formatKnockoutRank(roundId)

	if rank ~= "--" then
		return rank
	end

	roundId = checknumber(knockoutInfo and knockoutInfo.roundId)
	rank = self:_formatKnockoutRank(roundId)

	if rank ~= "--" then
		return rank
	end

	return "未晋级"
end

function YouthArenaThirdChampionRaceTabView:_formatKnockoutRank(roundId)
	roundId = checknumber(roundId)

	if roundId <= 0 then
		return "--"
	end

	local remainCount = {
		[YouthArenaThirdEnum.ChampionRoundId.KnockoutStart] = 128,
		[YouthArenaThirdEnum.ChampionRoundId.KnockoutStart + 1] = 64,
		[YouthArenaThirdEnum.ChampionRoundId.KnockoutStart + 2] = 32,
		[YouthArenaThirdEnum.ChampionRoundId.KnockoutEnd] = 16
	}
	local count = remainCount[roundId]

	if not count and YouthArenaThirdController.instance:isChampionScoreRound(self._activityId, roundId) then
		count = 8
	end

	return count and string.format("%s强", count) or "--"
end

function YouthArenaThirdChampionRaceTabView:_refreshRaceInfo()
	local stepData = self:_getCurrentStepData()

	self:_syncModeWithCurrentStep(stepData)
	self:_refreshTabs()

	if self:_isCurrentTabEnded() then
		self._txtPeriod.text = "当前赛程：已结束"

		self:_refreshBuffs(nil)

		return
	end

	local roundData = YouthArenaThirdConfig.instance:getRoundData(self._activityId, checknumber(stepData and stepData.roundId))

	self._txtPeriod.text = string.format("当前赛程：%s", (roundData or nil) and (roundData.roundName or "--"))

	self:_refreshBuffs(stepData)
end

function YouthArenaThirdChampionRaceTabView:_syncModeWithCurrentStep(stepData)
	local stepId = checknumber(stepData and stepData.stepId)

	if self._modeStepId == stepId and self:_isValidMode(self._curMode) then
		return
	end

	self._modeStepId = stepId

	if stepData and stepData.mode == "MODE_3V3" then
		self._curMode = YouthArenaThirdEnum.BattleMode.Three or YouthArenaThirdEnum.BattleMode.One
	end
end

function YouthArenaThirdChampionRaceTabView:_isValidMode(mode)
	return mode == YouthArenaThirdEnum.BattleMode.One or mode == YouthArenaThirdEnum.BattleMode.Three
end

function YouthArenaThirdChampionRaceTabView:_refreshTabs()
	self._tabScrollList:reloadData(TAB_DATA_LIST)
end

function YouthArenaThirdChampionRaceTabView:_refreshBuffs(stepData)
	local roundId = checknumber(stepData and stepData.roundId)
	local list = roundId > 0 and YouthArenaThirdConfig.instance:getKnockoutBuffPlanDatasByRoundMode(self._activityId, roundId, self._curMode) or {}

	list = list or {}

	goutil.setActive(self._tagBuffEmpty, #list <= 0)
	self._buffScrollList:reloadData(list)
end

function YouthArenaThirdChampionRaceTabView:_updateTabCell(view, cell, data)
	if not cell.gameObject then
		local go = cell
		local txtName = goutil.findChildTextComponent(go, "txtName")

		GameUtil.rmClickHandler(go)

		if txtName then
			if data then
				txtName.text = data.tabName or ""
			end
		end

		GameUtil.setUIGroupIdx(cell, data and data.mode == self._curMode and 1 or 0)
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickTab, self, data))
	end
end

function YouthArenaThirdChampionRaceTabView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell.gameObject or cell)
end

function YouthArenaThirdChampionRaceTabView:_onClickTab(data)
	local mode = data and data.mode

	if not self:_isValidMode(mode) or mode == self._curMode then
		return
	end

	self._curMode = mode

	self:_refreshTabs()

	if self:_isCurrentTabEnded() then
		self:_refreshBuffs(nil)

		return
	end

	self:_refreshBuffs(self:_getCurrentStepData())
end

function YouthArenaThirdChampionRaceTabView:_updateBuffCell(view, cell, data)
	if not cell.gameObject then
		local go = cell
		local icon = goutil.findChild(go, "icon")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local txtDesc = goutil.findChildTextComponent(go, "txtDesc")

		if data then
			txtName.text = data.name or ""
		end

		if data then
			txtDesc.text = data.desc or ""
		end

		if data and not string.nilorempty(data.icon) then
			uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, string.format("ui/%s.png", data.icon))
		else
			uGuiUtil.clearImage(icon)
		end
	end
end

function YouthArenaThirdChampionRaceTabView:_clearBuffCell(cell)
	if not cell.gameObject then
		local go = cell
		local icon = goutil.findChild(go, "icon")

		uGuiUtil.clearImage(icon)
	end
end

function YouthArenaThirdChampionRaceTabView:_getCurrentStepData()
	local subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	local stepId = checknumber(subMo and subMo:getCurStepId())

	return YouthArenaThirdConfig.instance:getStepData(self._activityId, stepId)
end

function YouthArenaThirdChampionRaceTabView:_isCurrentTabEnded()
	local subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	local currentStepId = checknumber(subMo and subMo:getCurStepId())
	local endStepId = self:_getContentEndStepId()

	return currentStepId > 0 and endStepId > 0 and endStepId <= currentStepId
end

function YouthArenaThirdChampionRaceTabView:_getContentEndStepId()
	if self._tabData and self._tabData.key == YouthArenaThirdEnum.TabKey.ChampionKnockout then
		return YouthArenaThirdController.instance:getChampionScoreMatchStartStepId(self._activityId)
	end

	if self._tabData and self._tabData.key == YouthArenaThirdEnum.TabKey.ChampionScoreMatch then
		return YouthArenaThirdController.instance:getDisplayStartStepId(self._activityId)
	end

	return checknumber(self._tabData and self._tabData.endStepId)
end

function YouthArenaThirdChampionRaceTabView:_formatScheduleTime()
	local startCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, (self._tabData or nil) and self._tabData.startStepId)
	local endCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, self:_getContentEndStepId())

	if endCfg then
		if not endCfg.startTime then
			local endTime = self:_getActivityEndTime()

			return string.format("赛程时间：%s - %s", self:_formatTimeStr(startCfg and startCfg.startTime), self:_formatTimeStr(endTime))
		end
	end
end

function YouthArenaThirdChampionRaceTabView:_getActivityEndTime()
	local actDefineCfg = ActivityDefineConfig.instance:getCfgByActivitYId(self._activityId)

	return actDefineCfg and actDefineCfg.endTime
end

function YouthArenaThirdChampionRaceTabView:_formatTimeStr(timeStr)
	if string.nilorempty(timeStr) then
		return ""
	end

	local date = GameUtil.time2date(GameUtil.string2time(timeStr))

	return string.format("%02d.%02d %02d:%02d", date.month, date.day, date.hour, date.min)
end

function YouthArenaThirdChampionRaceTabView:_onClickBtnPk()
	if self._tabData and self._tabData.key == YouthArenaThirdEnum.TabKey.ChampionKnockout then
		UIStateManager.instance:push(ViewName.YouthArenaThirdChampionKnockoutMainView, self._activityId)

		return
	end

	if self._tabData and self._tabData.key == YouthArenaThirdEnum.TabKey.ChampionScoreMatch then
		UIStateManager.instance:push(ViewName.YouthArenaThirdChampionScoreMainView, self._activityId)
	end
end

return YouthArenaThirdChampionRaceTabView
