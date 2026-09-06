-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/state/SxGameDefaultState.lua

module("logic.extensions.sxgame.view.state.SxGameDefaultState", package.seeall)

local SxGameDefaultState = class("SxGameDefaultState")

function SxGameDefaultState:ctor(stateName)
	self._stateName = stateName
end

function SxGameDefaultState:onEnter()
	GlobalDispatcher:dispatch(GlobalNotify.StepOver)
end

function SxGameDefaultState:onExit()
	return
end

return SxGameDefaultState
