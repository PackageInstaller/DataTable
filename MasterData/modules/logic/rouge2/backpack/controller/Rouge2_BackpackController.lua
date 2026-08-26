-- chunkname: @modules/logic/rouge2/backpack/controller/Rouge2_BackpackController.lua

module("modules.logic.rouge2.backpack.controller.Rouge2_BackpackController", package.seeall)

local Rouge2_BackpackController = class("Rouge2_BackpackController", BaseController)

function Rouge2_BackpackController:buildItemReddot()
	local redDotInfo = {}
	local hasNewItem = false
	local isAnyHoleUnlock = self:isAnySkillHoleCanActiveOrActive()

	for _, bagType in pairs(Rouge2_Enum.BagType) do
		local itemList = Rouge2_BackpackModel.instance:getItemList(bagType)
		local reddotId = Rouge2_Enum.ItemType2Reddot[bagType]
		local isActiveSkill = bagType == Rouge2_Enum.BagType.ActiveSkill
		local isBagHasNew = false

		if reddotId then
			if itemList then
				for _, itemMo in ipairs(itemList) do
					local uid = itemMo:getUid()
					local value = Rouge2_MapLocalDataHelper.getItemReddotStatus(uid)
					local info = {
						id = reddotId,
						uid = uid,
						value = value
					}

					table.insert(redDotInfo, info)

					if value == Rouge2_Enum.ItemStatus.New then
						if isActiveSkill then
							if isAnyHoleUnlock then
								hasNewItem = true
								isBagHasNew = true
							end
						else
							hasNewItem = true
							isBagHasNew = true
						end
					end
				end
			end

			if bagType == Rouge2_Enum.BagType.ActiveSkill and not isBagHasNew then
				isBagHasNew = self:hasAnyCanActiveTalent()
			end

			local info = {
				uid = 0,
				id = reddotId,
				value = isBagHasNew and 1 or 0
			}

			table.insert(redDotInfo, info)
		end
	end

	table.insert(redDotInfo, {
		uid = 0,
		id = RedDotEnum.DotNode.Rouge2BackpackEntrance,
		value = hasNewItem and 1 or 0
	})
	RedDotRpc.instance:clientAddRedDotGroupList(redDotInfo)
end

function Rouge2_BackpackController:updateItemReddotStatus(uid, status)
	local preStatus = Rouge2_MapLocalDataHelper.getItemReddotStatus(uid)

	if preStatus == status then
		return
	end

	Rouge2_MapLocalDataHelper.setItemReddotStatus(uid, status)
	self:buildItemReddot()
end

function Rouge2_BackpackController:readAllActiveSkills()
	local allActiveSklls = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	if allActiveSklls then
		for _, skillMo in ipairs(allActiveSklls) do
			self:updateItemReddotStatus(skillMo:getUid(), Rouge2_Enum.ItemStatus.Old)
		end
	end
end

function Rouge2_BackpackController:readAllItems(bagType)
	if bagType then
		::label_4_0::

		local allItems = Rouge2_BackpackModel.instance:getItemList(bagType)

		if allItems then
			for _, itemMo in ipairs(allItems) do
				self:updateItemReddotStatus(itemMo:getUid(), Rouge2_Enum.ItemStatus.Old)
			end
		end
	end
end

function Rouge2_BackpackController:switchItemDescMode(dataFlag, targetMode)
	local key = self:_getItemDescModeKey(dataFlag)

	GameUtil.playerPrefsSetNumberByUserId(key, targetMode)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSwitchItemDescMode, dataFlag, targetMode)
end

function Rouge2_BackpackController:getItemDescMode(dataFlag, defaultMode)
	defaultMode = defaultMode or Rouge2_Enum.ItemDescMode.Simply

	local key = self:_getItemDescModeKey(dataFlag)
	local descMode = GameUtil.playerPrefsGetNumberByUserId(key, defaultMode)

	return tonumber(descMode)
end

function Rouge2_BackpackController:_getItemDescModeKey(dataFlag)
	return PlayerPrefsKey.Rouge2ItemDescMode .. "#" .. tostring(dataFlag)
end

