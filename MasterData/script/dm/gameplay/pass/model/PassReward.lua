-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/model/PassReward.lua

PassReward = class("PassReward", objectlua.Object)

PassReward:has("_level", {
	is = "r"
})
PassReward:has("_rewardsId1", {
	is = "r"
})
PassReward:has("_rewardsId2", {
	is = "r"
})
PassReward:has("_goodLevel", {
	is = "r"
})
PassReward:has("_levelExp", {
	is = "r"
})
PassReward:has("_rewardsItems1", {
	is = "r"
})
PassReward:has("_rewardsItems2", {
	is = "r"
})
PassReward:has("_status", {
	is = "r"
})
PassReward:has("_excellentStatus", {
	is = "r"
})

function PassReward:initialize(data)
	super.initialize(self)

	self._level = 1
	self._status = 0
	self._excellentStatus = 0
	self._rewardsId1 = ""
	self._rewardsId2 = ""
	self._rewardsItems1 = {}
	self._rewardsItems2 = {}
	self._excellentLevel = 0
	self._levelExp = 0

	self:initData(data)
end

function PassReward:initData(data)
	self._level = data.Level
	self._rewardsId1 = data.NormalReward
	self._rewardsId2 = data.BuyReward
	self._goodLevel = data.LevelGood
	self._levelExp = data.LevelExp

	local reward1 = self:getReward(self._rewardsId1)

	if reward1 then
		self._rewardsItems1 = reward1.Content
	end

	local reward2 = self:getReward(self._rewardsId2)

	if reward2 then
		self._rewardsItems2 = reward2.Content
	end
end

function PassReward:userInject()
	return
end

function PassReward:synchronize(data)
	if data.status then
		self._status = data.status
	end

	if data.excellentStatus then
		self._excellentStatus = data.excellentStatus
	end
end

function PassReward:getReward(rewardsId)
	return ConfigReader:getRecordById("Reward", rewardsId)
end
