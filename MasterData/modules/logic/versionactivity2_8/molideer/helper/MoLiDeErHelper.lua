-- chunkname: @modules/logic/versionactivity2_8/molideer/helper/MoLiDeErHelper.lua

module("modules.logic.versionactivity2_8.molideer.helper.MoLiDeErHelper", package.seeall)

local MoLiDeErHelper = {}

MoLiDeErHelper.OptionConditionDic = {
	[MoLiDeErEnum.OptionConditionType.Team] = MoLiDeErHelper.checkTeamValid,
	[MoLiDeErEnum.OptionConditionType.Item] = MoLiDeErHelper.checkItemValid
}

function MoLiDeErHelper.isTeamBuffed(optionId, teamId)
	local teamConfig = MoLiDeErConfig.instance:getTeamConfig(teamId)

	if teamConfig == nil then
		return false
	end

	local optionConditionDic = MoLiDeErConfig.instance:getOptionCondition(optionId, MoLiDeErEnum.OptionConditionType.Team)

	if optionConditionDic ~= nil then
		return optionConditionDic[teamId] ~= nil
	end

	local optionConfig = MoLiDeErConfig.instance:getOptionConfig(optionId)

	if not string.nilorempty(optionConfig.effect) then
		local buffId = tonumber(teamConfig.buffId)

		if buffId == nil or buffId == 0 then
			return false
		end

		local teamBuffConfig = MoLiDeErConfig.instance:getBuffConfig(buffId)

		if string.nilorempty(teamBuffConfig.effectDesc) then
			return false
		end

		local buffEffectData = string.splitToNumber(teamBuffConfig.effectType, "#")
		local buffType = buffEffectData[1]
		local buffValue = buffEffectData[2]
		local params = string.split(optionConfig.effect, "|")

		for _, param in ipairs(params) do
			local data = string.splitToNumber(param, "#")
			local type = data[1]
			local baseCost = data[#data]

			if type == MoLiDeErEnum.OptionEffectType.Round and baseCost > 0 and (buffType == MoLiDeErEnum.RoundBuffType.Fixed or buffType == MoLiDeErEnum.RoundBuffType.Percent) and buffValue < 0 then
				return true
			elseif type == MoLiDeErEnum.OptionEffectType.Execution and baseCost < 0 and (buffType == MoLiDeErEnum.ExecutionBuffType.Fixed or buffType == MoLiDeErEnum.ExecutionBuffType.Percent) and buffValue < 0 then
				return true
			end
		end
	end

	return false
end

function MoLiDeErHelper.isTeamEnable(optionId, teamId)
	local optionConditionDic = MoLiDeErConfig.instance:getOptionCondition(optionId, MoLiDeErEnum.OptionConditionType.Team)

	if optionConditionDic == nil then
		return true
	end

	return optionConditionDic[teamId] ~= nil
end

function MoLiDeErHelper.handleImage(param)
	local imgTr = param.imgTransform
	local offsetParam = param.offsetParam

	ZProj.UGUIHelper.SetImageSize(imgTr.gameObject)

	if string.nilorempty(offsetParam) then
		return
	end

	local data = string.splitToNumber(offsetParam, "#")

	if not data[1] then
		if not data[2] then
			local scaleY = 1

			if not data[3] then
				local offsetX = 0

				if not data[4] then
					local offsetY = 0

					transformhelper.setLocalScale(imgTr, data[1], scaleY, 1)
					recthelper.setAnchor(imgTr, offsetX, offsetY)
				end
			end
		end
	end
end

function MoLiDeErHelper.getExecutionCostStr(cost)
	return (cost ~= 0 or nil) and (cost > 0 and string.format("+%s", math.abs(cost)) or string.format("-%s", math.abs(cost)))
end

function MoLiDeErHelper.getGameRoundTitleDesc(curRound, maxRound)
	local desc = curRound <= 9 and "0" .. tostring(curRound) or tostring(curRound)

	if maxRound ~= nil then
		local maxDesc = maxRound <= 9 and "0" .. tostring(maxRound) or tostring(maxRound)

		desc = string.format("%s/%s", desc, maxDesc)
	end

	return desc
end

function MoLiDeErHelper.getOptionRestrictionParamList(optionId)
	local optionConfig = MoLiDeErConfig.instance:getOptionConfig(optionId)
	local valueList = {}

	if not string.nilorempty(optionConfig.optionRestriction) then
		local data = string.splitToNumber(optionConfig.optionRestriction, "#")
		local type = data[1]

		if type == MoLiDeErEnum.OptionRestrictionType.Team then
			for i = 2, #data do
				local teamConfig = MoLiDeErConfig.instance:getTeamConfig(data[i])

				table.insert(valueList, teamConfig.name)
			end
		elseif type == MoLiDeErEnum.OptionRestrictionType.Item then
			for i = 2, #data do
				local itemConfig = MoLiDeErConfig.instance:getItemConfig(data[i])

				table.insert(valueList, itemConfig.name)
			end
		end
	end

	return valueList
end

function MoLiDeErHelper.getOptionEffectParamList(optionId, teamId)
	local optionConfig = MoLiDeErConfig.instance:getOptionConfig(optionId)
	local valueList = {}

	if not string.nilorempty(optionConfig.effect) then
		local params = string.split(optionConfig.effect, "|")

		for _, param in ipairs(params) do
			local data = string.splitToNumber(param, "#")
			local type = data[1]
			local baseCost = data[#data]

			if type == MoLiDeErEnum.OptionEffectType.Round then
				local finalCost = MoLiDeErGameModel.instance:getRoundCost(baseCost, teamId)

				table.insert(valueList, tostring(finalCost))
			elseif type == MoLiDeErEnum.OptionEffectType.Execution then
				local finalCost = MoLiDeErGameModel.instance:getExecutionCost(baseCost, teamId)

				table.insert(valueList, MoLiDeErHelper.getExecutionCostStr(finalCost))
			elseif type == MoLiDeErEnum.OptionEffectType.Team then
				local teamConfig = MoLiDeErConfig.instance:getTeamConfig(data[#data])

				table.insert(valueList, teamConfig.name)
			elseif type == MoLiDeErEnum.OptionEffectType.Item then
				local itemConfig = MoLiDeErConfig.instance:getItemConfig(data[#data])

				table.insert(valueList, itemConfig.name)
			end
		end
	end

	return valueList
end

function MoLiDeErHelper.getOptionResultEffectParamList(optionResultId)
	local optionResultConfig = MoLiDeErConfig.instance:getOptionResultConfig(optionResultId)
	local valueList = {}

	if not string.nilorempty(optionResultConfig.effect) then
		local params = string.split(optionResultConfig.effect, "|")

		for _, param in ipairs(params) do
			local data = string.splitToNumber(param, "#")
			local type = data[1]
			local baseCost = data[#data]

			if type == MoLiDeErEnum.OptionEffectType.Round then
				table.insert(valueList, tostring(baseCost))
			elseif type == MoLiDeErEnum.OptionEffectType.Execution then
				table.insert(valueList, MoLiDeErHelper.getExecutionCostStr(baseCost))
			elseif type == MoLiDeErEnum.OptionEffectType.Team then
				local teamConfig = MoLiDeErConfig.instance:getTeamConfig(data[#data])

				table.insert(valueList, teamConfig.name)
			elseif type == MoLiDeErEnum.OptionEffectType.Item then
				local itemConfig = MoLiDeErConfig.instance:getItemConfig(data[#data])

				table.insert(valueList, itemConfig.name)
			end
		end
	end

	return valueList
end

function MoLiDeErHelper.getRealRound(baseRound, isMain)
	local gameInfoMo = MoLiDeErGameModel.instance:getCurGameInfo()

	if gameInfoMo == nil then
		return baseRound
	end

	local buffIds = gameInfoMo.itemBuffIds

	if buffIds and buffIds[1] then
		for _, buffId in ipairs(buffIds) do
			local buffConfig = MoLiDeErConfig.instance:getBuffConfig(buffId)
			local gameId = MoLiDeErGameModel.instance:getCurGameId()

			if not string.nilorempty(buffConfig.effectType) then
				local data = string.splitToNumber(buffConfig.effectType, "#")
				local type = data[1]

				if type == MoLiDeErEnum.ItemBuffType.MainRoundAdd and isMain or type == MoLiDeErEnum.ItemBuffType.ExtraRoundAdd and not isMain then
					for i = 3, #data do
						local buffedGameId = data[i]

						if buffedGameId == gameId then
							baseRound = baseRound + data[2]

							break
						end
					end
				end
			end
		end
	end

	return baseRound
end

function MoLiDeErHelper.checkIsInSamePosition(posParamA, posParamB)
	return posParamA[1] == posParamB[1] and posParamA[2] == posParamB[2]
end

function MoLiDeErHelper.getRangeDesc(value, rangeParam, descParam)
	local rangeData = string.splitToNumber(rangeParam, "#")
	local descData = string.split(descParam, "#")

	for i = #rangeData, 1, -1 do
		if value >= rangeData[i] then
			if descData[i] then
				return descData[i], i
			else
				logError("莫莉德尔 角色活动 范围 " .. tostring(i) .. "里没有合适的描述")
			end
		end
	end

	logError("莫莉德尔 角色活动 目标 没有合适的描述")

	return descData[1], 1
end

function MoLiDeErHelper.getPreEventId(eventId)
	local config = MoLiDeErConfig.instance:getEventConfig(eventId)

	if string.nilorempty(config.trigger) then
		return 0
	end

	local params = string.split(config.trigger, "|")
	local curInfo = MoLiDeErGameModel.instance:getCurGameInfo()

	if curInfo == nil then
		return 0
	end

	for _, param in ipairs(params) do
		local data = string.splitToNumber(param, "#")

		if data[1] == 2 and data[2] == 0 then
			for _, eventInfo in ipairs(curInfo.newFinishEventList) do
				if eventInfo.optionId == data[3] then
					return eventInfo.finishedEventId or 0
				end
			end
		end
	end

	return 0
end

function MoLiDeErHelper.getTargetState(progressValue)
	if progressValue <= MoLiDeErEnum.ProgressRange.Failed then
		return MoLiDeErEnum.ProgressChangeType.Failed
	elseif progressValue >= MoLiDeErEnum.ProgressRange.Success then
		return MoLiDeErEnum.ProgressChangeType.Success
	else
		return MoLiDeErEnum.ProgressChangeType.Percentage
	end
end

function MoLiDeErHelper.getTargetTitleByProgress(progressValue, desc)
	local state = MoLiDeErHelper.getTargetState(progressValue)
	local color = MoLiDeErEnum.TargetDescColor[state]

	if state == MoLiDeErEnum.ProgressChangeType.Failed then
		desc = string.format("<s>%s</s>", desc)
	end

	return string.format("<color=%s>%s</color>", color, desc)
end

function MoLiDeErHelper.isOptionCanChose(optionId)
	local gameInfoMo = MoLiDeErGameModel.instance:getCurGameInfo()
	local teamInfo = gameInfoMo.teamInfos
	local canSelectCount = 0

	if gameInfoMo.teamInfos == nil or gameInfoMo.teamInfos[1] == nil then
		return false
	end

	for _, info in ipairs(teamInfo) do
		local canSelect = MoLiDeErHelper.isTeamCanChose(gameInfoMo, info, optionId)

		if canSelect then
			canSelectCount = canSelectCount + 1
		end
	end

	if canSelectCount <= 0 then
		return false
	end

	local optionConfig = MoLiDeErConfig.instance:getOptionConfig(optionId)
	local effectDataList = string.split(optionConfig.effect, "|")
	local notEnoughCount = 0

	for _, data in ipairs(effectDataList) do
		local effectData = string.splitToNumber(data, "#")
		local type = effectData[1]

		if type == MoLiDeErEnum.OptionEffectType.Item then
			local changeCount = effectData[2]
			local itemId = effectData[3]
			local itemInfo = gameInfoMo:getEquipInfo(itemId)

			if itemInfo == nil or itemInfo.quantity + changeCount < 0 then
				notEnoughCount = notEnoughCount + 1
			end
		elseif type == MoLiDeErEnum.OptionEffectType.Team then
			local teamId = effectData[3]
			local changeCount = effectData[2]
			local needTeamInfo = gameInfoMo:getTeamInfo(teamId)

			if changeCount < 0 and needTeamInfo == nil then
				notEnoughCount = notEnoughCount + 1
			end
		end
	end

	return notEnoughCount <= 0
end

function MoLiDeErHelper.isTeamCanChose(gameInfoMo, info, optionId)
	local teamId = info.teamId
	local canDispatch = gameInfoMo:canDispatchTeam(teamId)

	if canDispatch == false then
		return false, ToastEnum.Act194CurrentTeamDispatching
	end

	if info.roundActionTime <= 0 then
		return false, ToastEnum.Act194TeamCanNotAction
	end

	if info.roundActedTime >= info.roundActionTime then
		return false, ToastEnum.Act194CurrentTeamActTimesNotMatch
	end

	local eventId = MoLiDeErGameModel.instance:getSelectEventId()

	if optionId and not MoLiDeErHelper.isTeamEnable(optionId, teamId) then
		return false, ToastEnum.Act194CurrentTeamNotMatchCondition
	end

	local cost = MoLiDeErGameModel.instance:getExecutionCostById(eventId, optionId, teamId)

	if cost + gameInfoMo.leftRoundEnergy < 0 then
		return false, ToastEnum.Act194ExecutionNotEnough
	end

	return true
end

function MoLiDeErHelper.calculateExecutionCost(buffId, baseCost, percentBuff, teamId, specifiedType)
	local buffConfig = MoLiDeErConfig.instance:getBuffConfig(buffId)

	if buffConfig.buffType == MoLiDeErEnum.BuffType.Forever or buffConfig.buffType == MoLiDeErEnum.BuffType.Passive then
		local data = string.splitToNumber(buffConfig.effectType, "#")
		local type = data[1]

		if specifiedType == nil or type == specifiedType then
			if type == MoLiDeErEnum.ExecutionBuffType.Fixed then
				baseCost = baseCost + data[2]
			elseif type == MoLiDeErEnum.ExecutionBuffType.Percent then
				table.insert(percentBuff, data[2])
			elseif type == MoLiDeErEnum.ExecutionBuffType.FixedOther and teamId then
				for i = 3, #data do
					if data[i] == teamId then
						baseCost = baseCost + data[2]

						break
					end
				end
			end
		end
	end

	return baseCost
end

function MoLiDeErHelper.calculateRoundCost(buffId, baseCost, percentBuff, teamId, specifiedType)
	local buffConfig = MoLiDeErConfig.instance:getBuffConfig(buffId)

	if buffConfig.buffType == MoLiDeErEnum.BuffType.Forever or buffConfig.buffType == MoLiDeErEnum.BuffType.Passive then
		local data = string.splitToNumber(buffConfig.effectType, "#")
		local type = data[1]

		if specifiedType == nil or type == specifiedType then
			if type == MoLiDeErEnum.RoundBuffType.Fixed then
				baseCost = math.max(0, baseCost + data[2])
			elseif type == MoLiDeErEnum.RoundBuffType.Percent then
				table.insert(percentBuff, data[2])
			elseif type == MoLiDeErEnum.RoundBuffType.FixedOther and teamId then
				for i = 3, #data do
					if data[i] == teamId then
						baseCost = math.max(0, baseCost + data[2])

						break
					end
				end
			end
		end
	end

	return baseCost
end

function MoLiDeErHelper.getOptionItemCost(optionId)
	local optionConfig = MoLiDeErConfig.instance:getOptionConfig(optionId)
	local result = {}

	if optionConfig == nil then
		return nil
	end

	if string.nilorempty(optionConfig.effect) then
		return nil
	end

	local params = string.split(optionConfig.effect, "|")

	for _, param in ipairs(params) do
		local data = string.splitToNumber(param, "#")

		if data[1] == MoLiDeErEnum.OptionEffectType.Item then
			table.insert(result, data)
		end
	end

	return result
end

return MoLiDeErHelper
