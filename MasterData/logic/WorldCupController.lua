-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/controller/WorldCupController.lua

module("logic.extensions.worldcup.controller.WorldCupController", package.seeall)

local WorldCupController = class("WorldCupController", BaseController)

function WorldCupController:onInit()
	self:onReset()
end

function WorldCupController:onReset()
	self._showRealName = false
end

function WorldCupController:handlePM_WorldCupGetInfoRes(msg)
	WorldCupModel.instance:saveGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_WorldCupGetInfoRes, msg.activityId)
end

function WorldCupController:handlePM_WorldCupGainDailyPrizeRes(msg)
	WorldCupModel.instance:markDailyPrizeGained(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_WorldCupGainDailyPrizeRes, msg.activityId)
end

function WorldCupController:handlePM_WorldCupBetRes(msg)
	WorldCupModel.instance:saveBetResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_WorldCupBetRes, msg.activityId)
end

function WorldCupController:handlePM_WorldCupOneKeyGainPrizeRes(msg)
	WorldCupModel.instance:saveGainBetPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_WorldCupOneKeyGainPrizeRes, msg.activityId)
end

function WorldCupController:handlePM_WorldCupRankInfoRes(msg)
	WorldCupModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_WorldCupRankInfoRes, msg.activityId)
end

function WorldCupController:handlePM_WorldCupGuessTopThreeReq(msg)
	WorldCupModel.instance:saveGuessTop(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_WorldCupGuessTopThreeReq)
end

function WorldCupController:handlePM_WorldCupGainTopThreePrizeReq(msg)
	WorldCupModel.instance:saveGetGuessTopPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_WorldCupGainTopThreePrizeReq)
end

function WorldCupController:isShowRealTeamName()
	return self._showRealName
end

function WorldCupController:setShowRealTeamName(bool)
	self._showRealName = bool
end

function WorldCupController:getTeamName(teamCfg)
	if teamCfg then
		if self._showRealName == true then
			return teamCfg.name
		else
			return teamCfg.otherName
		end
	end
end

function WorldCupController:hasOddsPrize(activityId)
	local hasPrize = false

	for i, v in ipairs(WorldCupModel.instance:getAllBetInfo(activityId)) do
		if v.state == 0 then
			local checkMatchInfo = WorldCupModel.instance:getMatchInfo(activityId, v.matchId)

			if checkMatchInfo.result then
				hasPrize = true

				break
			end
		end
	end

	return hasPrize
end

function WorldCupController:getSignInPrize(activityId)
	local signInPrizeCfgs = WorldCupConfig.instance:getSignInPrizeCfgs(activityId)
	local list = {}

	for i, v in pairs(signInPrizeCfgs) do
		table.insert(list, {
			cfg = v,
			time = GameUtil.string2time(v.date)
		})
	end

	table.sort(list, function(a, b)
		return a.time < b.time
	end)

	local targetCfg

	for i = 1, #list - 1 do
		if list[i].time <= ServerTime.now() and list[i + 1].time > ServerTime.now() then
			targetCfg = list[i].cfg
		end
	end

	if not targetCfg and #list > 0 then
		if list[1].time > ServerTime.now() then
			list[1].cfg = targetCfg
		elseif list[#list].time <= ServerTime.now() then
			list[#list].cfg = targetCfg
		end
	end

	return targetCfg
end

function WorldCupController:isCanGetGuessTopThree(activityId)
	local actCfg = WorldCupConfig.instance:getActivityCfg(activityId)
	local startGainPrizeTime = GameUtil.string2time(actCfg.guessTopGainPrizeTime)

	if startGainPrizeTime > ServerTime.now() then
		return false, 0, nil
	end

	local matchList = WorldCupModel.instance:getMatchList(activityId)
	local curChampionTeamId = 0
	local curRunnerUpTeamId = 0
	local curThirdPlaceTeamId = 0

	for i, v in ipairs(matchList) do
		if v.stageId == 7 then
			local isHomeWin = v.result and v.result.fullTimeHome > v.result.fullTimeAway or false

			curChampionTeamId = isHomeWin and v.homeTeamId or v.awayTeamId
			curRunnerUpTeamId = isHomeWin and v.awayTeamId or v.homeTeamId
		elseif v.stageId == 6 then
			local isHomeWin = v.result and v.result.fullTimeHome > v.result.fullTimeAway or false

			curThirdPlaceTeamId = isHomeWin and v.homeTeamId or v.awayTeamId
		end
	end

	local currectCount = 0
	local currectMap = {}
	local guessInfo = WorldCupModel.instance:getTopGuessInfo(activityId)

	if guessInfo.championTeamId == curChampionTeamId then
		currectCount = currectCount + 1
		currectMap[1] = true
	end

	if guessInfo.runnerUpTeamId == curRunnerUpTeamId then
		currectCount = currectCount + 1
		currectMap[2] = true
	end

	if guessInfo.thirdPlaceTeamId == curThirdPlaceTeamId then
		currectCount = currectCount + 1
		currectMap[3] = true
	end

	if currectCount > 0 and not guessInfo.gainedPrize then
		return true, currectCount, currectMap
	else
		return false, currectCount, currectMap
	end
end

WorldCupController.instance = WorldCupController.New()

return WorldCupController
