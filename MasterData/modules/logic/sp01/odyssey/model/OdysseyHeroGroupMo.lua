-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyHeroGroupMo.lua

module("modules.logic.sp01.odyssey.model.OdysseyHeroGroupMo", package.seeall)

local OdysseyHeroGroupMo = class("OdysseyHeroGroupMo", HeroGroupMO)

function OdysseyHeroGroupMo:init(info)
	self.id = info.no
	self.groupId = info.no
	self.name = tostring(info.name)

	if info.clothId and info.clothId == 0 then
		local defaultSelectClothId = lua_cloth.configList[1].id

		if PlayerClothModel.instance:canUse(defaultSelectClothId) then
			info.clothId = defaultSelectClothId
		end
	end

	self.clothId = info.clothId or 0
	self.heroList = {}
	self.assistBossId = nil
	self.odysseyEquips = {}
	self.isReplay = false
	self.odysseySuitDic = {}
	self._playerMax = OdysseyEnum.MaxHeroGroupCount
	self._roleNum = OdysseyEnum.MaxHeroGroupCount
	self.odysseyEquipDic = {}
	self.heroIdPosDic = {}

	local tempTrialDict = {}
	local realHeroId

	if info.heroes then
		if not #info.heroes then
			local heroCount = 0

			for i = 1, heroCount do
				local odysseyFormHero = info.heroes[i]
				local trialId = odysseyFormHero.trialId
				local haveTrialId = trialId ~= nil and trialId ~= 0
				local trialCo

				if haveTrialId then
					trialCo = lua_hero_trial.configDict[trialId][0]

					local uid = tostring(tonumber(trialId .. "." .. "0") - 1099511627776)

					table.insert(self.heroList, tostring(uid))

					tempTrialDict[odysseyFormHero.position] = {
						trialId,
						0
					}
					realHeroId = -trialId
				else
					if odysseyFormHero.heroId ~= 0 then
						local heroMo = HeroModel.instance:getByHeroId(odysseyFormHero.heroId)

						table.insert(self.heroList, tostring(heroMo.uid))
					else
						table.insert(self.heroList, tostring(odysseyFormHero.heroId))
					end

					realHeroId = odysseyFormHero.heroId
				end

				self.heroIdPosDic[odysseyFormHero.position] = realHeroId

				if odysseyFormHero.mindId ~= nil then
					local equipUid = haveTrialId and (-trialCo.equipId or 0) or odysseyFormHero.mindId
					local param = {
						index = i - 1,
						equipUid = {
							tostring(equipUid)
						}
					}

					self:updatePosEquips(param)
				end

				self:updateOdysseyEquips(odysseyFormHero)

				for _, odysseyEquipInfo in ipairs(odysseyFormHero.equips) do
					if odysseyEquipInfo.equipUid ~= 0 then
						self.odysseyEquipDic[odysseyEquipInfo.equipUid] = {
							heroId = realHeroId,
							heroPos = odysseyFormHero.position,
							slotId = odysseyEquipInfo.slotId
						}
					end
				end
			end

			self.haveSuit = false

			for _, suitInfo in ipairs(info.suits) do
				if suitInfo then
					if self.odysseySuitDic[suitInfo.suitId] == nil then
						self.odysseySuitDic[suitInfo.suitId] = suitInfo
					end

					if suitInfo.count > 0 then
						self.haveSuit = true
					end
				end
			end

			self.trialDict = tempTrialDict

			for i = heroCount + 1, OdysseyEnum.MaxHeroGroupCount do
				table.insert(self.heroList, "0")
			end
		end
	end
end

function OdysseyHeroGroupMo:updateOdysseyEquips(v)
	local equipMo = OdysseyHeroGroupEquipMo.New()

	equipMo:init(v)
	self:setOdysseyEquips(equipMo)
end

function OdysseyHeroGroupMo:getOdysseyEquips(pos)
	return self.odysseyEquips[pos]
end

function OdysseyHeroGroupMo:setOdysseyEquips(odysseyEquipMo)
	self.odysseyEquips[odysseyEquipMo.index] = odysseyEquipMo
end

function OdysseyHeroGroupMo:swapOdysseyEquips(posA, posB)
	local odysseyEquipA = self:getOdysseyEquips(posA)
	local odysseyEquipB = self:getOdysseyEquips(posB)

	odysseyEquipA.index = posB
	odysseyEquipB.index = posA

	self:setOdysseyEquips(odysseyEquipA)
	self:setOdysseyEquips(odysseyEquipB)
end

function OdysseyHeroGroupMo:swapOdysseyEquip(posA, posB, indexA, indexB)
	local odysseyEquipA = self:getOdysseyEquips(posA)
	local odysseyEquipB = self:getOdysseyEquips(posB)

	if not odysseyEquipA.equipUid[indexA] then
		odysseyEquipA.equipUid[indexA] = odysseyEquipB.equipUid[indexB]
		odysseyEquipB.equipUid[indexB] = odysseyEquipA.equipUid[indexA]
	end
end

function OdysseyHeroGroupMo:setOdysseyEquip(heroPos, equipIndex, equipUid)
	self:checkOdysseyEquipIsUse(equipUid)

	local equipInfoMo = self:getOdysseyEquips(heroPos - 1)

	equipInfoMo.equipUid[equipIndex] = equipUid
end

function OdysseyHeroGroupMo:replaceOdysseyEquip(heroPos, equipIndex, equipUid)
	self:setOdysseyEquip(heroPos, equipIndex, equipUid)
end

function OdysseyHeroGroupMo:unloadOdysseyEquip(heroPos, equipIndex)
	self:setOdysseyEquip(heroPos, equipIndex, 0)
end

function OdysseyHeroGroupMo:checkOdysseyEquipIsUse(equipUid)
	if equipUid ~= nil and equipUid ~= 0 then
		local heroPosInfo = self.odysseyEquipDic[equipUid]

		if heroPosInfo then
			self:setOdysseyEquip(heroPosInfo.heroPos, heroPosInfo.slotId, 0)
		end
	end
end

function OdysseyHeroGroupMo:isEquipUse(equipUid)
	return self.odysseyEquipDic[equipUid] ~= nil
end

function OdysseyHeroGroupMo:getEquipByUid(equipUid)
	return self.odysseyEquipDic[equipUid]
end

function OdysseyHeroGroupMo:getOdysseyEquipSuit(id)
	return self.odysseySuitDic[id]
end

function OdysseyHeroGroupMo:updatePosEquips(v)
	for i = 0, OdysseyEnum.MaxHeroGroupCount do
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

return OdysseyHeroGroupMo