function Rouge2_BackpackController:showLossItemView(reason, lossItemList)
	if reason == Rouge2_MapEnum.ItemDropReason.LevelUpSucc then
		return
	end

	local type2ItemList = {}

	for _, itemMo in ipairs(lossItemList) do
		local itemId = itemMo.itemId
		local itemType = Rouge2_BackpackHelper.itemId2BagType(itemId)

		type2ItemList[itemType] = type2ItemList[itemType] or {}

		table.insert(type2ItemList[itemType], itemId)
	end

	for itemType, lossItems in pairs(type2ItemList) do
		local showViewName = Rouge2_BackpackHelper.itemType2ShowViewName(itemType)

		if showViewName then
			Rouge2_PopController.instance:addPopViewWithViewName(showViewName, {
				itemList = lossItems,
				dataType = Rouge2_Enum.ItemDataType.Config,
				viewEnum = Rouge2_MapEnum.ItemDropViewEnum.Loss
			})
		end
	end
end

function Rouge2_BackpackController:showGetItemView(reason, getItemList)
	if not reason or not Rouge2_MapEnum.ShowItemDropReason[reason] then
		return
	end

	local type2ItemList = {}
	local updateRelicsList = {}
	local updateSkillList = {}

	for _, itemInfo in ipairs(getItemList) do
		local itemMo = Rouge2_BagItemMO.New()

		itemMo:init(itemInfo)

		local uid = itemMo:getUid()
		local itemId = itemMo:getItemId()
		local itemType = Rouge2_BackpackHelper.uid2BagType(uid)
		local isRelics = itemType == Rouge2_Enum.BagType.Relics
		local isActiveSkill = itemType == Rouge2_Enum.BagType.ActiveSkill

		if isActiveSkill then
			::label_9_0::

			local preLevelSkillId = Rouge2_CollectionConfig.instance:getPreLevelActiveSkillId(itemId)

			if isRelics then
				::label_9_1::

				local updateId = Rouge2_CollectionConfig.instance:getBaseRelicsId(itemId)

				if updateId and updateId ~= 0 then
					table.insert(updateRelicsList, itemMo)
				elseif preLevelSkillId and preLevelSkillId ~= 0 then
					table.insert(updateSkillList, {
						preDataType = Rouge2_Enum.ItemDataType.Config,
						preDataId = preLevelSkillId,
						resultDataType = Rouge2_Enum.ItemDataType.Clone,
						resultDataId = itemMo
					})
				else
					type2ItemList[itemType] = type2ItemList[itemType] or {}

					table.insert(type2ItemList[itemType], itemMo)
				end
			end
		end
	end

	for itemType, itemList in pairs(type2ItemList) do
		if itemList then
			if not #itemList then
				local itemNum = 0
				local showViewName = Rouge2_BackpackHelper.itemType2ShowViewName(itemType)

				if showViewName and itemNum > 0 then
					Rouge2_PopController.instance:addPopViewWithViewName(showViewName, {
						itemList = itemList,
						dataType = Rouge2_Enum.ItemDataType.Clone,
						viewEnum = Rouge2_MapEnum.ItemDropViewEnum.Drop,
						reason = reason
					})
				end
			end
		end
	end

	if updateRelicsList then
		if not #updateRelicsList then
			local updateRelicsNum = 0

			if updateRelicsNum > 0 then
				local showViewName = Rouge2_BackpackHelper.itemType2ShowViewName(Rouge2_Enum.BagType.Relics)

				if showViewName then
					Rouge2_PopController.instance:addPopViewWithViewName(showViewName, {
						itemList = updateRelicsList,
						dataType = Rouge2_Enum.ItemDataType.Clone,
						viewEnum = Rouge2_MapEnum.ItemDropViewEnum.Drop,
						reason = Rouge2_MapEnum.ItemDropReason.LevelUpSucc
					})
				end
			end

			if updateSkillList then
				if not #updateSkillList then
					local updateSkillNum = 0

					if updateSkillNum > 0 then
						Rouge2_PopController.instance:addPopViewWithViewName(ViewName.Rouge2_ActiveSkillLevelUpView, {
							skillList = updateSkillList
						})
					end
				end
			end
		end
	end
end

function Rouge2_BackpackController:buildBXSBoxReddot()
	local reddotValue = 0

	if Rouge2_Model.instance:isUseBXSCareer() then
		local curPoint = Rouge2_BackpackModel.instance:getCurBoxPoint()
		local maxPoint = Rouge2_MapConfig.instance:BXSMaxBoxPoint()

		if maxPoint <= curPoint then
			reddotValue = 1
		end
	end

	RedDotRpc.instance:clientAddRedDotGroupList({
		{
			id = RedDotEnum.DotNode.Rouge2BXSBox,
			value = reddotValue
		}
	})
end

