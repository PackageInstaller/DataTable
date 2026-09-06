-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/state/ThreeEliminationViewSwap.lua

module("logic.extensions.threeelimination.view.state.ThreeEliminationViewSwap", package.seeall)

local ThreeEliminationViewSwap = class("ThreeEliminationViewSwap")

function ThreeEliminationViewSwap:ctor(stateName)
	self._stateName = stateName
end

function ThreeEliminationViewSwap:onEnter()
	GlobalDispatcher:dispatch(GlobalNotify.SwapView)
end

function ThreeEliminationViewSwap:onExit()
	return
end

return ThreeEliminationViewSwap
