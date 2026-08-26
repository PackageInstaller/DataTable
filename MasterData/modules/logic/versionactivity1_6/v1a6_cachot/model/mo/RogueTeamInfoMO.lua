-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/mo/RogueTeamInfoMO.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueTeamInfoMO", package.seeall)

local RogueTeamInfoMO = pureTable("RogueTeamInfoMO")

function RogueTeamInfoMO:init(info)
	self.groupIdx = info.groupIdx
	self._allHeros = {}
	self.fightHeros = {}

	for i, v in ipairs(info.fightHeros) do
		local hero = HeroMo.New()

		hero:update(v)
		table.insert(self.fightHeros, hero)

		self._allHeros[v.heroId] = true
	end

	self.supportHeros = {}

	for i, v in ipairs(info.supportHeros) do
		local hero = HeroMo.New()

		hero:update(v)
		table.insert(self.supportHeros, hero)

		self._allHeros[v.heroId] = true
	end

	self.lifes = {}
	self.lifeMap = {}

	for i, v in ipairs(info.lifes) do
		local heroLife = RogueHeroLifeMO.New()

		heroLife:init(v)
		table.insert(self.lifes, heroLife)

		self.lifeMap[heroLife.heroId] = heroLife
	end

	self.groupInfos = {}
	self.groupInfoMap = {}

	for i, v in ipairs(info.groupInfos) do
		local mo = RogueGroupInfoMO.New()

		mo:init(v)
		table.insert(self.groupInfos, mo)

		self.groupInfoMap[mo.id] = mo
	end

	self:updateGroupBoxStar(info.groupBoxStar)

	self.equipUids = {}
	self.equipUidsMap = {}

	for i, v in ipairs(info.equipUids) do
		table.insert(self.equipUids, v)

		self.equipUidsMap[v] = true
	end
end

function RogueTeamInfoMO:hasEquip(equipUid)
	return self.equipUidsMap[equipUid]
end

function RogueTeamInfoMO:updateGroupBoxStar(groupBoxStar)
	self.groupBoxStar = {}

	for i, v in ipairs(groupBoxStar) do
		table.insert(self.groupBoxStar, v)
	end
end

function RogueTeamInfoMO:getHeroHp(heroId)
	return self.lifeMap[heroId]
end

function RogueTeamInfoMO:getCurGroupInfo()
	return self.groupInfoMap[self.groupIdx]
end

function RogueTeamInfoMO:getGroupInfos()
	local list = {}

	for i = 1, 4 do
		local info = self.groupInfos[i]

		if not info then
			info = RogueGroupInfoMO.New()

			info:init({
				id = i,
				heroList = {},
				equips = {}
			})
		end

		table.insert(list, info)
	end

	return list
end

function RogueTeamInfoMO:getAllHeroIdsMap()
	return self._allHeros
end

function RogueTeamInfoMO:getAllHeroUids()
	local list = {}

	for i, v in ipairs(self.fightHeros) do
		local heroMO = HeroModel.instance:getByHeroId(v.heroId)

		if heroMO then
			table.insert(list, heroMO.uid)
		end
	end

	for i, v in ipairs(self.supportHeros) do
		local heroMO = HeroModel.instance:getByHeroId(v.heroId)

		if heroMO then
			table.insert(list, heroMO.uid)
		end
	end

	return list
end

function RogueTeamInfoMO:getGroupHeros()
	local curGroupInfo = self:getCurGroupInfo()
	local list = {}

	if not curGroupInfo then
		return list
	end

	for i, v in ipairs(curGroupInfo.heroList) do
		local heroMO = HeroModel.instance:getById(v)
		local mo = HeroSingleGroupMO.New()

		if heroMO then
			mo.id = heroMO.heroId
			mo.heroUid = heroMO.uid
		end

		table.insert(list, mo)
	end

	return list
end

function RogueTeamInfoMO:getGroupLiveHeros()
	local curGroupInfo = self:getCurGroupInfo()
	local list = {}

	if not curGroupInfo then
		return list
	end

	for i, v in ipairs(curGroupInfo.heroList) do
		local heroMO = HeroModel.instance:getById(v)
		local mo = HeroSingleGroupMO.New()
		local lifeInfo = heroMO and self:getHeroHp(heroMO.heroId)

		if lifeInfo and lifeInfo.life > 0 then
			mo.id = heroMO.heroId
			mo.heroUid = heroMO.uid
		end

		table.insert(list, mo)
	end

	return list
end

function RogueTeamInfoMO:getGroupEquips()
	local curGroupInfo = self:getCurGroupInfo()
	local list = {}

	if not curGroupInfo then
		return list
	end

	for i, v in ipairs(curGroupInfo.equips) do
		local equipId = v.equipUid[1]

		list[i] = EquipModel.instance:getEquip(equipId)
	end

	return list
end

function RogueTeamInfoMO:getFightHeros()
	local list = {}

	for i, v in ipairs(self.fightHeros) do
		local heroMO = HeroModel.instance:getByHeroId(v.heroId)
		local mo = HeroSingleGroupMO.New()

		if heroMO then
			mo.id = heroMO.heroId
			mo.heroUid = heroMO.uid
		end

		table.insert(list, mo)
	end

	return list
end

function RogueTeamInfoMO:getSupportHeros()
	local list = {}

	for i, v in ipairs(self.supportHeros) do
		local heroMO = HeroModel.instance:getByHeroId(v.heroId)

		if heroMO then
			local mo = HeroSingleGroupMO.New()

			mo.id = heroMO.heroId
			mo.heroUid = heroMO.uid
			mo._heroMO = heroMO

			table.insert(list, mo)
		end
	end

	return list
end

function RogueTeamInfoMO:getSupportLiveHeros()
	local list = {}

	for i, v in ipairs(self.supportHeros) do
		local heroMO = HeroModel.instance:getByHeroId(v.heroId)
		local lifeInfo = heroMO and self:getHeroHp(heroMO.heroId)

		if lifeInfo and lifeInfo.life > 0 then
			local mo = HeroSingleGroupMO.New()

			mo.id = heroMO.heroId
			mo.heroUid = heroMO.uid
			mo._heroMO = heroMO
			mo._hp = lifeInfo.life

			table.insert(list, mo)
		end
	end

	return list
end

return RogueTeamInfoMO
