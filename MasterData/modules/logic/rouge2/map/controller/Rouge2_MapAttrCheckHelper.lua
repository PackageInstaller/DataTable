-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapAttrCheckHelper.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapAttrCheckHelper", package.seeall)

local Rouge2_MapAttrCheckHelper = class("Rouge2_MapAttrCheckHelper")

function Rouge2_MapAttrCheckHelper.triggerCheckResult()
	if not Rouge2_MapAttrCheckHelper.isAttrCheckInteract() then
		return
	end

	local checkResInfo = Rouge2_MapAttrCheckHelper.buildCurCheckResInfoMO()

	if not checkResInfo then
		return
	end

	local checkType = Rouge2_MapEnum.AttrCheckType.ActiveRandom

	Rouge2_MapAttrCheckHelper._initInteractHandle()

	local handle = Rouge2_MapAttrCheckHelper.handleDict[checkType]

	if not handle then
		logError("not found interact type .. " .. tostring(checkType))

		return
	end

	handle(checkResInfo)
end

function Rouge2_MapAttrCheckHelper._initInteractHandle()
	Rouge2_MapAttrCheckHelper.handleDict = Rouge2_MapAttrCheckHelper.handleDict or {
		[Rouge2_MapEnum.AttrCheckType.ActiveRandom] = Rouge2_MapAttrCheckHelper.handleActiveRandom,
		[Rouge2_MapEnum.AttrCheckType.MiniGame] = Rouge2_MapAttrCheckHelper.handleMiniGame
	}
end

function Rouge2_MapAttrCheckHelper.handleActiveRandom(checkResInfo)
	logNormal("主动属性检定")

	local params = {
		checkResInfo = checkResInfo
	}

	Rouge2_PopController.instance:addPopViewWithViewName(ViewName.Rouge2_MapDiceView, params)
end

function Rouge2_MapAttrCheckHelper.handleMiniGame(checkResInfo)
	logNormal("属性小游戏")
end

function Rouge2_MapAttrCheckHelper.formatCheckRate(checkRate)
	return string.format("%s%%", math.ceil(checkRate / 10))
end

function Rouge2_MapAttrCheckHelper.isChoiceAttrThreshold(choiceId)
	local choiceCo = Rouge2_MapConfig.instance:getChoiceConfig(choiceId)
	local attrThreshold = choiceCo and choiceCo.attributeThreshold

	if string.nilorempty(attrThreshold) then
		return
	end

	local attrThresholdList = GameUtil.splitString2(attrThreshold, true)

	for _, thresholdInfo in ipairs(attrThresholdList) do
		local attrId = thresholdInfo[1]
		local thresholdValue = thresholdInfo[2]
		local curAttrValue = Rouge2_Model.instance:getAttrValue(attrId)

		if curAttrValue < thresholdValue then
			return
		end
	end

	return true
end

function Rouge2_MapAttrCheckHelper.getRediceCostNum(checkId, rediceNum)
	local checkCo = Rouge2_CareerConfig.instance:getDiceCheckConfig(checkId, Rouge2_MapEnum.AttrCheckResult.Failure)
	local retryCostStr = checkCo and checkCo.retryCost

	if string.nilorempty(retryCostStr) then
		return 0
	end

	local retryCostList = string.splitToNumber(retryCostStr, "#")

	if retryCostList then
		if not retryCostList[1] then
			local baseRetryCost = 0

			if retryCostList then
				if not retryCostList[2] then
					local stepRetryCost = 0

					return baseRetryCost + (rediceNum - 1) * stepRetryCost
				end
			end
		end
	end
end

function Rouge2_MapAttrCheckHelper.isAttrCheckInteract()
	local cutInteract = Rouge2_MapModel.instance:getCurInteractive()
	local curInteractType = Rouge2_MapModel.instance:getCurInteractType()

	return not string.nilorempty(cutInteract) and curInteractType == Rouge2_MapEnum.InteractType.Dice
end

function Rouge2_MapAttrCheckHelper.buildCurCheckResInfoMO()
	local curInteract = Rouge2_MapModel.instance:getCurInteractiveJson()
	local checkResInfo = Rouge2_DiceCheckResInfoMO.New()

	checkResInfo:init(curInteract)

	return checkResInfo
end

function Rouge2_MapAttrCheckHelper.endCheck(callback, callbackObj)
	if not Rouge2_MapAttrCheckHelper.isAttrCheckInteract() then
		ViewMgr.instance:closeView(ViewName.Rouge2_MapDiceView)

		return
	end

	return Rouge2_Rpc.instance:sendRouge2EndCheckRequest(callback, callbackObj)
end

return Rouge2_MapAttrCheckHelper
