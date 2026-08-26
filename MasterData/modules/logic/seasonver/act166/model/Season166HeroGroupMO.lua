-- chunkname: @modules/logic/seasonver/act166/model/Season166HeroGroupMO.lua

module("modules.logic.seasonver.act166.model.Season166HeroGroupMO", package.seeall)

local Season166HeroGroupMO = pureTable("Season166HeroGroupMO")

function Season166HeroGroupMO:ctor()
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
	self.isHaveTrial = false
end

function Season166HeroGroupMO:init(info)
	self.id = info.groupId
	self.groupId = info.groupId
	self.name = info.name
	self.clothId = info.clothId
	self.heroList = {}

	if info.heroList then
		if not #info.heroList then
			local heroCount = 0

			for i = 1, heroCount do
				table.insert(self.heroList, info.heroList[i])
			end

			for i = heroCount + 1, self:getMaxHeroCount() do
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
		end
	end
end

function Season166HeroGroupMO:initByFightGroup(fightGroup)
	self.id = 1
	self.groupId = 1
	self.clothId = fightGroup.clothId
	self.recordRound = fightGroup.recordRound
	self.heroList = {}
	self.replay_hero_data = {}

	local hero2IndexDict = {}

	self.replay_equip_data = {}
	self.trialDict = {}
	self.exInfos = {}
	self.replayAssistHeroUid = fightGroup.assistHeroUid
	self.replayAssistUserId = fightGroup.assistUserId

	local battleId = Season166HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]

	if battleCO then
		if not battleCO.playerMax then
			local playerMax = ModuleEnum.HeroCountInGroup

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

				local hero_uid = tostring(trialCo.heroId - 1099511627776)

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

function Season166HeroGroupMO:initByLocalData(saveData)
	self.id = 1
	self.groupId = 1
	self.name = ""
	self.heroList = {}
	self.aidDict = nil
	self.trialDict = {}
	self.clothId = saveData.clothId
	self.temp = true
	self.isReplay = false
	self.equips = {}
	self.activity104Equips = {}
	self.isHaveTrial = false

	local battleId = Season166HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]
	local configTrial = {}

	if not string.nilorempty(battleCO.trialHeros) then
		configTrial = GameUtil.splitString2(battleCO.trialHeros, true)
	end

	local addTrials = ToughBattleModel.instance:getAddTrialHeros()

	if addTrials then
		for _, trialId in pairs(addTrials) do
			table.insert(configTrial, {
				trialId
			})
		end
	end

	for i = 1, self:getMaxHeroCount() do
		self.heroList[i] = saveData.heroList[i] or "0"
		self.equips[i - 1] = HeroGroupEquipMO.New()

		local var_4_0 = {
			index = i - 1
		}
		local var_4_1 = {}

		var_4_1[1] = saveData.equips[i] or "0"
		var_4_0.equipUid = var_4_1

		self.equips[i - 1]:init(var_4_0)

		local var_4_2 = {
			index = i - 1
		}

		if saveData.activity104Equips then
			var_4_2.equipUid = saveData.activity104Equips[i] or {}
		end

		self:updateActivity104PosEquips(var_4_2)

		if tonumber(self.heroList[i]) < 0 then
			local find = false

			for _, v in pairs(configTrial) do
				local trialCo = lua_hero_trial.configDict[v[1]][(not v[2] or nil) and 0]

				if trialCo.heroId - 1099511627776 == tonumber(self.heroList[i]) then
					self.trialDict[i] = v
					find = true

					break
				end
			end

			if not find then
				self.heroList[i] = "0"
			end

			self.isHaveTrial = true
		end
	end

	local mainRolePos = self:getMaxHeroCount() + 1
	local var_4_4 = {
		index = mainRolePos - 1
	}

	if saveData.activity104Equips then
		var_4_4.equipUid = saveData.activity104Equips[mainRolePos] or {}
	end

	self:updateActivity104PosEquips(var_4_4)

	if Activity104Model.instance:isSeasonChapter() and saveData.battleId ~= battleId then
		for i, v in ipairs(self.heroList) do
			if tonumber(v) < 0 then
				self.heroList[i] = tostring(0)
				self.trialDict[i] = nil
			end
		end
	end
end

