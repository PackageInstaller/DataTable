-- chunkname: @modules/logic/character/model/recommed/CharacterRecommedMO.lua

module("modules.logic.character.model.recommed.CharacterRecommedMO", package.seeall)

local CharacterRecommedMO = pureTable("CharacterRecommedMO")

function CharacterRecommedMO:init(co)
	self.id = co.id
	self.heroId = co.id
	self.co = co
	self.teamRec = GameUtil.splitString2(co.teamRec, true, "|", "#")
	self.equipRec = string.splitToNumber(co.equipRec, "|")
	self.lvRec = GameUtil.splitString2(co.lvRec, true, "|", "#")
	self.resonanceRec = string.splitToNumber(co.resonanceRec, "|")
end

function CharacterRecommedMO:getHeroMo()
	return (HeroModel.instance:getByHeroId(self.heroId))
end

function CharacterRecommedMO:getHeroConfig()
	return HeroConfig.instance:getHeroCO(self.heroId)
end

function CharacterRecommedMO:getHeroSkinConfig()
	local heroMo = self:getHeroMo()
	local config = self:getHeroConfig()

	if heroMo then
		if not heroMo.skin then
			local skin = config.skinId

			return SkinConfig.instance:getSkinCo(skin)
		end
	end
end

function CharacterRecommedMO:isOwnHero()
	local heroMo = self:getHeroMo()

	if not heroMo then
		return
	end

	return heroMo:isOwnHero()
end

function CharacterRecommedMO:getHeroLevel()
	local heroMo = self:getHeroMo()

	if heroMo then
		return heroMo.level
	end

	return (CharacterModel.instance:getMaxLevel(self.heroId))
end

function CharacterRecommedMO:getHeroRank()
	local heroMo = self:getHeroMo()

	if heroMo then
		return heroMo.rank
	end

	return (CharacterModel.instance:getMaxRank(self.heroId))
end

function CharacterRecommedMO:isFavor()
	local heroMo = self:getHeroMo()

	if heroMo then
		return heroMo.isFavor
	end
end

function CharacterRecommedMO:getExSkillLevel()
	local heroMo = self:getHeroMo()

	if heroMo then
		return heroMo.exSkillLevel
	end

	return (CharacterModel.instance:getMaxexskill(self.heroId))
end

function CharacterRecommedMO:getTalentLevel()
	local heroMo = self:getHeroMo()

	if heroMo then
		return heroMo.talent
	end

	local talentCo = SkillConfig.instance:getherotalentsCo(self.heroId)

	return #talentCo
end

function CharacterRecommedMO:isShowTeam()
	return self.co.teamDisplay == 1 and not string.nilorempty(self.co.teamRec)
end

function CharacterRecommedMO:isShowEquip()
	return self.co.equipDisplay == 1 and not string.nilorempty(self.co.equipRec)
end

