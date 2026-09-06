-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/controller/LiYangKingController.lua

module("logic.extensions.liyangking.controller.LiYangKingController", package.seeall)

local LiYangKingController = class("LiYangKingController", BaseController)

function LiYangKingController:ctor()
	return
end

function LiYangKingController:onInit()
	self:onReset()
end

function LiYangKingController:onReset()
	self._chapter3FmtMo = LiYangKingFmtMo.New()
	self._chapter3HelpFmtMo = LiYangKingHelpFmtMo.New()
	self._activityId = nil
	self._otherUserId = nil
	self._positionId = nil
	self._helpId = nil
end

function LiYangKingController:getChapter3HelpFmtMo()
	return self._chapter3HelpFmtMo
end

function LiYangKingController:sendPM_PrinceLiyangInfoReq(activityId)
	LiYangKingAgent.instance:sendPM_PrinceLiyangInfoReq(activityId)
end

function LiYangKingController:handlePM_PrinceLiyangInfoRes(msg)
	LiYangKingModel.instance:handlePM_PrinceLiyangInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PrinceLiyangInfoRes, msg.report)
end

function LiYangKingController:sendPM_PrinceLiyangGainHangingReq(activityId)
	LiYangKingAgent.instance:sendPM_PrinceLiyangGainHangingReq(activityId)
end

function LiYangKingController:handlePM_PrinceLiyangGainHangingRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PrinceLiyangGainHangingRes, status)
end

function LiYangKingController:sendPM_PrinceLiyangUnlockBuildingReq(activityId, buildingId)
	LiYangKingAgent.instance:sendPM_PrinceLiyangUnlockBuildingReq(activityId, buildingId)
end

function LiYangKingController:handlePM_PrinceLiyangUnlockBuildingRes(msg)
	LiYangKingModel.instance:handlePM_PrinceLiyangUnlockBuildingRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PrinceLiyangUnlockBuildingRes)
end

function LiYangKingController:sendPM_PrinceLiyangUpgradeBuildingReq(activityId, buildingId)
	LiYangKingAgent.instance:sendPM_PrinceLiyangUpgradeBuildingReq(activityId, buildingId)
end

function LiYangKingController:handlePM_PrinceLiyangUpgradeBuildingRes(msg)
	LiYangKingModel.instance:handlePM_PrinceLiyangUpgradeBuildingRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PrinceLiyangUpgradeBuildingRes)
end

function LiYangKingController:sendPM_PrinceLiyangHandleEventReq(activityId, eventId, optionId)
	LiYangKingAgent.instance:sendPM_PrinceLiyangHandleEventReq(activityId, eventId, optionId)
end

function LiYangKingController:handlePM_PrinceLiyangHandleEventRes(msg)
	LiYangKingModel.instance:handlePM_PrinceLiyangHandleEventRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PrinceLiyangHandleEventRes, msg.activityId, msg.eventId, msg.optionId)
end

function LiYangKingController:sendPM_PrinceLiyangOneKeyGainPrizeReq(activityId)
	LiYangKingAgent.instance:sendPM_PrinceLiyangOneKeyGainPrizeReq(activityId)
end

function LiYangKingController:handlePM_PrinceLiyangOneKeyGainPrizeRes(msg)
	LiYangKingModel.instance:handlePM_PrinceLiyangOneKeyGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PrinceLiyangOneKeyGainPrizeRes)
end

function LiYangKingController:handlePM_NotifyPrinceLiyangChangeRes(msg)
	LiYangKingModel.instance:handlePM_NotifyPrinceLiyangChangeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyPrinceLiyangChangeRes, msg)
end

function LiYangKingController:sendPM_PrinceLiyangRankInfoReq(activityId)
	LiYangKingAgent.instance:sendPM_PrinceLiyangRankInfoReq(activityId)
end

function LiYangKingController:handlePM_PrinceLiyangRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PrinceLiyangRankInfoRes, msg)
end

function LiYangKingController:sendPM_PrinceLiyangClgInfoReq(activityId)
	LiYangKingAgent.instance:sendPM_PrinceLiyangClgInfoReq(activityId)
end

function LiYangKingController:handlePM_PrinceLiyangClgInfoRes(msg)
	LiYangKingModel.instance:handlePM_PrinceLiyangClgInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PrinceLiyangClgInfoRes, msg)
end

function LiYangKingController:sendPM_PrinceLiyangClgSelectStarReq(activityId, positionId, star)
	LiYangKingAgent.instance:sendPM_PrinceLiyangClgSelectStarReq(activityId, positionId, star)