function Season166HeroGroupMO:setTrials(isReConnect)
	self.trialDict = self.trialDict or {}

	local battleId = Season166HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]
	local useHeroIds = {}

	for _, v in pairs((not string.nilorempty(battleCO.trialHeros) or nil) and GameUtil.splitString2(battleCO.trialHeros, true)) do
		if v[3] then
			local posIndex = v[3]

			if posIndex < 0 then
				posIndex = self._playerMax - posIndex
			end

			self.trialDict[posIndex] = v

			local trialCo = lua_hero_trial.configDict[v[1]][v[2] or 0]

			self.heroList[posIndex] = tostring(trialCo.heroId - 1099511627776)
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

		for i = 1, math.min(#trialEquips, self:getMaxHeroCount()) do
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
			index = self:getMaxHeroCount(),
			equipUid = {
				-battleCO.trialMainAct104EuqipId
			}
		})
	end
end

function Season166HeroGroupMO:saveData()
	local battleId = Season166HeroGroupModel.instance.battleId
	local actId = Season166Model.instance:getCurSeasonId()
	local info = {}

	info.clothId = self.clothId
	info.heroList = {}
	info.equips = {}
	info.activity104Equips = {}

	for i = 1, self:getMaxHeroCount() do
		info.heroList[i] = self.heroList[i]
		info.equips[i] = self.equips[i - 1] and self.equips[i - 1].equipUid[1]
		info.activity104Equips[i] = self.activity104Equips[i - 1] and self.activity104Equips[i - 1].equipUid
	end

	local mainRolePos = self:getMaxHeroCount() + 1

	info.activity104Equips[mainRolePos] = self.activity104Equips[mainRolePos - 1] and self.activity104Equips[mainRolePos - 1].equipUid
	info.battleId = battleId

	local prefsKey = actId .. "#" .. PlayerPrefsKey.Season166HeroGroupTrial .. "#" .. tostring(PlayerModel.instance:getMyUserId()) .. "#" .. battleId

	PlayerPrefsHelper.setString(prefsKey, cjson.encode(info))
end

function Season166HeroGroupMO:setTempName(name)
	self.name = name
end

function Season166HeroGroupMO:setTemp(temp)
	self.temp = temp
end

function Season166HeroGroupMO:replaceHeroList(heroList)
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
			end

			self:_dropAidEquip()
		end
	end
end

function Season166HeroGroupMO:_dropAidEquip()
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
			self:updateActivity104PosEquips({
				index = i - 1
			})
		end
	end
end

function Season166HeroGroupMO:replaceClothId(clothId)
	self.clothId = clothId
end

function Season166HeroGroupMO:getHeroByIndex(index)
	return self.heroList[index]
end

function Season166HeroGroupMO:getAllPosEquips()
	return self.equips
end

function Season166HeroGroupMO:getPosEquips(pos)
	if not self.equips[pos] then
		self:updatePosEquips({
			index = pos
		})
	end

	return self.equips[pos]
end

function Season166HeroGroupMO:_setPosEquips(pos, equip)
	if equip == nil then
		equip = HeroGroupEquipMO.New()

		equip:init({
			index = pos
		})
	end

	self.equips[pos] = equip
end

function Season166HeroGroupMO:updatePosEquips(v)
	for i = 0, self:getMaxHeroCount() do
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

function Season166HeroGroupMO:getAct104PosEquips(pos)
	if not self.activity104Equips[pos] then
		self:updateActivity104PosEquips({
			index = pos
		})
	end

	return self.activity104Equips[pos]
end

function Season166HeroGroupMO:updateActivity104PosEquips(v)
	local equipMo = HeroGroupActivity104EquipMo.New()

	equipMo:setLimitNum(self._seasonCardMainNum, self._seasonCardNormalNum)
	equipMo:init(v)

	self.activity104Equips[v.index] = equipMo
end

function Season166HeroGroupMO:checkAndPutOffEquip()
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

function Season166HeroGroupMO:getAllHeroEquips()
	local result = {}
	local equipMiss = false
	local fightParam = FightModel.instance:getFightParam()
	local trialEquips = {}

	if fightParam and fightParam.battleId > 0 then
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

function Season166HeroGroupMO:getAllHeroActivity104Equips()
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

function Season166HeroGroupMO:getEquipUidList()
	local equipUidList = {}

	for i = 1, self:getMaxHeroCount() do
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