function CharacterRecommedMO:getNextDevelopMaterial()
	local heroMo = self:getHeroMo()
	local heroConfig = self:getHeroConfig()

	self._developGoalsMOList = self._developGoalsMOList or {}

	if heroMo then
		if not heroMo.rank then
			local curRank = 1

			if heroMo then
				if not heroMo.level then
					local curLv = 1
					local showLevel, showRank = HeroConfig.instance:getShowLevel(curLv)
					local lvRec = self:_getRecommedLvRec(showLevel, showRank)

					if lvRec then
						local rank = lvRec[1]
						local materialList = {}

						for i = curRank + 1, rank do
							local rankCo = SkillConfig.instance:getherorankCO(self.heroId, i)

							if rankCo and not string.nilorempty(rankCo.consume) then
								self:_addMaterials(rankCo.consume, materialList)
							end
						end

						local realLevel = self:_getRealLevel(rank, lvRec[2])
						local ignoreLevels = self:_getIgnoreLevel(self.heroId)

						for level = curLv + 1, realLevel do
							if not LuaUtil.tableContains(ignoreLevels, level) then
								local cosumeConfig = SkillConfig.instance:getcosumeCO(level, heroConfig.rare)

								self:_addMaterials(cosumeConfig.cosume, materialList)
							end
						end

						local _items = self:_convertMaterial(materialList)
						local type = CharacterRecommedEnum.DevelopGoalsType.RankLevel
						local mo = self._developGoalsMOList[type]

						if not mo then
							mo = CharacterDevelopGoalsMO.New()

							mo:init(type, self.heroId)

							self._developGoalsMOList[type] = mo
						end

						mo:setItemList(_items)

						local levelTxt, levelIcon

						if rank > 1 then
							local txtFormat = luaLang("character_develop_goals_title_1")

							levelIcon = "character_recommend_targeticon" .. 3 + rank
							rank = GameUtil.getRomanNums(rank - 1)
							levelTxt = GameUtil.getSubPlaceholderLuaLangTwoParam(txtFormat, rank, lvRec[2])
						else
							local txtFormat = luaLang("character_develop_goals_title_2")

							levelTxt = GameUtil.getSubPlaceholderLuaLangOneParam(txtFormat, lvRec[2])
						end

						mo:setTitleTxtAndIcon(levelTxt, levelIcon)
					else
						self._developGoalsMOList[CharacterRecommedEnum.DevelopGoalsType.RankLevel] = nil
					end

					if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) and curRank >= CharacterEnum.TalentRank then
						local talent = self:getTalentLevel()
						local talentLvRec = self:_getRecommedTalentLvRec(talent)

						if talentLvRec then
							local materialList = {}

							for i = talent + 1, talentLvRec do
								local co = SkillConfig.instance:gettalentCO(self.heroId, i)

								if co then
									self:_addMaterials(co.consume, materialList)
								end
							end

							local _items = self:_convertMaterial(materialList)
							local type = CharacterRecommedEnum.DevelopGoalsType.TalentLevel
							local mo = self._developGoalsMOList[type]

							if not mo then
								mo = CharacterDevelopGoalsMO.New()

								mo:init(type, self.heroId)

								self._developGoalsMOList[type] = mo
							end

							mo:setItemList(_items)

							local txtFormat = luaLang("character_develop_goals_title_3")
							local levelTxt = GameUtil.getSubPlaceholderLuaLangOneParam(txtFormat, talentLvRec)
							local levelIcon = "character_recommend_targeticon3"

							mo:setTitleTxtAndIcon(levelTxt, levelIcon)
						else
							self._developGoalsMOList[CharacterRecommedEnum.DevelopGoalsType.TalentLevel] = nil
						end
					end

					return self._developGoalsMOList
				end
			end
		end
	end
end

function CharacterRecommedMO:getDevelopGoalsMO(type)
	local list = self:getNextDevelopMaterial()

	return list[type]
end

function CharacterRecommedMO:_convertMaterial(materialList)
	local list = {}

	if not materialList then
		return
	end

	for materilType, v in pairs(materialList) do
		for materilId, quantity in pairs(v) do
			table.insert(list, {
				materilType = materilType,
				materilId = materilId,
				quantity = quantity
			})
		end
	end

	return list
end

function CharacterRecommedMO:_getRealLevel(rank, level)
	local rankCo = SkillConfig.instance:getherorankCO(self.heroId, rank)

	if not rankCo then
		return CharacterModel.instance:getMaxLevel(self.heroId)
	end

	local demands = string.split(rankCo.requirement, "|")

	for _, v in pairs(demands) do
		local demand = string.splitToNumber(v, "#")

		if demand[1] == 1 then
			return demand[2] + level, demand[2]
		end
	end

	return level
end

function CharacterRecommedMO:_getIgnoreLevel(heroId)
	self._ignoreLevels = self._ignoreLevels or {}

	local ignoreLevel = self._ignoreLevels[heroId]

	if not ignoreLevel then
		ignoreLevel = {}

		local rankCos = SkillConfig.instance:getheroranksCO(self.heroId)

		for _, co in pairs(rankCos) do
			local demands = string.split(co.requirement, "|")

			for _, v in pairs(demands) do
				local demand = string.splitToNumber(v, "#")

				if demand[1] == 1 then
					table.insert(ignoreLevel, demand[2] + 1)
				end
			end
		end

		self._ignoreLevels[heroId] = ignoreLevel
	end

	return ignoreLevel
end

function CharacterRecommedMO:_addMaterials(consume, materialList)
	if string.nilorempty(consume) then
		return
	end

	local consumeList = GameUtil.splitString2(consume, true, "|", "#")

	for _, v in ipairs(consumeList) do
		local list = materialList[v[1]] or {}
		local count = list[v[2]]

		list[v[2]] = count and count + v[3] or v[3]
		materialList[v[1]] = list
	end
end

function CharacterRecommedMO:_getRecommedLvRec(level, rank)
	for _, v in ipairs(self.lvRec) do
		if v[1] == rank and level < v[2] or rank < v[1] then
			return v
		end
	end
end

function CharacterRecommedMO:_getRecommedTalentLvRec(talent)
	for _, v in ipairs(self.resonanceRec) do
		if talent < v then
			return v
		end
	end
end

return CharacterRecommedMO
