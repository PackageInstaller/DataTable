-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/state/TripleMacthesDefaultState.lua

module("logic.extensions.triplemacthesgame.view.state.TripleMacthesDefaultState", package.seeall)

local TripleMacthesDefaultState = class("TripleMacthesDefaultState")

function TripleMacthesDefaultState:ctor(stateName)
	self._stateName = stateName
end

function TripleMacthesDefaultState:onEnter()
	TripleMachesGameController.instance:changeAllEmptyShow(true)
	GlobalDispatcher:dispatch(GlobalNotify.StepOver)
end

function TripleMacthesDefaultState:onExit()
	return
end

return TripleMacthesDefaultState
