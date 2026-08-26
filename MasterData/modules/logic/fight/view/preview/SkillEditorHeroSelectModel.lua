-- chunkname: @modules/logic/fight/view/preview/SkillEditorHeroSelectModel.lua

module("modules.logic.fight.view.preview.SkillEditorHeroSelectModel", package.seeall)

local SkillEditorHeroSelectModel = class("SkillEditorHeroSelectModel", ListScrollModel)

SkillEditorHeroSelectModel.selectedCharacterTagDict = {}

function SkillEditorHeroSelectModel:setSelect(side, selectType, stancePosId, searchText)
	self.side = side
	self.selectType = selectType
	self.stancePosId = stancePosId

	local coList = self:_getCOList()
	local list = {}

	for i, co in ipairs(coList) do
		if not string.find(tostring(co.id), searchText) and not string.find(tostring(co.skinId), searchText) then
			if not string.find(co.name or "", searchText) then
				if string.find(FightConfig.instance:getSkinCO(co.skinId) and FightConfig.instance:getSkinCO(co.skinId).name or "", searchText) then
					local mo = {
						id = i,
						co = co
					}

					table.insert(list, mo)
				elseif self.selectType == SkillEditorMgr.SelectType.Group then
					self:_cacheGroupNames()

					local groupMonsterName = self._groupId2NameDict[co.id]

					if groupMonsterName and string.find(groupMonsterName, searchText) then
						local mo = {
							id = i,
							co = co
						}

						table.insert(list, mo)
					end
				end
			end
		end
	end

	self:setList(list)
end

function SkillEditorHeroSelectModel:_getCOList()
	if self.selectType == SkillEditorMgr.SelectType.Hero then
		local hasTag = false

		for k, v in pairs(SkillEditorHeroSelectModel.selectedCharacterTagDict) do
			if v then
				hasTag = true

				break
			end
		end

		if not hasTag then
			return lua_character.configList
		else
			if not self.tag2CharacterList then
				self.tag2CharacterList = {}

				for i, config in ipairs(lua_character.configList) do
					local skillList = FightHelper._buildHeroSkills(config)

					if skillList and #skillList > 0 then
						local skillConfig = lua_skill.configDict[skillList[1]]

						if skillConfig then
							self.tag2CharacterList[skillConfig.showTag] = self.tag2CharacterList[skillConfig.showTag] or {}

							table.insert(self.tag2CharacterList[skillConfig.showTag], config)
						end
					end

					local editorRoleConfig = lua_editor_role_sources.configDict[config.id]

					if editorRoleConfig then
						local skillArr = string.splitToNumber(editorRoleConfig.exSkill, "#")

						for _, v in ipairs(skillArr) do
							local skillConfig = lua_skill.configDict[v]

							if skillConfig then
								self.tag2CharacterList[skillConfig.showTag] = self.tag2CharacterList[skillConfig.showTag] or {}

								table.insert(self.tag2CharacterList[skillConfig.showTag], config)
							end
						end
					end
				end
			end

			local retList = {}

			for tag, coList in pairs(self.tag2CharacterList) do
				if SkillEditorHeroSelectModel.selectedCharacterTagDict[tag] then
					for i, co in ipairs(coList) do
						table.insert(retList, co)
					end
				end
			end

			return retList
		end
	elseif self.selectType == SkillEditorMgr.SelectType.SubHero then
		return lua_character.configList
	elseif self.selectType == SkillEditorMgr.SelectType.Monster then
		local dict = {}
		local list = {}

		for _, monsterCO in ipairs(lua_monster.configList) do
			dict[monsterCO.skinId] = dict[monsterCO.skinId] or {}

			if not string.nilorempty(monsterCO.activeSkill) then
				table.insert(dict[monsterCO.skinId], 1, monsterCO)
			else
				table.insert(dict[monsterCO.skinId], monsterCO)
			end
		end

		for k, v in pairs(dict) do
			table.insert(list, v[1])
		end

		table.sort(list, function(item1, item2)
			return item1.skinId < item2.skinId
		end)

		return list
	elseif self.selectType == SkillEditorMgr.SelectType.Group then
		self:_cacheGroupNames()

		return lua_monster_group.configList
	elseif self.selectType == SkillEditorMgr.SelectType.MonsterId then
		return lua_monster.configList
	end
end

function SkillEditorHeroSelectModel:_cacheGroupNames()
	if self._groupId2NameDict then
		return
	end

	self._groupId2NameDict = {}

	for _, co in ipairs(lua_monster_group.configList) do
		local monsterIds = string.splitToNumber(co.monster, "#")
		local monsterCO = lua_monster.configDict[monsterIds[1]]

		for i = 2, #monsterIds do
			if tabletool.indexOf(string.splitToNumber(co.bossId, "#"), monsterIds[i]) then
				monsterCO = lua_monster.configDict[monsterIds[i]]

				break
			end
		end

		self._groupId2NameDict[co.id] = monsterCO and monsterCO.name
	end
end

SkillEditorHeroSelectModel.instance = SkillEditorHeroSelectModel.New()

return SkillEditorHeroSelectModel
