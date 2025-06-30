-- chunkname: @IQIGame\\Module\\SceneTransfer\\MainCityToGhostGameTransfer.lua

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
	GhostGameModule.Initialize(self.Args.activityId)
	self:__CommonLoadScene()
end

function Transfer:__Exit()
	self:__CommonExit()
end

return Transfer
