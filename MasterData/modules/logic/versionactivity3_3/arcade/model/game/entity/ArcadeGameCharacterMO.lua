-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameCharacterMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameCharacterMO", package.seeall)

local ArcadeGameCharacterMO = class("ArcadeGameCharacterMO", ArcadeGameBaseUnitMO)

function ArcadeGameCharacterMO:onCtor(extraParam)
	local isRestart = extraParam and extraParam.restart

	self._resourceDict = {}

	for _, resId in pairs(ArcadeGameEnum.CharacterResource) do
		self._resourceDict[resId] = ArcadeGameResource.New(resId)
	end

	self._genUid = 0
	self._collectionDict = {}
	self._collectionType2UidDict = {}
	self._collectionId2UidDict = {}

	if not isRestart then
		local collectionId = ArcadeConfig.instance:getCharacterCollection(self.id)

		if collectionId and collectionId > 0 then
			self:addCollection(collectionId)
		end
	end
end

function ArcadeGameCharacterMO:setDataFromServerInfo(serverInfo, attrDict)
	for _, attrId in pairs(ArcadeGameEnum.BaseAttr) do
		local data = attrDict[attrId]

		if data then
			local base = data.base
			local attrMO = self:getAttrMO(attrId)

			if attrId == ArcadeGameEnum.BaseAttr.hp then
				self:setHp(base)

				if attrMO then
					attrMO:setBase(base)
				end
			elseif attrMO then
				attrMO:setBase(base)
				attrMO:setRate(data.rate)
				attrMO:setIncrease(data.extra)
			end
		end
	end

	for _, resId in pairs(ArcadeGameEnum.CharacterResource) do
		local resMO = self:getResourceMO(resId)
		local data = attrDict[resId]

		if resMO and data then
			resMO:setCount(data.base)
			resMO:setGainRate(data.rate)
			resMO:setUseDiscount(data.extra)
		end
	end

	local collectibleSlots = serverInfo.collectibleSlots

	for _, collectionData in ipairs(collectibleSlots) do
		local collectible = collectionData.collectible
		local collectionId = collectible.id
		local durability = collectible.durability
		local useTimes = collectible.useTimes
		local collectionMO = self:addCollection(collectionId, useTimes, durability)

		if collectionMO then
			local collectionSkillSetMO = collectionMO:getSkillSetMO()

			collectionSkillSetMO:setSkillCounterBox(collectible.counterBox)
		end
	end

	local passiveSkillIds = serverInfo.passiveSkillIds
	local characterSkillSetMO = self:getSkillSetMO()

	for _, skillId in ipairs(passiveSkillIds) do
		characterSkillSetMO:addSkillById(skillId)
	end

	local playerInfo = serverInfo.player
	local attackAttrId = playerInfo.attackAttrId

	self._attackAttrId = attackAttrId and attackAttrId > 0 and attackAttrId or nil

	characterSkillSetMO:setSkillCounterBox(playerInfo.skillCounterBox)
end

function ArcadeGameCharacterMO:resetGridPos()
	local posArr = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.CharacterDefaultGamePos, true, "#")

	self:setGridPos(posArr[1], posArr[2])
end

function ArcadeGameCharacterMO:_generateUid()
	self._genUid = self._genUid + 1

	return self._genUid
end

function ArcadeGameCharacterMO:removeSkillById(skillId)
	if self._collectionType2UidDict then
		for type, uidList in pairs(self._collectionType2UidDict) do
			for _, uid in ipairs((type == ArcadeGameEnum.CollectionType.Weapon or nil) and {
				uidList[1]
			}) do
				local collectionMO = self:getCollectionMO(uid)

				if collectionMO then
					local skillSetMO = collectionMO:getSkillSetMO()

					skillSetMO:removeSkillById(skillId)
				end
			end
		end
	end

	self._skillSetMO:removeSkillById(skillId)

	self._allSkillList = nil
end

