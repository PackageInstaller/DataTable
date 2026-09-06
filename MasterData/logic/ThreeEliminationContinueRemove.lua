-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/state/ThreeEliminationContinueRemove.lua

module("logic.extensions.threeelimination.view.state.ThreeEliminationContinueRemove", package.seeall)

local ThreeEliminationContinueRemove = class("ThreeEliminationContinueRemove")

function ThreeEliminationContinueRemove:ctor(stateName)
	self._stateName = stateName
end

function ThreeEliminationContinueRemove:onEnter()
	GlobalDispatcher:dispatch(GlobalNotify.RemoveCell)
end

function ThreeEliminationContinueRemove:onExit()
	return
end

return ThreeEliminationContinueRemove
