-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/actioncardhandler/IRogueCardActionHandler.lua

module("logic.extensions.roguelike.flow.component.handler.actioncardhandler.IRogueCardActionHandler", package.seeall)

local M = class("IRogueCardActionHandler")

function M:ctor()
	self._formatText = "<color=#ffffff>%s~%s</color>"
end

function M:execAction(judgeHandler, matchCountOrigin, curRoundMatchCount, actionBase)
	return
end

function M:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
	return
end

return M
