-- chunkname: @modules/logic/fight/mgr/SkillEditorMgr.lua

module("modules.logic.fight.mgr.SkillEditorMgr", package.seeall)

local SkillEditorMgr = class("SkillEditorMgr")

SkillEditorMgr.OnSelectEntity = 2020
SkillEditorMgr.ShowHeroSelectView = 2021
SkillEditorMgr.OnSubHeroEnter = 2022
SkillEditorMgr.OnSelectSkill = 2023
SkillEditorMgr.OnClickOutline = 2024
SkillEditorMgr.OnSelectStance = 2025
SkillEditorMgr._onSwitchEnityOrSkill = 2026
SkillEditorMgr._StopAutoPlayFlow1 = 2027
SkillEditorMgr._StopAutoPlayFlow2 = 2028
SkillEditorMgr._OpenAutoPlaySkin = 2029
SkillEditorMgr._SelectAutoPlaySkin = 2030
SkillEditorMgr.DefaultSceneLevelId = 10801
SkillEditorMgr.DefaultHeroId = 3023
SkillEditorMgr.DefaultMonsterId = 110401
SkillEditorMgr.SelectType = {
	Group = 3,
	Monster = 2,
	MonsterId = 5,
	Hero = 1,
	SubHero = 4
}

function SkillEditorMgr:start()
	self.inEditMode = true

	local fightData = FightData.New(FightDef_pb.Fight())

	fightData.version = 999

	FightMgr.instance:startFight(fightData)
	self:InitDefaultData()
	LuaEventSystem.addEventMechanism(self)

	UnityEngine.Application.targetFrameRate = 60

	local fightParam = FightParam.New()
	local sceneLevelId = self:getSceneLevelId() or SkillEditorMgr.DefaultSceneLevelId

	fightParam:setSceneLevel(sceneLevelId)
	FightModel.instance:setFightParam(fightParam)
	self:refreshInfo(FightEnum.EntitySide.MySide)
	self:AddSubHeroModelData()
	self:refreshInfo(FightEnum.EntitySide.EnemySide)
	GameSceneMgr.instance:registerCallback(SceneType.Fight, self._onFightSceneStart, self)
	FightController.instance:enterFightScene()
end

function SkillEditorMgr:InitDefaultData()
	self.stance_count_limit = 3
	self.enemy_stance_count_limit = 3
	self.stance_id = FightEnum.MySideDefaultStanceId
	self.enemy_stance_id = FightEnum.EnemySideDefaultStanceId
	self.cur_select_entity_id = nil
	self.cur_select_side = FightEnum.EntitySide.MySide
end

function SkillEditorMgr:exit()
	ViewMgr.instance:closeView(ViewName.SkillEditorView)
	ViewMgr.instance:closeView(ViewName.SkillEffectStatView)

	self.inEditMode = false
end

function SkillEditorMgr:_onFightSceneStart(sceneLevelId, Exit0Enter1)
	if Exit0Enter1 == 1 then
		GameSceneMgr.instance:unregisterCallback(SceneType.Fight, self._onFightSceneStart, self)
		ViewMgr.instance:closeAllViews()
		ViewMgr.instance:openView(ViewName.SkillEditorView)
		ViewMgr.instance:openView(ViewName.SkillEffectStatView)
		MainController.instance:dispatchEvent(MainEvent.OnFirstEnterMain)
	end
end

function SkillEditorMgr:getSceneLevelId()
	return PlayerPrefsHelper.getNumber(PlayerPrefsKey.SkillEditorSceneLevelId, nil)
end

function SkillEditorMgr:setSceneLevelId(levelId)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SkillEditorSceneLevelId, levelId)
end

function SkillEditorMgr:getTypeInfo(side)
	if not self._saveTypeR then
		local saveInfoStr = PlayerPrefsHelper.getString(PlayerPrefsKey.SkillEditorInfos)

		self._saveTypeR = SkillEditorMgr.SelectType.Hero
		self._saveInfoR = {}
		self._saveTypeL = SkillEditorMgr.SelectType.Monster
		self._saveInfoL = {}

		if string.nilorempty(saveInfoStr) then
			local defaultHeroCO = lua_character.configDict[SkillEditorMgr.DefaultHeroId]

			self._saveInfoR.ids = {
				defaultHeroCO.id
			}
			self._saveInfoR.skinIds = {
				defaultHeroCO.skinId
			}

			local defaultMonsterCO = lua_monster.configDict[SkillEditorMgr.DefaultMonsterId]

			self._saveInfoL.ids = {
				defaultMonsterCO.id
			}
			self._saveInfoL.skinIds = {
				defaultMonsterCO.skinId
			}
		else
			local saveInfoArr = string.split(saveInfoStr, "|")

			self._saveTypeR = tonumber(saveInfoArr[1])

			local tempR = string.split(saveInfoArr[2], "#")

			self._saveInfoR.ids = string.splitToNumber(tempR[1], ":")
			self._saveInfoR.skinIds = string.splitToNumber(tempR[2], ":")
			self._saveInfoR.groupId = self._saveTypeR == SkillEditorMgr.SelectType.Group and tonumber(tempR[3])
			self._saveTypeL = tonumber(saveInfoArr[3])

			local tempL = string.split(saveInfoArr[4], "#")

			self._saveInfoL.ids = string.splitToNumber(tempL[1], ":")
			self._saveInfoL.skinIds = string.splitToNumber(tempL[2], ":")
			self._saveInfoL.groupId = self._saveTypeL == SkillEditorMgr.SelectType.Group and tonumber(tempL[3])
		end

		self.select_sub_hero_id = self._saveInfoR.ids[1]
		self.select_sub_hero_skin_id = self._saveInfoR.skinIds[1]
	end

	if side == FightEnum.EntitySide.MySide then
		return self._saveTypeR, self._saveInfoR
	else
		return self._saveTypeL, self._saveInfoL
	end
