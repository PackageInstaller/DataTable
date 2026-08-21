-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/actioncardhandler/RogueAction_Shield2ReduceDiceWallHandler.lua

module("logic.extensions.roguelike.flow.component.handler.actioncardhandler.RogueAction_Shield2ReduceDiceWallHandler", package.seeall)

local M = class("RogueAction_Shield2ReduceDiceWallHandler", IRogueCardActionHandler)

function M:execAction(judgeHandler, matchCountOrigin, curRoundMatchCount, actionBase)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.Shield2ReduceDiceWall)

	if result then
		local actionCo = judgeModel:getRoleSelectActionCo()
		local param1 = string.gsub(params, "X", curRoundMatchCount)
		local diceWall = judgeModel:getRoleDiceWall()

		param1 = string.gsub(param1, "F", diceWall)

		local count1 = TableUtil.strToTable(param1).result

		count1 = tostring(count1) == "inf" and 0 or count1

		local reduceCount = math.floor(tonumber(count1)) + actionBase
		local wallCount = reduceCount < #judgeHandler._mgr._curRoundCombatDice and reduceCount or #judgeHandler._mgr._curRoundCombatDice
		local msg = string.format(actionCo.effectDesc, reduceCount)

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)

		if reduceCount > 0 then
			judgeModel:setRoleDiceWall(0)
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_ROLE_DICE_WALL, 0)

			local msg1 = string.format(RoguelikeConfig.getBroadCast("Role_Reduce_Wall"), wallCount)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg1, false)
		end

		RogueMgr.instance:getRogueFlow().judgeMgr:clearRoleDiceWall()

		for i = #judgeHandler._mgr._curRoundCombatDice, #judgeHandler._mgr._curRoundCombatDice - wallCount + 1, -1 do
			local dice2 = judgeHandler._mgr._curRoundCombatDice[i]

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_MATCH_DICE, judgeHandler:getPlayerMatchDiceId(), dice2:getId(), RoguelikeConst.DICE_MATCH_TYPE.DICE_WALL)
			table.remove(judgeHandler._mgr._curRoundCombatDice, i)
		end
	end
end

function M:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local actionId = actionCo.id
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.Shield2ReduceDiceWall, actionId)

	if result then
		local param1 = string.gsub(params, "X", diceResultCount)
		local param2 = string.gsub(params, "X", minResultCount)
		local diceWall = judgeModel:getRoleDiceWall()

		param1 = string.gsub(param1, "F", diceWall)
		param2 = string.gsub(param2, "F", diceWall)

		local count1 = TableUtil.strToTable(param1).result
		local count2 = TableUtil.strToTable(param2).result

		count1 = tostring(count1) == "inf" and 0 or count1
		count2 = tostring(count2) == "inf" and 0 or count2

		local attackCount = math.floor(count1) + actionBase
		local minCount = math.floor(count2) + actionBase

		minCount = math.max(0, minCount)
		attackCount = attackCount == 0 and "?" or attackCount

		local countStr = attackCount == minCount and minCount or string.format(self._formatText, minCount, attackCount)

		return string.format(actionCo.effectDesc, countStr)
	end
end

return M