end

function LiYangKingController:handlePM_PrinceLiyangClgSelectStarRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PrinceLiyangClgSelectStarRes, msg)
end

function LiYangKingController:sendPM_PrinceLiyangClgSelfClgReq(activityId, positionId, form)
	LiYangKingAgent.instance:sendPM_PrinceLiyangClgSelfClgReq(activityId, positionId, form)
end

function LiYangKingController:handlePM_PrinceLiyangClgSelfClgRes(msg)
	local info = GameUtil.pbToTable(msg)
	local state = info.state

	if state == 1 then
		FloatWordMgr.instance:show("已经刷新走了")
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
	elseif state == 2 then
		FloatWordMgr.instance:show("已经被击杀")
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
	elseif state == 3 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		LiYangKingModel.instance:pushChangeSetId(msg.changeSetId)
		BattleController.instance:viewUserFightMonsterBtlResult(msg.battleResult, false)
	elseif state == 4 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		LiYangKingModel.instance:pushChangeSetId(msg.changeSetId)
		BattleController.instance:viewUserFightMonsterBtlResult(msg.battleResult, false)
	end
end

function LiYangKingController:sendPM_PrinceLiyangClgSeekHelpReq(activityId, positionId)
	LiYangKingAgent.instance:sendPM_PrinceLiyangClgSeekHelpReq(activityId, positionId)
end

function LiYangKingController:handlePM_PrinceLiyangClgSeekHelpRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PrinceLiyangClgSeekHelpRes, msg)
end

function LiYangKingController:sendPM_PrinceLiyangClgResetStarReq(activityId, positionId, star)
	LiYangKingAgent.instance:sendPM_PrinceLiyangClgResetStarReq(activityId, positionId, star)
end

function LiYangKingController:handlePM_PrinceLiyangClgResetStarRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PrinceLiyangClgResetStarRes, msg)
end

function LiYangKingController:sendPM_PrinceLiyangClgHelpInfoReq(activityId, otherUserId, positionId, helpId)
	if checknumber(RoleModel.instance:getUserId()) == checknumber(otherUserId) then
		return
	end

	self._lastActivityId = checknumber(activityId)
	self._lastOtherUserId = checknumber(otherUserId)
	self._lastHelpId = checknumber(helpId)
	self._lastPositionId = checknumber(positionId)
	self._needJump = false

	if BattleController.instance:isBattling() then
		FloatWordMgr.instance:show("战斗中")

		return
	end

	LiYangKingAgent.instance:sendPM_PrinceLiyangClgHelpInfoReq(activityId, otherUserId, positionId, helpId)
end

function LiYangKingController:handlePM_PrinceLiyangClgHelpInfoRes(msg)
	local info = GameUtil.pbToTable(msg)

	if not info.position then
		FloatWordMgr.instance:show("该求助已处理了")

		return
	else
		self:openChapter3HelpMissionView(self._lastActivityId, self._lastOtherUserId, self._lastHelpId, info.position)
	end

	self._lastActivityId = nil
	self._lastOtherUserId = nil
	self._lastHelpId = nil
	self._lastPositionId = nil

	GlobalDispatcher:dispatch(GlobalNotify.PM_PrinceLiyangClgHelpInfoRes, msg)
end

function LiYangKingController:openChapter3HelpMissionView(activityId, otherUserId, helpId, positionInfo)
	self._chapter3HelpFmtMo:initParams(activityId, otherUserId, helpId, positionInfo)
	CustomFmtController.instance:showMissionView(self._chapter3HelpFmtMo)
end

function LiYangKingController:sendPM_PrinceLiyangClgHelpCenterReq(activityId, star)
	LiYangKingAgent.instance:sendPM_PrinceLiyangClgHelpCenterReq(activityId, checknumber(star))
end

function LiYangKingController:handlePM_PrinceLiyangClgHelpCenterRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PrinceLiyangClgHelpCenterRes, msg)
end

function LiYangKingController:sendPM_PrinceLiyangClgHelpClgReq(activityId, otherUserId, helpId, positionId, form)
	LiYangKingAgent.instance:sendPM_PrinceLiyangClgHelpClgReq(activityId, otherUserId, helpId, positionId, form)
end

