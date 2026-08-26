-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadRoleCardWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadRoleCardWork", package.seeall)

local FightPreloadRoleCardWork = class("FightPreloadRoleCardWork", BaseWork)

FightPreloadRoleCardWork.isOpen = true

function FightPreloadRoleCardWork:onStart(context)
	if not FightPreloadRoleCardWork.isOpen then
		self:onDone(true)

		return
	end

	self._loader = SequenceAbLoader.New()

	self:getRoleCardResList()
	self._loader:setConcurrentCount(10)
	self._loader:setPathList(self.resList)
	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function FightPreloadRoleCardWork:_onPreloadFinish()
	local assetItemDict = self._loader:getAssetItemDict()

	for _, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, assetItem)
		FightPreloadController.instance:addRoleCardAsset(assetItem)
	end

	self:onDone(true)
end

function FightPreloadRoleCardWork:_onPreloadOneFail(loader, assetItem)
	logError("战斗卡牌加载失败：" .. assetItem.ResPath)
end

function FightPreloadRoleCardWork:getRoleCardResList()
	self.resList = {}

	local heroSingleGroupMO = self:getSingleGroupModel()

	for i = 1, 4 do
		local groupMo = heroSingleGroupMO:getById(i)
		local heroCo = groupMo:getHeroCO()
		local monsterCo = groupMo:getMonsterCO()

		if heroCo then
			logNormal("预加载 角色 卡牌资源 ： " .. heroCo.name or "")
			self:addSkill(heroCo.skill)
			self:addHeroExSkill(heroCo.exSkill)
		elseif monsterCo then
			logNormal("预加载 怪物 卡牌资源 ： " .. monsterCo.name or "")
			self:addSkill(monsterCo.activeSkill)
			self:addMonsterUniqueSkill(monsterCo.uniqueSkill)
		end
	end

	return self.resList
end

function FightPreloadRoleCardWork:getSingleGroupModel()
	local fightParam = FightModel.instance:getFightParam()
	local episodeId = fightParam and fightParam.episodeId

	if episodeId then
		::label_5_0::

		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

		if episodeCo and episodeCo.type == DungeonEnum.EpisodeType.Rouge then
			return RougeHeroSingleGroupModel.instance
		else
			return HeroSingleGroupModel.instance
		end
	end
end

function FightPreloadRoleCardWork:addSkill(skillStr)
	if string.nilorempty(skillStr) then
		return
	end

	local skillList = FightStrUtil.instance:getSplitString2Cache(skillStr, true)

	for _, skill in ipairs(skillList) do
		self:addResBySkillId(skill[2])
	end
end

function FightPreloadRoleCardWork:addHeroExSkill(skillId)
	self:addResBySkillId(skillId)
end

function FightPreloadRoleCardWork:addMonsterUniqueSkill(uniqueSkillList)
	for _, skillId in ipairs(uniqueSkillList) do
		self:addResBySkillId(skillId)
	end
end

function FightPreloadRoleCardWork:addResBySkillId(skillId)
	local skillCo = lua_skill.configDict[skillId]

	if skillCo then
		if skillCo.icon == 0 then
			logError("技能未配置icon, skillId:" .. skillId)
		else
			table.insert(self.resList, ResUrl.getSkillIcon(skillCo.icon))
		end
	elseif skillId ~= 0 then
		logError("技能表找不到id:" .. skillId)
	end
end

function FightPreloadRoleCardWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return FightPreloadRoleCardWork
