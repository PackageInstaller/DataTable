-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/config/LuyngardeConfig.lua

module("logic.extensions.luyngarde.config.LuyngardeConfig", package.seeall)

local LuyngardeConfig = class("LuyngardeConfig", BaseConfig)

function LuyngardeConfig:getNames()
	return {
		"luyngarde_activity",
		"luyngarde_chapter",
		"luyngarde_chapter2_boss",
		"luyngarde_chapter2_boss_buff",
		"luyngarde_chapter2_boss_damage",
		"luyngarde_chapter2_boss_kill",
		"luyngarde_chapter2_boss_rank_prize",
		"luyngarde_chapter3_explore",
		"luyngarde_chapter3_explore_rank_prize",
		"luyngarde_chapter3_explore_star",
		"luyngarde_chapter3_explore_reset",
		"luyngarde_chapter3_explore_star_show",
		"luyngarde_chapter4_rank_prize",
		"luyngarde_creeps",
		"luyngarde_support_pet",
		"luyngarde_pet",
		"luyngarde_team",
		"luyngarde_chapter_story",
		"luyngarde_chapter4_desc"
	}
end

function LuyngardeConfig:handleConfig(name, content)
	if name == "luyngarde_activity" then
		self._luyngarde_activity = content
	elseif name == "luyngarde_chapter" then
		self._luyngarde_chapter = content
	elseif name == "luyngarde_chapter2_boss" then
		self._luyngarde_chapter2_boss = content
	elseif name == "luyngarde_chapter2_boss_buff" then
		self._luyngarde_chapter2_boss_buff = content

		self:_handlerChapter2BossBuffCfgs()
	elseif name == "luyngarde_chapter2_boss_damage" then
		self._luyngarde_chapter2_boss_damage = content
	elseif name == "luyngarde_chapter2_boss_kill" then
		self._luyngarde_chapter2_boss_kill = content

		self:_handleChapter2AreaKillCfgs()
	elseif name == "luyngarde_chapter2_boss_rank_prize" then
		self._luyngarde_chapter2_boss_rank_prize = content

		self:_handlerChapter2RankPrizeCfgs()
	elseif name == "luyngarde_chapter3_explore" then
		self._luyngarde_chapter3_explore = content
	elseif name == "luyngarde_chapter3_explore_rank_prize" then
		self._luyngarde_chapter3_explore_rank_prize = content

		self:_handlerChapter3RankPrizeCfgs()
	elseif name == "luyngarde_chapter3_explore_star" then
		self._luyngarde_chapter3_explore_star = content
	elseif name == "luyngarde_chapter4_rank_prize" then
		self._luyngarde_chapter4_rank_prize = content

		self:_handlerChapter4RankPrizeCfgs()
	elseif name == "luyngarde_creeps" then
		self._luyngarde_creeps = content
	elseif name == "luyngarde_support_pet" then
		self._luyngarde_support_pet = content

		self:_handlerSupportPetCfg()
	elseif name == "luyngarde_pet" then
		self._luyngarde_pet = content
	elseif name == "luyngarde_team" then
		self._luyngarde_team = content
	elseif name == "luyngarde_chapter_story" then
		self._luyngarde_chapter_story = content
	elseif name == "luyngarde_chapter4_desc" then
		self._luyngarde_chapter4_desc = content
	elseif name == "luyngarde_chapter3_explore_reset" then
		self._luyngarde_chapter3_explore_reset = content
	elseif name == "luyngarde_chapter3_explore_star_show" then
		self._luyngarde_chapter3_explore_star_show = content
	end
end

function LuyngardeConfig:getActCfg(activityId)
	return self._luyngarde_activity[activityId]
end

function LuyngardeConfig:getChapterCfg(activityId, chapterId)
	if self._luyngarde_chapter[activityId] then
		return self._luyngarde_chapter[activityId][chapterId]
	end
end

function LuyngardeConfig:getPetUpgradeCfgs(activityId)
	return self._luyngarde_pet[activityId]
end

