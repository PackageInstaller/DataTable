-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/Activity114Helper.lua

module("modules.logic.versionactivity1_2.jiexika.system.Activity114Helper", package.seeall)

local Activity114Helper = pureTable("Activity114Helper")

function Activity114Helper.getEventCoByBattleId(battleId)
	local battleEventId = Activity114Model.instance.serverData.battleEventId

	if battleEventId > 0 then
		local eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, battleEventId)

		if eventCo and eventCo.config.battleId == battleId then
			return eventCo
		end
	end

	return false
end

function Activity114Helper.haveAttrOrFeatureChange(context)
	if Activity114Model.instance.serverData.battleEventId > 0 then
		return false
	end

	if context.resultBonus then
		return true
	end

	local result = context.result

	if result == nil then
		result = Activity114Enum.Result.Success
	end

	if result == Activity114Enum.Result.None then
		return false
	end

	local eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, context.eventId)

	if not eventCo then
		return false
	end

	local featuresList = (result == Activity114Enum.Result.Success or context.type == Activity114Enum.EventType.Rest) and eventCo.successFeatures or result == Activity114Enum.Result.FightSucess and eventCo.successBattleFeatures or eventCo.failureFeatures
	local addAttr = (result == Activity114Enum.Result.Success or context.type == Activity114Enum.EventType.Rest) and eventCo.successVerify or result == Activity114Enum.Result.FightSucess and eventCo.successBattleVerify or eventCo.failureVerify

	addAttr[Activity114Enum.AddAttrType.UnLockMeet] = nil
	addAttr[Activity114Enum.AddAttrType.UnLockTravel] = nil
	featuresList = next(Activity114Model.instance.newUnLockFeature) and Activity114Model.instance.newUnLockFeature or {}

	if next(Activity114Model.instance.newUnLockMeeting) then
		addAttr[Activity114Enum.AddAttrType.UnLockMeet] = Activity114Model.instance.newUnLockMeeting
	end

	if next(Activity114Model.instance.newUnLockTravel) then
		addAttr[Activity114Enum.AddAttrType.UnLockTravel] = Activity114Model.instance.newUnLockTravel
	end

	if next(addAttr) or next(featuresList) then
		context.resultBonus = {
			addAttr = addAttr,
			featuresList = featuresList
		}

		return true
	end

	return false
end

function Activity114Helper.getNextKeyDayDesc(day)
	day = day or Activity114Model.instance.serverData.day

	local keyDayCo = Activity114Config.instance:getKeyDayCo(Activity114Model.instance.id, day)

	if keyDayCo then
		return keyDayCo.desc
	end

	return ""
end

function Activity114Helper.getNextKeyDayLeft(day)
	day = day or Activity114Model.instance.serverData.day

	local keyDayCo = Activity114Config.instance:getKeyDayCo(Activity114Model.instance.id, day)

	if keyDayCo then
		return keyDayCo.day - day
	end

	return 0
end

function Activity114Helper.getWeekEndScore()
	local allAttr = 0

	for i = 1, Activity114Enum.Attr.End - 1 do
		allAttr = allAttr + Activity114Model.instance.attrDict[i] or 0
	end

	local score1 = Activity114Model.instance.serverData.middleScore
	local score2 = Activity114Model.instance.serverData.endScore
	local totalScore = allAttr + score1 + score2

	return allAttr, score1, score2, totalScore
end

return Activity114Helper
