-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_SettlementTriggerHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_SettlementTriggerHelper", package.seeall)

local Rouge2_SettlementTriggerHelper = class("Rouge2_SettlementTriggerHelper")

function Rouge2_SettlementTriggerHelper.getTriggerConfigByType(type)
	local resultCfgs = lua_rouge2_result.configList
	local configList = {}

	if resultCfgs then
		for _, resultCfg in ipairs(resultCfgs) do
			local cfgType = resultCfg.type

			if cfgType == type then
				table.insert(configList, resultCfg)
			end
		end
	end

	table.sort(configList, Rouge2_SettlementTriggerHelper.configSortFunction)

	return configList
end

function Rouge2_SettlementTriggerHelper.refreshEndingDesc(reviewInfo)
	local isSucc = reviewInfo:isSucceed()
	local desc = ""

	if isSucc then
		local endingId = reviewInfo.endId
		local endingCfg = Rouge2_Config.instance:getEndingCO(endingId)

		desc = endingCfg and endingCfg.desc
	else
		local layerId = reviewInfo.layerId
		local middleLayerId = reviewInfo.middleLayerId
		local isInMiddleLayer = reviewInfo:isInMiddleLayer()
		local finalStepLayerName = ""

		if isInMiddleLayer then
			local middleLayerCfg = lua_rouge2_middle_layer.configDict[middleLayerId]

			finalStepLayerName = middleLayerCfg and middleLayerCfg.name
		else
			local layerCfg = lua_rouge2_layer.configDict[layerId]

			finalStepLayerName = layerCfg and layerCfg.name
		end

		desc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_resultreportview_txt_dec_end"), finalStepLayerName)
	end

	return desc
end

function Rouge2_SettlementTriggerHelper.tryFilterTrigger(resultCfg)
	if not resultCfg then
		return nil
	end

	local values = {
		Rouge2_SettlementTriggerHelper.isResultTrigger(resultCfg.trigger, unpack((not string.nilorempty(resultCfg.triggerParam) or nil) and string.splitToNumber(resultCfg.triggerParam, "#")))
	}
	local isTrigger = values and values[1] ~= nil
	local isDefaultVisible = Rouge2_SettlementTriggerHelper.checkIsTriggerDefaultVisible(resultCfg)

	if isTrigger or isDefaultVisible then
		return (GameUtil.getSubPlaceholderLuaLang(resultCfg.desc, values))
	end

	return nil
end

function Rouge2_SettlementTriggerHelper.checkIsTriggerDefaultVisible(triggerCfg)
	return triggerCfg and triggerCfg.priority == 0
end

function Rouge2_SettlementTriggerHelper.configSortFunction(a, b)
	local aPriority = a.priority
	local bPriority = b.priority

	if aPriority ~= bPriority then
		return aPriority < bPriority
	end

	return a.id < b.id
end

function Rouge2_SettlementTriggerHelper.isResultTrigger(triggerType, ...)
	local func = Rouge2_SettlementTriggerHelper["triggerType" .. triggerType]

	if not func then
		logError("未处理当前触发类型, 触发类型 = " .. tostring(triggerType))

		return
	end

	return func(...)
end

function Rouge2_SettlementTriggerHelper.triggerType1()
	local rougeInfo = Rouge2_Model.instance:getRougeInfo()
	local difficultyCfg = lua_rouge2_difficulty.configDict[rougeInfo.difficulty]

	return difficultyCfg and difficultyCfg.title
end

function Rouge2_SettlementTriggerHelper.triggerType2()
	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local drugId = resultInfo.reviewInfo.drugId

	if drugId == nil or drugId == 0 then
		return nil
	end

	local dragConfig = lua_rouge2_formula.configDict[drugId]

	if dragConfig == nil then
		logError("不存在的配方id:" .. tostring(drugId))
	end

	return dragConfig.name
end

function Rouge2_SettlementTriggerHelper.triggerType3()
	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local careerId = resultInfo.reviewInfo.mainCareer
	local careerConfig = lua_rouge2_career.configDict[careerId]

	if careerConfig == nil then
		logError("不存在的职业id:" .. tostring(careerId))
	end

	return careerConfig.name
end

