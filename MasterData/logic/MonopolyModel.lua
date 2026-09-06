-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monopoly/model/MonopolyModel.lua

module("logic.extensions.material.model.MonopolyModel", package.seeall)

local MonopolyModel = class("MonopolyModel", BaseModel)

MonopolyModel.CELL_NUM = 20

local SHOW_RULE_KEY = "monopoly_extra_prize_rule"

function MonopolyModel:ctor()
	return
end

function MonopolyModel:onInit()
	self:onReset()
end

function MonopolyModel:onReset()
	self._curPos = nil
	self._activityId = nil
	self._round = nil
	self._hasBuyDiceTimes = 0
	self.isActivityOpen = false
	self._timeStamp = nil
	self.randomEvent = {}
	self.stepLevelList = {}
end

function MonopolyModel:checkMonopolyOpen()
	local curActivityId
	local data_version = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.Monopoly)

	for k, v in pairs(data_version) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.Monopoly, v.activityId) then
			curActivityId = v.activityId

			break
		end
	end

	if self._activityId ~= curActivityId then
		self._activityId = curActivityId

		if checknumber(self._activityId) ~= 0 then
			local cfg = MonopolyConfig.instance:getMonopolyConfigById(self._activityId)

			if cfg then
				self._planId = cfg.planId
			end

			MonopolyController.instance:getMonopolyInfo()
		end
	end

	self.isActivityOpen = not not self._activityId

	return self.isActivityOpen
end

function MonopolyModel:refreshHasBuyDiceTimes()
	local res = false
	local lastTimeStamp = self._timeStamp

	if lastTimeStamp then
		local lastTimeObj = GameUtil.time2date(lastTimeStamp)
		local lastWeekDay = lastTimeObj.wday
		local lastHour = lastTimeObj.hour

		if lastHour >= 0 and lastHour < 5 then
			lastWeekDay = lastWeekDay + 6
		end

		lastWeekDay = lastWeekDay % 7

		local curTime = GameUtil.time2date(ServerTime.now())
		local curWeekDay = curTime.wday
		local curHour = curTime.hour

		if curHour >= 0 and curHour < 5 then
			curWeekDay = curWeekDay + 6
		end

		curWeekDay = curWeekDay % 7
		res = curWeekDay ~= lastWeekDay
	end

	if res then
		MonopolyModel.instance:setHasBuyDiceTimes(0)
		self:setLastTimeStamp()
	end
end

function MonopolyModel:setLastTimeStamp()
	self._timeStamp = ServerTime.now()
end

function MonopolyModel:getLastTimeStamp()
	return self._timeStamp
end

function MonopolyModel:setCurPosition(index)
	self._curPos = index
end

function MonopolyModel:getCurPosition()
	return self._curPos
end

function MonopolyModel:setCurRound(round)
	self._round = round
end

function MonopolyModel:getCurRound()
	return self._round
end

function MonopolyModel:getActivityId()
	return self._activityId
end

function MonopolyModel:SaveRandomEvent(eventId, eventForward)
	self.randomEvent.eventId = eventId
	self.randomEvent.eventForward = eventForward
end

function MonopolyModel:hasRandomEvent()
	return self.randomEvent.eventId ~= nil
end

function MonopolyModel:getRandomEvent()
	return self.randomEvent
end

function MonopolyModel:setHasBuyDiceTimes(hasBuyDiceTimes)
	self._hasBuyDiceTimes = hasBuyDiceTimes
end

function MonopolyModel:getHasBuyDiceTimes()
	return self._hasBuyDiceTimes
end

function MonopolyModel:setStepLevel(step, level)
	step = step + 1
	self.stepLevelList[step] = level
end

function MonopolyModel:setStepLevelAdd1(step)
	local cfg = MonopolyConfig.instance:getRoundCfg(step, self._planId)

	step = step + 1

	if checknumber(cfg.upgradePlanId) > 0 then
		local upgradeCfg = MonopolyConfig.instance:getLevelPlan(cfg.upgradePlanId)
		local curLevel = self:getStepLevel(step)

		if checknumber(curLevel) < #upgradeCfg then
			self.stepLevelList[step] = curLevel + 1
		end
	end
end

function MonopolyModel:getStepLevel(step)
	local res = self.stepLevelList[step]

	if res == nil then
		res = 1
	end

	return res
end

function MonopolyModel:setStepLevelPre(step)
	return
end

function MonopolyModel:getStepLevelPre(step)
	local res = self.stepLevelList[step]

	if res == nil then
		res = 1
	end

	return res
end

function MonopolyModel:getLoginFirstChallenge()
	return (GameUtil.getUserDayData(SHOW_RULE_KEY))
end

function MonopolyModel:setLoginFirstChallenge(torf)
	local res = GameUtil.getUserDayData(SHOW_RULE_KEY)

	if res ~= torf then
		GameUtil.saveUserDayData(SHOW_RULE_KEY, torf)
	end
end

MonopolyModel.instance = MonopolyModel.New()

return MonopolyModel
