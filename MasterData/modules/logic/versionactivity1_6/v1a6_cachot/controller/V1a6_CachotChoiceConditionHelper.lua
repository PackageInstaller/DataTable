-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/controller/V1a6_CachotChoiceConditionHelper.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotChoiceConditionHelper", package.seeall)

local V1a6_CachotChoiceConditionHelper = class("V1a6_CachotChoiceConditionHelper")

function V1a6_CachotChoiceConditionHelper.getConditionToast(conditionType, ...)
	local func = V1a6_CachotChoiceConditionHelper["conditionType" .. conditionType]

	if not func then
		logError("未处理当前条件类型")

		return
	end

	return func(...)
end

function V1a6_CachotChoiceConditionHelper.conditionType1(collectionId)
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local collectionCfgMap = rogueInfo and rogueInfo.collectionCfgMap
	local collectionBaseMap = rogueInfo and rogueInfo.collectionBaseMap
	local collectionCfgList = collectionCfgMap and collectionCfgMap[collectionId]
	local collectionBaseList = collectionBaseMap and collectionBaseMap[collectionId]
	local hasExistCollection = collectionCfgList and #collectionCfgList > 0
	local hasExitBaseCollection = collectionBaseList and #collectionBaseList > 0

	if not hasExistCollection and not hasExitBaseCollection then
		return ToastEnum.V1a6CachotToast07, lua_rogue_collection.configDict[collectionId].name
	end
end

function V1a6_CachotChoiceConditionHelper.conditionType2(minVal, maxVal)
	local heartVal = V1a6_CachotModel.instance:getRogueInfo().heart

	if heartVal < minVal or maxVal < heartVal then
		return ToastEnum.V1a6CachotToast08, minVal, maxVal
	end
end

function V1a6_CachotChoiceConditionHelper.conditionType3(count)
	local coin = V1a6_CachotModel.instance:getRogueInfo().coin

	if coin < count then
		return ToastEnum.V1a6CachotToast24, count
	end
end

function V1a6_CachotChoiceConditionHelper.conditionType4(count)
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local collectionList = rogueInfo and rogueInfo.collections

	if collectionList then
		if not #collectionList then
			local collectionCountInBag = 0

			if collectionCountInBag < count then
				return ToastEnum.V1a6CachotToast14, count
			end
		end
	end
end

function V1a6_CachotChoiceConditionHelper.conditionType5(count)
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local collectionList = rogueInfo and rogueInfo.collections

	if collectionList then
		if not #collectionList then
			local collectionCountInBag = 0

			if count < collectionCountInBag then
				return ToastEnum.V1a6CachotToast15, count
			end
		end
	end
end

function V1a6_CachotChoiceConditionHelper.conditionType6(count, groupId)
	local groupCfg = lua_rogue_collection_group.configDict[groupId]
	local matchCollectionNum = V1a6_CachotChoiceConditionHelper.getMatchCollectionNumInBag(groupId)

	if groupCfg then
		if not groupCfg.dropGroupType then
			local dropGroupType = ""

			if matchCollectionNum < count then
				return ToastEnum.V1a6CachotToast16, count, dropGroupType
			end
		end
	end
end

function V1a6_CachotChoiceConditionHelper.conditionType7(count, groupId)
	local groupCfg = lua_rogue_collection_group.configDict[groupId]
	local matchCollectionNum = V1a6_CachotChoiceConditionHelper.getMatchCollectionNumInBag(groupId)

	if groupCfg then
		if not groupCfg.dropGroupType then
			local dropGroupType = ""

			if count < matchCollectionNum then
				return ToastEnum.V1a6CachotToast17, count, dropGroupType
			end
		end
	end
end

function V1a6_CachotChoiceConditionHelper.getMatchCollectionNumInBag(groupId)
	local matchCollectionNum = 0

	if groupId and groupId ~= 0 then
		local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
		local collectionMap = rogueInfo and rogueInfo.collectionCfgMap
		local collectionList = V1a6_CachotCollectionConfig.instance:getCollectionsByGroupId(groupId)

		if collectionList and collectionMap then
			for _, collectionCfg in pairs(collectionList) do
				local collectionList = collectionMap[collectionCfg.id]

				if collectionList then
					if not #collectionList then
						local collectionNum = 0

						matchCollectionNum = matchCollectionNum + collectionNum
					end
				end
			end
		end
	end

	return matchCollectionNum
end

function V1a6_CachotChoiceConditionHelper.conditionType8(num)
	local info = V1a6_CachotModel.instance:getTeamInfo()

	if not info then
		return
	end

	for i, heroLifeMo in ipairs(info.lifes) do
		if num < heroLifeMo.lifePercent then
			return ToastEnum.V1a6CachotToast18, num
		end
	end
end

function V1a6_CachotChoiceConditionHelper.conditionType9(num)
	local info = V1a6_CachotModel.instance:getTeamInfo()

	if not info then
		return
	end

	for i, heroLifeMo in ipairs(info.lifes) do
		if num > heroLifeMo.lifePercent then
			return ToastEnum.V1a6CachotToast19, num
		end
	end
end

function V1a6_CachotChoiceConditionHelper.conditionType10(num)
	local info = V1a6_CachotModel.instance:getTeamInfo()

	if not info then
		return
	end

	for i, heroLifeMo in ipairs(info.lifes) do
		if num >= heroLifeMo.lifePercent then
			return ToastEnum.V1a6CachotToast20, num
		end
	end
end

function V1a6_CachotChoiceConditionHelper.conditionType11(num)
	local info = V1a6_CachotModel.instance:getTeamInfo()

	if not info then
		return
	end

	for i, heroLifeMo in ipairs(info.lifes) do
		if num <= heroLifeMo.lifePercent then
			return ToastEnum.V1a6CachotToast21, num
		end
	end
end

function V1a6_CachotChoiceConditionHelper.conditionType12(num)
	local heartVal = V1a6_CachotModel.instance:getRogueInfo().heart

	if heartVal < num then
		return ToastEnum.V1a6CachotToast22, num
	end
end

function V1a6_CachotChoiceConditionHelper.conditionType13(num)
	local heartVal = V1a6_CachotModel.instance:getRogueInfo().heart

	if num < heartVal then
		return ToastEnum.V1a6CachotToast23, num
	end
end

return V1a6_CachotChoiceConditionHelper
