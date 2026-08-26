-- chunkname: @modules/logic/versionactivity2_4/act181/model/Activity181MO.lua

module("modules.logic.versionactivity2_4.act181.model.Activity181MO", package.seeall)

local Activity181MO = pureTable("Activity181MO")

function Activity181MO:setInfo(info)
	self.config = Activity181Config.instance:getBoxConfig(info.activityId)
	self.id = info.activityId
	self.rewardInfo = {}
	self.bonusIdDic = {}
	self.getBonusCount = 0
	self.allBonusCount = 0

	for _, bonusInfo in ipairs(info.infos) do
		self.rewardInfo[bonusInfo.pos] = bonusInfo.id
		self.bonusIdDic[bonusInfo.id] = bonusInfo.pos

		if bonusInfo.pos ~= 0 then
			self.getBonusCount = self.getBonusCount + 1
		end
	end

	local bonusList = Activity181Config.instance:getBoxListByActivityId(self.id)

	self.allBonusCount = #bonusList
	self.canGetTimes = info.canGetTimes
	self.spBonusState = self.rewardInfo[0] ~= nil and Activity181Enum.SPBonusState.HaveGet or info.canGetSpBonus
end

function Activity181MO:setBonusInfo(pos, id)
	self.rewardInfo[pos] = id
	self.bonusIdDic[id] = pos
	self.getBonusCount = self.getBonusCount + 1

	self:setBonusTimes(math.max(0, self.canGetTimes - 1))

	if self.spBonusState == Activity181Enum.SPBonusState.Locked then
		local unlock = self:getSPUnlockState()

		if unlock then
			self.spBonusState = Activity181Enum.SPBonusState.Unlock
		end
	end
end

function Activity181MO:refreshSpBonusInfo()
	if self.spBonusState ~= Activity181Enum.SPBonusState.HaveGet then
		local unlock = self:getSPUnlockState()

		if unlock then
			self.spBonusState = Activity181Enum.SPBonusState.Unlock or Activity181Enum.SPBonusState.Locked
		end

		Activity181Controller.instance:dispatchEvent(Activity181Event.OnGetSPBonus, self.id)
	end
end

function Activity181MO:getBonusState(pos)
	if self.rewardInfo[pos] then
		return Activity181Enum.BonusState.HaveGet
	end

	return Activity181Enum.BonusState.Unlock
end

function Activity181MO:getBonusIdByPos(pos)
	return self.rewardInfo[pos]
end

function Activity181MO:getBonusStateById(id)
	local pos = self.bonusIdDic[id]

	return self:getBonusState(pos)
end

function Activity181MO:setSPBonusInfo()
	self.spBonusState = Activity181Enum.SPBonusState.HaveGet
	self.rewardInfo[0] = 0
	self.bonusIdDic[0] = 0
end

function Activity181MO:getSPUnlockState()
	local config = self.config

	if config.obtainType == Activity181Enum.SPBonusUnlockType.Time then
		return self:isSpBonusTimeUnlock(config)
	elseif config.obtainType == Activity181Enum.SPBonusUnlockType.Count then
		return self:isSpBonusCountUnlock(config)
	else
		return self:isSpBonusTimeUnlock(config) or self:isSpBonusCountUnlock(config)
	end
end

function Activity181MO:isSpBonusTimeUnlock(config)
	local nowTime = ServerTime.now()
	local startTime = TimeUtil.stringToTimestamp(config.obtainStart)
	local endTime = TimeUtil.stringToTimestamp(config.obtainEnd)

	return startTime <= nowTime and nowTime <= endTime
end

function Activity181MO:isSpBonusCountUnlock(config)
	return self.getBonusCount >= config.obtainTimes
end

function Activity181MO:getBonusTimes()
	return self.canGetTimes
end

function Activity181MO:setBonusTimes(time)
	self.canGetTimes = time
end

function Activity181MO:canGetBonus()
	return self.getBonusCount < self.allBonusCount
end

return Activity181MO
