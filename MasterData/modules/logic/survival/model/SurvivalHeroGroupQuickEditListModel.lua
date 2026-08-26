-- chunkname: @modules/logic/survival/model/SurvivalHeroGroupQuickEditListModel.lua

module("modules.logic.survival.model.SurvivalHeroGroupQuickEditListModel", package.seeall)

local SurvivalHeroGroupQuickEditListModel = class("SurvivalHeroGroupQuickEditListModel", HeroGroupQuickEditListModel)

function SurvivalHeroGroupQuickEditListModel:copyQuickEditCardList()
	local moList
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local inSurvival = weekInfo.inSurvival
	local teamInfo

	if HeroGroupTrialModel.instance:isOnlyUseTrial() then
		moList = {}
	elseif inSurvival then
		teamInfo = SurvivalMapModel.instance:getSceneMo().teamInfo
		moList = {}

		local hero = CharacterBackpackCardListModel.instance:getCharacterCardList()

		if hero then
			for i, heroMo in ipairs(hero) do
				local uid = heroMo.uid
				local have

				for id in pairs(teamInfo.heroUids) do
					if id == uid then
						have = true

						break
					end
				end

				if have then
					table.insert(moList, (teamInfo:getHeroMo(uid)))
				end
			end
		end
	else
		moList = CharacterBackpackCardListModel.instance:getCharacterCardList()
	end

	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUidMap = {}
	self._inTeamHeroUidList = {}
	self._originalHeroUidList = {}
	self._selectUid = nil

	local alreadyList = HeroSingleGroupModel.instance:getList()

	for pos, heroSingleGroupMO in ipairs(alreadyList) do
		local heroUid = heroSingleGroupMO.heroUid

		if tonumber(heroUid) > 0 and not repeatHero[heroUid] then
			if inSurvival then
				table.insert(newMOList, (teamInfo:getHeroMo(heroUid)))
			else
				table.insert(newMOList, HeroModel.instance:getById(heroUid))
			end

			self._inTeamHeroUidMap[heroUid] = 1
			repeatHero[heroUid] = true
		else
			local singleGroupMo = HeroSingleGroupModel.instance:getByIndex(pos)

			if singleGroupMo.trial then
				table.insert(newMOList, HeroGroupTrialModel.instance:getById(heroUid))

				self._inTeamHeroUidMap[heroUid] = 1
				repeatHero[heroUid] = true
			end
		end

		table.insert(self._inTeamHeroUidList, heroUid)
		table.insert(self._originalHeroUidList, heroUid)
	end

	local trialList = HeroGroupTrialModel.instance:getFilterList()

	for i, heroMo in ipairs(trialList) do
		if not repeatHero[heroMo.uid] then
			table.insert(newMOList, heroMo)
		end
	end

	local deathList = {}

	for i, mo in ipairs(moList) do
		if not repeatHero[mo.uid] then
			repeatHero[mo.uid] = true

			local healthMo = weekInfo:getHeroMo(mo.heroId)

			if healthMo.health <= 0 or SurvivalHeroGroupEditListModel.instance:getSelectByIndex(mo.heroId) ~= nil then
				table.insert(deathList, mo)
			else
				table.insert(newMOList, mo)
			end
		end
	end

	tabletool.addValues(newMOList, deathList)
	self:setList(newMOList)
end

function SurvivalHeroGroupQuickEditListModel:isTeamFull()
	local limitRole = HeroGroupModel.instance:getBattleRoleNum() or 0

	for i = 1, math.min(limitRole, #self._inTeamHeroUidList) do
		if self._inTeamHeroUidList[i] == "0" then
			return false
		end
	end

	return true
end

SurvivalHeroGroupQuickEditListModel.instance = SurvivalHeroGroupQuickEditListModel.New()

return SurvivalHeroGroupQuickEditListModel
