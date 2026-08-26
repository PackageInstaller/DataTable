-- chunkname: @modules/logic/bossrush/model/v3a9/V3a9_BossRushTeamMO.lua

module("modules.logic.bossrush.model.v3a9.V3a9_BossRushTeamMO", package.seeall)

local V3a9_BossRushTeamMO = pureTable("V3a9_BossRushTeamMO")

function V3a9_BossRushTeamMO:initInfo(actId, stage, actModeTeam)
	self._actId = actId
	self._stage = stage
	self._heroList = {}
	self._stageCo = V3a9_BossRushModel.instance:getStageMo(actId, stage)

	local episodeCos = BossRushConfig.instance:getEpisodeStages(self._stage, actId)

	self._episodeCo = episodeCos and episodeCos[1]

	self:refreshTeamInfo(actModeTeam)
end

function V3a9_BossRushTeamMO:refreshTeamInfo(actModeTeam)
	self._heroList = {}
	self._assistMo = nil

	for i, info in ipairs(actModeTeam.frontHeroInfos) do
		self._heroList[i] = self:_refreshHeroMo(self._heroList[i], info)
	end

	for i, info in ipairs(actModeTeam.backHeroInfos) do
		local index = 4 + i

		self._heroList[index] = self:_refreshHeroMo(self._heroList[index], info)
	end

	self._addBondGroupId = actModeTeam.addBondGroupId or 0
end

function V3a9_BossRushTeamMO:_refreshHeroMo(mo, info)
	mo = mo or {}
	mo.uid = info.uid
	mo.friendUserId = info.friendUserId
	mo.isFriend = info.isFriend
	mo.assistHeroInfo = info.assistHeroInfo
	mo.tag1 = info.tag1
	mo.tag2s = info.tag2s

	if info.uid ~= "0" and mo.isFriend and mo.assistHeroInfo then
		if self._assistMo then
			self._assistMo:setHeroInfo(mo.assistHeroInfo)
		else
			self._assistMo = PickAssistHeroMO.New()

			self._assistMo:init(mo.assistHeroInfo)
		end

		mo.assistMo = self._assistMo
	end

	return mo
end

function V3a9_BossRushTeamMO:getHeroId(info)
	if info and info.uid and info.uid ~= "0" then
		if info.isFriend and info.assistMo then
			return info.assistMo.heroId
		else
			local heroMo = HeroModel.instance:getById(info.uid)

			if not heroMo then
				local userId = PlayerModel.instance:getMyUserId()

				logError(string.format("不是协助角色 拿不到该角色数据：userId:%s  heroUid:%s", userId, info.uid))

				return
			end

			return heroMo.heroId
		end
	end
end

function V3a9_BossRushTeamMO:getHeroPos(heroId)
	if not self._heroList or not heroId then
		return
	end

	for i, info in pairs(self._heroList) do
		local id = self:getHeroId(info)

		if heroId == id then
			return i
		end
	end
end

function V3a9_BossRushTeamMO:isBackHero(heroId)
	if not self._heroList or not heroId then
		return
	end

	for i = 5, 8 do
		local info = self:getHeroInfo(i)
		local id = self:getHeroId(info)

		if heroId == id then
			return i
		end
	end
end

function V3a9_BossRushTeamMO:saveHeroList(uids, assistMo)
	self._heroList = {}

	if uids then
		for i, uid in pairs(uids) do
			local info = {}

			info.uid = uid

			if assistMo and assistMo.heroUid == uid then
				info.friendUserId = assistMo.userId
			end

			self._heroList[i] = info
		end
	end
end

function V3a9_BossRushTeamMO:removeHero(index)
	self._heroList[index] = "0"
end

function V3a9_BossRushTeamMO:getAssistMo()
	return self._assistMo
end

function V3a9_BossRushTeamMO:clearAssistMo()
	if self._assistMo then
		local heroList = self:getHeroInfos()

		if heroList then
			for i, info in pairs(heroList) do
				if info.uid ~= "0" and info.uid == self._assistMo.heroUid then
					heroList[i].uid = "0"
					heroList[i].isFriend = false
					heroList[i].friendUserId = "0"
				end
			end
		end
	end

	self._assistMo = nil
end

function V3a9_BossRushTeamMO:getHeroInfo(index)
	return self._heroList[index]
end

function V3a9_BossRushTeamMO:getHeroInfos()
	return self._heroList
end

function V3a9_BossRushTeamMO:getBackHeroUids()
	local list = {}

	for i = 5, 8 do
		if self._heroList[i] then
			if not self._heroList[i].uid then
				local uid = "0"

				table.insert(list, uid)
			end
		end
	end

	return list
end

function V3a9_BossRushTeamMO:getHeroGroupMO()
	return V3a9_BossRushModel.instance:getCurGroupMO()
end

function V3a9_BossRushTeamMO:refreshHeroList(heroList)
	if heroList then
		for i, hero in ipairs(heroList) do
			self:modifyHero(i, hero)
		end
	end
end

function V3a9_BossRushTeamMO:getAddBondGroupId()
	return self._addBondGroupId or 0
end

function V3a9_BossRushTeamMO:setAddBondGroupId(groupId)
	self._addBondGroupId = groupId
end

return V3a9_BossRushTeamMO