function LiYangKingController:handlePM_PrinceLiyangClgHelpClgRes(msg)
	local info = GameUtil.pbToTable(msg)
	local state = info.state

	if state == 1 then
		FloatWordMgr.instance:show("已经刷新走了")
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
	elseif state == 2 then
		FloatWordMgr.instance:show("已经被击杀")
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
	elseif state == 3 then
		BattleController.instance:viewUserFightMonsterBtlResult(msg.battleResult, false)
		BattleFacade.instance:registerResultHandler(function()
			BattleFacade.instance:registerResultHandler(nil, nil)
			UIStateManager.instance:push(ViewName.LiYangKingHelpCfgResultView, info)

			return true
		end)
	elseif state == 4 then
		BattleController.instance:viewUserFightMonsterBtlResult(msg.battleResult, false)
		BattleFacade.instance:registerResultHandler(function()
			BattleFacade.instance:registerResultHandler(nil, nil)
			UIStateManager.instance:push(ViewName.LiYangKingHelpCfgResultView, info)

			return true
		end)
	end
end

function LiYangKingController:hasEvent(activityId, buildId)
	local info = LiYangKingModel.instance:getInfo(activityId)
	local eventIds = info.eventIds
	local eventIdMap = LiYangKingConfig.instance:getEventIdMap(activityId)

	if eventIds then
		for i, eventId in ipairs(eventIds) do
			if table.indexof((eventIdMap[buildId] or nil) and eventIdMap[buildId], eventId) then
				return true
			end
		end
	end

	return false
end

function LiYangKingController:getCurAttrLevelProgressAndNeed(activityId, id, curProgress)
	local levelCfgs = LiYangKingConfig.instance:getAttributeLevelCfgsById(activityId, id)

	for i, cfg in ipairs(levelCfgs) do
		local progress = cfg.progress

		if curProgress < progress then
			if not levelCfgs[i - 1] then
				local preCfg = {}
				local curHasProgress = curProgress - checknumber(preCfg.progress)
				local needProgress = cfg.progress - checknumber(preCfg.progress)

				return curHasProgress, needProgress
			end
		end
	end

	return -1, -1
end

function LiYangKingController:getCurLevel(activityId, id, curProgress)
	local levelCfgs = LiYangKingConfig.instance:getAttributeLevelCfgsById(activityId, id)
	local maxLevel = #levelCfgs

	for i, cfg in ipairs(levelCfgs) do
		local progress = cfg.progress

		if curProgress < progress then
			return cfg.level - 1
		end
	end

	return maxLevel
end

function LiYangKingController:getCurKingLevel(activityId)
	local info = LiYangKingModel.instance:getInfo(activityId)
	local attrMap = info.attributesMap
	local attrCfgs = LiYangKingConfig.instance:getAttributeCfgs(activityId)
	local kingLevelCfgs = LiYangKingConfig.instance:getLevelCfgs(activityId)
	local maxKingLevel = #kingLevelCfgs
	local attrNum = #attrCfgs
	local totalLevel = 0

	for i = 1, attrNum do
		local attrInfo = attrMap[i]

		if attrInfo then
			if not attrInfo.progress then
				local progress = 0
				local attrLevel = self:getCurLevel(activityId, i, progress)

				totalLevel = totalLevel + attrLevel
			end
		end
	end

	local levelUpNum = totalLevel - attrNum

	for i, cfg in ipairs(kingLevelCfgs) do
		if levelUpNum < cfg.need then
			return cfg.level - 1
		end
	end

	return maxKingLevel
end

function LiYangKingController:getTotalEfficiency(activityId)
	local info = LiYangKingModel.instance:getInfo(activityId)
	local curKingLevel = self:getCurKingLevel(activityId)
	local actCfg = LiYangKingConfig.instance:getActCfg(activityId)
	local curKingCfg = LiYangKingConfig.instance:getLevelCfgByLevel(activityId, curKingLevel)
	local buildingsMap = info.buildingsMap
	local buildCfgs = LiYangKingConfig.instance:getBuildingCfgs(activityId)
	local buildNum = #buildCfgs
	local totalEfficiency = 0

	for buildId = 1, buildNum do
		local curBuildInfo = buildingsMap[buildId]

		if curBuildInfo then
			local curBuildLevel = curBuildInfo.level
			local levelCfg = LiYangKingConfig.instance:getBuildingLevelCfgBybuildIdlevel(activityId, buildId, curBuildLevel)
			local efficiency = levelCfg.efficiency

			totalEfficiency = totalEfficiency + efficiency
		end
	end

	totalEfficiency = totalEfficiency + curKingCfg.efficiency

	return totalEfficiency
end

