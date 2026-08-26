-- chunkname: @modules/logic/herogroup/model/HeroGroupMO.lua

module("modules.logic.herogroup.model.HeroGroupMO", package.seeall)

local HeroGroupMO = pureTable("HeroGroupMO")

function HeroGroupMO:ctor()
	self.id = nil
	self.groupId = nil
	self.name = nil
	self.heroList = {}
	self.aidDict = nil
	self.trialDict = nil
	self.clothId = nil
	self.temp = false
	self.isReplay = false
	self.equips = {}
	self.activity104Equips = {}
	self.exInfos = {}
	self.assistBossId = nil
	self.params = nil
end

function HeroGroupMO:init(info)
	self.id = info.groupId
	self.groupId = info.groupId
	self.name = info.name
	self.clothId = info.clothId
	self.assistBossId = info.assistBossId
	self.params = info.params
	self.heroList = {}
	self.trialDict = {}

	if info.heroList then
		if not #info.heroList then
			local heroCount = 0

			for i = 1, heroCount do
				table.insert(self.heroList, info.heroList[i])
			end

			for i = heroCount + 1, ModuleEnum.MaxHeroCountInGroup do
				table.insert(self.heroList, "0")
			end

			if info.equips then
				if info.equips[0] then
					self:updatePosEquips(info.equips[0])
				end

				for i, v in ipairs(info.equips) do
					self:updatePosEquips(v)
				end
			end

			if info.activity104Equips then
				if info.activity104Equips[0] then
					self:updateActivity104PosEquips(info.activity104Equips[0])
				end

				for _, v in ipairs(info.activity104Equips) do
					self:updateActivity104PosEquips(v)
				end
			end
		end
	end
end

