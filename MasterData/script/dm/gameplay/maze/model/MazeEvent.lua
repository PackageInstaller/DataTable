-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeEvent.lua

require("dm.gameplay.maze.model.MazeDpTask")

MazeEvent = class("MazeEvent", objectlua.Object, _M)

MazeEvent:has("_configId", {
	is = "rw"
})
MazeEvent:has("_dp", {
	is = "rw"
})
MazeEvent:has("_dpGotRewards", {
	is = "rw"
})
MazeEvent:has("_suspects", {
	is = "rw"
})
MazeEvent:has("_talents", {
	is = "rw"
})
MazeEvent:has("_talentCost", {
	is = "rw"
})
MazeEvent:has("_clues", {
	is = "rw"
})
MazeEvent:has("_config", {
	is = "rw"
})
MazeEvent:has("_talentStar", {
	is = "rw"
})
MazeEvent:has("_mazeDpTaskList", {
	is = "rw"
})
MazeEvent:has("_mazeClueList", {
	is = "rw"
})

function MazeEvent:initialize()
	super.initialize(self)

	self._optionsList = {}
	self._mazeDpTaskList = {}
	self._mazeClueList = {}
end

function MazeEvent:initTaskList()
	local taskConfig = self._configData.DPTask

	for k, v in pairs(taskConfig) do
		self._mazeDpTaskList[v] = {}
	end
end

function MazeEvent:initClueList()
	local clueConfig = self._configData.ClueList

	for k, v in pairs(clueConfig) do
		self._mazeClueList[v] = {}
	end
end

function MazeEvent:syncData(data)
	if data then
		for k, v in pairs(data) do
			if v.id then
				self._configId = v.id
				self._configData = ConfigReader:getRecordById("PansLabList", self._configId)

				if #self._mazeDpTaskList <= 0 then
					self:initTaskList()
				end

				if #self._mazeClueList <= 0 then
					self:initClueList()
				end
			end

			if v.dp then
				self._dp = v.dp
				self._talentStar = math.floor(self._dp / 50)
			end

			if v.dpGotRewards then
				self._dpGotRewards = v.dpGotRewards
			end

			if v.suspects then
				self._suspects = v.suspects
			end

			if v.talents then
				if self._talents then
					for kk, vv in pairs(v.talents) do
						self._talents[kk] = vv
					end
				else
					self._talents = v.talents
				end
			end

			if v.talentCost then
				self._talentCost = v.talentCost
			end

			if v.clues then
				self._clues = v.clues
			end

			if v.tasks then
				for kk, vv in pairs(v.tasks) do
					if self._mazeDpTaskList[vv.taskId] then
						local value = self._mazeDpTaskList[vv.taskId]

						if vv.taskId then
							value.taskId = vv.taskId
						end

						if vv.taskValues then
							value.taskValues = vv.taskValues
						end

						if vv.taskStatus then
							value.taskStatus = vv.taskStatus
						end
					end
				end
			end
		end
	end
end

function MazeEvent:getEventName()
	return Strings:get(self._configData.StoryName)
end

function MazeEvent:getEventMasterName()
	local nameid = ConfigReader:getDataByNameIdAndKey("EnemyMaster", self._configData.Master, "Name")

	return Strings:get(nameid)
end

function MazeEvent:getEventConfigDpReward()
	local derewards = self._configData.DPReward

	return self:sortByKey(derewards)
end

function MazeEvent:sortByKey(t)
	local a = {}
	local b = {}

	for n in pairs(t) do
		a[#a + 1] = n
	end

	table.sort(a, function(v1, v2)
		return tonumber(v1) < tonumber(v2)
	end)

	for k, v in pairs(a) do
		b[k] = v .. "|" .. t[v]
	end

	return b
end

function MazeEvent:getEventMaxDp()
	local derewards = self._configData.DPReward
	local all = self:sortByKey(derewards)

	return string.split(all[#all], "|")[1]
end

function MazeEvent:getBoxCanGetDp(id)
	local derewards = self._configData.DPReward
	local all = self:sortByKey(derewards)

	return tonumber(string.split(all[id], "|")[1])
end

function MazeEvent:getEventDpTaskById(id)
	return self._mazeDpTaskList[id]
end

function MazeEvent:getEventDpTaskByIndex(index)
	local id = self._configData.DPTask[index]

	return self:getEventDpTaskById(id)
end

function MazeEvent:getEventDpTaskRewardByIndex(index)
	local rewards = self:getEventConfigDpReward()

	return (tonumber(string.split(rewards[index], "|")[1]))
end

function MazeEvent:getEventDpTaskProgressById(id)
	local value = self._mazeDpTaskList[id].taskValues

	for k, v in pairs(value) do
		return tonumber(v.currentValue), tonumber(v.targetValue)
	end
end

function MazeEvent:getEventDpTaskDescById(id, mediator)
	local name = Strings:get(ConfigReader:getDataByNameIdAndKey("PansLabDPTask", id, "Name"))

	if name == "" then
		local conditionkeeper = mediator:getInjector():getInstance(Conditionkeeper)
		local desc = Strings:get(ConfigReader:getDataByNameIdAndKey("PansLabDPTask", id, "Condition"))

		name = conditionkeeper:getConditionDesc(desc[1])
	end

	return name
end

function MazeEvent:getEventDpTaskRewardById(id)
	return ConfigReader:getDataByNameIdAndKey("PansLabDPTask", id, "DP")
end

function MazeEvent:getEventDpTaskCount()
	return table.nums(self._mazeDpTaskList)
end

function MazeEvent:getEventAllDpTask()
	return self._mazeDpTaskList
end

function MazeEvent:haveGetRewards(reward)
	for k, v in pairs(self._dpGotRewards) do
		if tonumber(v) == reward then
			return true
		end
	end

	return false
end

function MazeEvent:getClueNameById(eventid, clueid)
	local clulist = ConfigReader:getDataByNameIdAndKey("PansLabList", eventid, "ClueList")
	local config = ConfigReader:getRecordById("PansLabClue", clulist[clueid])
	local clueName = Strings:get(config.Name)
	local clueDesc = Strings:get(config.Desc)

	return clueName, clueDesc
end

function MazeEvent:getClueDesc(clueid)
	return
end

function MazeEvent:getClueSets()
	return (ConfigReader:getDataByNameIdAndKey("PansLabList", self._configId, "ClueList"))
end
