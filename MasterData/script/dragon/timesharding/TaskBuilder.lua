-- chunkname: @/tmp/or_script/lua_compile/dragon/timesharding/TaskBuilder.lua

local _G = _G

if not _G.cclog then
	module("timesharding", package.seeall)

	TaskBuilder = class("TaskBuilder")

	function TaskBuilder:buildParalelTask(taskSource)
		local compTaskStack = {}
		local finalTask = ParallelTask:new()

		compTaskStack[#compTaskStack + 1] = finalTask

		local ctx = self:setupBuildContext(compTaskStack)

		setfenv(taskSource, setmetatable(ctx, {
			__index = _G
		}))
		taskSource()
		assert(#compTaskStack == 1, "")

		return finalTask
	end

	function TaskBuilder:buildSequencialTask(taskSource)
		local compTaskStack = {}
		local finalTask = SequencialTask:new()

		compTaskStack[#compTaskStack + 1] = finalTask

		local ctx = self:setupBuildContext(compTaskStack)

		setfenv(taskSource, setmetatable(ctx, {
			__index = _G
		}))
		taskSource()
		assert(#compTaskStack == 1, "")

		return finalTask
	end

	function TaskBuilder:setupBuildContext(compTaskStack)
		local ctx = {}

		function ctx.SEQUENCE(timeLimit)
			local task = SequencialTask:new()

			task:setTimeLimitation(timeLimit)

			compTaskStack[#compTaskStack + 1] = task
		end

		function ctx.PARALLEL(timeLimit)
			local task = ParallelTask:new()

			task:setTimeLimitation(timeLimit)

			compTaskStack[#compTaskStack + 1] = task
		end

		function ctx.END()
			local topTask = compTaskStack[#compTaskStack]

			if topTask == nil then
				return
			end

			compTaskStack[#compTaskStack] = nil

			local parentTask = compTaskStack[#compTaskStack]

			if parentTask ~= nil then
				parentTask:addTask(topTask:calcTotalWeight(), topTask)
			end
		end

		function ctx.ADD_TASK(weight, task)
			local compTask = compTaskStack[#compTaskStack]

			assert(compTask ~= nil, "No SEQUENCE/PARALLEL")
			compTask:addTask(weight, task)
		end

		function ctx.DO_ACTION(action, weight)
			ctx.ADD_TASK(weight or 1, CustomTask:new(function()
				action()

				return true
			end))
		end

		function ctx.REQUIRE(url, weight)
			ctx.ADD_TASK(weight or 1, CustomTask:new(function()
				require(url)

				return true
			end))
		end

		function ctx.ADD_SPRITEFRAMES(fileName, weight)
			ctx.ADD_TASK(weight, CustomTask:new(function()
				cc.SpriteFrameCache:getInstance():addSpriteFrames(fileName)

				return true
			end))
		end

		function ctx.ADD_IMAGE(fileName, weight)
			ctx.ADD_TASK(weight, CustomTask:new(function(task)
				local texture = cc.Director:getInstance():getTextureCache():addImage(fileName)

				if texture ~= nil then
					task:finish()
				else
					local err = "addImage failed, file: " .. fileName

					task:reportError(err, timesharding.kWarning)
				end
			end))
		end

		function ctx.ADD_IMAGE_ASYNC(fileName, weight)
			ctx.ADD_TASK(weight, CustomTask:new(function(task)
				cc.Director:getInstance():getTextureCache():addImageAsync(fileName, function(texture)
					if texture ~= nil then
						task:finish()
					else
						local err = "addImageAsync failed, file: " .. fileName

						task:reportError(err, timesharding.kWarning)
					end
				end)
			end), function()
				return
			end)
		end

		function ctx.ADD_MCLIB(fileName, weight)
			ctx.ADD_TASK(weight, CustomTask:new(function()
				cc.MCLibrary:getInstance():loadDefinitionsFromFile(fileName, 1)

				return true
			end))
		end

		return ctx
	end

	function fastRunTask(options, task, endCallback)
		local listener = TaskListener:new()
		local abortOnError = options ~= nil and options.abortOnError

		function listener:onError(task, err)
			if abortOnError then
				task:abort()

				if endCallback then
					endCallback(err)
				end
			end
		end

		function listener:onCompleted(task)
			if endCallback then
				endCallback()
			end
		end

		task:setTaskListener(listener)
		task:start()
	end
end
