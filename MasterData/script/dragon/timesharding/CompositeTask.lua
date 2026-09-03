-- chunkname: @/tmp/or_script/lua_compile/dragon/timesharding/CompositeTask.lua

module("timesharding", package.seeall)

if not os.timemillis then
	local function gettime()
		return os.clock() * 1000
	end

	CompositeTask = class("CompositeTask", Task)

	function CompositeTask:initialize()
		super.initialize(self)

		self._subTasks = {}
		self._timeLimitation = nil
	end

	function CompositeTask:reportError(err, level, errSubTask)
		self._errSubTask = errSubTask

		super.reportError(self, err, level)
	end

	function CompositeTask:recoveryFromError()
		if not self._error then
			return
		end

		self._error = nil

		local errSubTask = self._errSubTask

		if errSubTask ~= nil then
			self._errSubTask = nil

			errSubTask:recoveryFromError()
		end
	end

	function CompositeTask:traceError()
		if not self._error then
			return nil
		end

		local stack

		if self._errSubTask ~= nil then
			stack = self._errSubTask:traceError()
		end

		if stack == nil then
			stack = {
				self
			}
		else
			stack[#stack + 1] = self
		end
	end

	function CompositeTask:setTimeLimitation(milliseconds)
		self._timeLimitation = milliseconds
	end

	function CompositeTask:addTask(weight, task)
		self._subTasks[#self._subTasks + 1] = {
			task = task,
			weight = weight or 1
		}
	end

	function CompositeTask:calcTotalWeight()
		local totalWeight = 0

		for i, info in ipairs(self._subTasks) do
			totalWeight = totalWeight + info.weight
		end

		return totalWeight
	end

	function getCCScheduler()
		return cc.Director:getInstance():getScheduler()
	end

	function CompositeTask:runStep(stepFunc)
		if self:isRunning() then
			stepFunc()
		end

		if self:isRunning() then
			if self.tickEntry == nil then
				self.tickEntry = getCCScheduler():scheduleScriptFunc(function(dt)
					self:runStep(stepFunc)
				end, 0, false)
			end
		elseif self.tickEntry ~= nil then
			getCCScheduler():unscheduleScriptEntry(self.tickEntry)

			self.tickEntry = nil
		end
	end

	function CompositeTask:breakTask()
		if self.tickEntry ~= nil then
			getCCScheduler():unscheduleScriptEntry(self.tickEntry)

			self.tickEntry = nil
		end

		super.breakTask(self)
	end

	SequencialTask = class("SequencialTask", CompositeTask)

	function SequencialTask:start()
		super.start(self)

		local completed = 0
		local totalWeight = 0
		local taskIndices = {}

		for i, info in ipairs(self._subTasks) do
			totalWeight = totalWeight + info.weight
			taskIndices[info.task] = {
				p = 0,
				weight = info.weight
			}
		end

		self._currentTask = nil

		local subListener = TaskListener:new()
		local nextIndex = 1

		local function step()
			if self._currentTask ~= nil then
				return
			end

			local t0 = gettime()

			while nextIndex <= #self._subTasks do
				if not self._isRunning then
					return
				end

				local info = self._subTasks[nextIndex]

				nextIndex = nextIndex + 1
				self._currentTask = info

				info.task:setTaskListener(subListener)
				info.task:start()

				if info.task:isRunning() then
					break
				end

				if self._timeLimitation ~= nil then
					local t1 = gettime()

					if t1 - t0 >= self._timeLimitation then
						break
					end
				end
			end

			if oldCompleted ~= completed then
				oldCompleted = completed

				local progress = totalWeight == 0 and 1 or completed / totalWeight

				progress = math.max(0, math.min(1, progress))

				self:reportProgress(progress)
			end

			if nextIndex > #self._subTasks and self._currentTask == nil then
				self:finish()
			end
		end

		local function updateProgress(task, p)
			local info = taskIndices[task]

			if info == nil then
				return
			end

			if not info.p then
				local p0 = 0

				info.p = p
				completed = completed + (p - p0) * info.weight
			end
		end

		local function markFinished(task)
			if self._currentTask == nil then
				return
			end

			assert(task == self._currentTask.task)

			self._currentTask = nil

			updateProgress(task, 1)
		end

		local parentTask = self

		function subListener:onProgress(task, p)
			updateProgress(task, p)
		end

		function subListener:onError(task, err, level)
			markFinished(task)
			parentTask:reportError(err, level, task)

			if parentTask:hasError() then
				parentTask:breakTask()
			end
		end

		function subListener:onCompleted(task)
			markFinished(task)
		end

		self:runStep(step)
	end

	function SequencialTask:breakTask()
		if self._currentTask ~= nil then
			self._currentTask.task:abort()

			self._currentTask = nil
		end

		super.breakTask(self)
	end

	ParallelTask = class("ParallelTask", CompositeTask)

	function ParallelTask:start()
		super.start(self)

		local completed = 0
		local totalWeight = 0
		local taskIndices = {}

		for i, info in ipairs(self._subTasks) do
			totalWeight = totalWeight + info.weight
			taskIndices[info.task] = {
				p = 0,
				weight = info.weight
			}
		end

		local runningTasks = {}

		self._runningTasks = runningTasks

		local oldCompleted
		local subListener = TaskListener:new()
		local nextIndex = 1

		local function step()
			local t0 = gettime()

			while nextIndex <= #self._subTasks do
				if not self._isRunning then
					return
				end

				local info = self._subTasks[nextIndex]

				nextIndex = nextIndex + 1
				runningTasks[info.task] = info

				info.task:setTaskListener(subListener)
				info.task:start()

				if self._timeLimitation ~= nil then
					local t1 = gettime()

					if t1 - t0 >= self._timeLimitation then
						break
					end
				end
			end

			if oldCompleted ~= completed then
				oldCompleted = completed

				local progress = totalWeight == 0 and 1 or completed / totalWeight

				progress = math.max(0, math.min(1, progress))

				self:reportProgress(progress)
			end

			if nextIndex > #self._subTasks and next(runningTasks) == nil then
				self:finish()
			end
		end

		local function updateProgress(task, p)
			local info = taskIndices[task]

			if info == nil then
				return
			end

			if not info.p then
				local p0 = 0

				info.p = p
				completed = completed + (p - p0) * info.weight
			end
		end

		local function markFinished(task)
			runningTasks[task] = nil

			updateProgress(task, 1)
		end

		local parentTask = self

		function subListener:onProgress(task, p)
			updateProgress(task, p)
		end

		function subListener:onError(task, err, level)
			markFinished(task)
			parentTask:reportError(err, level, task)

			if parentTask:hasError() then
				parentTask:breakTask()
			end
		end

		function subListener:onCompleted(task)
			markFinished(task)
		end

		self:runStep(step)
	end

	function ParallelTask:breakTask()
		for task, _ in pairs(self._runningTasks) do
			task:abort()
		end

		self._runningTasks = nil

		super.breakTask(self)
	end
end
