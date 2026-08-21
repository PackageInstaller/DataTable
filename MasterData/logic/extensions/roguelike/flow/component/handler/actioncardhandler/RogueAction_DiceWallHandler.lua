-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/actioncardhandler/RogueAction_DiceWallHandler.lua

module("logic.extensions.roguelike.flow.component.handler.actioncardhandler.RogueAction_DiceWallHandler", package.seeall)

local M = class("RogueAction_DiceWallHandler", IRogueCardActionHandler)

function M:execAction(judgeHandler, matchCountOrigin, curRoundMatchCount, actionBase)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local isDiceWall, diceParam = judgeModel:getRoleActionIsDiceWall()

	if isDiceWall then
		local actionCo = judgeModel:getRoleSelectActionCo()
		local diceWallCount = math.floor(tonumber(diceParam) * curRoundMatchCount) + actionBase

		if diceWallCount > 0 then
			judgeModel:addRoleDiceWall(diceWallCount)

			local msg = string.format(actionCo.effectDesc, diceWallCount)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
			RogueBroadcastModel.instance:addMoByDefence(diceWallCount, RogueMgr.instance:getModel():getCurRoleMo():getRoleId())
		end
	end
end

function M:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local actionId = actionCo.id
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.AddDiceWall, actionId)

	if result then
		local wallCount = math.floor(tonumber(params) * diceResultCount) + actionBase
		local minCount = math.floor(tonumber(params) * minResultCount) + actionBase

		wallCount = wallCount == 0 and "?" or wallCount

		return string.format(actionCo.effectDesc, string.format(self._formatText, minCount, wallCount))
	end
end

return M
