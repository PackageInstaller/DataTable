-- chunkname: @IQIGame\\Module\\SceneTransfer\\MainCityToStoryTransfer.lua

local SceneTransferController = require("IQIGame/Module/SceneTransfer/SceneTransferController")
local Transfer = Clone(SceneTransferController)

function Transfer:__UnloadScene()
	if SceneTransferModule.CurScene == SceneTransferModule.SceneName.EmptyMainCity then
		self:__ChangeState(self.State.LoadScene)

		return
	end

	MainCityModule.Shutdown()
	self:__CommonUnloadScene()
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
