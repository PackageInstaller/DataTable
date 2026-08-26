-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadRoleCardByRealDataWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadRoleCardByRealDataWork", package.seeall)

local FightPreloadRoleCardByRealDataWork = class("FightPreloadRoleCardByRealDataWork", BaseWork)

FightPreloadRoleCardByRealDataWork.isOpen = true

function FightPreloadRoleCardByRealDataWork:onStart(context)
	if not FightPreloadRoleCardByRealDataWork.isOpen then
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

function FightPreloadRoleCardByRealDataWork:_onPreloadFinish()
	local assetItemDict = self._loader:getAssetItemDict()

	for _, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, assetItem)
		FightPreloadController.instance:addRoleCardAsset(assetItem)
	end

	self:onDone(true)
end

function FightPreloadRoleCardByRealDataWork:_onPreloadOneFail(loader, assetItem)
	logError("战斗卡牌加载失败：" .. assetItem.ResPath)
end

function FightPreloadRoleCardByRealDataWork:getRoleCardResList()
	self.resList = {}

	local entityList = {}

	FightDataHelper.entityMgr:getMyNormalList(entityList)
	FightDataHelper.entityMgr:getMySpList(entityList)

	for i, entityData in ipairs(entityList) do
		for index, skillId in ipairs(entityData.skillGroup1) do
			self:addResBySkillId(skillId)
		end

		for index, skillId in ipairs(entityData.skillGroup2) do
			self:addResBySkillId(skillId)
		end

		if entityData.exSkill ~= 0 then
			self:addResBySkillId(entityData.exSkill)
		end
	end

	return self.resList
end

function FightPreloadRoleCardByRealDataWork:addResBySkillId(skillId)
	local skillCo = lua_skill.configDict[skillId]

	if skillCo then
		if skillCo.icon == 0 then
			logError("技能未配置icon, skillId:" .. skillId)
		else
			table.insert(self.resList, ResUrl.getSkillIcon(skillCo.icon))

			local config = lua_fight_card_choice.configDict[skillId]

			if config then
				local skillList = string.splitToNumber(config.choiceSkIlls, "#")

				for _, skill in ipairs(skillList) do
					local skillConfig = lua_skill.configDict[skill]

					if skillConfig then
						table.insert(self.resList, ResUrl.getSkillIcon(skillConfig.icon))
					end
				end
			end
		end
	elseif skillId ~= 0 then
		logError("技能表找不到id:" .. skillId)
	end
end

function FightPreloadRoleCardByRealDataWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return FightPreloadRoleCardByRealDataWork
