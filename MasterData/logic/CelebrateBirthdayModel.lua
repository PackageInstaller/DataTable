-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/celebratebirthday/model/CelebrateBirthdayModel.lua

module("logic.extensions.celebratebirthday.model.CelebrateBirthdayModel", package.seeall)

local CelebrateBirthdayModel = class("CelebrateBirthdayModel", BaseModel)

CelebrateBirthdayModel.ACTID = 92001

function CelebrateBirthdayModel:ctor()
	CelebrateBirthdayModel.super.ctor(self)
end

function CelebrateBirthdayModel:onInit()
	CelebrateBirthdayModel.super.onInit(self)
end

function CelebrateBirthdayModel:onReset()
	CelebrateBirthdayModel.super.onReset(self)
end

function CelebrateBirthdayModel:setDailyTime(dailyTime)
	self._dailyTime = dailyTime
end

function CelebrateBirthdayModel:getDailyTime()
	return self._dailyTime
end

function CelebrateBirthdayModel:setWeeklyTime(weeklyTime)
	self._weeklyTime = weeklyTime
end

function CelebrateBirthdayModel:getWeeklyTime()
	return self._weeklyTime
end

function CelebrateBirthdayModel:setTotalTime(totalTime)
	self._totalTime = totalTime
end

function CelebrateBirthdayModel:getTotalTime()
	return self._totalTime
end

function CelebrateBirthdayModel:setEarliestTime(earliestTime)
	self._earliestTime = earliestTime / 1000
end

function CelebrateBirthdayModel:getEarliesTime()
	return self._earliestTime
end

function CelebrateBirthdayModel:setGainPrizeStatus(gainPrizeStatus)
	self._gainPrizeStatus = {}

	for i, v in ipairs(gainPrizeStatus) do
		self._gainPrizeStatus[i] = v
	end
end

function CelebrateBirthdayModel:gainPrize(prizeId)
	self._gainPrizeStatus[prizeId] = true
end

function CelebrateBirthdayModel:getGainPrizeStatus()
	return self._gainPrizeStatus
end

function CelebrateBirthdayModel:getHasGainPrize(prizeId)
	return self._gainPrizeStatus and self._gainPrizeStatus[prizeId]
end

CelebrateBirthdayModel.instance = CelebrateBirthdayModel.New()

return CelebrateBirthdayModel
