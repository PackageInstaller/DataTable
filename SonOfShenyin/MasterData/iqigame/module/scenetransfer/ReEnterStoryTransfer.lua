-- chunkname: @IQIGame\\Module\\SceneTransfer\\ReEnterStoryTransfer.lua

local SceneTransferController = require("IQIGame/Module/SceneTransfer/SceneTransferController")
local Transfer = Clone(SceneTransferController)

function Transfer:__UnloadScene()
	self.storyModuleDisposed = false

	BattleModule.Dispose()

	local function condition()
		return self.storyModuleDisposed
	end

	local function callback()
		StoryModule.SaveEmpty()
		self:__CommonUnloadScene()
	end

	self:__AddConditionCall(condition, nil, callback, nil)
	CoroutineUtility.StartCoroutine(function()
		if StoryModule.onExitFight then
			StoryModule.onExitFight()
		end

		StoryModule.StopAllBehaviorTree()
		StoryModule.Dispose()

		self.storyModuleDisposed = true
	end)
end

function Transfer:__LoadScene()
	local loadSceneComplete = false

	CoroutineUtility.StartCoroutine(function()
		local startStoryParam, _ = StoryModule.InitStartStoryParam(StoryModule.plotStageDupPOD)

		CoroutineUtility.Yield(StoryModule.StartStory, startStoryParam)

		loadSceneComplete = true

		self:__CommonLoadScene()
	end)
end

function Transfer:__Exit()
	self:__CommonExit()
	StoryModule.AllNPCsTriggerStart()
end

return Transfer
