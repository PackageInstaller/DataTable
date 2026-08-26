-- chunkname: @modules/logic/fight/model/mo/FightParam.lua

module("modules.logic.fight.model.mo.FightParam", package.seeall)

local FightParam = pureTable("FightParam")

function FightParam:ctor()
	self.name = nil
	self.sceneId = nil
	self.levelId = nil
	self.sceneIds = nil
	self.levelIds = nil
	self.clothId = nil
	self.mySideUids = nil
	self.mySideSubUids = nil
	self.monsterGroupIds = nil
	self.episodeId = nil
	self.battleId = nil
	self.equips = nil
	self.isShowSettlement = true
	self.extraList = nil
	self.assistUserId = nil
	self.assistHeroUid = nil
	self.assistBossId = nil
	self.params = nil
	self.chapterId = nil
	self.episodeId = nil
	self.multiplication = nil
	self.preload = false
	self.adventure = nil
	self.isTestFight = false
	self.isReplay = false
end

function FightParam:setAdventure(adventure)
	self.adventure = adventure
end

function FightParam:setPreload()
	self.preload = true
end

function FightParam:setDungeon(chapterId, episodeId, multiplication)
	self.chapterId = chapterId
	self.episodeId = episodeId
	self.multiplication = multiplication
end

function FightParam:setShowSettlement(value)
	self.isShowSettlement = value
end

function FightParam:setReqFightGroup(req)
	local fightGroup = req.fightGroup

	if req.isRestart then
		local preGroup = FightModel.instance.last_fightGroup

		tabletool.addValues(fightGroup.heroList, preGroup.heroList)
		tabletool.addValues(fightGroup.subHeroList, preGroup.subHeroList)
		tabletool.addValues(fightGroup.equips, preGroup.equips)
		tabletool.addValues(fightGroup.trialHeroList, preGroup.trialHeroList)
		tabletool.addValues(fightGroup.activity104Equips, preGroup.activity104Equips)
		tabletool.addValues(fightGroup.extraList, preGroup.extraList)

		fightGroup.clothId = preGroup.clothId
		fightGroup.assistHeroUid = preGroup.assistHeroUid
		fightGroup.assistUserId = preGroup.assistUserId

		if preGroup.assistBossId then
			fightGroup.assistBossId = preGroup.assistBossId
		end

		if preGroup.params then
			fightGroup.params = preGroup.params
		end

		return
	end

	if Activity104Model.instance:isSeasonChapter() or Activity104Model.instance:isSeasonGMChapter() then
		FightParam.initFightGroup(fightGroup, self.clothId, self.mySideUids, self.mySideSubUids, self.equips, self.activity104Equips)
	elseif Season123Controller.sendEpisodeUseSeason123Equip() then
		FightParam.initFightGroup(fightGroup, self.clothId, self.mySideUids, self.mySideSubUids, self.equips, self.activity104Equips)
	else
		FightParam.initFightGroup(fightGroup, self.clothId, self.mySideUids, self.mySideSubUids, self.equips, nil, self.assistBossId, self.params)
	end

	tabletool.addValues(fightGroup.extraList, self.extraList)

	if self.assistHeroUid then
		fightGroup.assistHeroUid = self.assistHeroUid
	end

	if self.assistUserId then
		fightGroup.assistUserId = self.assistUserId
	end

	self.trialHeroList = fightGroup.trialHeroList
end

