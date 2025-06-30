-- chunkname: @IQIGame\\Module\\SceneTransfer\\StoryToMainCityTransfer.lua

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
	local function callback()
		self:__ChangeState(self.State.Exit)

		if self.Args.callBack then
			self.Args.callBack()
		end
	end

	SceneTransferModule.LoadMainCity(self.Args.revertUI, callback, self.Args)
end

return Transfer
