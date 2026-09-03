-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/zero/ActivityZeroStep.lua

ActivityZeroStep = class("ActivityZeroStep", objectlua.Object, _M)

ActivityZeroStep:has("_id", {
	is = "r"
})
ActivityZeroStep:has("_config", {
	is = "r"
})
ActivityZeroStep:has("_events", {
	is = "r"
})
ActivityZeroStep:has("_curEventId", {
	is = "r"
})

function ActivityZeroStep:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:getRecordById("ActivityMonopStep", self._id)
	self._events = {}
	self._curEventId = ""
end

function ActivityZeroStep:synchronize(data)
	for k, v in pairs(data) do
		if k == "events" then
			self:syncEvent(v)
		else
			self["_" .. k] = v
		end
	end
end

function ActivityZeroStep:syncEvent(events)
	self._events = events
	self._curEventId = ""

	for idx, event in pairs(events) do
		for eventId, status in pairs(event) do
			if status ~= 1 then
				self._curEventId = eventId

				return
			end
		end
	end
end

function ActivityZeroStep:getLabPicture()
	return ConfigReader:getDataByNameIdAndKey("ActivityMonopLab", self._config.LoopEvent, "Picture")
end

function ActivityZeroStep:getEventPicture()
	for id, v in pairs(self._events) do
		for eventId, status in pairs(v) do
			return ConfigReader:getDataByNameIdAndKey("ActivityMonopEvent", eventId, "Picture")
		end
	end

	return ""
end

function ActivityZeroStep:getImg()
	local picture = self:getLabPicture()

	if picture ~= "" then
		return picture .. ".png"
	end

	local picture = self:getEventPicture()

	if picture ~= "" then
		return picture .. ".png"
	end

	return "hd_cl_ysj_wz_kg.png"
end
