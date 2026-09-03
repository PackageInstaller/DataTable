-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeDpTask.lua

MazeDpTask = class("MazeDpTask", objectlua.Object, _M)

MazeDpTask:has("_taskId", {
	is = "rw"
})
MazeDpTask:has("_taskValues", {
	is = "rw"
})
MazeDpTask:has("_taskStatus", {
	is = "rw"
})

function MazeDpTask:initialize()
	super.initialize(self)

	self._optionsList = {}
	self._type = ""
end

function MazeDpTask:syncData(data)
	dump(data, "---MazeDpTask:syncData---")

	if data then
		for k, v in pairs(data) do
			if v.id then
				self._configId = v.id
				self._configData = ConfigReader:getRecordById("PansLabList", self._configId)
			end

			if v.dp then
				self._dp = v.dp
				self._talentStar = math.floor(self._dp / 50)
			end
		end
	end
end
