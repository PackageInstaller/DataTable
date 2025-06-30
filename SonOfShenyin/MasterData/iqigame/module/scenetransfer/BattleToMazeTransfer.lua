-- chunkname: @IQIGame\\Module\\SceneTransfer\\BattleToMazeTransfer.lua

local SceneTransferController = require("IQIGame/Module/SceneTransfer/SceneTransferController")
local Transfer = Clone(SceneTransferController)

function Transfer:__UnloadScene()
	UIModule.Close(Constant.UIControllerName.GameLevelEndUI)
	BattleModule.Dispose()
	self:__CommonUnloadScene()
end

function Transfer:__LoadScene()
	self:__AddConditionCall(function(_args)
		return MazeModule.enterMazeSceneComplete
	end, nil, function(_args)
		self:__ChangeState(self.State.Exit)
	end, nil)
	MazeModule.BattleBackToMaze()
end

return Transfer
