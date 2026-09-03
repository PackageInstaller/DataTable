-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/zero/ActivityZeroEvent.lua

ActivityZeroEvent = class("ActivityZeroEvent", objectlua.Object, _M)

ActivityZeroEvent:has("_id", {
	is = "r"
})
ActivityZeroEvent:has("_config", {
	is = "r"
})

function ActivityZeroEvent:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:getRecordById("ActivityMonopEvent", self._id)
end

function ActivityZeroEvent:synchronize(data)
	for k, v in pairs(data) do
		if v then
			self["_" .. k] = v
		end
	end
end
