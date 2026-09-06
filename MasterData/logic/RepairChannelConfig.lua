-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/repairchannel/config/RepairChannelConfig.lua

module("logic.extensions.repairchannel.config.RepairChannelConfig", package.seeall)

local RepairChannelConfig = class("RepairChannelConfig", BaseConfig)

function RepairChannelConfig:onInit()
	RepairChannelConfig.super.onInit(self)

	self._conditionDescMap = {}
	self._conditionParamsMap = {}
	self._conditionSortCheckFuncMap = {}
end

function RepairChannelConfig:getNames()
	return {
		"repair_channel_condition",
		"repair_channel_node",
		"repair_channel_activity"
	}
end

function RepairChannelConfig:handleConfig(name, content)
	if name == "repair_channel_condition" then
		self._repair_channel_condition = content
	elseif name == "repair_channel_node" then
		self._repair_channel_node = content

		self:_handleInsertNodeCfgs(content)
	elseif name == "repair_channel_activity" then
		self._repair_channel_activity = content
	end
end

function RepairChannelConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function RepairChannelConfig:getActCfgByActId(activityId)
	return self:_safeGet(self._repair_channel_activity, activityId)
end

function RepairChannelConfig:getBranchCountByActId(activityId)
	local nodeCfgList = self:getNodeCfgListByActId(activityId)

	if not nodeCfgList then
		return 0
	end

	local branchIds = {}

	for _, nodeCfg in ipairs(nodeCfgList) do
		branchIds[nodeCfg.branchId] = true
	end

	local count = 0

	for _ in pairs(branchIds) do
		count = count + 1
	end

	return count
end

function RepairChannelConfig:getNodeCfgsByBranchId(activityId, branchId)
	return self:_safeGet(self._repair_channel_node, activityId, branchId)
end

function RepairChannelConfig:getNodeCfgByNodeId(activityId, branchId, nodeId)
	return self:_safeGet(self._repair_channel_node, activityId, branchId, nodeId)
end

function RepairChannelConfig:_handleInsertNodeCfgs(content)
	self._nodeCfgListByActId = {}

	local temList = {}

	for _, v in ipairs(content.dataList) do
		local activityId = v.activityId

		if not temList[activityId] then
			table.insert(temList[activityId], v)

			temList[activityId] = temList[activityId]
		end
	end

	for activityId, nodeCfgList in pairs(temList) do
		table.sort(nodeCfgList, function(a, b)
			if a.branchId == b.branchId then
				return a.nodeId < b.nodeId
			else
				return a.branchId < b.branchId
			end
		end)
	end

	self._nodeCfgListByActId = temList
end

function RepairChannelConfig:getNodeCfgListByActId(activityId)
	return self:_safeGet(self._nodeCfgListByActId, activityId)
end

function RepairChannelConfig:getConditionCfgById(conditionId)
	return self:_safeGet(self._repair_channel_condition, conditionId)
end

function RepairChannelConfig:getConditionPetCountById(conditionId)
	local conditionCfg = self:getConditionCfgById(conditionId)

	return (conditionCfg or nil) and (conditionCfg.requirement or 0)
end

function RepairChannelConfig:getConditionParamsById(conditionId)
	local params = self._conditionParamsMap[conditionId]

	if not params then
		params = {}

		local conditionCfg = self:getConditionCfgById(conditionId)

		if conditionCfg then
			if not conditionCfg.petValidator then
				local petValidator = ""
				local paramList = string.split(petValidator, "$")

				if #paramList == 2 then
					table.insert(params, paramList[1])

					local subParams = string.split(paramList[2], ",")

					for _, subParam in ipairs(subParams) do
						table.insert(params, subParam)
					end
				else
					printError("前端暂时不支持修复通道条件配置的petValidator字段格式，conditionId=%s, petValidator=%s", conditionId, petValidator)
				end
			end
		end

		self._conditionParamsMap[conditionId] = params
	end

	return self._conditionParamsMap[conditionId]
end

function RepairChannelConfig:getConditionDescById(conditionId)
	local desc = self._conditionDescMap[conditionId]

	if not desc then
		desc = ""

		local conditionCfg = self:getConditionCfgById(conditionId)

		if conditionCfg then
			if not conditionCfg.requireDesc then
				local descPre = ""

				if conditionCfg then
					if not conditionCfg.requirement then
						local petCount = 0
						local params = self:getConditionParamsById(conditionId)

						if #params > 0 then
							local validatorType = params[1]

							if validatorType == "Job" then
								desc = langPara(descPre, petCount, ConstString.JobIdxToStr[GameEnum.JobZh[params[2]]])
							elseif validatorType == "RaceType" then
								desc = langPara(descPre, petCount, ConstString.RaceIdToTxt[GameEnum.Races[params[2]]])
							elseif validatorType == "AwakenLevel" then
								desc = langPara(descPre, petCount, params[#params])
							elseif validatorType == "Race" then
								local raceId = checknumber(params[2])
								local petCo = CharacterConfig.instance:getPetCo(raceId)

								if petCo then
									if not petCo.name then
										local petName = ""

										desc = langPara(descPre, petCount, petName)
									end
								end
							end
						end

						self._conditionDescMap[conditionId] = desc
					end
				end
			end
		end
	end

	return self._conditionDescMap[conditionId]
end

function RepairChannelConfig:getConditionSortCheckFuncById(conditionId)
	local func = self._conditionSortCheckFuncMap[conditionId]

	if not func then
		function func(petMo)
			return true
		end

		local params = self:getConditionParamsById(conditionId)

		if #params > 0 then
			local validatorType = params[1]

			if validatorType == "Job" then
				function func(petMo)
					if not petMo then
						return false
					end

					return (PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.JobZh[params[2]]))
				end
			elseif validatorType == "RaceType" then
				function func(petMo)
					if not petMo then
						return false
					end

					return (petMo:checkHasRace(params[2]))
				end
			elseif validatorType == "AwakenLevel" then
				function func(petMo)
					if not petMo then
						return false
					end

					local dealTypeParam = params[2]
					local checkParam = checknumber(params[#params])
					local awakenLevel = petMo:getAwakenLv()
					local isMatch = false

					if dealTypeParam == tostring(GameEnum.GREATER_THAN_OR_EQUAL_TO) then
						isMatch = checkParam <= awakenLevel
					elseif dealTypeParam == tostring(GameEnum.LESS_THAN) then
						isMatch = awakenLevel < checkParam
					elseif dealTypeParam == tostring(GameEnum.LESS_THAN_OR_EQUAL_TO) then
						isMatch = awakenLevel <= checkParam
					elseif dealTypeParam == tostring(GameEnum.EQUAL_TO) then
						isMatch = awakenLevel == checkParam
					elseif dealTypeParam == tostring(GameEnum.GREATER_THAN) then
						isMatch = checkParam < awakenLevel
					else
						printError("前端暂时不支持修复通道条件配置的觉醒等级比较方式，conditionId=%s, dealTypeParam=%s", conditionId, dealTypeParam)
					end

					return isMatch
				end
			elseif validatorType == "Race" then
				function func(petMo)
					local raceId = checknumber(params[2])

					return petMo and petMo:getDefineId() == raceId
				end
			end
		end

		self._conditionSortCheckFuncMap[conditionId] = func
	end

	return self._conditionSortCheckFuncMap[conditionId]
end

RepairChannelConfig.instance = RepairChannelConfig.New()

return RepairChannelConfig
