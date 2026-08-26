-- chunkname: @modules/logic/scene/fight/preloadwork/FightRoundPreloadTimelineWork.lua

module("modules.logic.scene.fight.preloadwork.FightRoundPreloadTimelineWork", package.seeall)

local FightRoundPreloadTimelineWork = class("FightRoundPreloadTimelineWork", BaseWork)

function FightRoundPreloadTimelineWork:onStart(context)
	local timelineUrlList = self:_getTimelineUrlList()

	self._loader = SequenceAbLoader.New()

	for _, resPath in ipairs(timelineUrlList) do
		self._loader:addPath(resPath)
	end

	local conCurrentCount = 10

	self._loader:setConcurrentCount(conCurrentCount)
	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function FightRoundPreloadTimelineWork:_onPreloadFinish()
	local assetItemDict = self._loader:getAssetItemDict()

	self.context.timelineDict = self.context.timelineDict or {}

	for url, assetItem in pairs(assetItemDict) do
		self.context.timelineDict[url] = assetItem

		self.context.callback(self.context.callbackObj, assetItem)
	end

	self:onDone(true)
end

function FightRoundPreloadTimelineWork:_onPreloadOneFail(loader, assetItem)
	logError("Timeline加载失败：" .. assetItem.ResPath)
end

function FightRoundPreloadTimelineWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function FightRoundPreloadTimelineWork:_getTimelineUrlList()
	if not self.context.timelineDict then
		local lastTimelineDict = {}

		self.context.timelineUrlDict = {}
		self.context.timelineSkinDict = {}

		if SkillEditorMgr.instance.inEditMode then
			self:_clacEditor()
		else
			self:_calcFightCards()
		end

		local newTimelineUrlDict = {}

		for url, _ in pairs(self.context.timelineUrlDict) do
			if lastTimelineDict[url] == nil then
				table.insert(newTimelineUrlDict, url)
			end
		end

		return newTimelineUrlDict
	end
end

function FightRoundPreloadTimelineWork:_clacEditor()
	self.context.timelineUrlDict = {}
	self.context.timelineSkinDict = {}

	local mySideList = FightDataHelper.entityMgr:getMyNormalList()

	for _, one in ipairs(mySideList) do
		local modelId = one.modelId
		local skinId = one.skin

		self:_gatherModelSkillIds(FightEnum.EntitySide.MySide, modelId, skinId)
	end

	local enemySideList = FightDataHelper.entityMgr:getEnemyNormalList()

	for _, one in ipairs(enemySideList) do
		local modelId = one.modelId
		local skinId = one.skin

		self:_gatherModelSkillIds(FightEnum.EntitySide.EnemySide, modelId, skinId)
	end
end

function FightRoundPreloadTimelineWork:_calcFightCards()
	local roundData = FightDataHelper.roundMgr:getRoundData()
	local aiUseCardMOList = roundData and roundData:getAIUseCardMOList()
	local handCards = FightDataHelper.handCardMgr.handCard

	if aiUseCardMOList then
		for i, cardInfoMO in ipairs(aiUseCardMOList) do
			local entityMO = FightDataHelper.entityMgr:getById(cardInfoMO.uid)

			if entityMO then
				self:_gatherSkill(FightEnum.EntitySide.EnemySide, entityMO.skin, cardInfoMO.skillId)
			end
		end
	end

	for i, cardInfoMO in ipairs(handCards) do
		local entityMO = FightDataHelper.entityMgr:getById(cardInfoMO.uid)

		if entityMO then
			local skinId = FightHelper.processSkinId(entityMO, cardInfoMO)

			self:_gatherSkill(FightEnum.EntitySide.MySide, skinId, cardInfoMO.skillId)
		end
	end

	local battleId = FightModel.instance:getFightParam().battleId
	local battleCO = lua_battle.configDict[battleId]
	local additionRule = battleCO and battleCO.additionRule
	local hiddenRule = battleCO and battleCO.hiddenRule

	self:_checkBattleRuleSkill(additionRule)
	self:_checkBattleRuleSkill(hiddenRule)
end

function FightRoundPreloadTimelineWork:_checkBattleRuleSkill(rule)
	if not string.nilorempty(rule) then
		local ruleList = FightStrUtil.instance:getSplitString2Cache(rule, true, "|", "#")

		for _, v in ipairs(ruleList) do
			local ruleId = v[2]
			local ruleCO = lua_rule.configDict[ruleId]

			if ruleCO and ruleCO.type == DungeonEnum.AdditionRuleType.FightSkill then
				local skillId = tonumber(ruleCO.effect)

				self:_gatherSkill(FightEnum.EntitySide.BothSide, nil, skillId)

				break
			end
		end
	end
end

function FightRoundPreloadTimelineWork:_gatherModelSkillIds(side, modelId, skinId)
	local skillIds = FightHelper.buildSkills(modelId)

	if not skillIds then
		logError(modelId .. " no skill")
	end

	for _, skillId in ipairs(skillIds) do
		local skillCO = lua_skill.configDict[skillId]

		if not skillCO then
			local heroCO = lua_character.configDict[modelId]
			local monsterOrHero = heroCO and "角色：" or "怪物："

			logError(monsterOrHero .. modelId .. "，技能id不存在：" .. skillId)
		end

		self:_gatherSkill(side, skinId, skillId)
	end
end

function FightRoundPreloadTimelineWork:_gatherSkill(side, skinId, skillId)
	local timeline = FightConfig.instance:getSkinSkillTimeline(skinId, skillId)

	if not string.nilorempty(timeline) then
		local timelineList = FightHelper.getTimelineListByName(timeline, skinId)

		for i, v in ipairs(timelineList) do
			timeline = v

			local tlUrl = ResUrl.getSkillTimeline(v)
			local prevSide = self.context.timelineUrlDict[tlUrl]

			if not prevSide then
				self.context.timelineUrlDict[tlUrl] = side
			elseif prevSide == FightEnum.EntitySide.MySide and side == FightEnum.EntitySide.EnemySide then
				self.context.timelineUrlDict[tlUrl] = FightEnum.EntitySide.BothSide
			elseif prevSide == FightEnum.EntitySide.EnemySide and side == FightEnum.EntitySide.MySide then
				self.context.timelineUrlDict[tlUrl] = FightEnum.EntitySide.BothSide
			end

			skinId = skinId or 0
			self.context.timelineSkinDict[tlUrl] = self.context.timelineSkinDict[tlUrl] or {}
			self.context.timelineSkinDict[tlUrl][skinId] = true
		end
	end
end

return FightRoundPreloadTimelineWork
