-- chunkname: @modules/logic/rouge/map/controller/RougeMapSkillCheckHelper.lua

module("modules.logic.rouge.map.controller.RougeMapSkillCheckHelper", package.seeall)

local RougeMapSkillCheckHelper = class("RougeMapSkillCheckHelper")

RougeMapSkillCheckHelper.CantUseMapSkillReason = {
	UseLimit = 1,
	DoingEvent = 5,
	CoinCost = 3,
	StepCd = 2,
	ForbidenPathSelect = 7,
	ForbidenMiddle = 6,
	PowerCost = 4,
	None = 0
}
RougeMapSkillCheckHelper.CantUseSkillToast = {
	[RougeMapSkillCheckHelper.CantUseMapSkillReason.UseLimit] = ToastEnum.CantUseMapSkill_StepCd,
	[RougeMapSkillCheckHelper.CantUseMapSkillReason.StepCd] = ToastEnum.CantUseMapSkill_StepCd,
	[RougeMapSkillCheckHelper.CantUseMapSkillReason.CoinCost] = ToastEnum.CantUseMapSkill,
	[RougeMapSkillCheckHelper.CantUseMapSkillReason.PowerCost] = ToastEnum.CantUseMapSkill,
	[RougeMapSkillCheckHelper.CantUseMapSkillReason.DoingEvent] = ToastEnum.CantUseMapSkill_DoingEvent,
	[RougeMapSkillCheckHelper.CantUseMapSkillReason.ForbidenMiddle] = ToastEnum.CantUseMapSkill_MiddleLayer,
	[RougeMapSkillCheckHelper.CantUseMapSkillReason.ForbidenPathSelect] = ToastEnum.CantUseMapSkill_MiddleLayer
}

function RougeMapSkillCheckHelper.canUseMapSkill(skillMo)
	local cantUseReason = RougeMapSkillCheckHelper._getCantUseReason(skillMo)
	local canUse = not cantUseReason or cantUseReason == RougeMapSkillCheckHelper.CantUseMapSkillReason.None

	return canUse, cantUseReason
end

function RougeMapSkillCheckHelper._getCantUseReason(skillMo)
	RougeMapSkillCheckHelper._initSkillUseChcekFuncList()

	local skillCo = lua_rouge_map_skill.configDict[skillMo.id]

	for _, checkFunc in ipairs(RougeMapSkillCheckHelper._checkFuncList) do
		local reason = checkFunc(skillMo, skillCo)

		if reason and reason ~= RougeMapSkillCheckHelper.CantUseMapSkillReason.None then
			return reason
		end
	end
end

function RougeMapSkillCheckHelper.showCantUseMapSkillToast(reason)
	local toastId = RougeMapSkillCheckHelper.CantUseSkillToast[reason]

	if toastId then
		GameFacade.showToast(toastId)
	end
end

function RougeMapSkillCheckHelper._initSkillUseChcekFuncList()
	RougeMapSkillCheckHelper._checkFuncList = RougeMapSkillCheckHelper._checkFuncList or {
		RougeMapSkillCheckHelper.checkDoineEvent,
		RougeMapSkillCheckHelper.checkMiddleLayer,
		RougeMapSkillCheckHelper.checkPathSelectLayer,
		RougeMapSkillCheckHelper.checkUseLimiter,
		RougeMapSkillCheckHelper.checkStepCd,
		RougeMapSkillCheckHelper.checkCoinCost,
		RougeMapSkillCheckHelper.checkPowerCost
	}
end

function RougeMapSkillCheckHelper.checkDoineEvent(skillMo, skillCo)
	local isNormalLayer = RougeMapModel.instance:isNormalLayer()

	if isNormalLayer then
		local curNode = RougeMapModel.instance:getCurNode()

		if curNode and curNode:checkIsNormal() and not curNode:isFinishEvent() then
			return RougeMapSkillCheckHelper.CantUseMapSkillReason.DoingEvent
		end
	end
end

function RougeMapSkillCheckHelper.checkMiddleLayer(skillMo, skillCo)
	local middleLayerLimit = skillCo.middleLayerLimit == 0
	local isMiddle = RougeMapModel.instance:isMiddle()

	if middleLayerLimit and isMiddle then
		return RougeMapSkillCheckHelper.CantUseMapSkillReason.ForbidenMiddle
	end
