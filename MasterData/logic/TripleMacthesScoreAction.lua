-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/state/TripleMacthesScoreAction.lua

module("logic.extensions.triplemacthesgame.view.state.TripleMacthesScoreAction", package.seeall)

local TripleMacthesScoreAction = class("TripleMacthesScoreAction")

function TripleMacthesScoreAction:ctor(stateName)
	self._stateName = stateName
end

function TripleMacthesScoreAction:onEnter()
	TripleMacthesGameModel.instance:clearAllIce()
	GlobalDispatcher:dispatch(GlobalNotify.RemoveCell)
end

function TripleMacthesScoreAction:onExit()
	return
end

return TripleMacthesScoreAction