function FightParam.initFightGroup(fightGroup, clothId, heroList, subHeroList, equips, activity104Equips, assistBossId, params)
	if clothId then
		fightGroup.clothId = clothId
	end

	if assistBossId then
		fightGroup.assistBossId = assistBossId
	end

	if params then
		fightGroup.params = params
	end

	local trialDict = {}

	if heroList then
		if not #heroList then
			local heroListLen = 0

			if heroList then
				for index, hero in ipairs(heroList) do
					if tonumber(hero) < 0 then
						local mo = HeroGroupTrialModel.instance:getById(hero)

						if mo then
							trialDict[index] = FightDef_pb.TrialHero()
							trialDict[index].pos = index
							trialDict[index].trialId = mo.trialCo.id
						else
							table.insert(fightGroup.heroList, hero)
						end
					else
						table.insert(fightGroup.heroList, hero)
					end
				end
			end

			if subHeroList then
				for index, subHero in ipairs(subHeroList) do
					if tonumber(subHero) < 0 then
						local mo = HeroGroupTrialModel.instance:getById(subHero)

						if mo then
							trialDict[index + heroListLen] = FightDef_pb.TrialHero()
							trialDict[index + heroListLen].pos = -index
							trialDict[index + heroListLen].trialId = mo.trialCo.id
						else
							table.insert(fightGroup.subHeroList, subHero)
						end
					else
						table.insert(fightGroup.subHeroList, subHero)
					end
				end
			end

			if equips then
				local _, assistMo = HeroGroupModel.instance:getAssistMo()

				for i, v in ipairs(equips) do
					if trialDict[i] then
						for _, uid in ipairs(v.equipUid) do
							table.insert(trialDict[i].equipUid, uid)
						end
					else
						local assistuid
						local fightEquip = FightDef_pb.FightEquip()

						fightEquip.heroUid = (assistMo and assistMo.id == i or nil) and assistMo.heroUid or v.heroUid

						for _, uid in ipairs(v.equipUid) do
							table.insert(fightEquip.equipUid, uid)
						end

						table.insert(fightGroup.equips, fightEquip)
					end
				end
			end

			if activity104Equips then
				for i, v in ipairs(activity104Equips) do
					local fightEquip = FightDef_pb.FightEquip()

					fightEquip.heroUid = v.heroUid

					if v.equipUid then
						for _, uid in ipairs(v.equipUid) do
							table.insert(fightEquip.equipUid, uid)

							if trialDict[i] then
								table.insert(trialDict[i].act104EquipUid, uid)
							end
						end
					end

					if v.equipId then
						for _, id in ipairs(v.equipId) do
							table.insert(fightEquip.equipId, id)

							if trialDict[i] then
								table.insert(trialDict[i].act104EquipId, id)
							end
						end
					end

					table.insert(fightGroup.activity104Equips, fightEquip)
				end
			end

			for _, v in pairs(trialDict) do
				table.insert(fightGroup.trialHeroList, v)
			end
		end
	end
end

function FightParam:setAssistHeroInfo(assistHeroUid, assistUserId)
	self.assistHeroUid = assistHeroUid
	self.assistUserId = assistUserId
end

function FightParam:setMySide(clothId, mainUids, subUids, equips, activity104Equips, trialHeroList, extraList, assistBossId, params)
	self.clothId = clothId
	self.mySideUids = mainUids
	self.mySideSubUids = subUids
	self.equips = equips
	self.activity104Equips = activity104Equips
	self.trialHeroList = trialHeroList
	self.extraList = extraList
	self.assistBossId = assistBossId
	self.params = params
end

function FightParam:setEpisodeAndBattle(episodeId, battleId)
	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)

	self.name = episodeCO.name
	self.episodeId = episodeId
	self.chapterId = episodeCO.chapterId

	self:setBattleId(battleId)
end

function FightParam:setEpisodeId(episodeId, battleId)
	battleId = battleId or DungeonConfig.instance:getEpisodeBattleId(episodeId)

	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)

	self.name = episodeCO.name
	self.episodeId = episodeId
	self.chapterId = episodeCO.chapterId

	self:setBattleId(battleId)
end

function FightParam:setBattleId(battleId)
	self.battleId = battleId

	local battleConfig = lua_battle.configDict[battleId]

	self.sceneIds, self.levelIds = FightHelper.buildSceneAndLevel(self.episodeId, battleId)

	local waveId = FightModel.instance:getCurWaveId()

	self.sceneId = self:getScene(waveId)
	self.levelId = self:getSceneLevel(waveId)
	self.monsterGroupIds = string.splitToNumber(battleConfig.monsterGroupIds, "#")
end

function FightParam:getCurEpisodeConfig()
	return DungeonConfig.instance:getEpisodeCO(self.episodeId)
