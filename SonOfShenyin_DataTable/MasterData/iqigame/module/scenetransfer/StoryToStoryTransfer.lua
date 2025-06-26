-- chunkname: @IQIGame\\Module\\SceneTransfer\\StoryToStoryTransfer.lua

local SceneTransferController = require("IQIGame/Module/SceneTransfer/SceneTransferController")
local Transfer = Clone(SceneTransferController)

function Transfer:__OnPrepare()
	self:__CommonPrepare()
end

function Transfer:__UnloadScene()
	self.storyModuleDisposed = false

	BattleModule.Dispose()

	local function condition()
		return self.storyModuleDisposed
	end

	local function callback()
		self:__CommonUnloadScene()
	end

	self:__AddConditionCall(condition, nil, callback, nil)
	CoroutineUtility.StartCoroutine(function()
		if StoryModule.onExitFight then
			StoryModule.onExitFight()
		end

		StoryModule.Dispose()

		self.storyModuleDisposed = true
	end)
end

function Transfer:__LoadScene()
	local loadSceneComplete = false

	CoroutineUtility.StartCoroutine(function()
		CoroutineUtility.Yield(StoryModule.StartStory, self.Args.StartStoryParam)

		loadSceneComplete = true

		self:__CommonLoadScene()
	end)
end

function Transfer:__Exit()
	self:__CommonExit()
	StoryModule.AllNPCsTriggerStart()
end

return Transfer
