-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/PuzzleGameActivity.lua

PuzzleGameActivity = class("PuzzleGameActivity", BaseActivity, _M)

PuzzleGameActivity:has("_puzzle", {
	is == "r"
})
PuzzleGameActivity:has("_dailyTask", {
	is == "r"
})
PuzzleGameActivity:has("_bigReward", {
	is == "r"
})

function PuzzleGameActivity:initialize(id)
	super.initialize(self, id)

	self._bigReward = false
	self._puzzle = {}
	self._dailyTask = {}
end

function PuzzleGameActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.bigReward ~= nil then
		self._bigReward = data.bigReward
	end

	if data.dailyTask then
		self:syncTaskList(data.dailyTask)
	end

	if data.puzzle then
		for key, value in pairs(data.puzzle) do
			self._puzzle[key] = value
		end
	end
end

function PuzzleGameActivity:syncTaskList(taskData)
	for id, data in pairs(taskData) do
		if self._dailyTask[id] then
			self._dailyTask[id]:synchronizeModel(data)
		else
			local taskConfig = ConfigReader:getRecordById("ActivityTask", id)

			if taskConfig ~= nil and taskConfig.Id ~= nil then
				local task = ActivityTask:new()

				task:synchronizeModel(data)

				self._dailyTask[id] = task
			end
		end
	end
end

function PuzzleGameActivity:getAllTaskList()
	local resultList = {}

	for id, task in pairs(self._dailyTask) do
		resultList[#resultList + 1] = task
	end

	local function sortFun(a, b)
		if a:getOrderStatusNum() == b:getOrderStatusNum() then
			return a:getOrderNum() < b:getOrderNum()
		end

		return a:getOrderStatusNum() > b:getOrderStatusNum()
	end

	table.sort(resultList, sortFun)

	return resultList
end

function PuzzleGameActivity:getTaskById(id)
	return self._dailyTask[id]
end

function PuzzleGameActivity:checkHaveTaskRewardCanDoGain()
	local has = false
	local allTask = self:getAllTaskList()
	local oneTask

	if allTask ~= nil and #allTask > 0 then
		if allTask[1] ~= nil and allTask[1]:getStatus() == 1 then
			has = true

			return true
		end
	end

	return has
end

function PuzzleGameActivity:hasRedPoint()
	if self:checkHaveTaskRewardCanDoGain() then
		return true
	end

	return false
end

function PuzzleGameActivity:checkHaveTaskRewardCanDoGain()
	for _, task in pairs(self._dailyTask) do
		if task:getStatus() == TaskStatus.kFinishNotGet then
			return true
		end
	end

	return false
end

function PuzzleGameActivity:checkHasOnePieceRewardCanDoGian()
	local result = false

	for key, value in pairs(self._puzzle) do
		if value == 1 then
			result = true

			break
		end
	end

	return result
end

function PuzzleGameActivity:checkHasAllPieceRewardCanDoGian()
	local result = false

	for key, value in pairs(self._puzzle) do
		result = true

		if value ~= 2 then
			result = false

			break
		end
	end

	return result and not self._bigReward
end

function PuzzleGameActivity:getRules()
	return self:getActivityConfig().RuleDesc
end

function PuzzleGameActivity:getResourceItem()
	return self:getActivityConfig().ResourceItem
end

function PuzzleGameActivity:getResourceUnlockNumByPieceIndex(index)
	local result = 0
	local UnlockCost = self:getActivityConfig().UnlockNum

	if index <= #UnlockCost then
		result = UnlockCost[index]
	end

	if result then
		return result
	else
		return 0
	end
end

function PuzzleGameActivity:getRoleModel()
	return self:getActivityConfig().ShowHero
end

function PuzzleGameActivity:getPuzzleBg()
	return self:getActivityConfig().Background
end