function ArcadeGameCharacterMO:addCollection(collectionId, usedTimes, durability)
	local type = ArcadeConfig.instance:getCollectionType(collectionId)

	if not type then
		return
	end

	if type == ArcadeGameEnum.CollectionType.Weapon and not durability then
		local addDurability = ArcadeGameModel.instance:getGameAttribute(ArcadeGameEnum.GameAttribute.AddWeaponDurability)

		durability = ArcadeConfig.instance:getCollectionDurability(collectionId) + addDurability
	end

	local uid = self:_generateUid()
	local collectionMO = ArcadeGameCollectionMO.New(uid, collectionId, usedTimes, durability)

	self._collectionDict[uid] = collectionMO

	local typeUidList = ArcadeGameHelper.checkDictTable(self._collectionType2UidDict, type)

	typeUidList[#typeUidList + 1] = uid

	local id2UidList = ArcadeGameHelper.checkDictTable(self._collectionId2UidDict, collectionId)

	id2UidList[#id2UidList + 1] = uid
	self._allSkillList = nil

	return collectionMO
end

function ArcadeGameCharacterMO:removeCollection(uid)
	local mo = self._collectionDict[uid]

	if not mo then
		return
	end

	local id = mo:getId()
	local type = ArcadeConfig.instance:getCollectionType(id)
	local id2UidList = self._collectionId2UidDict[id]

	if id2UidList then
		tabletool.removeValue(id2UidList, uid)
	end

	local typeUidList = self._collectionType2UidDict[type]

	if typeUidList then
		tabletool.removeValue(typeUidList, uid)
	end

	self._collectionDict[uid] = nil
	self._allSkillList = nil

	return mo
end

function ArcadeGameCharacterMO:setPlayerActType(actType)
	self._playerActType = actType
end

function ArcadeGameCharacterMO:triggerSkillSetMOCounterRecord(counterName, counterParam, count)
	ArcadeGameCharacterMO.super.triggerSkillSetMOCounterRecord(self, counterName, counterParam, count)

	if not self._collectionType2UidDict then
		return
	end

	for type, uidList in pairs(self._collectionType2UidDict) do
		for _, uid in ipairs((type == ArcadeGameEnum.CollectionType.Weapon or nil) and {
			uidList[1]
		}) do
			local collectionMO = self:getCollectionMO(uid)

			if collectionMO then
				local skillSetMO = collectionMO:getSkillSetMO()

				skillSetMO:triggerSkillCounterRecord(counterName, counterParam, count)
			end
		end
	end
end

function ArcadeGameCharacterMO:getCfg()
	return (ArcadeConfig.instance:getCharacterCfg(self.id, true))
end

function ArcadeGameCharacterMO:getSize()
	if not self._sizeX then
		self._sizeX, self._sizeY = ArcadeConfig.instance:getCharacterSize(self.id)
	end

	return self._sizeX, self._sizeY
end

function ArcadeGameCharacterMO:getRes()
	return ArcadeConfig.instance:getCharacterRes(self.id)
end

function ArcadeGameCharacterMO:getResourceMO(resId)
	return self._resourceDict and self._resourceDict[resId]
end

function ArcadeGameCharacterMO:getResourceCount(resId)
	local resMO = self:getResourceMO(resId)

	return (resMO or nil) and resMO:getCount()
end

function ArcadeGameCharacterMO:getCollectionDict()
	return self._collectionDict
end

function ArcadeGameCharacterMO:getCollectionMO(uid)
	return self._collectionDict and self._collectionDict[uid]
end

function ArcadeGameCharacterMO:getHasCollection(collectionId)
	if self._collectionId2UidDict then
		return self._collectionId2UidDict and #self._collectionId2UidDict > 0
	end
end

function ArcadeGameCharacterMO:getCollectionId2Uids(collectionId)
	return self._collectionId2UidDict and self._collectionId2UidDict[collectionId]
end

function ArcadeGameCharacterMO:getCollectionIdList(collectionType)
	local result = {}

	if self._collectionId2UidDict then
		local uidPosDict = {}

		if self._collectionType2UidDict then
			if self._collectionType2UidDict then
				for i, uid in ipairs(self._collectionType2UidDict) do
					uidPosDict[uid] = i
				end
			end

			local posDict = {}

			for collectionId, uidList in pairs(self._collectionId2UidDict) do
				local type = ArcadeConfig.instance:getCollectionType(collectionId)

				if type and type == collectionType and #uidList > 0 then
					result[#result + 1] = collectionId
				end

				local minPos

				for _, uid in ipairs(uidList) do
					local pos = uidPosDict[uid]

					if not minPos or pos and pos < minPos then
						minPos = pos
					end
				end

				if minPos then
					posDict[collectionId] = minPos
				end
			end

			table.sort(result, function(a, b)
				local posA = posDict[a]
				local posB = posDict[b]

				if posA and posB then
					return posB < posA
				end

				return a < b
			end)
		end
	end

	return result
end

function ArcadeGameCharacterMO:getCollectionUidList(collectionId)
	return self._collectionId2UidDict and self._collectionId2UidDict[collectionId]
end

function ArcadeGameCharacterMO:getCollectionCountWithType(collectionType)
	if self._collectionType2UidDict then
		if self._collectionType2UidDict then
			return #self._collectionType2UidDict
		end

		return 0
	end
end

function ArcadeGameCharacterMO:getCollectionUidListWithType(collectionType)
	local result = {}

	if collectionType then
		if self._collectionType2UidDict then
			result = self._collectionType2UidDict[collectionType] or result
		end
	else
		for _, uidList in pairs(self._collectionType2UidDict) do
			for _, uid in ipairs(uidList) do
				result[#result + 1] = uid
			end
		end
	end

	return result
end

function ArcadeGameCharacterMO:findUseWeaponUid(uidList)
	if not uidList then
		return
	end

	local weaponList = self:getCollectionUidListWithType(ArcadeGameEnum.CollectionType.Weapon)

	if weaponList and #weaponList > 0 then
		table.insert(uidList, weaponList[1])
	end
end

function ArcadeGameCharacterMO:getCanCarryWeaponNum()
	local isDualWieldingOn = ArcadeGameModel.instance:getGameSwitchIsOn(ArcadeGameEnum.GameSwitch.DualWielding)

	return (isDualWieldingOn or nil) and (ArcadeGameEnum.Const.DualWieldingCarryWeapon or ArcadeGameEnum.Const.NormalCarryWeapon)
end

function ArcadeGameCharacterMO:getIsCanRespawn()
	local respawnTimes = self:getResourceCount(ArcadeGameEnum.CharacterResource.RespawnTimes)

	return respawnTimes > 0
end

function ArcadeGameCharacterMO:getImgOffsetArr()
	return (ArcadeConfig.instance:getCharacterIcon2Offset(self.id))
end

function ArcadeGameCharacterMO:getImgScaleArr()
	return (ArcadeConfig.instance:getCharacterIcon2Scale(self.id))
end

function ArcadeGameCharacterMO:getPlayerActType()
	return self._playerActType
end

function ArcadeGameCharacterMO:getSkillList()
	local lastedOpIdx = self._skillSetMO:getOpIdx()

	if self._allSkillList and self._skillSetOpIdx == lastedOpIdx then
		return self._allSkillList
	end

	self._allSkillList = {}

	local characterSkillList = self._skillSetMO:getSkillList()

	tabletool.addValues(self._allSkillList, characterSkillList)

	self._skillSetOpIdx = lastedOpIdx

	if self._collectionType2UidDict then
		for type, uidList in pairs(self._collectionType2UidDict) do
			for _, uid in ipairs((type == ArcadeGameEnum.CollectionType.Weapon or nil) and {
				uidList[1]
			}) do
				local collectionMO = self:getCollectionMO(uid)

				if collectionMO then
					local skillSetMO = collectionMO:getSkillSetMO()
					local skillList = skillSetMO:getSkillList()

					tabletool.addValues(self._allSkillList, skillList)
				end
			end
		end
	end

	table.sort(self._allSkillList, ArcadeGameHelper.sortSkillList)

	return self._allSkillList
end

return ArcadeGameCharacterMO
