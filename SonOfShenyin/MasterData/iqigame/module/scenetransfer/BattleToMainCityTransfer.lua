-- chunkname: @IQIGame\\Module\\SceneTransfer\\BattleToMainCityTransfer.lua

local SceneTransferController = require("IQIGame/Module/SceneTransfer/SceneTransferController")
local Transfer = Clone(SceneTransferController)

function Transfer:__UnloadScene()
	UIModule.Close(Constant.UIControllerName.GameLevelEndUI)
	BattleModule.Dispose()
	self:__CommonUnloadScene()
end

function Transfer:__LoadScene()
	SceneTransferModule.LoadMainCity(true, function()
		self:__CommonLoadScene()
	end, self.Args)
end

return Transfer