end

function SkillEditorMgr:setTypeInfo(side, type, ids, skinIds, groupId)
	if side == FightEnum.EntitySide.MySide then
		self._saveTypeR = type
		self._saveInfoR.ids = ids
		self._saveInfoR.skinIds = skinIds
		self._saveInfoR.groupId = groupId
	else
		self._saveTypeL = type
		self._saveInfoL.ids = ids
		self._saveInfoL.skinIds = skinIds
		self._saveInfoL.groupId = groupId
	end

	local right = table.concat(self._saveInfoR.ids, ":") .. "#" .. table.concat(self._saveInfoR.skinIds, ":")

	if self._saveTypeR == SkillEditorMgr.SelectType.Group then
		right = right .. "#" .. self._saveInfoR.groupId
	end

	local left = table.concat(self._saveInfoL.ids, ":") .. "#" .. table.concat(self._saveInfoL.skinIds, ":")

	if self._saveTypeL == SkillEditorMgr.SelectType.Group then
		left = left .. "#" .. self._saveInfoL.groupId
	end

	local saveInfoStr = string.format("%d|%s|%d|%s", self._saveTypeR, right, self._saveTypeL, left)

	PlayerPrefsHelper.setString(PlayerPrefsKey.SkillEditorInfos, saveInfoStr)
end

function SkillEditorMgr:refreshInfo(side)
	local type, info = self:getTypeInfo(side)

	self:setTypeInfo(side, type, info.ids, info.skinIds, info.groupId)
	self:setEntityMOs(side, type, info.ids, info.skinIds)
end

function SkillEditorMgr:setEntityMOs(side, type, ids, skinIds)
	if type == SkillEditorMgr.SelectType.Hero then
		local main, sub = FightHelper.buildHeroEntityMOList(side, ids, skinIds)

		FightDataHelper.entityMgr:clientTestSetEntity(side, main, sub)
	else
		local main, sub = FightHelper.buildMonsterEntityMOList(side, ids)

		FightDataHelper.entityMgr:clientTestSetEntity(side, main, sub)
	end
end

function SkillEditorMgr:addSubHero(hero_id, skin_id)
	local side = FightEnum.EntitySide.MySide
	local type, info = self:getTypeInfo(side)

	for i, v in ipairs(info.ids) do
		if not lua_character.configDict[v] then
			return
		end
	end

	self.select_sub_hero_id = hero_id
	self.select_sub_hero_skin_id = skin_id

	SkillEditorMgr.instance:rebuildEntitys(side)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectEntity, side)
end

function SkillEditorMgr:clearSubHero()
	self.select_sub_hero_id = nil
	self.select_sub_hero_model = nil

	local side = FightEnum.EntitySide.MySide

	self:refreshInfo(side)
	SkillEditorMgr.instance:rebuildEntitys(side)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectEntity, side)
end

function SkillEditorMgr:rebuildEntitys(side)
	if side == FightEnum.EntitySide.MySide then
		if not SceneTag.UnitPlayer then
			local tag = SceneTag.UnitMonster
			local entityMgr = FightGameMgr.entityMgr
			local list = entityMgr:getTagList(tag)

			if list then
				for _, entity in ipairs(list) do
					if entity.skill then
						entity.skill:stopSkill()
					end

					FightController.instance:dispatchEvent(FightEvent.BeforeDeadEffect, entity.id)
					entityMgr:delEntity(entity.id)
				end
			end

			local entityMOs = FightDataHelper.entityMgr:getNormalList(side)

			for _, entityMO in ipairs(entityMOs) do
				entityMgr:newEntity(entityMO)
			end

			if side == FightEnum.EntitySide.MySide and self.select_sub_hero_id then
				self:_buildSubHero()
			end
		end
	end
end

function SkillEditorMgr:AddSubHeroModelData()
	if not self.select_sub_hero_id then
		return
	end

	local main, sub = FightHelper.buildHeroEntityMOList(FightEnum.EntitySide.MySide, {}, {}, {
		self.select_sub_hero_id
	}, {
		self.select_sub_hero_skin_id
	})

	FightDataHelper.entityMgr:clientSetSubEntityList(FightEnum.EntitySide.MySide, sub)

	self.select_sub_hero_model = sub[1]
end

function SkillEditorMgr:_buildSubHero()
	self:AddSubHeroModelData()

	local sub_entity = FightDataHelper.entityMgr:getMySubList()

	if sub_entity then
		for _, entityMO in ipairs(sub_entity) do
			FightGameMgr.entityMgr:newEntity(entityMO)
		end
	end
end

SkillEditorMgr.instance = SkillEditorMgr.New()

return SkillEditorMgr
