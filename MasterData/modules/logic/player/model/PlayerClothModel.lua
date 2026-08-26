-- chunkname: @modules/logic/player/model/PlayerClothModel.lua

module("modules.logic.player.model.PlayerClothModel", package.seeall)

local PlayerClothModel = class("PlayerClothModel", ListScrollModel)

function PlayerClothModel:onGetInfo(clothInfos)
	local list = {}

	for _, co in ipairs(lua_cloth.configList) do
		local playerClothMO = PlayerClothMO.New()

		playerClothMO:initFromConfig(co)
		table.insert(list, playerClothMO)
	end

	self:setList(list)
	self:updateInfo(clothInfos)
end

function PlayerClothModel:onPushInfo(clothInfos)
	self:updateInfo(clothInfos)
end

function PlayerClothModel:updateInfo(clothInfos)
	for _, oneInfo in ipairs(clothInfos) do
		local playerClothMO = self:getById(oneInfo.clothId)

		if playerClothMO then
			playerClothMO:init(oneInfo)
		else
			logError("服装配置不存在：" .. oneInfo.clothId)
		end
	end
end

function PlayerClothModel:hasCloth(clothId)
	local playerClothMO = self:getById(clothId)

	return playerClothMO and playerClothMO.has
end

function PlayerClothModel.isSatisfy(conditionStr)
	local sp = string.splitToNumber(conditionStr, "#")
	local playerLvLimit = sp[1]
	local episodeLimit = sp[2]

	if playerLvLimit and playerLvLimit > 0 and playerLvLimit > PlayerModel.instance:getPlayinfo().level then
		return false
	end

	if episodeLimit and episodeLimit > 0 then
		local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeLimit)

		if not episodeInfo or episodeInfo.star <= DungeonEnum.StarType.None then
			return false
		end
	end

	return true
end

function PlayerClothModel:canUse(clothId)
	local has = self:hasCloth(clothId)
	local functionOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill)

	return has and functionOpen
end

function PlayerClothModel:getSpEpisodeClothID()
	local var_7_0 = HeroGroupModel.instance.episodeId

	if not HeroGroupModel.instance.episodeId then
		var_7_0 = FightModel.instance:getFightParam()

		if var_7_0 then
			var_7_0 = FightModel.instance:getFightParam().episodeId

			local episodeId = var_7_0

			if not episodeId then
				return nil
			end

			local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)
			local battleCO = episodeCO and lua_battle.configDict[episodeCO.battleId]

			if episodeCO.type == DungeonEnum.EpisodeType.Sp and battleCO and not string.nilorempty(battleCO.clothSkill) then
				return string.splitToNumber(battleCO.clothSkill, "#")[1]
			end

			return nil
		end
	end
end

PlayerClothModel.instance = PlayerClothModel.New()

return PlayerClothModel
