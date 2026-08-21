-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/actioncardhandler/RogueAction_RecoveryHurtHandler.lua

module("logic.extensions.roguelike.flow.component.handler.actioncardhandler.RogueAction_RecoveryHurtHandler", package.seeall)

local M = class("RogueAction_RecoveryHurtHandler", IRogueCardActionHandler)

function M:execAction(judgeHandler, matchCountOrigin, curRoundMatchCount, actionBase)
	local judgeModel = judgeHandler._mgr.flow.judgeModel
	local result, params = judgeModel:getRoleActionAndEffect(judgeModel.RoleActionType.RecoveryHurt)

	if result then
		local paramList = string.split(params, "#")
		local actionCo = judgeModel:getRoleSelectActionCo()
		local cd = actionCo.cd < 0 and actionCo.cd * -1 - matchCountOrigin or actionCo.cd

		cd = math.max(cd, 0)

		local hpEffect = RoguelikeConfig.instance:getConstEffect(paramList[1])
		local sanEffect = RoguelikeConfig.instance:getConstEffect(paramList[2])
		local lossValue = RogueMgr.instance:getRogueFlow().stateMgr:getCurJudgeRoleChangeValue()

		for k, v in pairs(lossValue) do
			if v.hp > 0 then
				RoguelikeController.instance:execEffectIds({
					hpEffect
				}, nil, k, v.hp)
			end

			if v.san > 0 then
				RoguelikeController.instance:execEffectIds({
					sanEffect
				}, nil, k, v.san)
			end
		end

		RogueMgr.instance:getRogueFlow().stateMgr:clearRoleChange()

		local msg = string.format(actionCo.effectDesc, cd)

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
	end
end

function M:getPredictionValue(actionCo, resultOrigin, diceResultCount, minResultCount, actionBase)
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local actionId = actionCo.id
	local min = math.max(actionCo.cd * -1 - resultOrigin, 0)

	min = min == 0 and "?" or min

	return string.format(actionCo.effectDesc, string.format(self._formatText, min, actionCo.cd * -1 - minResultCount))
end

return M