function Season166HeroGroupMO:initWithBattle(info, configAids, roleNum, playerMax, recommend, configTrial)
	playerMax = math.min(playerMax, roleNum)

	self:init(info)

	self.battleHeroGroup = true
	self.aidDict = {}
	self.trialDict = {}

	if not recommend then
		self._roleNum = roleNum
		self._playerMax = playerMax
	end

	local MaxHeroCount = self:getMaxHeroCount()
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

				self.heroList[posIndex] = tostring(trialCo.heroId - 1099511627776)
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
						if playerMax < i or roleNum < i or i > Season166HeroGroupModel.instance:positionOpenCount() then
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

	local aidHeroUid = 0
	local isSetAid = false

	for i = MaxHeroCount, 1, -1 do
		if roleNum < i or i > Season166HeroGroupModel.instance:positionOpenCount() and not self.trialDict[i] then
			if self.heroList[i] and tonumber(self.heroList[i]) > 0 then
				table.insert(dropedHeroList, self.heroList[i])
				table.insert(dropedEquipList, self:getPosEquips(i - 1))
			end

			self.heroList[i] = "0"

			if i <= Season166HeroGroupModel.instance:positionOpenCount() then
				self.aidDict[i] = -1
			end
		elseif playerMax < i and tabletool.len(configAids) == 0 then
			-- block empty
		elseif not self.heroList[i] or tonumber(self.heroList[i]) >= 0 and not self.trialDict[i] then
			for j = 1, MaxHeroCount do
				if configAids[j] then
					if self.heroList[i] and tonumber(self.heroList[i]) > 0 then
						table.insert(dropedHeroList, self.heroList[i])
						table.insert(dropedEquipList, self:getPosEquips(i - 1))
					end

					aidHeroUid = configAids[j] ~= 0 and aidHeroUid + 1 or aidHeroUid
					self.heroList[i] = configAids[j] == 0 and "0" or tostring(-aidHeroUid)
					self.aidDict[j] = configAids[j] == 0 and -1 or configAids[j]

					self:updatePosEquips({
						index = i - 1
					})

					configAids[j] = nil
					isSetAid = true

					break
				end
			end
		end
	end

	if isSetAid then
		tabletool.revert(self.heroList)
	end

	for i = 1, MaxHeroCount do
		if #dropedHeroList <= 0 then
			break
		end

		if i <= roleNum and i <= Season166HeroGroupModel.instance:positionOpenCount() and (not self.heroList[i] or self.heroList[i] == "0" or self.heroList[i] == 0) then
			self.heroList[i] = dropedHeroList[#dropedHeroList]

			self:_setPosEquips(i - 1, dropedEquipList[#dropedEquipList])
			table.remove(dropedHeroList, #dropedHeroList)
			table.remove(dropedEquipList, #dropedEquipList)
		end
	end

	self:_dropAidEquip()
end

function Season166HeroGroupMO:_getHeroListBackup()
	local heroListBackup = {}

	for _, heroUid in ipairs(self.heroList) do
		table.insert(heroListBackup, heroUid)
	end

	return heroListBackup
end

function Season166HeroGroupMO:getMainList()
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
		local battleId = Season166HeroGroupModel.instance.battleId
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

function Season166HeroGroupMO:getSubList()
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
		local battleId = Season166HeroGroupModel.instance.battleId
		local battleCO = battleId and lua_battle.configDict[battleId]

		if battleCO then
			if not battleCO.playerMax then
				local playerMax = ModuleEnum.HeroCountInGroup

				for i = playerMax + 1, self:getMaxHeroCount() do
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

function Season166HeroGroupMO:isAidHero(uid)
	uid = tonumber(uid) or 0

	local maxCount = self:getMaxHeroCount()

	return uid < 0 and uid >= -maxCount
end

function Season166HeroGroupMO:clearAidHero()
	if self.heroList then
		for i, v in ipairs(self.heroList) do
			if self:isAidHero(v) and (not self.aidDict or not self.aidDict[i]) then
				self.heroList[i] = tostring(0)
			end
		end
	end
end

function Season166HeroGroupMO:setSeasonCardLimit(mainCardNum, normalCardNum)
	self._seasonCardMainNum, self._seasonCardNormalNum = mainCardNum, normalCardNum
end

function Season166HeroGroupMO:getSeasonCardLimit()
	return self._seasonCardMainNum, self._seasonCardNormalNum
end

function Season166HeroGroupMO:getMaxHeroCount()
	return self._roleNum or Season166HeroGroupModel.instance:getMaxHeroCountInGroup()
end

function Season166HeroGroupMO:setMaxHeroCount(playerMaxCount)
	self._playerMax = playerMaxCount
end

return Season166HeroGroupMO