function Rouge2_SettlementTriggerHelper.triggerType4()
	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local mainCareerId = resultInfo.reviewInfo.mainCareer
	local curCareerId = resultInfo.reviewInfo.curCareer

	if mainCareerId == curCareerId then
		return nil
	end

	local careerConfig = lua_rouge2_career.configDict[curCareerId]

	if careerConfig == nil then
		logError("不存在的职业id:" .. tostring(curCareerId))
	end

	return careerConfig.name
end

function Rouge2_SettlementTriggerHelper.triggerType5(endType)
	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local isSucc = resultInfo:isSucceed()

	if isSucc then
		if not Rouge2_OutsideEnum.FinishEnum.Finish then
			local curState = Rouge2_OutsideEnum.FinishEnum.Fail

			if endType ~= curState then
				return nil
			end

			local heroIds = resultInfo.endHeroId

			if heroIds == nil or #heroIds == 0 then
				return nil
			end

			return Rouge2_SettlementTriggerHelper.getAllEndHeroNames(heroIds)
		end
	end
end

function Rouge2_SettlementTriggerHelper.triggerType6()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	if resultInfo.attributeCheckTotalCount <= 0 then
		return nil
	end

	local successCount = resultInfo.attributeCheckSuccessCount
	local maxUseAttributeId = resultInfo.attributeCheckMaxId
	local attributeConfig = Rouge2_AttributeConfig.instance:getAttributeConfig(maxUseAttributeId)

	if not attributeConfig then
		logError("没有找到检视属性 id:" .. tostring(maxUseAttributeId))

		return nil
	end

	return resultInfo.attributeCheckTotalCount, successCount, attributeConfig.name
end

function Rouge2_SettlementTriggerHelper.triggerType7()
	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local nodeCount = resultInfo.stepNum
	local coinCount = resultInfo.gainCoin

	return nodeCount, coinCount
end

function Rouge2_SettlementTriggerHelper.triggerType13(endId)
	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local reviewInfo = resultInfo and resultInfo.reviewInfo
	local finishEndId = reviewInfo and reviewInfo.endId

	if finishEndId == endId then
		return finishEndId
	end
end

function Rouge2_SettlementTriggerHelper.triggerType14(endId)
	local failEndId = Rouge2_MapModel.instance:getEndId()
	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local isSucc = resultInfo:isSucceed()

	if not isSucc and failEndId == endId then
		return failEndId
	end
end

function Rouge2_SettlementTriggerHelper.triggerType15()
	local isAbort = Rouge2_Model.instance:isAbortRouge()

	if isAbort then
		return
	end

	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local failEndId = Rouge2_MapModel.instance:getEndId()
	local isSucc = resultInfo:isSucceed()
	local isNormalFight = not isSucc and (not failEndId or failEndId <= 0)
	local eventCo = Rouge2_MapModel.instance:getCurEvent()

	if not eventCo then
		return
	end

	local eventName = eventCo.name

	if isNormalFight then
		return eventName
	end
end

function Rouge2_SettlementTriggerHelper.triggerType16()
	local isAbort = Rouge2_Model.instance:isAbortRouge()

	if isAbort then
		return "abort"
	end
end

function Rouge2_SettlementTriggerHelper.triggerType17()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	if resultInfo.attributeCheckTotalCount > 0 then
		return nil
	end

	return 0, 0
end

function Rouge2_SettlementTriggerHelper.getAllEndHeroNames(endHeroIds)
	local heroNameList = {}

	if endHeroIds then
		for _, heroId in ipairs(endHeroIds) do
			local heroCfg = HeroConfig.instance:getHeroCO(heroId)
			local heroName = heroCfg and heroCfg.name

			if heroName then
				table.insert(heroNameList, heroName)
			end
		end
	end

	return (table.concat(heroNameList, luaLang("room_levelup_init_and1")))
end

function Rouge2_SettlementTriggerHelper._getTotalTeamExp(season, curTeamLv, curTeamExp)
	if not season then
		return 0
	end

	curTeamLv = curTeamLv or 0
	curTeamExp = curTeamExp or 0

	local seasonTeamCfgs = lua_rouge_level.configDict[season]
	local totalTeamExp = 0

	for i = 1, curTeamLv do
		local lvCfg = seasonTeamCfgs and seasonTeamCfgs[i]

		if lvCfg then
			if not lvCfg.exp then
				local teamExp = 0

				totalTeamExp = totalTeamExp + teamExp
			end
		end
	end

	totalTeamExp = totalTeamExp + curTeamExp

	return totalTeamExp
end

return Rouge2_SettlementTriggerHelper
