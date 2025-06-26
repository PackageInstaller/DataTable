-- chunkname: @IQIGame\\Module\\MemoryStory\\MemoryStoryExecutionModule.lua

MemoryStoryExecutionModule = {}
MemoryStoryExecutionModule.ExecuteType = {
	RequestExperienceMemory = 23,
	SetVirtualItemCount = 21,
	Talk = 2,
	RemoveElement = 10,
	ShowOption = 1,
	ChangeScene = 12,
	StoryEnd = 5,
	PlayerSceneEffect = 17,
	StopElementEffect = 16,
	SubmitTask = 8,
	StopSceneEffect = 18,
	PlayAnimation = 11,
	Outline = 13,
	AddTaskProgress = 7,
	DelayExecution = 24,
	CameraLookAt = 25,
	RemoveVirtualItemCount = 20,
	OutLineLight = 14,
	ReceiveTask = 6,
	PlayElementEffect = 15,
	Transfiguration = 27,
	ForceTalk = 28,
	CameraLookAtHero = 26,
	Transfer = 4,
	PlayEffect = 3,
	HeroAutoMove = 22,
	AddVirtualItemCount = 19,
	AddElement = 9
}
MemoryStoryExecutionModule.TaskExecution = require("IQIGame.Module.MemoryStory.Execution.MemoryStoryTaskExecution")
MemoryStoryExecutionModule.UIExecution = require("IQIGame.Module.MemoryStory.Execution.MemoryStoryUIExecution")
MemoryStoryExecutionModule.SceneExecution = require("IQIGame.Module.MemoryStory.Execution.MemoryStorySceneExecution")

function MemoryStoryExecutionModule.ExecuteService(element, executionIds)
	for _, id in pairs(executionIds) do
		MemoryStoryExecutionModule.__DoExecute(element, id)
	end
end

function MemoryStoryExecutionModule.__DoExecute(element, executionID)
	local cfg = CfgMemoryStoryExecutionTable[executionID]
	local func = MemoryStoryExecutionModule.__GetExecution(tonumber(cfg.Type))

	if not func then
		logError("MemoryStoryExecution Unknown ExecuteType " .. tostring(cfg.Type) .. " in Execution " .. tostring(executionID))

		return
	end

	func(element, cfg)
end

function MemoryStoryExecutionModule.__GetExecution(executeType)
	if executeType == MemoryStoryExecutionModule.ExecuteType.DelayExecution then
		return MemoryStoryExecutionModule.__DelayExecution
	end

	if MemoryStoryExecutionModule.TaskExecution[executeType] ~= nil then
		return MemoryStoryExecutionModule.TaskExecution[executeType]
	end

	if MemoryStoryExecutionModule.UIExecution[executeType] ~= nil then
		return MemoryStoryExecutionModule.UIExecution[executeType]
	end

	if MemoryStoryExecutionModule.SceneExecution[executeType] ~= nil then
		return MemoryStoryExecutionModule.SceneExecution[executeType]
	end

	return nil
end

function MemoryStoryExecutionModule.__DelayExecution(element, cfg)
	local delay = tonumber(cfg.Parameter[1])
	local executionList = {}

	for i = 2, #cfg.Parameter do
		local executeId = tonumber(cfg.Parameter[i])

		table.insert(executionList, executeId)
	end

	if #executionList == 0 then
		logError("DelayExecution can't find execution in " .. tostring(cfg.Id))

		return
	end

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.MemoryStory, function()
		for i = 1, #executionList do
			MemoryStoryExecutionModule.__DoExecute(nil, executionList[i])
		end
	end, delay, false)

	timer:Start()
end
