-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/state/TripleMacthesViewSwap.lua

module("logic.extensions.triplemacthesgame.view.state.TripleMacthesViewSwap", package.seeall)

local TripleMacthesViewSwap = class("TripleMacthesViewSwap")

function TripleMacthesViewSwap:ctor(stateName)
	self._stateName = stateName
end

function TripleMacthesViewSwap:onEnter()
	GlobalDispatcher:dispatch(GlobalNotify.SwapView)
end

function TripleMacthesViewSwap:onExit()
	return
end

return TripleMacthesViewSwap