function LuyngardeConfig:getPetUpgradeCfgByLevel(activityId, level)
	if self._luyngarde_pet[activityId] then
		return self._luyngarde_pet[activityId][level]
	end
end

function LuyngardeConfig:getStoryCfgs(activityId)
	return self._luyngarde_chapter_story[activityId]
end

function LuyngardeConfig:getStoryCfgByChapterId(activityId, chapterId)
	if self._luyngarde_chapter_story[activityId] then
		return self._luyngarde_chapter_story[activityId][chapterId]
	end
end

function LuyngardeConfig:getChapter2BossCfgs(activityId)
	return self._luyngarde_chapter2_boss[activityId]
end

function LuyngardeConfig:getChapter2PersonDamageCfgs(activityId)
	return self._luyngarde_chapter2_boss_damage[activityId]
end

function LuyngardeConfig:_handleChapter2AreaKillCfgs()
	self._Chapter2_AreaKill_Cfgs = {}

	for i, v in ipairs(self._luyngarde_chapter2_boss_kill.dataList) do
		self._Chapter2_AreaKill_Cfgs[v.activityId] = self._Chapter2_AreaKill_Cfgs[v.activityId] or {}

		table.insert(self._Chapter2_AreaKill_Cfgs[v.activityId], v)
	end
end

function LuyngardeConfig:getChapter2AreaKillCfgs(activityId)
	return self._Chapter2_AreaKill_Cfgs[activityId]
end

function LuyngardeConfig:_handlerChapter2BossBuffCfgs()
	self._Chapter2_Boss_BossBuff_Cfgs = {}

	for i, v in ipairs(self._luyngarde_chapter2_boss_buff.dataList) do
		self._Chapter2_Boss_BossBuff_Cfgs[v.activityId] = self._Chapter2_Boss_BossBuff_Cfgs[v.activityId] or {}

		if not self._Chapter2_Boss_BossBuff_Cfgs[v.activityId][v.bossId] then
			table.insert(self._Chapter2_Boss_BossBuff_Cfgs[v.activityId][v.bossId], v)

			self._Chapter2_Boss_BossBuff_Cfgs[v.activityId][v.bossId] = self._Chapter2_Boss_BossBuff_Cfgs[v.activityId][v.bossId]
		end
	end
end

function LuyngardeConfig:getChapter2BossBuffCfg(activityId, bossId)
	if self._Chapter2_Boss_BossBuff_Cfgs[activityId] and self._Chapter2_Boss_BossBuff_Cfgs[activityId][bossId] then
		return self._Chapter2_Boss_BossBuff_Cfgs[activityId][bossId][1]
	end
end

function LuyngardeConfig:getSupportPetCfg(activityId, petId)
	if self._luyngarde_support_pet[activityId] then
		return self._luyngarde_support_pet[activityId][petId]
	end
end

function LuyngardeConfig:_handlerSupportPetCfg()
	self._support_pet_cfgs_byPool = {}

	for i, v in ipairs(self._luyngarde_support_pet.dataList) do
		self._support_pet_cfgs_byPool[v.activityId] = self._support_pet_cfgs_byPool[v.activityId] or {}

		if not self._support_pet_cfgs_byPool[v.activityId][v.supportPetPoolId] then
			table.insert(self._support_pet_cfgs_byPool[v.activityId][v.supportPetPoolId], v)

			self._support_pet_cfgs_byPool[v.activityId][v.supportPetPoolId] = self._support_pet_cfgs_byPool[v.activityId][v.supportPetPoolId]
		end
	end
end

function LuyngardeConfig:getSupportPetCfgs(activityId, supportPetPoolId)
	if self._support_pet_cfgs_byPool[activityId] then
		return self._support_pet_cfgs_byPool[activityId][supportPetPoolId]
	end
end

function LuyngardeConfig:getCreepCfgs(creepsMasterId)
	return self._luyngarde_creeps[creepsMasterId]
end

function LuyngardeConfig:getTeamCfg(creepsMasterId)
	return self._luyngarde_team[creepsMasterId]