end

function FightParam:setSceneLevel(levelId)
	local levelCO = lua_scene_level.configDict[levelId]

	self.levelIds = {
		levelId
	}
	self.sceneIds = {
		levelCO.sceneId
	}
	self.sceneId = levelCO.sceneId
	self.levelId = levelId
end

function FightParam:getScene(waveId)
	if self.sceneIds and #self.sceneIds > 0 then
		if waveId <= #self.sceneIds then
			return self.sceneIds[waveId]
		else
			return self.sceneIds[#self.sceneIds]
		end
	end
end

function FightParam:getSceneLevel(waveId)
	if self.levelIds and #self.levelIds > 0 then
		if waveId <= #self.levelIds then
			return self.levelIds[waveId]
		else
			return self.levelIds[#self.levelIds]
		end
	end

	local levelCOs = SceneConfig.instance:getSceneLevelCOs(self.sceneId)

	return levelCOs[1].id
end

function FightParam:getAllHeroMoList()
	local heroMoList = {}

	for _, uid in ipairs(self.mySideUids) do
		local heroMo = HeroModel.instance:getById(uid)

		if heroMo then
			table.insert(heroMoList, heroMo)
		end
	end

	for _, uid in ipairs(self.mySideSubUids) do
		local heroMo = HeroModel.instance:getById(uid)

		if heroMo then
			table.insert(heroMoList, heroMo)
		end
	end

	return heroMoList
end

function FightParam:getMainHeroMoList()
	local mainHeroMoList = {}

	for _, uid in ipairs(self.mySideUids) do
		local heroMo = HeroModel.instance:getById(uid)

		if heroMo then
			table.insert(mainHeroMoList, heroMo)
		end
	end

	if self.trialHeroList then
		for _, trialInfo in ipairs(self.trialHeroList) do
			if trialInfo.pos > 0 then
				local heroMo = HeroMo.New()

				heroMo:initFromTrial(trialInfo.trialId)
				table.insert(mainHeroMoList, heroMo)
			end
		end
	end

	return mainHeroMoList
end

function FightParam:getSubHeroMoList()
	local subHeroMoList = {}

	for _, uid in ipairs(self.mySideSubUids) do
		local heroMo = HeroModel.instance:getById(uid)

		if heroMo then
			table.insert(subHeroMoList, heroMo)
		end
	end

	if self.trialHeroList then
		for _, trialInfo in ipairs(self.trialHeroList) do
			if trialInfo.pos < 0 then
				local heroMo = HeroMo.New()

				heroMo:initFromTrial(trialInfo.trialId)
				table.insert(subHeroMoList, heroMo)
			end
		end
	end

	return subHeroMoList
end

function FightParam:getEquipMoList()
	local equipMoList = {}

	for _, fightEquip in ipairs(self.equips) do
		table.insert(equipMoList, EquipModel.instance:getEquip(fightEquip.equipUid[1]))
	end

	if self.trialHeroList then
		for _, trialInfo in ipairs(self.trialHeroList) do
			local trialCo = lua_hero_trial.configDict[trialInfo.trialId][0]

			if trialCo and trialCo.equipId > 0 then
				local trialEquipMo = EquipMO.New()

				trialEquipMo:initByTrialCO(trialCo)
				table.insert(equipMoList, trialEquipMo)
			end
		end
	end

	return equipMoList
end

function FightParam:getHeroEquipMoList()
	local heroEquipMoList = {}
	local heroUid2EquipMoDict = {}

	for _, fightEquip in ipairs(self.equips) do
		local heroUid = fightEquip.heroUid
		local equipUid = fightEquip.equipUid[1]

		heroUid2EquipMoDict[heroUid] = EquipModel.instance:getEquip(equipUid)
	end

	local _, assistMo = HeroGroupModel.instance:getAssistMo()

	for _, uid in ipairs(self.mySideUids) do
		local heroMo = HeroModel.instance:getById(uid)

		if assistMo and uid == assistMo.heroUid then
			heroMo = heroMo or assistMo.assistMo.heroMO

			local info = self.equips[assistMo.id]
			local equipMo = heroUid2EquipMoDict[assistMo.heroUid]

			if not equipMo and info then
				equipMo = EquipModel.instance:getEquip(info.equipUid[1])
			end

			table.insert(heroEquipMoList, {
				heroMo = heroMo,
				equipMo = equipMo
			})
		elseif heroMo then
			local heroUid = heroMo.uid

			table.insert(heroEquipMoList, {
				heroMo = heroMo,
				equipMo = heroUid2EquipMoDict[heroUid]
			})
		end
	end

	for _, uid in ipairs(self.mySideSubUids) do
		local heroMo = HeroModel.instance:getById(uid)

		if heroMo then
			local heroUid = heroMo.uid

			table.insert(heroEquipMoList, {
				heroMo = heroMo,
				equipMo = heroUid2EquipMoDict[heroUid]
			})
		end
	end

	if self.trialHeroList then
		for _, trialInfo in ipairs(self.trialHeroList) do
			local trialCo = lua_hero_trial.configDict[trialInfo.trialId][0]

			if trialCo and trialCo.equipId > 0 then
				local trialEquipMo = EquipMO.New()

				trialEquipMo:initByTrialCO(trialCo)

				local heroMo = HeroMo.New()

				heroMo:initFromTrial(trialInfo.trialId)
				table.insert(heroEquipMoList, {
					heroMo = heroMo,
					equipMo = trialEquipMo
				})
			end
		end
	end

	return heroEquipMoList
end

function FightParam:getHeroEquipMoListWithTrial()
	local heroEquipList = {}
	local subHeroEquipList = {}
	local heroUid2EquipMoDict = {}

	for _, fightEquip in ipairs(self.equips) do
		local heroUid = fightEquip.heroUid
		local equipUid = fightEquip.equipUid[1]

		heroUid2EquipMoDict[heroUid] = EquipModel.instance:getEquip(equipUid)
	end

	for _, uid in ipairs(self.mySideUids) do
		local heroMo = HeroModel.instance:getById(uid) or FightHelper.getAssitHeroInfoByUid(uid)

		if heroMo then
			table.insert(heroEquipList, {
				heroMo = heroMo,
				equipMo = heroUid2EquipMoDict[uid]
			})
		end
	end

	for _, uid in ipairs(self.mySideSubUids) do
		local heroMo = HeroModel.instance:getById(uid) or FightHelper.getAssitHeroInfoByUid(uid, true)

		if heroMo then
			table.insert(subHeroEquipList, {
				heroMo = heroMo,
				equipMo = heroUid2EquipMoDict[uid]
			})
		end
	end

	if self.trialHeroList then
		for _, trialInfo in ipairs(self.trialHeroList) do
			local trialCo = lua_hero_trial.configDict[trialInfo.trialId][0]

			if trialCo and trialCo.equipId > 0 then
				local trialEquipMo = EquipMO.New()

				trialEquipMo:initByTrialCO(trialCo)

				local heroMo = HeroMo.New()

				heroMo:initFromTrial(trialInfo.trialId)

				local heroEquipMo = {
					heroMo = heroMo,
					equipMo = trialEquipMo
				}
				local pos = trialInfo.pos

				if pos > 0 then
					table.insert(heroEquipList, heroEquipMo)
				else
					table.insert(subHeroEquipList, heroEquipMo)
				end
			end
		end
	end

	return heroEquipList, subHeroEquipList
end

function FightParam.initTowerFightGroup(fightGroup, clothId, heroList, subHeroList, equips, activity104Equips, assistBossId, skipCheckTrial, params)
	if clothId then
		fightGroup.clothId = clothId
	end

	if assistBossId then
		fightGroup.assistBossId = assistBossId
	end

	if params then
		fightGroup.params = params
	end

	if heroList then
		for index, hero in ipairs(heroList) do
			if tonumber(hero) < 0 then
				local mo = HeroGroupTrialModel.instance:getById(hero)

				if mo then
					local trialHeroId = mo.trialCo.id > 0 and tostring(-mo.trialCo.id) or "0"

					table.insert(fightGroup.heroList, trialHeroId)
				elseif skipCheckTrial then
					table.insert(fightGroup.heroList, hero)
				end
			else
				table.insert(fightGroup.heroList, hero)
			end
		end
	end

	if subHeroList then
		for index, subHero in ipairs(subHeroList) do
			if tonumber(subHero) < 0 then
				local mo = HeroGroupTrialModel.instance:getById(subHero)

				if mo then
					local trialHeroId = mo.trialCo.id > 0 and tostring(-mo.trialCo.id) or "0"

					table.insert(fightGroup.subHeroList, trialHeroId)
				end
			else
				table.insert(fightGroup.subHeroList, subHero)
			end
		end
	end

	if equips then
		for i, v in ipairs(equips) do
			local fightEquip = FightDef_pb.FightEquip()

			if tonumber(v.heroUid) < 0 then
				local mo = HeroGroupTrialModel.instance:getById(v.heroUid)

				fightEquip.heroUid = mo and mo.trialCo.id > 0 and tostring(-mo.trialCo.id) or "0"
			else
				fightEquip.heroUid = v.heroUid
			end

			for _, uid in ipairs(v.equipUid) do
				table.insert(fightEquip.equipUid, uid)
			end

			table.insert(fightGroup.equips, fightEquip)
		end
	end

	if activity104Equips then
		for i, v in ipairs(activity104Equips) do
			local fightEquip = FightDef_pb.FightEquip()

			if tonumber(v.heroUid) < 0 then
				local mo = HeroGroupTrialModel.instance:getById(v.heroUid)

				fightEquip.heroUid = mo and mo.trialCo.id > 0 and tostring(-mo.trialCo.id) or "0"
			else
				fightEquip.heroUid = v.heroUid
			end

			if v.equipUid then
				for _, uid in ipairs(v.equipUid) do
					table.insert(fightEquip.equipUid, uid)
				end
			end

			table.insert(fightGroup.activity104Equips, fightEquip)
		end
	end
end

function FightParam:getHeroEquipAndTrialMoList(ignoreEmpty)
	local heroEquipMoList = {}
	local heroUid2EquipMoDict = {}

	for _, fightEquip in ipairs(self.equips) do
		local heroUid = fightEquip.heroUid
		local equipUid = fightEquip.equipUid[1]

		heroUid2EquipMoDict[heroUid] = EquipModel.instance:getEquip(equipUid)
	end

	for _, uid in ipairs(self.mySideUids) do
		local heroMo = HeroModel.instance:getById(uid)

		if heroMo then
			local heroUid = heroMo.uid

			table.insert(heroEquipMoList, {
				heroMo = heroMo,
				equipMo = heroUid2EquipMoDict[heroUid]
			})
		else
			table.insert(heroEquipMoList, {})
		end
	end

	for _, uid in ipairs(self.mySideSubUids) do
		local heroMo = HeroModel.instance:getById(uid)

		if heroMo then
			local heroUid = heroMo.uid

			table.insert(heroEquipMoList, {
				heroMo = heroMo,
				equipMo = heroUid2EquipMoDict[heroUid]
			})
		else
			table.insert(heroEquipMoList, {})
		end
	end

	if self.trialHeroList then
		for _, trialInfo in ipairs(self.trialHeroList) do
			local trialCo = lua_hero_trial.configDict[trialInfo.trialId][0]

			if trialCo and trialCo.equipId > 0 then
				local trialEquipMo = EquipMO.New()

				trialEquipMo:initByTrialCO(trialCo)

				local heroMo = HeroMo.New()

				heroMo:initFromTrial(trialInfo.trialId)
				table.insert(heroEquipMoList, trialInfo.pos, {
					heroMo = heroMo,
					equipMo = trialEquipMo
				})
			end
		end
	end

	for i = #heroEquipMoList, 1, -1 do
		if heroEquipMoList[i].heroMo == nil and ignoreEmpty then
			table.remove(heroEquipMoList, i)
		end
	end

	return heroEquipMoList
end

return FightParam
