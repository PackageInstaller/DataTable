-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/state/ThreeEliminationScoreAction.lua

module("logic.extensions.threeelimination.view.state.ThreeEliminationScoreAction", package.seeall)

local ThreeEliminationScoreAction = class("ThreeEliminationScoreAction")

function ThreeEliminationScoreAction:ctor(stateName)
	self._stateName = stateName
end

function ThreeEliminationScoreAction:onEnter()
	GlobalDispatcher:dispatch(GlobalNotify.RemoveCell)
end

function ThreeEliminationScoreAction:onExit()
	return
end

return ThreeEliminationScoreAction