function Rouge2_BackpackController:isCanResetTalentStage()
	local activeTalentIdList = Rouge2_BackpackModel.instance:getActiveTalentIds()

	if not activeTalentIdList then
		return
	end

	for _, talentId in ipairs(activeTalentIdList) do
		local talentCo = Rouge2_CareerConfig.instance:getTalentConfig(talentId)
		local isNotInitStage = talentCo and talentCo.stage > -1
		local isNotTransform = talentCo and talentCo.type ~= Rouge2_Enum.BagTalentType.Transform

		if isNotInitStage and isNotTransform then
			local isActive = Rouge2_BackpackModel.instance:isTalentActive(talentCo.talentId)

			if isActive then
				return true
			end
		end
	end
end

function Rouge2_BackpackController:isAnyStageTalentActive(stage)
	local talentList = Rouge2_CareerConfig.instance:getTalentConfigsByStage(stage)

	if talentList then
		for _, talentCo in ipairs(talentList) do
			if Rouge2_BackpackModel.instance:isTalentActive(talentCo.talentId) then
				return true
			end
		end
	end
end

function Rouge2_BackpackController:isAnyNextTalentActive(talentId)
	local nextTalentList = Rouge2_CareerConfig.instance:getNextTalentList(talentId)
	local isAnyNextTalentActive = false

	if nextTalentList then
		for _, nextTalentCo in ipairs(nextTalentList) do
			local isActive = Rouge2_BackpackModel.instance:isTalentActive(nextTalentCo.talentId)

			if isActive then
				isAnyNextTalentActive = true

				break
			end
		end
	end

	return isAnyNextTalentActive
end

function Rouge2_BackpackController:isPreTalentActive(talentId)
	local preTalentList = Rouge2_CareerConfig.instance:getPreTalentList(talentId)

	if preTalentList then
		for _, preTalentCo in ipairs(preTalentList) do
			if Rouge2_BackpackModel.instance:isTalentActive(preTalentCo.talentId) then
				return true
			end
		end
	end

	return false
end

function Rouge2_BackpackController:getTalentResetRecycleTalentNum(stage)
	local recycleNum = 0
	local activeTalentIdList = Rouge2_BackpackModel.instance:getActiveTalentIds()

	if activeTalentIdList then
		for _, talentId in ipairs(activeTalentIdList) do
			local talentCo = Rouge2_CareerConfig.instance:getTalentConfig(talentId)

			if talentCo and stage <= talentCo.stage then
				recycleNum = recycleNum + talentCo.unlockCost
			end
		end
	end

	return recycleNum
end

function Rouge2_BackpackController:hasAnyCanActiveTalent()
	if not Rouge2_Model.instance:isUseYBXCareer() then
		return
	end

	for _, talentCo in ipairs(lua_fight_rouge2_summoner.configList) do
		local status = Rouge2_BackpackModel.instance:getTalentStatus(talentCo.talentId)

		if status == Rouge2_Enum.BagTalentStatus.UnlockCanActive then
			return true
		end
	end
end

function Rouge2_BackpackController:getNewUnlockTalentId()
	local activeTalentIdList = Rouge2_BackpackModel.instance:getActiveTalentIds()

	if activeTalentIdList then
		for _, talentId in ipairs(activeTalentIdList) do
			local nextTalentList = Rouge2_CareerConfig.instance:getNextTalentList(talentId)

			if nextTalentList then
				for _, nextTalentCo in ipairs(nextTalentList) do
					local nextTalentId = nextTalentCo.talentId
					local status = Rouge2_BackpackModel.instance:getTalentStatus(nextTalentId)

					if status == Rouge2_Enum.BagTalentStatus.UnlockNotActive or status == Rouge2_Enum.BagTalentStatus.UnlockCanActive then
						return nextTalentId
					end
				end
			end
		end
	end
end

function Rouge2_BackpackController:isAnySkillHoleCanActiveOrActive()
	for i = 1, Rouge2_Enum.MaxActiveSkillNum do
		local status = Rouge2_BackpackModel.instance:getActiveSkillHoleStatus(i)
		local isValid = status and status >= Rouge2_Enum.ActiveSkillHoleStatus.UnlockCanActive

		if isValid then
			return true
		end
	end

	return false
end

function Rouge2_BackpackController:isBagActiveSkillUpdateAttr(attrId)
	local skillList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	if not skillList then
		return
	end

	for _, skillMo in ipairs(skillList) do
		local skillId = skillMo:getItemId()
		local isSkillUpdateAttr = Rouge2_CollectionConfig.instance:isSkillUpdateAttr(skillId, attrId)

		if isSkillUpdateAttr then
			return true
		end
	end
