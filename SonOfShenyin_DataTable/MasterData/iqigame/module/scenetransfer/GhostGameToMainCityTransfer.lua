-- chunkname: @IQIGame\\Module\\SceneTransfer\\GhostGameToMainCityTransfer.lua

local SceneTransferController = require("IQIGame/Module/SceneTransfer/SceneTransferController")
local Transfer = Clone(SceneTransferController)

function Transfer:__UnloadScene()
	GhostGameModule.Shutdown()

	if SceneTransferModule.CurScene == SceneTransferModule.SceneName.EmptyMainCity then
		self:__ChangeState(self.State.LoadScene)

		return
	end

	self:__CommonUnloadScene()
end

function Transfer:__LoadScene()
	self:__CommonLoadScene()
end

function Transfer:__Exit()
	self:__CommonExit()
	SceneTransferModule.LoadMainCity(false, nil, nil)
end

return Transfer
