-- chunkname: @modules/logic/bossrush/config/BossRushConfig.lua

module("modules.logic.bossrush.config.BossRushConfig", package.seeall)

local BossRushConfig = class("BossRushConfig", Activity128Config)

function BossRushConfig:InfiniteDoubleMaxTimes()
	local res = self:getConst(2)

	return res or 0
end

function BossRushConfig:getActivityRewardStr()
	local _, str = self:getConst(3)

	return str
end

function BossRushConfig:getIssxIconName(stage, layer)
	layer = self:getDefaultLayer(stage) or 1

	local monsterId = self:getFinalMonsterId(stage, layer)
	local monsterCO = lua_monster.configDict[monsterId]
	local career = monsterCO.career

	return "lssx_" .. career
end

function BossRushConfig:getMonsterCO(stage, layer)
	layer = self:getDefaultLayer(stage) or 1

	local monsterId = self:getFinalMonsterId(stage, layer)

	return lua_monster.configDict[monsterId]
end

function BossRushConfig:getDefaultLayer(stage)
	local stageEpisode = self:getEpisodeStages(stage)

	if stageEpisode then
		for _, info in pairs(stageEpisode) do
			return info.layer
		end
	end
end

function BossRushConfig:getAssessCo(stage, point, type)
	type = type or BossRushEnum.AssessType.V3a2

	return self:_getAssessCoByType(stage, point, type)
end

function BossRushConfig:_getAssessCoByType(stage, point, type)
	local memberName = "needPointBoss" .. tostring(stage)
	local list = lua_activity128_assess.configList

	for i = #list, 1, -1 do
		local v = list[i]

		if v.layer4Assess == type then
			local needPoint = v[memberName]

			if needPoint <= point then
				return v
			end
		end
	end
end

function BossRushConfig:getAssessSpriteName(stage, point, type)
	local assessCo = self:getAssessCo(stage, point, type)

	if assessCo then
		return assessCo.spriteName, assessCo.level, assessCo.strLevel
	end

	return "", -1, ""
end

function BossRushConfig:getAssessBattleIconBgName(stage, point, type)
	local assessCo = self:getAssessCo(stage, point, type)

	if assessCo then
		return assessCo.battleIconBg, assessCo.level
	end

	return "v3a2_bossrush_ig_tipsbgempty", -1
end

function BossRushConfig:getAssessMainBossBgName(stage, point, type)
	local assessCo = self:getAssessCo(stage, point, type)

	if assessCo then
		return assessCo.mainBg, assessCo.level
	end

	return "v1a6_bossrush_taskitembg1", -1
end

function BossRushConfig:getAssessPointByStrLevel(stage, assessStrLevel)
	local memberName = "needPointBoss" .. tostring(stage)
	local list = lua_activity128_assess.configList

	for _, v in ipairs(list) do
		if v.strLevel == assessStrLevel then
			return v[memberName]
		end
	end

	return 0
end

function BossRushConfig:getScoreStr(num, symbol)
	assert(num >= 0)

	local a = math.modf(num / 10)
	local b = math.fmod(num, 10)
	local c = 1
	local str = tostring(b)

	symbol = symbol or ","

	while a > 0 do
		b = math.fmod(a, 10)

		if c >= 3 then
			str = symbol .. str
			c = 0
		end

		str = tostring(b) .. str
		a = math.modf(a / 10)
		c = c + 1
	end

	return str
end

function BossRushConfig:getBossRushMainItemBossSprite(stage, activityId)
	local resName = self:getStageCO(stage, activityId).bossRushMainItemBossSprite

	return ResUrl.getV1a4BossRushIcon(resName)
end

function BossRushConfig:getResultViewFullBgSImage(stage, activityId)
	local resName = self:getStageCO(stage, activityId).resultViewFullBgSImage

	return ResUrl.getV1a4BossRushSinglebg(resName)
end

function BossRushConfig:getResultViewNameSImage(stage, activityId)
	local resName = self:getStageCO(stage, activityId).resultViewNameSImage

	return ResUrl.getV1a4BossRushLangPath(resName)
end

function BossRushConfig:getBossDetailTitlePath(stage, activityId)
	local resName = self:getStageCO(stage, activityId).resultViewNameSImage

	return ResUrl.getBossRushDetailPath(resName)
end

function BossRushConfig:getBossDetailFullPath(stage, activityId)
	local resName = self:getStageCO(stage, activityId).bossRushLevelDetailFullBgSimage

	return ResUrl.getBossRushDetailPath(resName)
end

function BossRushConfig:getBossRushLevelDetailFullBgSimage(stage, activityId)
	local resName = self:getStageCO(stage, activityId).bossRushLevelDetailFullBgSimage

	return ResUrl.getV1a4BossRushSinglebg(resName)
end

function BossRushConfig:getMonsterSkinIdList(stage, activityId)
	local str = self:getStageCO(stage, activityId).skinIds

	return string.splitToNumber(str, "#")
end

function BossRushConfig:getMonsterSkinScaleList(stage, activityId)
	local str = self:getStageCO(stage, activityId).skinScales

	return string.splitToNumber(str, "#")
end

function BossRushConfig:getMonsterSkinOffsetXYs(stage, activityId)
	local str = self:getStageCO(stage, activityId).skinOffsetXYs

	return GameUtil.splitString2(str, true)