function HeroGroupMO:initByFightGroup(fightGroup)
	self.id = 1
	self.groupId = 1
	self.clothId = fightGroup.clothId
	self.recordRound = fightGroup.recordRound
	self.heroList = {}
	self.replay_hero_data = {}

	local hero2IndexDict = {}

	self.replay_equip_data = {}
	self.trialDict = {}
	self.aidDict = {}
	self.exInfos = {}
	self.replayAssistHeroUid = fightGroup.assistHeroUid
	self.replayAssistUserId = fightGroup.assistUserId
	self.assistBossId = fightGroup.assistBossId
	self.params = fightGroup.params

	local battleId = HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]

	if battleCO then
		if not battleCO.playerMax then
			local playerMax = ModuleEnum.HeroCountInGroup
			local configAids = string.splitToNumber(battleCO.aid, "#") or {}

			if fightGroup.exInfos then
				for i, v in ipairs(fightGroup.exInfos) do
					self.exInfos[i] = v
				end
			end

			for _, trialHero in ipairs(fightGroup.trialHeroList) do
				local trialCo = lua_hero_trial.configDict[trialHero.trialId][0]
				local pos = trialHero.pos

				if pos < 0 then
					pos = playerMax - pos
				end

				local hero_uid = tostring(tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776)

				hero2IndexDict[hero_uid] = pos
				self.heroList[pos] = hero_uid

				local hero_data = {}

				hero_data.heroUid = hero_uid
				hero_data.heroId = trialCo.heroId
				hero_data.level = trialCo.level
				hero_data.skin = trialCo.skin

				if hero_data.skin == 0 then
					hero_data.skin = lua_character.configDict[trialCo.heroId].skinId
				end

				self.replay_hero_data[hero_uid] = hero_data

				local index = pos - 1

				self.equips[index] = HeroGroupEquipMO.New()

				self.equips[index]:init({
					index = index,
					equipUid = {
						trialHero.equipRecords[1].equipUid
					}
				})

				local equip_data = {}

				equip_data.equipUid = trialHero.equipRecords[1].equipUid
				equip_data.equipId = trialHero.equipRecords[1].equipId
				equip_data.equipLv = trialHero.equipRecords[1].equipLv
				equip_data.refineLv = trialHero.equipRecords[1].refineLv
				self.replay_equip_data[hero_uid] = equip_data
				self.trialDict[pos] = {
					trialHero.trialId,
					0,
					pos
				}
			end

			for _, heroData in ipairs(fightGroup.heroList) do
				local hero_uid = heroData.heroUid
				local index = 1

				while self.heroList[index] do
					index = index + 1
				end

				self.heroList[index] = hero_uid
				hero2IndexDict[hero_uid] = index

				local hero_data = {}

				hero_data.heroUid = hero_uid
				hero_data.heroId = heroData.heroId
				hero_data.level = heroData.level
				hero_data.skin = heroData.skin
				self.replay_hero_data[hero_uid] = hero_data

				if tonumber(hero_uid) < 0 then
					self.aidDict[index] = configAids[-tonumber(hero_uid)]
				end
			end

			for _, subHeroData in ipairs(fightGroup.subHeroList) do
				local hero_uid = subHeroData.heroUid
				local index = 1

				while self.heroList[index] do
					index = index + 1
				end

				self.heroList[index] = hero_uid
				hero2IndexDict[hero_uid] = index

				local hero_data = {}

				hero_data.heroUid = hero_uid
				hero_data.heroId = subHeroData.heroId
				hero_data.level = subHeroData.level
				hero_data.skin = subHeroData.skin
				self.replay_hero_data[hero_uid] = hero_data
			end

			self.replay_equip_data = {}

			for _, equip in ipairs(fightGroup.equips) do
				local index = hero2IndexDict[equip.heroUid] - 1

				self.equips[index] = HeroGroupEquipMO.New()

				local record1 = equip.equipRecords[1]

				if record1 then
					self.equips[index]:init({
						index = index,
						equipUid = {
							record1.equipUid
						}
					})

					local equip_data = {}

					equip_data.equipUid = record1.equipUid
					equip_data.equipId = record1.equipId
					equip_data.equipLv = record1.equipLv
					equip_data.refineLv = record1.refineLv
					self.replay_equip_data[equip.heroUid] = equip_data
				end
			end

			self.replay_activity104Equip_data = {}

			for _, equip in ipairs(fightGroup.activity104Equips) do
				local index = equip.heroUid == "-100000" and 4 or hero2IndexDict[equip.heroUid] - 1

				self.activity104Equips[index] = HeroGroupActivity104EquipMo.New()

				self.activity104Equips[index]:setLimitNum(self._seasonCardMainNum, self._seasonCardNormalNum)

				local record = equip.activity104EquipRecords[1]

				if record then
					local actEquipUIds = {}

					for _, record in ipairs(equip.activity104EquipRecords) do
						table.insert(actEquipUIds, record.equipUid)
					end

					self.activity104Equips[index]:init({
						index = index,
						equipUid = actEquipUIds
					})

					local equip_data = {}

					for tar_index, tar_equip in ipairs(equip.activity104EquipRecords) do
						local tab = {}

						tab.equipUid = tar_equip.equipUid
						tab.equipId = tar_equip.equipId

						table.insert(equip_data, tab)
					end

					self.replay_activity104Equip_data[equip.heroUid] = equip_data
				else
					self.activity104Equips[index]:init({
						index = index,
						equipUid = {}
					})
				end
			end

			self.isReplay = true
		end
	end
end

