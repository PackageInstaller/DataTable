-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/SceneFestivalMO.lua

module("logicscene.scene.SceneFestivalMO", package.seeall)

local SceneFestivalMO = class("SceneFestivalMO")

function SceneFestivalMO:ctor()
	self.startTimeStamp = 0
	self.endTimeStamp = 0
	self.sceneId = 0
	self.festival = nil
	self.startHours = 0
	self.endHours = 0
end

function SceneFestivalMO:isOpened(now)
	now = now or ServerTime.now()

	return self.startTimeStamp == 0 or now >= self.startTimeStamp
end

function SceneFestivalMO:isClosed(now)
	now = now or ServerTime.now()

	return self.endTimeStamp ~= 0 and now >= self.endTimeStamp
end

function SceneFestivalMO:isInPeriod(now)
	now = now or ServerTime.now()

	return self:isOpened(now) and not self:isClosed(now)
end

function SceneFestivalMO:timeToOpened(now)
	now = now or ServerTime.now()

	if self:isOpened(now) then
		return 0
	end

	return self.startTimeStamp - now
end

function SceneFestivalMO:timeToClosed(now)
	now = now or ServerTime.now()

	if self:isClosed(now) then
		return 0
	end

	return self.endTimeStamp - now
end

return SceneFestivalMO