end

function LuyngardeConfig:getChapter4DescCfgs(activityId)
	return self._luyngarde_chapter4_desc[activityId]
end

function LuyngardeConfig:_handlerChapter2RankPrizeCfgs()
	self._Chapter2_Rank_PrizeCfgs = {}

	for i, v in ipairs(self._luyngarde_chapter2_boss_rank_prize.dataList) do
		self._Chapter2_Rank_PrizeCfgs[v.activityId] = self._Chapter2_Rank_PrizeCfgs[v.activityId] or {}

		if not self._Chapter2_Rank_PrizeCfgs[v.activityId][v.typeId] then
			table.insert(self._Chapter2_Rank_PrizeCfgs[v.activityId][v.typeId], v)

			self._Chapter2_Rank_PrizeCfgs[v.activityId][v.typeId] = self._Chapter2_Rank_PrizeCfgs[v.activityId][v.typeId]
		end
	end
end

function LuyngardeConfig:getChapter2RankPrizeCfgs(activityId, typeId)
	if self._Chapter2_Rank_PrizeCfgs[activityId] then
		return self._Chapter2_Rank_PrizeCfgs[activityId][typeId]
	end
end

function LuyngardeConfig:_handlerChapter3RankPrizeCfgs()
	self._Chapter3_Rank_PrizeCfgs = {}

	for i, v in ipairs(self._luyngarde_chapter3_explore_rank_prize.dataList) do
		self._Chapter3_Rank_PrizeCfgs[v.activityId] = self._Chapter3_Rank_PrizeCfgs[v.activityId] or {}

		table.insert(self._Chapter3_Rank_PrizeCfgs[v.activityId], v)
	end
end

function LuyngardeConfig:getChapter3RankPrizeCfgs(activityId)
	return self._Chapter3_Rank_PrizeCfgs[activityId]
end

function LuyngardeConfig:_handlerChapter4RankPrizeCfgs()
	self._Chapter4_Rank_PrizeCfgs = {}

	for i, v in ipairs(self._luyngarde_chapter4_rank_prize.dataList) do
		self._Chapter4_Rank_PrizeCfgs[v.activityId] = self._Chapter4_Rank_PrizeCfgs[v.activityId] or {}

		table.insert(self._Chapter4_Rank_PrizeCfgs[v.activityId], v)
	end
end

function LuyngardeConfig:getChapter4RankPrizeCfgs(activityId)
	return self._Chapter4_Rank_PrizeCfgs[activityId]
end

function LuyngardeConfig:getChapter3ExploreCfgs(activityId)
	return self._luyngarde_chapter3_explore[activityId]
end

function LuyngardeConfig:getChapter3ExploreCfgByPosId(activityId, posId)
	if self._luyngarde_chapter3_explore[activityId] then
		return self._luyngarde_chapter3_explore[activityId][posId]
	end
end

function LuyngardeConfig:getChapter3ExploreStarCfg(activityId, id)
	if self._luyngarde_chapter3_explore_star[activityId] then
		return self._luyngarde_chapter3_explore_star[activityId][id]
	end
end

function LuyngardeConfig:getChapter3ExploreStarShowCfgs(activityId, typeId)
	if self._luyngarde_chapter3_explore_star_show[activityId] then
		return self._luyngarde_chapter3_explore_star_show[activityId][typeId]
	end
end

function LuyngardeConfig:getChapter3ExploreStarShowCfgByStar(activityId, typeId, star)
	if self._luyngarde_chapter3_explore_star_show[activityId] and self._luyngarde_chapter3_explore_star_show[activityId][typeId] then
		return self._luyngarde_chapter3_explore_star_show[activityId][typeId][star]
	end
end

function LuyngardeConfig:getChapter3ExploreResetCfgs(activityId)
	return self._luyngarde_chapter3_explore_reset[activityId]
end

LuyngardeConfig.instance = LuyngardeConfig.New()

return LuyngardeConfig
