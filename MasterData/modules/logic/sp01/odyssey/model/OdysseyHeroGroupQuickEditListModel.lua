-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyHeroGroupQuickEditListModel.lua

module("modules.logic.sp01.odyssey.model.OdysseyHeroGroupQuickEditListModel", package.seeall)

local OdysseyHeroGroupQuickEditListModel = class("OdysseyHeroGroupQuickEditListModel", HeroGroupQuickEditListModel)

function OdysseyHeroGroupQuickEditListModel:copyQuickEditCardList()
	local moList = HeroGroupTrialModel.instance:isOnlyUseTrial() and {} or CharacterBackpackCardListModel.instance:getCharacterCardList()
	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUidMap = {}
	self._inTeamHeroUidList = {}
	self._originalHeroUidList = {}
	self._selectUid = nil

	local alreadyList = HeroSingleGroupModel.instance:getList()

	for pos, heroSingleGroupMO in ipairs(alreadyList) do
		local posOpen = OdysseyHeroGroupModel.instance:isPositionOpen(pos)
		local heroUid = heroSingleGroupMO.heroUid

		if tonumber(heroUid) > 0 and not repeatHero[heroUid] then
			table.insert(newMOList, HeroModel.instance:getById(heroUid))

			if posOpen then
				self._inTeamHeroUidMap[heroUid] = 1
			end

			repeatHero[heroUid] = true
		else
			local singleGroupMo = HeroSingleGroupModel.instance:getByIndex(pos)

			if singleGroupMo.trial then
				table.insert(newMOList, HeroGroupTrialModel.instance:getById(heroUid))

				if posOpen then
					self._inTeamHeroUidMap[heroUid] = 1
				end

				repeatHero[heroUid] = true
			end
		end

		if posOpen then
			table.insert(self._inTeamHeroUidList, heroUid)
			table.insert(self._originalHeroUidList, heroUid)
		end
	end

	local trialList = HeroGroupTrialModel.instance:getFilterList()

	for i, heroMo in ipairs(trialList) do
		if not repeatHero[heroMo.uid] then
			table.insert(newMOList, heroMo)
		end
	end

	local isTowerBattle = self.isTowerBattle
	local isWeekWalk_2 = self.isWeekWalk_2
	local deathList = {}

	if isTowerBattle then
		for i = #newMOList, 1, -1 do
			if TowerModel.instance:isHeroBan(newMOList[i].heroId) then
				table.insert(deathList, newMOList[i])
				table.remove(newMOList, i)
			end
		end
	end

	for i, mo in ipairs(moList) do
		if not repeatHero[mo.uid] then
			repeatHero[mo.uid] = true

			if self.adventure then
				local cd = WeekWalkModel.instance:getCurMapHeroCd(mo.heroId)

				if cd > 0 then
					table.insert(deathList, mo)
				else
					table.insert(newMOList, mo)
				end
			elseif isWeekWalk_2 then
				local cd = WeekWalk_2Model.instance:getCurMapHeroCd(mo.heroId)

				if cd > 0 then
					table.insert(deathList, mo)
				else
					table.insert(newMOList, mo)
				end
			elseif isTowerBattle then
				if TowerModel.instance:isHeroBan(mo.heroId) then
					table.insert(deathList, mo)
				else
					table.insert(newMOList, mo)
				end
			else
				table.insert(newMOList, mo)
			end
		end
	end

	if self.adventure or isTowerBattle or isWeekWalk_2 then
		tabletool.addValues(newMOList, deathList)
	end

	self:setList(newMOList)
end

local instance = OdysseyHeroGroupQuickEditListModel.New()

return OdysseyHeroGroupQuickEditListModel
