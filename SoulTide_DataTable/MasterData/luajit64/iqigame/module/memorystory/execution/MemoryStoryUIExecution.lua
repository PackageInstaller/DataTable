-- chunkname: @IQIGame\\Module\\MemoryStory\\Execution\\MemoryStoryUIExecution.lua

local Execution = {}

Execution[MemoryStoryExecutionModule.ExecuteType.ShowOption] = function(element, cfg)
	local args = {
		TalkID = tonumber(cfg.Parameter[1]),
		ExamineID = tonumber(cfg.Parameter[2])
	}

	EventDispatcher.Dispatch(EventID.SetMemoryStoryOptionUIActiveEvent, true, element.CfgData.Id, args)
end
Execution[MemoryStoryExecutionModule.ExecuteType.Talk] = function(element, cfg)
	local talkId = tonumber(cfg.Parameter[1])

	log("Execute " .. tostring(cfg.Id) .. " Show Talk " .. tostring(talkId))
	EventDispatcher.Dispatch(EventID.ShowMemoryStoryTalkEvent, element.CfgData.Id, talkId)
end
Execution[MemoryStoryExecutionModule.ExecuteType.ForceTalk] = function(element, cfg)
	local elementID = tonumber(cfg.Parameter[1])
	local talkId = tonumber(cfg.Parameter[2])

	EventDispatcher.Dispatch(EventID.ShowMemoryStoryTalkEvent, elementID, talkId)
end

return Execution
