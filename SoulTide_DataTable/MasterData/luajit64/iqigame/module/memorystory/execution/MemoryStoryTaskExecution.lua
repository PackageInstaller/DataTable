-- chunkname: @IQIGame\\Module\\MemoryStory\\Execution\\MemoryStoryTaskExecution.lua

local Execution = {}

Execution[MemoryStoryExecutionModule.ExecuteType.ReceiveTask] = function(element, cfg)
	local taskId = tonumber(cfg.Parameter[1])

	log("Execute " .. tostring(cfg.Id) .. " ReceiveTask:" .. tostring(taskId))
	MemoryStoryPlayerModule.OnReceiveTask(taskId)
end
Execution[MemoryStoryExecutionModule.ExecuteType.AddTaskProgress] = function(element, cfg)
	local taskId = tonumber(cfg.Parameter[1])
	local targetId = tonumber(cfg.Parameter[2])
	local progress = tonumber(cfg.Parameter[3])

	log("Execute " .. tostring(cfg.Id) .. " AddTaskProgress:" .. tostring(taskId))
	MemoryStoryPlayerModule.OnAddTaskProgress(taskId, targetId, progress)
end
Execution[MemoryStoryExecutionModule.ExecuteType.SubmitTask] = function(element, cfg)
	local taskId = tonumber(cfg.Parameter[1])

	log("Execute " .. tostring(cfg.Id) .. " SubmitTask:" .. tostring(taskId))
	MemoryStoryPlayerModule.OnSubmitTask(taskId)
end
Execution[MemoryStoryExecutionModule.ExecuteType.AddVirtualItemCount] = function(element, cfg)
	local itemId = tonumber(cfg.Parameter[1])
	local itemCount = tonumber(cfg.Parameter[2])

	MemoryStoryPlayerModule.AddItem(itemId, itemCount)
end
Execution[MemoryStoryExecutionModule.ExecuteType.RemoveVirtualItemCount] = function(element, cfg)
	local itemId = tonumber(cfg.Parameter[1])
	local itemCount = tonumber(cfg.Parameter[2])

	MemoryStoryPlayerModule.RemoveItem(itemId, itemCount)
end
Execution[MemoryStoryExecutionModule.ExecuteType.SetVirtualItemCount] = function(element, cfg)
	local itemId = tonumber(cfg.Parameter[1])
	local itemCount = tonumber(cfg.Parameter[2])

	MemoryStoryPlayerModule.SetItemCount(itemId, itemCount)
end

return Execution