function HeroGroupMO:initByLocalData(saveData)
	self.id = 1
	self.groupId = 1
	self.name = ""
	self.heroList = {}
	self.aidDict = nil
	self.trialDict = {}
	self.clothId = saveData.clothId
	self.assistBossId = saveData.assistBossId
	self.params = saveData.params
	self.temp = true
	self.isReplay = false
	self.equips = {}
	self.activity104Equips = {}

	if not saveData.version then
		local curVersion = HeroGroupEnum.saveOldVersion
		local battleId = HeroGroupModel.instance.battleId
		local configTrial = {}
		local curBattleTrialHeros = HeroGroupHandler.getTrialHeros(HeroGroupModel.instance.episodeId)

		if not string.nilorempty(curBattleTrialHeros) then
			configTrial = GameUtil.splitString2(curBattleTrialHeros, true)
		end

		local addTrials = ToughBattleModel.instance:getAddTrialHeros()

		if addTrials then
			for _, trialId in pairs(addTrials) do
				table.insert(configTrial, {
					trialId
				})
			end
		end

		for i = 1, ModuleEnum.MaxHeroCountInGroup do
			self.heroList[i] = saveData.heroList[i] or "0"
			self.equips[i - 1] = HeroGroupEquipMO.New()

			local var_4_1 = {
				index = i - 1
			}
			local var_4_2 = {}

			var_4_2[1] = saveData.equips[i] or "0"
			var_4_1.equipUid = var_4_2

			self.equips[i - 1]:init(var_4_1)

			local var_4_3 = {
				index = i - 1
			}

			if saveData.activity104Equips then
				var_4_3.equipUid = saveData.activity104Equips[i] or {}
			end

			self:updateActivity104PosEquips(var_4_3)

			if tonumber(self.heroList[i]) < 0 then
				local find = false

				for _, v in pairs(configTrial) do
					local trialCo = lua_hero_trial.configDict[v[1]][(not v[2] or nil) and 0]
					local trialHeroUid = tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776

					if ((curVersion == HeroGroupEnum.saveOldVersion or nil) and trialCo.heroId - 1099511627776) == tonumber(self.heroList[i]) then
						if curVersion == HeroGroupEnum.saveOldVersion then
							self.heroList[i] = tostring(tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776)
						end

						self.trialDict[i] = v
						find = true

						break
					end
				end

				if not find then
					self.heroList[i] = "0"
				end
			end
		end

		local mainRolePos = ModuleEnum.MaxHeroCountInGroup + 1
		local var_4_5 = {
			index = mainRolePos - 1
		}

		if saveData.activity104Equips then
			var_4_5.equipUid = saveData.activity104Equips[mainRolePos] or {}
		end

		self:updateActivity104PosEquips(var_4_5)

		if Activity104Model.instance:isSeasonChapter() and saveData.battleId ~= battleId then
			for i, v in ipairs(self.heroList) do
				if tonumber(v) < 0 then
					self.heroList[i] = tostring(0)
					self.trialDict[i] = nil
				end
			end
		end
	end
end

