-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/actioncardhandler/RogueAction_AddPatternHandler.lua

module("logic.extensions.roguelike.flow.component.handler.actioncardhandler.RogueAction_AddPatternHandler", package.seeall)

local PATTERN = RoguelikeConst.DICE_PATTERN
local M = class("RogueAction_AddPatternHandler", IRogueCardActionHandler)

function M:execAction(judgeHandler, matchCountOrigin, curRoundMatchCount, actionBase)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local isAddPattern = judgeModel:getRoleActionIsAddPattern()

	if isAddPattern then
		local actionCo = judgeModel:getRoleSelectActionCo()
		local patterns = {}
		local count = math.floor(curRoundMatchCount) + actionBase

		for j = 1, count do
			table.insert(patterns, judgeHandler:getLevelPattern(PATTERN.NORMAL, 3))
		end

		if not judgeHandler._mgr.flow.model:checkIsLastOne() then
			RogueMgr.instance:getStateMgr():addRoundExtraPattern(patterns)
		end

		if count > 0 then
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_EXTRA_PATTERN)

			local msg = string.format(actionCo.effectDesc, count)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		end
	end
end

function M:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local actionId = actionCo.id
	local result, paramsF = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.AddDicePattern, actionId)
	local params = string.split(paramsF, "#")
	local count = math.floor(tonumber(params[#params]) * diceResultCount) + actionBase
	local minCount = math.floor(tonumber(params[#params]) * minResultCount) + actionBase

	count = count == 0 and "?" or count

	return string.format(actionCo.effectDesc, string.format(self._formatText, minCount, count))
end

return M
