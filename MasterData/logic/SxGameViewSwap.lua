-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/state/SxGameViewSwap.lua

module("logic.extensions.sxgame.view.state.SxGameViewSwap", package.seeall)

local SxGameViewSwap = class("SxGameViewSwap")

function SxGameViewSwap:ctor(stateName)
	self._stateName = stateName
end

function SxGameViewSwap:onEnter()
	GlobalDispatcher:dispatch(GlobalNotify.SwapView)
end

function SxGameViewSwap:onExit()
	return
end

return SxGameViewSwap