function HeroGroupMO:setTrials(isReConnect)
	self.trialDict = self.trialDict or {}

	local battleId = HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]
	local curBattleTrialHeros = HeroGroupHandler.getTrialHeros(HeroGroupModel.instance.episodeId)
	local useHeroIds = {}

	for _, v in pairs((not string.nilorempty(curBattleTrialHeros) or nil) and GameUtil.splitString2(curBattleTrialHeros, true)) do
		if v[3] then
			local posIndex = v[3]

			if posIndex < 0 then
				posIndex = self._playerMax - posIndex
			end

			self.trialDict[posIndex] = v

			local trialCo = lua_hero_trial.configDict[v[1]][v[2] or 0]

			self.heroList[posIndex] = tostring(tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776)
			useHeroIds[trialCo.heroId] = true

			if not isReConnect and (trialCo.act104EquipId1 > 0 or trialCo.act104EquipId2 > 0) then
				self:updateActivity104PosEquips({
					index = posIndex - 1
				})
			end
		end
	end

	for posIndex, uid in pairs(self.heroList) do
		if tonumber(uid) > 0 then
			local heroMO = HeroModel.instance:getById(uid)

			if heroMO and useHeroIds[heroMO.heroId] then
				self.heroList[posIndex] = "0"
			end
		end
	end

	if not isReConnect and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not string.nilorempty(battleCO.trialEquips) then
		local trialEquips = string.splitToNumber(battleCO.trialEquips, "|")

		for i = 1, math.min(#trialEquips, ModuleEnum.MaxHeroCountInGroup) do
			self:updatePosEquips({
				index = i - 1,
				equipUid = {
					tostring(-trialEquips[i])
				}
			})
		end
	end

	if not isReConnect and battleCO.trialMainAct104EuqipId > 0 then
		self:updateActivity104PosEquips({
			index = ModuleEnum.MaxHeroCountInGroup,
			equipUid = {
				-battleCO.trialMainAct104EuqipId
			}
		})
	end
end

function HeroGroupMO:saveData()
	local battleId = HeroGroupModel.instance.battleId
	local info = {}

	info.clothId = self.clothId
	info.heroList = {}
	info.equips = {}
	info.activity104Equips = {}
	info.assistBossId = self.assistBossId
	info.params = self.params

	for i = 1, ModuleEnum.MaxHeroCountInGroup do
		info.heroList[i] = self.heroList[i]
		info.equips[i] = self.equips[i - 1] and self.equips[i - 1].equipUid[1]
		info.activity104Equips[i] = self.activity104Equips[i - 1] and self.activity104Equips[i - 1].equipUid
	end

	local mainRolePos = ModuleEnum.MaxHeroCountInGroup + 1

	info.activity104Equips[mainRolePos] = self.activity104Equips[mainRolePos - 1] and self.activity104Equips[mainRolePos - 1].equipUid
	info.battleId = battleId
	info.version = HeroGroupEnum.saveTrialVersion

	local prefsKey

	PlayerPrefsHelper.setString(Activity104Model.instance:isSeasonChapter() and Activity104Model.instance:getSeasonTrialPrefsKey() or SodacheUtil.isSodacheEpisode() and PlayerPrefsKey.SodacheTrialHeroGroupKey .. "#" .. tostring(PlayerModel.instance:getMyUserId()) or PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. battleId, cjson.encode(info))
end

function HeroGroupMO:setTempName(name)
	self.name = name
end

function HeroGroupMO:setTemp(temp)
	self.temp = temp
end

function HeroGroupMO:replaceHeroList(heroList)
	self.heroList = {}
	self.aidDict = {}
	self.trialDict = {}

	if heroList then
		if not #heroList then
			local heroCount = 0

			for i = 1, heroCount do
				table.insert(self.heroList, heroList[i].heroUid)

				if heroList[i].aid then
					self.aidDict[i] = heroList[i].aid
				end

				local trialCo = heroList[i]:getTrialCO()

				if trialCo then
					self.trialDict[i] = {
						trialCo.id,
						trialCo.trialTemplate
					}
				end
			end

			self:_dropAidEquip()
		end
	end
end

function HeroGroupMO:_dropAidEquip()
	if self.aidDict then
		for i, aid in pairs(self.aidDict) do
			if aid > 0 then
				self:_setPosEquips(i - 1, nil)
				self:updateActivity104PosEquips({
					index = i - 1
				})
			end
		end
	end

	if self.trialDict then
		for i, trialData in pairs(self.trialDict) do
			self:_setPosEquips(i - 1, nil)
		end
	end
end

function HeroGroupMO:replaceClothId(clothId)
	self.clothId = clothId
end

function HeroGroupMO:getHeroByIndex(index)
	return self.heroList[index]
end

function HeroGroupMO:getAllPosEquips()
	return self.equips
end

function HeroGroupMO:getPosEquips(pos)
	if not self.equips[pos] then
		self:updatePosEquips({
			index = pos
		})
	end

	return self.equips[pos]
end

function HeroGroupMO:_setPosEquips(pos, equip)
	if equip == nil then
		equip = HeroGroupEquipMO.New()

		equip:init({
			index = pos
		})
	end

	self.equips[pos] = equip
end

function HeroGroupMO:updatePosEquips(v)
	for i = 0, math.max(3, #self.heroList - 1) do
		local equips = self.equips[i]

		if equips and equips.equipUid and #equips.equipUid > 0 and v.equipUid and #v.equipUid > 0 then
			for j = 1, 1 do
				if equips.equipUid[j] == v.equipUid[j] then
					equips.equipUid[j] = "0"
				end
			end
		end
	end

	local t = HeroGroupEquipMO.New()

	t:init(v)

	self.equips[v.index] = t
end

function HeroGroupMO:getAct104PosSlotEquip(pos, slot)
	local equips = self:getAct104PosEquips(pos)

	return equips and equips:getEquipUID(slot)
end

function HeroGroupMO:getAct104PosEquips(pos)
	if not self.activity104Equips[pos] then
		self:updateActivity104PosEquips({
			index = pos
		})
	end

	return self.activity104Equips[pos]
end

function HeroGroupMO:updateActivity104PosEquips(v)
	local equipMo = HeroGroupActivity104EquipMo.New()

	equipMo:setLimitNum(self._seasonCardMainNum, self._seasonCardNormalNum)
	equipMo:init(v)

	self.activity104Equips[v.index] = equipMo
end

function HeroGroupMO:checkAndPutOffEquip()
	if not self.equips then
		return
	end

	for _, v in pairs(self.equips) do
		for i, _equipUid in ipairs(v.equipUid) do
			if tonumber(_equipUid) > 0 then
				local equipMO = EquipModel.instance:getEquip(_equipUid)

				v.equipUid[i] = equipMO and _equipUid or "0"
			end
		end
	end
end

function HeroGroupMO:getAllHeroEquips()
	local result = {}
	local equipMiss = false
	local fightParam = FightModel.instance:getFightParam()
	local trialEquips = {}

	if fightParam and fightParam.battleId and fightParam.battleId > 0 then
		local battleCo = lua_battle.configDict[fightParam.battleId]

		if not string.nilorempty(battleCo.trialEquips) then
			trialEquips = string.splitToNumber(battleCo.trialEquips, "|")
		end
	end

	for index, v in pairs(self.equips) do
		local posIndex = index + 1

		if not self.heroList[posIndex] then
			local mo = FightEquipMO.New()

			mo.heroUid = self.heroList[posIndex]

			for i, _equipUid in ipairs(v.equipUid) do
				if tonumber(_equipUid) > 0 then
					local equipMO = EquipModel.instance:getEquip(_equipUid)

					v.equipUid[i] = equipMO and _equipUid or "0"

					if not equipMO then
						equipMiss = true
					end
				else
					local id = -tonumber(_equipUid)
					local trialEquipCo = lua_equip_trial.configDict[id]

					v.equipUid[i] = trialEquipCo and tabletool.indexOf(trialEquips, id) and _equipUid or "0"
				end
			end

			mo.equipUid = v.equipUid

			table.insert(result, mo)
		end
	end

	return result, equipMiss
end

function HeroGroupMO:getAllHeroActivity104Equips()
	local result = {}

	for index, v in pairs(self.activity104Equips) do
		local posIndex = index + 1
		local mo = FightEquipMO.New()

		mo.heroUid = posIndex == 5 and "-100000" or self.heroList[posIndex] or "0"

		for i, _equipUid in ipairs(v.equipUid) do
			if tonumber(_equipUid) > 0 then
				local equipId = Activity104Model.instance:getItemIdByUid(_equipUid)

				v.equipUid[i] = equipId and equipId > 0 and _equipUid or "0"
			end
		end

		mo.equipUid = v.equipUid

		table.insert(result, mo)
	end

	return result
end

function HeroGroupMO:getEquipUidList()
	local equipUidList = {}

	for i = 1, ModuleEnum.MaxHeroCountInGroup do
		local equipMO = self.equips[i - 1]

		if equipMO then
			if equipMO.equipUid then
				equipUidList[i] = equipMO.equipUid[1] or 0
			end
		else
			equipUidList[i] = 0
		end
	end

	return equipUidList
end

function HeroGroupMO:initWithBattle(info, configAids, roleNum, playerMax, recommend, configTrial)
	playerMax = math.min(playerMax, roleNum)

	self:init(info)

	self.battleHeroGroup = true
	self.aidDict = {}
	self.trialDict = {}

	if not recommend then
		self._roleNum = roleNum
		self._playerMax = playerMax
	end

	local MaxHeroCount = ModuleEnum.MaxHeroCountInGroup
	local dropedHeroList = {}
	local dropedEquipList = {}
	local allUseHeroIds = {}

	configTrial = configTrial or {}

	for _, data in ipairs(configTrial) do
		if data[3] then
			local posIndex = data[3]

			if posIndex < 0 then
				posIndex = self._playerMax - posIndex
			end

			if self.heroList[posIndex] then
				local trialCo = lua_hero_trial.configDict[data[1]][(not data[2] or nil) and 0]

				if tonumber(self.heroList[posIndex]) > 0 then
					table.insert(dropedHeroList, self.heroList[posIndex])
					table.insert(dropedEquipList, self:getPosEquips(posIndex - 1))
				end

				self.heroList[posIndex] = tostring(tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776)
				self.trialDict[posIndex] = data
				allUseHeroIds[trialCo.heroId] = true
			end
		end
	end

	for i = 1, MaxHeroCount do
		local heroMo = HeroModel.instance:getById(self.heroList[i])

		if heroMo and allUseHeroIds[heroMo.heroId] then
			self.heroList[i] = "0"
		end
	end

	for i = 1, MaxHeroCount do
		for j = 1, #configAids do
			local aidConfig = lua_monster.configDict[tonumber(configAids[j])]
			local skinCO = lua_skin.configDict[aidConfig and aidConfig.skinId]
			local aidHeroId = skinCO and skinCO.characterId

			if aidHeroId then
				if self.heroList[i] then
					local heroMO = HeroModel.instance:getById(self.heroList[i])

					if self.heroList[i] and self.heroList[i].heroId == aidHeroId then
						if playerMax < i or roleNum < i or i > HeroGroupModel.instance:positionOpenCount() then
							self.heroList[i] = "0"

							break
						end

						self.heroList[i] = tostring(-j)
						self.aidDict[i] = configAids[j]

						self:updatePosEquips({
							index = i - 1
						})

						configAids[j] = nil

						break
					end
				end
			end
		end
	end

	for i = MaxHeroCount, 1, -1 do
		if roleNum < i or i > HeroGroupModel.instance:positionOpenCount() and not self.trialDict[i] then
			if self.heroList[i] and tonumber(self.heroList[i]) > 0 then
				table.insert(dropedHeroList, self.heroList[i])
				table.insert(dropedEquipList, self:getPosEquips(i - 1))
			end

			self.heroList[i] = "0"

			if i <= HeroGroupModel.instance:positionOpenCount() then
				self.aidDict[i] = -1
			end
		elseif playerMax < i then
			-- block empty
		elseif not self.heroList[i] or tonumber(self.heroList[i]) >= 0 and not self.trialDict[i] then
			for j = 1, MaxHeroCount do
				if configAids[j] then
					if self.heroList[i] and tonumber(self.heroList[i]) > 0 then
						table.insert(dropedHeroList, self.heroList[i])
						table.insert(dropedEquipList, self:getPosEquips(i - 1))
					end

					self.heroList[i] = tostring(-j)
					self.aidDict[i] = configAids[j]

					self:updatePosEquips({
						index = i - 1
					})

					configAids[j] = nil

					break
				end
			end
		end
	end

	for i = 1, MaxHeroCount do
		if #dropedHeroList <= 0 then
			break
		end

		if i <= roleNum and i <= HeroGroupModel.instance:positionOpenCount() and (not self.heroList[i] or self.heroList[i] == "0" or self.heroList[i] == 0) then
			self.heroList[i] = dropedHeroList[#dropedHeroList]

			self:_setPosEquips(i - 1, dropedEquipList[#dropedEquipList])
			table.remove(dropedHeroList, #dropedHeroList)
			table.remove(dropedEquipList, #dropedEquipList)
		end
	end

	self:_dropAidEquip()
end

function HeroGroupMO:_getHeroListBackup()
	local heroListBackup = {}

	for _, heroUid in ipairs(self.heroList) do
		table.insert(heroListBackup, heroUid)
	end

	return heroListBackup
end

function HeroGroupMO:getMainList()
	local mainUids = {}
	local count = 0

	if self._playerMax then
		for i = 1, self._playerMax do
			if not self.heroList[i] then
				table.insert(mainUids, self.heroList[i])

				if self.heroList[i] ~= "0" and self.heroList[i] ~= 0 then
					count = count + 1
				end
			end
		end
	else
		local battleId = HeroGroupModel.instance.battleId
		local battleCO = battleId and lua_battle.configDict[battleId]

		if battleCO then
			if not battleCO.playerMax then
				local playerMax = ModuleEnum.HeroCountInGroup

				for i = 1, playerMax do
					if not self.heroList[i] then
						mainUids[i] = self.heroList[i]

						if self.heroList[i] ~= "0" and self.heroList[i] ~= 0 then
							count = count + 1
						end
					end
				end
			end
		end
	end

	return mainUids, count
end

function HeroGroupMO:getSubList()
	local ans = {}
	local count = 0

	if self._playerMax then
		for i = 1, self._roleNum do
			if i > self._playerMax then
				if not self.heroList[i] then
					table.insert(ans, self.heroList[i])

					if self.heroList[i] ~= "0" and self.heroList[i] ~= 0 then
						count = count + 1
					end
				end
			end
		end
	else
		local battleId = HeroGroupModel.instance.battleId
		local battleCO = battleId and lua_battle.configDict[battleId]

		if battleCO then
			if not battleCO.playerMax then
				local playerMax = ModuleEnum.HeroCountInGroup

				for i = playerMax + 1, ModuleEnum.MaxHeroCountInGroup do
					if not self.heroList[i] then
						table.insert(ans, self.heroList[i])

						if self.heroList[i] ~= "0" and self.heroList[i] ~= 0 then
							count = count + 1
						end
					end
				end
			end
		end
	end

	return ans, count
end

function HeroGroupMO:isAidHero(uid)
	uid = tonumber(uid) or 0

	local maxCount = ModuleEnum.MaxHeroCountInGroup

	return uid < 0 and uid >= -maxCount
end

function HeroGroupMO:clearAidHero()
	if self.heroList then
		for i, v in ipairs(self.heroList) do
			if self:isAidHero(v) and (not self.aidDict or not self.aidDict[i]) then
				self.heroList[i] = tostring(0)
			end
		end
	end
end

function HeroGroupMO:setSeasonCardLimit(mainCardNum, normalCardNum)
	self._seasonCardMainNum, self._seasonCardNormalNum = mainCardNum, normalCardNum
end

function HeroGroupMO:getSeasonCardLimit()
	return self._seasonCardMainNum, self._seasonCardNormalNum
end

function HeroGroupMO:getAssistBossId()
	return self.assistBossId
end

function HeroGroupMO:setAssistBossId(bossId)
	self.assistBossId = bossId
end

function HeroGroupMO:replaceTowerHeroList(heroList)
	local dict = {}
	local list = {}
	local emptyUid = tostring(0)

	if heroList then
		if not #heroList then
			local heroCount = 0

			for i = 1, heroCount do
				local hero = heroList[i].heroUid

				dict[hero] = heroList[i].equipUid

				if hero ~= emptyUid then
					table.insert(list, hero)
				end
			end

			self.heroList = self.heroList or {}

			local emptyPosDict = {}

			for i = 1, ModuleEnum.MaxHeroCountInGroup do
				if not self.heroList[i] then
					local hero = emptyUid

					if dict[hero] then
						tabletool.removeValue(list, hero)
					else
						self.heroList[i] = emptyUid
						emptyPosDict[i] = 1
					end
				end
			end

			local posList = {}

			for k, v in pairs(emptyPosDict) do
				table.insert(posList, k)
			end

			if #posList > 1 then
				table.sort(posList)
			end

			for i, v in ipairs(list) do
				local pos = posList[i]

				self.heroList[pos] = v
			end

			self.equips = {}

			for i = 1, ModuleEnum.MaxHeroCountInGroup do
				if not self.heroList[i] then
					local hero = emptyUid
					local equipUid = dict[hero]

					if equipUid then
						local index = i - 1

						self.equips[index] = HeroGroupEquipMO.New()

						self.equips[index]:init({
							index = index,
							equipUid = equipUid
						})
					end
				end
			end

			self.trialDict = {}

			for pos, heroUid in ipairs(self.heroList) do
				if tonumber(heroUid) < 0 then
					local heroMO = HeroGroupTrialModel.instance:getById(heroUid)

					if heroMO then
						self.trialDict[pos] = {
							heroMO.trialCo.id,
							0
						}
					else
						self.heroList[pos] = "0"
					end
				end
			end
		end
	end
end

function HeroGroupMO:checkAct183HeroList(maxHeroCount, groupEpisodeMo)
	if groupEpisodeMo then
		for index, heroId in ipairs(self.heroList) do
			if heroId ~= "0" then
				local heroMo = HeroModel.instance:getById(heroId)

				if heroMo and groupEpisodeMo:isHeroRepress(heroMo.heroId) then
					self.heroList[index] = "0"
				end
			end
		end
	end

	if self.heroList then
		if not #self.heroList then
			local curHeroCount = 0

			if curHeroCount < maxHeroCount then
				for i = curHeroCount + 1, maxHeroCount do
					table.insert(self.heroList, "0")
				end
			elseif maxHeroCount < curHeroCount then
				logError("角色数量超过上限")
			end
		end
	end
end

function HeroGroupMO:setTowerComposeHeroList(maxHeroCount)
	if self.heroList then
		if not #self.heroList then
			local curHeroCount = 0

			if curHeroCount < maxHeroCount then
				for i = curHeroCount + 1, maxHeroCount do
					table.insert(self.heroList, "0")
				end
			end
		end
	end
end

function HeroGroupMO:getSaveParams()
	return self.params
end

function HeroGroupMO:setSaveParams(params)
	self.params = params or ""
end

return HeroGroupMO
