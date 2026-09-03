-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityColorEggActivity.lua

require("dm.gameplay.activity.model.ActivityColorEgg")

ActivityColorEggActivity = class("ActivityColorEggActivity", BaseActivity, _M)

ActivityColorEggActivity:has("_eggInfo", {
	is = "r"
})

function ActivityColorEggActivity:initialize()
	super.initialize(self)

	self._eggInfo = {}
end

function ActivityColorEggActivity:dispose()
	super.dispose(self)
end

function ActivityColorEggActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.egg then
		self._eggInfo = data.egg
	end

	self:syncRewards(data.rewards)

	if data.eggKey then
		self._eggKey = data.eggKey
	end
end

function ActivityColorEggActivity:reset()
	super.reset(self)
end

function ActivityColorEggActivity:hasRedPoint()
	return false
end

function ActivityColorEggActivity:syncRewards(rewards)
	self._disableList = {}

	for k, eggId in pairs(rewards) do
		table.insert(self._disableList, eggId)
	end
end

function ActivityColorEggActivity:getDisableList()
	return self._disableList
end
