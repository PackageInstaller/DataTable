-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityColorEgg.lua

ActivityColorEgg = class("ActivityColorEgg")

ActivityColorEgg:has("_type", {
	is = "rw"
})
ActivityColorEgg:has("_eggId", {
	is = "rw"
})
ActivityColorEgg:has("_config", {
	is = "rw"
})
ActivityColorEgg:has("_owner", {
	is = "rw"
})

function ActivityColorEgg:initialize(eggId)
	self._eggId = eggId
	self._config = ConfigReader:getRecordById("ActivityColourEgg", self._eggId)
end

function ActivityColorEgg:sync(data)
	return
end

function ActivityColorEgg:canShow()
	return self._config.Show
end

function ActivityColorEgg:getName()
	return Strings:get(self._config.Name)
end

function ActivityColorEgg:getDesc()
	return Strings:get(self._config.Content)
end

function ActivityColorEgg:getLocation()
	return self._config.Coordinates
end

function ActivityColorEgg:getRewardId()
	return self._config.Reward
end

function ActivityColorEgg:getStoryId()
	return self._config.StoryLink
end

function ActivityColorEgg:getUnlockCondition()
	local condition = self._config.Condition[1]
	local id = "IR_HalloweenStaminaConsumed"
	local amount = 100

	for k, v in pairs(condition) do
		id = k
		amount = tonumber(v)
	end

	return id, amount
end

function ActivityColorEgg:getIcon()
	return self._config.Icon
end

function ActivityColorEgg:getMap()
	return self._config.Map
end

function ActivityColorEgg:getModelConfig()
	return self._config.Model or {}
end