function LiYangKingController:hasEnoughStrenthToReset(activityId)
	local clgInfo = LiYangKingModel.instance:getClgInfo(activityId)

	if clgInfo == nil or clgInfo.resetTimes == nil then
		return false
	end

	local resetTimes = clgInfo.resetTimes
	local resetCostStr = LiYangKingConfig.instance:getResetCostStr(activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(resetCostStr)
	local hasMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	local resetMap = LiYangKingConfig.instance:getResetMap(activityId)
	local isEnough = false

	if resetTimes and hasMatNum > 0 then
		for i, resetInfo in ipairs(resetTimes) do
			if resetInfo.times > 0 then
				if not resetMap[resetInfo.times] then
					local needNum = 0

					if needNum <= hasMatNum then
						isEnough = true

						break
					end
				end
			end
		end
	end

	return isEnough
end

local weiWangType = 3

function LiYangKingController:getMaxCanHelpNum(activityId)
	local info = LiYangKingModel.instance:getInfo(activityId)
	local attrMap = info.attributesMap

	if attrMap[weiWangType] then
		if not attrMap[weiWangType].progress then
			local curProgress = 0
			local weiWangAttrLevel = self:getCurLevel(activityId, weiWangType, curProgress)
			local curWeiWangLevelCfgs = LiYangKingConfig.instance:getAttributeLevelCfgsById(activityId, weiWangType)
			local curWeiWangLevelCfg = curWeiWangLevelCfgs[weiWangAttrLevel]

			return curWeiWangLevelCfg.clgHelpPrizeTimes
		end
	end
end

function LiYangKingController:getRewardList(activityId, rank)
	local rankPrizeCfgs = LiYangKingConfig.instance:getRankPrizeCfgs(activityId)

	for i, cfg in pairs(rankPrizeCfgs) do
		local rankRange = cfg.rankRange

		if rank >= rankRange[1] and rank <= rankRange[2] then
			local prize = cfg.prize

			return (string.split(prize, "#"))
		end
	end
end

function LiYangKingController:getMoneyTotalRatio(activityId)
	local actCfg = LiYangKingConfig.instance:getActCfg(activityId)
	local buildCfgs = LiYangKingConfig.instance:getBuildingCfgs(activityId)
	local moneyItemId = actCfg.itemId
	local info = LiYangKingModel.instance:getInfo(activityId)
	local ratio = 0

	for i, buildCfg in ipairs(buildCfgs) do
		if buildCfg.itemId == moneyItemId then
			local curBuildId = buildCfg.buildingId
			local buildInfo = info.buildingsMap[curBuildId]

			if buildInfo then
				local curBuildLevel = buildInfo.level
				local buildLevelCfg = LiYangKingConfig.instance:getBuildingLevelCfgBybuildIdlevel(activityId, curBuildId, curBuildLevel)

				ratio = ratio + buildLevelCfg.addRate
			end
		end
	end

	return ratio
end

function LiYangKingController:openChapter3MissionView(activityId, creepsMasterId, posId)
	self._chapter3FmtMo:initParams(activityId, creepsMasterId, posId)
	CustomFmtController.instance:showMissionView(self._chapter3FmtMo)
end

function LiYangKingController:getChapter3ExploreHelpInfo(activityId, otherUserId, positionId, helpId)
	if checknumber(RoleModel.instance:getUserId()) == checknumber(otherUserId) then
		return
	end

	local info = LiYangKingModel.instance:getInfo(activityId)

	self._activityId = activityId
	self._otherUserId = otherUserId
	self._positionId = positionId
	self._helpId = helpId

	if info == nil then
		GlobalDispatcher:addListener(GlobalNotify.PM_PrinceLiyangInfoRes, self._handleOutSideSendHelpInfo, self)
		self:sendPM_PrinceLiyangInfoReq(activityId)
	else
		self:_handleOutSideSendHelpInfo()
	end
end

function LiYangKingController:_handleOutSideSendHelpInfo()
	GlobalDispatcher:removeListener(GlobalNotify.PM_PrinceLiyangInfoRes, self._handleOutSideSendHelpInfo, self)

	self._lastActivityId = checknumber(self._activityId)
	self._lastOtherUserId = checknumber(self._otherUserId)
	self._lastHelpId = checknumber(self._helpId)
	self._lastPositionId = checknumber(self._positionId)
	self._needJump = false

	if BattleController.instance:isBattling() then
		FloatWordMgr.instance:show("战斗中")

		return
	end

	LiYangKingAgent.instance:sendPM_PrinceLiyangClgHelpInfoReq(self._activityId, self._otherUserId, self._positionId, self._helpId)

	self._activityId = nil
	self._otherUserId = nil
	self._positionId = nil
	self._helpId = nil
end

LiYangKingController.instance = LiYangKingController.New()

return LiYangKingController