end

function Rouge2_BackpackController:getAllHeroIdList()
	local allHeroIdMap = {}
	local allHeroIdList = {}
	local allHeroList = HeroModel.instance:getAllHero()

	if allHeroList then
		for heroId in pairs(allHeroList) do
			allHeroIdMap[heroId] = true

			table.insert(allHeroIdList, heroId)
		end
	end

	local trialHeroList = self:getActiveSkillTrialHeroList()

	if trialHeroList then
		for _, trialInfo in ipairs(trialHeroList) do
			local trialId = trialInfo[1]

			if not trialInfo[2] then
				local templateId = 0
				local trialCo = lua_hero_trial.configDict[trialId][templateId]
				local heroId = trialCo and trialCo.heroId

				if heroId and not allHeroIdMap[heroId] then
					allHeroIdMap[heroId] = true

					table.insert(allHeroIdList, heroId)
				end
			end
		end
	end

	return allHeroIdList
end

function Rouge2_BackpackController:getActiveSkillTrialHeroList()
	local skillList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	if not skillList then
		return
	end

	local trialHeroMap = {}
	local trialHeroList = {}

	for _, skillMo in ipairs(skillList) do
		local trialInfoList = Rouge2_CollectionConfig.instance:getTrialHeroListBySkillId(skillMo:getItemId())

		if trialInfoList then
			for _, trialInfo in ipairs(trialInfoList) do
				local trialId = trialInfo[1]

				if trialId and not trialHeroMap[trialId] then
					trialHeroMap[trialId] = true

					table.insert(trialHeroList, trialInfo)
				end
			end
		end
	end

	return trialHeroList
end

function Rouge2_BackpackController:isHeroGetFromActiveSkill(targetHeroId)
	local trialCo = self:getTrialConfigByHeroId(targetHeroId)

	return trialCo ~= nil
end

function Rouge2_BackpackController:getTrialConfigByHeroId(targetHeroId)
	if not targetHeroId then
		return
	end

	local skillList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	if not skillList then
		return
	end

	for _, skillMo in ipairs(skillList) do
		local trialInfoList = Rouge2_CollectionConfig.instance:getTrialHeroListBySkillId(skillMo:getItemId())

		if trialInfoList then
			for _, trialInfo in ipairs(trialInfoList) do
				local trialId = trialInfo[1]

				if not trialInfo[2] then
					local templateId = 0
					local trialCo = lua_hero_trial.configDict[trialId][templateId]
					local heroId = trialCo and trialCo.heroId

					if heroId == targetHeroId then
						return trialCo
					end
				end
			end
		end
	end
end

function Rouge2_BackpackController:isHasTrialHero(trialId, templateId)
	local skillList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	if not skillList then
		return
	end

	templateId = templateId or 0

	for _, skillMo in ipairs(skillList) do
		local trialInfoList = Rouge2_CollectionConfig.instance:getTrialHeroListBySkillId(skillMo:getItemId())

		if trialInfoList then
			for _, trialInfo in ipairs(trialInfoList) do
				local id = trialInfo[1]

				if not trialInfo[2] then
					if id == trialId and templateId == trialInfo[2] then
						return true
					end
				end
			end
		end
	end
end

function Rouge2_BackpackController:isAttrRecommend(careerId, attrId, systemId)
	careerId = careerId or Rouge2_Model.instance:getCareerId()
	systemId = systemId or Rouge2_Model.instance:getCurTeamSystemId()

	return Rouge2_CareerConfig.instance:isSystemRecommendAttr(systemId, attrId) or self:isBagActiveSkillUpdateAttr(attrId)
end

function Rouge2_BackpackController:getAttrValueRange(difficulty, attrId)
	difficulty = difficulty or Rouge2_Model.instance:getDifficulty()

	local exAttrLimit = Rouge2_AttributeConfig.instance:getExAttrLimit(difficulty, attrId)
	local attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(attrId)

	if attrCo then
		if not attrCo.min then
			local originMinValue = 0

			if attrCo then
				if not attrCo.showMax then
					local originMaxValue = 0

					return originMinValue, originMaxValue + exAttrLimit
				end
			end
		end
	end
end

Rouge2_BackpackController.instance = Rouge2_BackpackController.New()

return Rouge2_BackpackController