end

function RougeMapSkillCheckHelper.checkPathSelectLayer(skillMo, skillCo)
	local middleLayerLimit = skillCo.middleLayerLimit == 0
	local isPathSelect = RougeMapModel.instance:isPathSelect()

	if middleLayerLimit and isPathSelect then
		return RougeMapSkillCheckHelper.CantUseMapSkillReason.ForbidenPathSelect
	end
end

function RougeMapSkillCheckHelper.checkUseLimiter(skillMo, skillCo)
	if skillMo:getUseCount() >= skillCo.useLimit then
		return RougeMapSkillCheckHelper.CantUseMapSkillReason.UseLimit
	end
end

function RougeMapSkillCheckHelper.checkStepCd(skillMo, skillCo)
	if skillMo:getStepRecord() >= skillCo.stepCd then
		return RougeMapSkillCheckHelper.CantUseMapSkillReason.StepCd
	end
end

function RougeMapSkillCheckHelper.checkCoinCost(skillMo, skillCo)
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if rougeInfo then
		if not rougeInfo.coin then
			local coin = 0

			if coin < skillCo.coinCost then
				return RougeMapSkillCheckHelper.CantUseMapSkillReason.CoinCost
			end
		end
	end
end

function RougeMapSkillCheckHelper.checkPowerCost(skillMo, skillCo)
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if rougeInfo then
		if not rougeInfo.power then
			local power = 0

			if power < skillCo.powerCost then
				return RougeMapSkillCheckHelper.CantUseMapSkillReason.PowerCost
			end
		end
	end
end

function RougeMapSkillCheckHelper._initUseMapSkillCallBackMap()
	RougeMapSkillCheckHelper._mapSkillUseCallBackMap = RougeMapSkillCheckHelper._mapSkillUseCallBackMap or {
		[13002] = RougeMapSkillCheckHelper.useMapSkill_13002
	}
end

function RougeMapSkillCheckHelper.executeUseMapSkillCallBack(skillMo)
	if not skillMo then
		return
	end

	RougeMapSkillCheckHelper._initUseMapSkillCallBackMap()

	local callback = RougeMapSkillCheckHelper._mapSkillUseCallBackMap[skillMo.id]

	if callback then
		callback(skillMo)
	end
end

local function collectUnTreasurePlaceNode(curNodeId, visitNodeIdMap, unTreasureNodeList)
	local curNode = RougeMapModel.instance:getNode(curNodeId)

	if curNode and not curNode:checkIsEnd() then
		local nextNodeList = curNode.nextNodeList

		if nextNodeList then
			for _, nodeId in ipairs(nextNodeList) do
				local nodeMo = RougeMapModel.instance:getNode(nodeId)
				local eventCo = nodeMo and nodeMo:getEventCo()
				local isTreasurePlace = eventCo and eventCo.type == RougeMapEnum.EventType.TreasurePlace

				if nodeMo and not nodeMo:checkIsEnd() and not isTreasurePlace and not visitNodeIdMap[nodeId] then
					visitNodeIdMap[nodeId] = true

					table.insert(unTreasureNodeList, nodeId)
				end

				collectUnTreasurePlaceNode(nodeId, visitNodeIdMap, unTreasureNodeList)
			end
		end
	end
end

function RougeMapSkillCheckHelper.useMapSkill_13002(skillMo, skillCo)
	local isNormalLayer = RougeMapModel.instance:isNormalLayer()

	if isNormalLayer then
		local curNode = RougeMapModel.instance:getCurNode()
		local visitNodeIdMap = {}
		local unTreasureNodeList = {}
		local curNodeId = curNode and curNode.nodeId

		collectUnTreasurePlaceNode(curNodeId, visitNodeIdMap, unTreasureNodeList)

		local canVisitUnTreasureNodeNum = #unTreasureNodeList

		if canVisitUnTreasureNodeNum < 2 then
			GameFacade.showToast(ToastEnum.UseMapSkillLimit_13002)
		end
	end
end

return RougeMapSkillCheckHelper
