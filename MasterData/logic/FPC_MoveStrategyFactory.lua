-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/game/strategy/FPC_MoveStrategyFactory.lua

module("logic.extensions.firepowercontest.game.strategy.FPC_MoveStrategyFactory", package.seeall)

local FPC_MoveStrategyFactory = class("FPC_MoveStrategyFactory")

function FPC_MoveStrategyFactory.getStrategy()
	return FPC_MoveStrategyBase.New()
end

return FPC_MoveStrategyFactory
