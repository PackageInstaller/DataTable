-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualdragonchallenge/model/DualdragonchallengeModel.lua

module("logic.extensions.dualdragonchallenge.view.DualdragonchallengeModel", package.seeall)

local DualdragonchallengeModel = class("DualdragonchallengeModel", BaseModel)

function DualdragonchallengeModel:ctor()
	return
end

function DualdragonchallengeModel:onInit()
	self:onReset()
end

function DualdragonchallengeModel:onReset()
	self._currExtremeIndex = 0
end

function DualdragonchallengeModel:setInfos(msg)
	self._universalinfo = msg.universalInfo
	self._extremeinfo = msg.extremeInfo

	self:_parseExtreme()
	self:_calRedInfo()
end

function DualdragonchallengeModel:_parseExtreme()
	self._currExtremeIndex = 0

	for i, v in ipairs(self._extremeinfo.group1IsPass) do
		if v ~= self._extremeinfo.group2IsPass[i] then
			self._currExtremeIndex = i

			break
		end
	end
end

function DualdragonchallengeModel:getCurrExtremeIndex()
	return self._currExtremeIndex
end

function DualdragonchallengeModel:isStagePass(groupId, stageId)
	return (groupId == 1 and self:getGroup1IsPass() or self:getGroup2IsPass())[stageId]
end

function DualdragonchallengeModel:getUniversalCreepsMasterId()
	if self._universalinfo then
		return self._universalinfo.universalBossId
	end

	return 0
end

function DualdragonchallengeModel:getUniversalBossLeftHp()
	if self._universalinfo then
		return self._universalinfo.bossLeftHp
	end

	return 0
end

function DualdragonchallengeModel:getUniversalLeftTime()
	if self._universalinfo then
		return self._universalinfo.leftChallengeTimes
	end

	return 0
end

function DualdragonchallengeModel:getUniversalLeftBuyTime()
	if self._universalinfo then
		return self._universalinfo.leftBuyTimes
	end

	return 0
end

function DualdragonchallengeModel:getGroup1IsPass()
	if self._extremeinfo then
		return self._extremeinfo.group1IsPass
	end

	return {}
end

function DualdragonchallengeModel:getGroup2IsPass()
	if self._extremeinfo then
		return self._extremeinfo.group2IsPass
	end

	return {}
end

function DualdragonchallengeModel:isGainExtremePrize()
	if self._extremeinfo then
		return self._extremeinfo.hasGain
	end

	return false
end

function DualdragonchallengeModel:resetExtreme(activityId, groupId, stageId)
	local actId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DualDragon)

	if actId ~= activityId then
		return
	end

	if self._extremeinfo then
		self._extremeinfo.group1IsPass[stageId] = false
		self._extremeinfo.group2IsPass[stageId] = false
	end

	self:_parseExtreme()
end

function DualdragonchallengeModel:addUniversalChallengeTime()
	self._universalinfo.leftBuyTimes = self._universalinfo.leftBuyTimes - 1
	self._universalinfo.leftChallengeTimes = self._universalinfo.leftChallengeTimes + 1
end

function DualdragonchallengeModel:getGroup1PassNum()
	if self._extremeinfo then
		local passNum = 0

		for i, v in ipairs(self._extremeinfo.group1IsPass) do
			if v then
				passNum = passNum + 1
			end
		end

		return passNum
	end

	return 0
end

function DualdragonchallengeModel:getGroup2PassNum()
	if self._extremeinfo then
		local passNum = 0

		for i, v in ipairs(self._extremeinfo.group2IsPass) do
			if v then
				passNum = passNum + 1
			end
		end

		return passNum
	end

	return 0
end

function DualdragonchallengeModel:isAllExtremePass()
	for i, v in ipairs(self._extremeinfo.group1IsPass) do
		if not v then
			return false
		end
	end

	for i, v in ipairs(self._extremeinfo.group2IsPass) do
		if not v then
			return false
		end
	end

	return true
end

function DualdragonchallengeModel:_calRedInfo()
	local leftTime = self:getUniversalLeftTime()
	local universalRed = leftTime > 0

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DUALDRAGON_UNIVERSAL, universalRed)

	local extremeRed = self:isAllExtremePass() and not self:isGainExtremePrize()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DUALDRAGON_EXTREME_REWARD, extremeRed)
end

DualdragonchallengeModel.instance = DualdragonchallengeModel.New()

return DualdragonchallengeModel
