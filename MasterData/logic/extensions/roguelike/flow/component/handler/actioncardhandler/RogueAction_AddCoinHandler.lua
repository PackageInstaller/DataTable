-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/actioncardhandler/RogueAction_AddCoinHandler.lua

module("logic.extensions.roguelike.flow.component.handler.actioncardhandler.RogueAction_AddCoinHandler", package.seeall)

local M = class("RogueAction_AddCoinHandler", IRogueCardActionHandler)

function M:execAction(judgeHandler, matchCountOrigin, curRoundMatchCount, actionBase)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local isAddCoin = judgeModel:getRoleActionIsAddCoin()

	if isAddCoin then
		local actionCo = judgeModel:getRoleSelectActionCo()
		local cd = actionCo.cd < 0 and actionCo.cd * -1 - matchCountOrigin or actionCo.cd

		cd = math.max(cd, 0)

		local effectIds = judgeModel:getRoleActionEffectId()

		RoguelikeController.instance:execEffectIds(effectIds)

		local msg = string.format(actionCo.effectDesc, cd)

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
	end
end

function M:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local actionId = actionCo.id
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.ReduceCoin, actionId)
	local count = math.floor(tonumber(params) * diceResultCount) + actionBase
	local min = math.max(actionCo.cd * -1 - resultOrigin, 0)

	min = min == 0 and "?" or min

	return string.format(actionCo.effectDesc, string.format(self._formatText, min, actionCo.cd * -1 - minResultCount))
end

return M
