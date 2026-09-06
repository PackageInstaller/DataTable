-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/state/ThreeEliminationDefaultState.lua

module("logic.extensions.threeelimination.view.state.ThreeEliminationDefaultState", package.seeall)

local ThreeEliminationDefaultState = class("ThreeEliminationDefaultState")

function ThreeEliminationDefaultState:ctor(stateName)
	self._stateName = stateName
end

function ThreeEliminationDefaultState:onEnter()
	GlobalDispatcher:dispatch(GlobalNotify.StepOver)
end

function ThreeEliminationDefaultState:onExit()
	return
end

return ThreeEliminationDefaultState
