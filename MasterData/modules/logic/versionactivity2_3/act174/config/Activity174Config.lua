-- chunkname: @modules/logic/versionactivity2_3/act174/config/Activity174Config.lua

module("modules.logic.versionactivity2_3.act174.config.Activity174Config", package.seeall)

local Activity174Config = class("Activity174Config", BaseConfig)

function Activity174Config:reqConfigNames()
	return {
		"activity174_const",
		"activity174_turn",
		"activity174_shop",
		"activity174_bag",
		"activity174_role",
		"activity174_collection",
		"activity174_enhance",
		"activity174_bet",
		"activity174_season",
		"activity174_badge",
		"activity174_template",
		"activity174_effect"
	}
end

function Activity174Config:onInit()
	return
end

function Activity174Config:onConfigLoaded(configName, configTable)
	if configName == "activity174_turn" then
		self.turnConfig = configTable
	elseif configName == "activity174_shop" then
		self.shopConfig = configTable
	elseif configName == "activity174_role" then
		self.roleConfig = configTable
	elseif configName == "activity174_collection" then
		self.collectionConfig = configTable
	end
end

function Activity174Config:initUnlockNewTeamTurnData()
	self.unlockNewTeamTurn = {}

	for _, cfg in ipairs(self.turnConfig.configList) do
		local newTurn = cfg.turn
		local teamNum = cfg.groupNum
		local oldTurn = self.unlockNewTeamTurn[teamNum]

		if not oldTurn or newTurn < oldTurn then
			self.unlockNewTeamTurn[teamNum] = newTurn
		end
	end
end

function Activity174Config:isUnlockNewTeamTurn(curTurn)
	local result = false

	if not self.unlockNewTeamTurn then
		self:initUnlockNewTeamTurnData()
	end

	for teamNum, turn in ipairs(self.unlockNewTeamTurn) do
		if turn == curTurn then
			result = true

			break
		end
	end

	return result
end

function Activity174Config:getTurnCo(actId, round)
	local turnCo = self.turnConfig.configDict[actId][round]

	if not turnCo then
		logError("dont exist turnCo" .. tostring(actId) .. "#" .. tostring(round))
	end

	return turnCo
end

function Activity174Config:getMaxRound(actId, curRound)
	local maxRound = 0

	for _, config in ipairs(self.turnConfig.configDict[actId]) do
		if config.endless == 1 then
			maxRound = config.turn
		end
	end

	if maxRound < curRound then
		return #self.turnConfig.configDict[actId], true
	end

	return maxRound, false
end

function Activity174Config:getUnlockLevel(actId, teamCnt)
	for _, config in ipairs(self.turnConfig.configDict[actId]) do
		if config.groupNum == teamCnt then
			return config.turn
		end
	end
end

function Activity174Config:getShopCo(actId, shopLevel)
	for _, shopCo in ipairs(self.shopConfig.configList) do
		if shopCo.activityId == actId and shopCo.level == shopLevel then
			return shopCo
		end
	end

	logError("dont exist shopCo" .. tostring(actId) .. "#" .. tostring(shopLevel))
end

function Activity174Config:getHeroPassiveSkillIdList(roleId, isRepleace)
	local roleCo = self:getRoleCo(roleId)

	return isRepleace and string.splitToNumber(roleCo.replacePassiveSkill, "|") or string.splitToNumber(roleCo.passiveSkill, "|")
end

function Activity174Config:getHeroSkillIdDic(roleId, singleMax)
	local roleCo = self:getRoleCo(roleId)
	local skillIdDic = {}
	local skillList1 = string.splitToNumber(roleCo.activeSkill1, "#")
	local skillList2 = string.splitToNumber(roleCo.activeSkill2, "#")

	if singleMax then
		skillIdDic[1] = skillList1[#skillList1]
		skillIdDic[2] = skillList2[#skillList1]
		skillIdDic[3] = roleCo.uniqueSkill
	else
		skillIdDic[1] = skillList1
		skillIdDic[2] = skillList2
		skillIdDic[3] = {
			roleCo.uniqueSkill
		}
	end

	return skillIdDic
end

function Activity174Config:getRoleCo(roleId)
	local roleCo = self.roleConfig.configDict[roleId]

	if not roleCo then
		logError("dont exist role" .. tostring(roleId))
	end

	return roleCo
end

function Activity174Config:getRoleCoByHeroId(heroId)
	for _, v in ipairs(self.roleConfig.configList) do
		if v.heroId == heroId then
			return v
		end
	end

	logError("dont exist role with heroId" .. tostring(heroId))
end

function Activity174Config:getCollectionCo(collectionId)
	local collectionCo = self.collectionConfig.configDict[collectionId]

	if not collectionCo then
		logError("dont exist collection" .. tostring(collectionId))
	end

	return collectionCo
end

Activity174Config.instance = Activity174Config.New()

return Activity174Config
