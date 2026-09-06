-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/state/SxGameScoreAction.lua

module("logic.extensions.sxgame.view.state.SxGameScoreAction", package.seeall)

local SxGameScoreAction = class("SxGameScoreAction")

function SxGameScoreAction:ctor(stateName)
	self._stateName = stateName
end

function SxGameScoreAction:onEnter()
	SxGameModel.instance:clearAllIce()
	GlobalDispatcher:dispatch(GlobalNotify.RemoveCell)
end

function SxGameScoreAction:onExit()
	return
end

return SxGameScoreAction
