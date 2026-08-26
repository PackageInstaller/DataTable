-- chunkname: @modules/logic/bossrush/model/v3a9/V3a9_BossRushExpandBondGroupMO.lua

module("modules.logic.bossrush.model.v3a9.V3a9_BossRushExpandBondGroupMO", package.seeall)

local V3a9_BossRushExpandBondGroupMO = pureTable("V3a9_BossRushExpandBondGroupMO")

function V3a9_BossRushExpandBondGroupMO:init(groupId)
	self._groupId = groupId
	self._moDict = {}
	self._tags = {}
	self._containsHeroIdList = {}
	self._containsHeroIdDict = {}
	self._heroIdsDict = {}
	self._battleTags = {}
	self._maxActiveNum = 0
end

function V3a9_BossRushExpandBondGroupMO:getGroupId()
	return self._groupId
end

function V3a9_BossRushExpandBondGroupMO:AddMo(mo)
	local co = mo:getConfig()
	local activeNum = mo:getActiveNum()

	self._moDict[activeNum] = mo
	self._maxActiveNum = math.max(self._maxActiveNum, activeNum)

	local _, tags = mo:getTags()

	if tags then
		for tag in pairs(tags) do
			table.insert(self._battleTags, tag)
		end
	end

	self._co = co
end

function V3a9_BossRushExpandBondGroupMO:checkExpandBonds(heroIdList)
	self._containsHeroIdList = {}
	self._containsHeroIdDict = {}

	if heroIdList then
		for _, heroId in pairs(heroIdList) do
			if self:hasHero(heroId) then
				table.insert(self._containsHeroIdList, heroId)

				self._containsHeroIdDict[heroId] = true
			end
		end
	end
end

function V3a9_BossRushExpandBondGroupMO:isEquipHero(heroId)
	return self._containsHeroIdDict[heroId]
end

function V3a9_BossRushExpandBondGroupMO:isDeathHero(heroId)
	return V3a9_BossRushModel.instance:isDeathHero(heroId)
end

function V3a9_BossRushExpandBondGroupMO:refreshHero(heroId)
	self._heroList = nil
	self._heroIdsDict[heroId] = self:isContainsHeroCareer(heroId) or self:isContainsHeroBattleTags(heroId)
end

function V3a9_BossRushExpandBondGroupMO:isContainsHeroCareer(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)
	local career

	if heroMo then
		career = heroMo:getCareer()
	else
		local heroConfig = HeroConfig.instance:getHeroCO(heroId)

		career = heroConfig.career
	end

	local careers = FightConfig.instance:getCareerList(career)

	if careers and self:isContainsCareerTags(careers) then
		return true
	end
end

function V3a9_BossRushExpandBondGroupMO:isContainsHeroBattleTags(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)
	local battleTag

	if heroMo then
		battleTag = heroMo:getHeroBattleTag()
	else
		local heroConfig = HeroConfig.instance:getHeroCO(heroId)

		battleTag = heroConfig.battleTag
	end

	if not string.nilorempty(battleTag) then
		local tags = string.splitToNumber(battleTag, "#")

		if self:isContainsBattleTags(tags) then
			return true
		end
	end
end

function V3a9_BossRushExpandBondGroupMO:isContainsCareerTags(tags)
	for _, mo in pairs(self._moDict) do
		if mo:isContainsCareerTags(tags) then
			return true
		end
	end
end

function V3a9_BossRushExpandBondGroupMO:isContainsBattleTags(tags)
	for _, mo in pairs(self._moDict) do
		if mo:isContainsBattleTags(tags) then
			return true
		end
	end
end

function V3a9_BossRushExpandBondGroupMO:getAllHero()
	if not self._heroList then
		self._heroList = {}

		for id in pairs(self._heroIdsDict) do
			table.insert(self._heroList, id)
		end
	end

	table.sort(self._heroList, function(a, b)
		local a_heroMo = HeroModel.instance:getByHeroId(a)
		local b_heroMo = HeroModel.instance:getByHeroId(b)
		local a_hasHero = a_heroMo ~= nil
		local b_hasHero = b_heroMo ~= nil

		if a_hasHero ~= b_hasHero then
			return a_hasHero
		end

		local a_isEquiped = self:isEquipHero(a)
		local b_isEquiped = self:isEquipHero(b)

		if a_isEquiped ~= b_isEquiped then
			return a_isEquiped
		end

		local a_isDeath = V3a9_BossRushModel.instance:isRestrict(a)
		local b_isDeath = V3a9_BossRushModel.instance:isRestrict(b)

		if a_isDeath ~= b_isDeath then
			return b_isDeath
		end

		local a_heroCo = HeroConfig.instance:getHeroCO(a)
		local b_heroCo = HeroConfig.instance:getHeroCO(b)

		if a_heroCo.rare ~= b_heroCo.rare then
			return a_heroCo.rare > b_heroCo.rare
		end

		return a < b
	end)

	return self._heroList
end

function V3a9_BossRushExpandBondGroupMO:getTagType()
	return self._co.tagType
end

function V3a9_BossRushExpandBondGroupMO:hasHero(id)
	return self._heroIdsDict[id]
end

function V3a9_BossRushExpandBondGroupMO:getRealActiveHeroNum()
	if self._containsHeroIdList then
		if not #self._containsHeroIdList then
			return 0
		end
	end
end

function V3a9_BossRushExpandBondGroupMO:getCurActiveHeroNum()
	local groupId = self:getGroupId()
	local addGroupId = V3a9_BossRushExpandBondModel.instance:getEditorAddBondGroupId()
	local num = self:getRealActiveHeroNum()

	if groupId == addGroupId and num > 0 then
		num = num + 1
	end

	return num, self._maxActiveNum
end

function V3a9_BossRushExpandBondGroupMO:getCurActiveMo()
	local num = self:getCurActiveNum()

	return self._moDict[num]
end

function V3a9_BossRushExpandBondGroupMO:getCurActiveNum()
	local curNum = self:getCurActiveHeroNum()
	local num = 0

	for activeNum in pairs(self._moDict) do
		if activeNum <= curNum and num < activeNum then
			num = activeNum
		end
	end

	return num
end

function V3a9_BossRushExpandBondGroupMO:isOverMaxLevel()
	local cur, max = self:getCurActiveHeroNum()

	return max <= cur
end

function V3a9_BossRushExpandBondGroupMO:getLevelMoList()
	if not self._moList then
		self._moList = {}

		for _, mo in pairs(self._moDict) do
			table.insert(self._moList, mo)
		end

		table.sort(self._moList, function(a, b)
			return a:getActiveNum() < b:getActiveNum()
		end)
	end

	return self._moList
end

function V3a9_BossRushExpandBondGroupMO:getIcon()
	return self._co and self._co.icon
end

function V3a9_BossRushExpandBondGroupMO:getName()
	return self._co and self._co.name
end

function V3a9_BossRushExpandBondGroupMO:getBattleTags()
	return self._battleTags
end

return V3a9_BossRushExpandBondGroupMO
