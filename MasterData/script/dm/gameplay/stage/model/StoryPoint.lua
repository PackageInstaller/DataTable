-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/StoryPoint.lua

StoryPoint = class("StoryPoint")

StoryPoint:has("_id", {
	is = "r"
})
StoryPoint:has("_index", {
	is = "rw"
})
StoryPoint:has("_owner", {
	is = "rw"
})
StoryPoint:has("_isHidden", {
	is = "rw"
})

function StoryPoint:initialize(pointId, configName)
	assert(pointId ~= nil, "error:pointId=nil")
	super.initialize(self)

	self._id = pointId
	self._isPass = false
	self._isHidden = false
	self._config = configName and ConfigReader:getRecordById(configName, pointId) or ConfigReader:getRecordById(self:getConfigName(), pointId)
end

function StoryPoint:sync(data)
	if data.isPass then
		self._isPass = data.isPass
	end
end

function StoryPoint:isPass()
	if self._config.IsHide then
		return self:isUnlock()
	end

	return self._isPass
end

function StoryPoint:isUnlock()
	if not self._owner:isUnlock() then
		return false
	end

	local preBCondition = true

	for _, v in ipairs(self:getPrevBPointId()) do
		local tempBattlePoint = self._owner:getPointById(v)

		if tempBattlePoint then
			preBCondition = preBCondition and tempBattlePoint:isPass()
		end
	end

	for _, v in ipairs(self:getPrevSPointId()) do
		local storyPoint = self._owner:getPointById(v)

		if storyPoint then
			preBCondition = preBCondition and storyPoint:isPass()
		end
	end

	return preBCondition
end

function StoryPoint:getState()
	if self:isUnlock() then
		if self:isPass() then
			return StoryStageType.kPass
		else
			return StoryStageType.kNotPass
		end
	else
		return StoryStageType.klock
	end
end

function StoryPoint:getConfigName()
	return "StoryPoint"
end

function StoryPoint:getName()
	return Strings:get(self._config.Name)
end

function StoryPoint:getPointPos()
	return self._config.Location
end

function StoryPoint:getPrevBPointId()
	return self._config.PreBattlePoint
end

function StoryPoint:getPrevSPointId()
	return self._config.PreStoryPoint
end

function StoryPoint:getFirstReward()
	return self._config.FirstReward
end

function StoryPoint:getBublingTips()
	if self._config.UnlockBubble == "" then
		return false
	end

	return Strings:get(self._config.UnlockBubble)
end

function StoryPoint:isBoss()
	return false
end

function StoryPoint:getConfig()
	return self._config
end

function StoryPoint:getLocation()
	return self._config.Location
end