end

function BossRushConfig:getQualityBgSpriteName(quality)
	return "bg_pinjidi_" .. quality
end

function BossRushConfig:getQualityFrameSpriteName(quality)
	return "bg_pinjidi_lanse_" .. quality
end

local _rewardStatusSpriteName = {
	[0] = "bg_xingjidian",
	"bg_xingjidian_1",
	"bg_xingjidian_dis",
	"bg_xingjidian_1_dis",
	"bg_xingjidian_layer4"
}

function BossRushConfig:getRewardStatusSpriteName(isDisplay, isGot)
	local id = 0

	if isDisplay then
		id = id + 1
	end

	if not isGot then
		id = id + 2
	end

	return _rewardStatusSpriteName[id]
end

function BossRushConfig:getSpriteRewardStatusSpriteName(isGot)
	local id = isGot and 4 or 2

	return _rewardStatusSpriteName[id]
end

function BossRushConfig:getStageRewardDisplayIndexesList(stage)
	return self:__getOrCreateStageRewardDisplayIndexesList(stage)
end

function BossRushConfig:__getOrCreateStageRewardDisplayIndexesList(stage)
	self.__cumulativeDisplayRewards = self.__cumulativeDisplayRewards or {}

	if self.__cumulativeDisplayRewards[stage] then
		return self.__cumulativeDisplayRewards[stage]
	end

	local res = {}
	local stageRewardList = self:getStageRewardList(stage)

	for i, stageRewardCO in ipairs(stageRewardList) do
		local isDisplay = stageRewardCO.display > 0

		if isDisplay then
			res[#res + 1] = i
		end
	end

	self.__cumulativeDisplayRewards[stage] = res

	return res
end

function BossRushConfig:calcStageRewardProgWidthByListScrollParam(stage, value, listScrollParam, firstStep, startPosX, endSpace)
	local cellWidth = listScrollParam.cellWidth
	local cellSpaceH = listScrollParam.cellSpaceH
	local normalStep = cellWidth + cellSpaceH

	endSpace = endSpace or listScrollParam.endSpace or 0

	return self:calcStageRewardProgWidth(stage, value, cellSpaceH, cellWidth, firstStep, normalStep, startPosX, endSpace)
end

function BossRushConfig:calcStageRewardProgWidth(stage, value, cellSpaceH, cellWidth, firstStep, normalStep, startPosX, endSpace)
	local stageRewardList = self:getStageRewardList(stage)
	local rewardCount = #stageRewardList

	if rewardCount == 0 then
		return 0, 0
	end

	startPosX = startPosX or 0
	endSpace = endSpace or 0
	firstStep = firstStep or cellWidth / 2
	normalStep = normalStep or cellWidth + cellSpaceH

	local maxWidth = firstStep + (rewardCount - 1) * normalStep + endSpace
	local curWidth = 0
	local last = 0

	for i, stageRewardCO in ipairs(stageRewardList) do
		local num = stageRewardCO.rewardPointNum
		local step = i == 1 and firstStep or normalStep

		if num <= value then
			curWidth = curWidth + step
			last = num
		else
			local offset = GameUtil.remap(value, last, num, 0, step)

			curWidth = curWidth + offset

			break
		end
	end

	local width = math.max(0, curWidth - startPosX)

	return width, maxWidth
end

function BossRushConfig:getBgmViewNames()
	self._bgmViews = self._bgmViews or {
		ViewName.V1a4_BossRushMainView,
		ViewName.V1a4_BossRushLevelDetail,
		ViewName.V1a4_BossRush_ScoreTaskAchievement,
		ViewName.V1a4_BossRush_ScheduleView
	}

	return self._bgmViews
end

function BossRushConfig:getMonsterResPathList(stage, activityId)
	local res = {}
	local skinIdList = BossRushConfig.instance:getMonsterSkinIdList(stage, activityId)

	for _, skinId in ipairs(skinIdList) do
		local skinCO = FightConfig.instance:getSkinCO(skinId)

		if skinCO then
			local resPath = ResUrl.getSpineUIPrefab(skinCO.spine)

			table.insert(res, resPath)
		end
	end

	return res
end

function BossRushConfig:initEvaluateCo()
	return
end

function BossRushConfig:getEvaluateInfo(id)
	local co = self:getEvaluateConfig(id)

	return co.name, co.desc
end

function BossRushConfig:getActRoleEnhanceCoById(roleId)
	local cos = self:getActRoleEnhance()

	return cos[roleId]
end

function BossRushConfig:getEpisodeCoByEpisodeId(episodeId)
	local episode12Dict = lua_activity128_episode.configDict[self.__activityId]

	if episode12Dict then
		for _, stageDict in pairs(episode12Dict) do
			for _, co in pairs(stageDict) do
				if co.episodeId == episodeId then
					return co
				end
			end
		end
	end
end

function BossRushConfig:getAssassinStyleZongmaoCo(id)
	return lua_assassin_style_zongmao.configDict[id]
end

function BossRushConfig:getV3a2BossTypeByStage(stage, activityId)
	local co = self:getStageCO(stage, activityId)

	if co then
		return co.type
	end
end

BossRushConfig.instance = BossRushConfig.New()

return BossRushConfig
