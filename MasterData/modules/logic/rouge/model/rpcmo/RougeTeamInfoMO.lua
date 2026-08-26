-- chunkname: @modules/logic/rouge/model/rpcmo/RougeTeamInfoMO.lua

module("modules.logic.rouge.model.rpcmo.RougeTeamInfoMO", package.seeall)

local RougeTeamInfoMO = pureTable("RougeTeamInfoMO")

function RougeTeamInfoMO:init(info)
	self.battleHeroList, self.battleHeroMap = GameUtil.rpcInfosToListAndMap(info.battleHeroList, RougeBattleHeroMO, "index")
	self.heroLifeList, self.heroLifeMap = GameUtil.rpcInfosToListAndMap(info.heroLifeList, RougeHeroLifeMO, "heroId")
	self.heroInfoList, self.heroInfoMap = GameUtil.rpcInfosToListAndMap(info.heroInfoList, RougeHeroInfoMO, "heroId")
	self._assistHeroMO = nil

	if info:HasField("assistHeroInfo") then
		local assistMO = Season123AssistHeroMO.New()

		assistMO:init(info.assistHeroInfo)

		self._assistHeroMO = Season123HeroUtils.createHeroMOByAssistMO(assistMO)

		if RougeHeroGroupBalanceHelper.getIsBalanceMode() then
			self._assistHeroMO:setOtherPlayerIsOpenTalent(true)
		end
	end

	self:_initSupportHeroAndSkill()
	self:_initTeamList()
	self:updateDeadHeroNum()
end

function RougeTeamInfoMO:_initSupportHeroAndSkill()
	self._supportSkillMap = {}
	self._supportBattleHeroMap = {}

	for i, v in ipairs(self.battleHeroList) do
		if v.supportHeroId > 0 and v.supportHeroSkill > 0 then
			local skillIdDict = SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(v.supportHeroId, nil, self:getAnyHeroMo(v.supportHeroId))

			self._supportSkillMap[v.supportHeroId] = skillIdDict and skillIdDict[v.supportHeroSkill]
			self._supportBattleHeroMap[v.index + RougeEnum.FightTeamNormalHeroNum] = {
				heroId = v.supportHeroId
			}
		end
	end
end

function RougeTeamInfoMO:_initTeamList()
	self._teamMap = {}
	self._teamAssistMap = {}

	for i, v in ipairs(self.battleHeroList) do
		if v.heroId ~= 0 then
			self._teamMap[v.heroId] = v
		end

		if v.supportHeroId ~= 0 then
			self._teamAssistMap[v.supportHeroId] = v
		end
	end
end

function RougeTeamInfoMO:getAssistHeroMo(heroId)
	if heroId then
		if self._assistHeroMO and self._assistHeroMO.heroId == heroId then
			return self._assistHeroMO
		end
	else
		return self._assistHeroMO
	end
end

function RougeTeamInfoMO:getAssistHeroMoByUid(uid)
	if self._assistHeroMO and self._assistHeroMO.uid == uid then
		return self._assistHeroMO
	end
end

function RougeTeamInfoMO:getAnyHeroMo(heroId)
	return self:getAssistHeroMo(heroId) or HeroModel.instance:getByHeroId(heroId)
end

function RougeTeamInfoMO:isAssistHero(heroId)
	return self._assistHeroMO and self._assistHeroMO.heroId == heroId
end

function RougeTeamInfoMO:inTeam(heroId)
	return self._teamMap[heroId] ~= nil
end

function RougeTeamInfoMO:inTeamAssist(heroId)
	return self._teamAssistMap[heroId] ~= nil
end

function RougeTeamInfoMO:getAssistTargetHero(heroId)
	return self._teamAssistMap and self._teamAssistMap[heroId]
end

function RougeTeamInfoMO:getHeroHp(heroId)
	return self.heroLifeMap[heroId]
end

function RougeTeamInfoMO:getSupportSkillStrList()
	local list = {}

	for i = 1, RougeEnum.FightTeamNormalHeroNum do
		local mo = self.battleHeroMap[i]

		list[i] = mo and mo.supportHeroSkill ~= 0 and string.format("%s#%s", mo.supportHeroId, mo.supportHeroSkill) or ""
	end

	return list
end

function RougeTeamInfoMO:getSupportSkillIndex(heroId)
	local skillId = self:getSupportSkill(heroId)

	if not skillId then
		return
	end

	local heroMo = self:getAnyHeroMo(heroId)

	if not heroMo then
		logError(string.format("RougeTeamInfoMO getSupportSkillIndex heroId:%s heroMo nil", heroId))

		return
	end

	local skillIdDict = SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(heroId, nil, heroMo)

	if not skillIdDict then
		return
	end

	for k, v in pairs(skillIdDict) do
		if v == skillId then
			return k
		end
	end
end

function RougeTeamInfoMO:getSupportSkill(heroId)
	return self._supportSkillMap[heroId]
end

function RougeTeamInfoMO:setSupportSkill(heroId, skillId)
	self._supportSkillMap[heroId] = skillId
end

function RougeTeamInfoMO:getGroupInfos()
	local groupMo = RougeHeroGroupMO.New()
	local heroList = {}
	local equipList = {}

	groupMo:setMaxHeroCount(RougeEnum.FightTeamHeroNum)

	for i = 1, RougeEnum.FightTeamHeroNum do
		if not self.battleHeroMap[i] then
			local battleHeroMo = self._supportBattleHeroMap[i]

			if battleHeroMo then
				if not battleHeroMo.heroId then
					local heroId = 0
					local heroMo = HeroModel.instance:getByHeroId(heroId)

					if battleHeroMo then
						if not battleHeroMo.equipUid then
							local equipUid = "0"

							table.insert(heroList, (heroMo or nil) and (heroMo.uid or "0"))

							if i <= RougeEnum.FightTeamNormalHeroNum then
								local equipMo = HeroGroupEquipMO.New()
								local pos = i - 1

								equipMo:init({
									index = pos,
									equipUid = {
										equipUid
									}
								})

								equipList[pos] = equipMo
							end
						end
					end
				end
			end
		end
	end

	groupMo:init({
		id = 1,
		heroList = heroList,
		equips = equipList
	})

	return {
		groupMo
	}
end

function RougeTeamInfoMO:getBattleHeroList()
	return self.battleHeroList
end

function RougeTeamInfoMO:updateTeamLife(heroLifeList)
	for _, info in ipairs(heroLifeList) do
		local mo = self.heroLifeMap[info.heroId]

		if mo then
			mo:update(info)
		else
			mo = RougeHeroLifeMO.New()

			mo:init(info)

			self.heroLifeMap[mo.heroId] = mo

			table.insert(self.heroLifeList, mo)
		end
	end

	self:updateDeadHeroNum()
end

function RougeTeamInfoMO:updateExtraHeroInfo(heroInfoList)
	for _, info in ipairs(heroInfoList) do
		local mo = self.heroInfoMap[info.heroId]

		if mo then
			mo:update(info)
		else
			mo = RougeHeroInfoMO.New()

			mo:init(info)

			self.heroInfoMap[mo.heroId] = mo

			table.insert(self.heroInfoList, mo)
		end
	end
end

function RougeTeamInfoMO:updateTeamLifeAndDispatchEvent(heroLifeList)
	local status = RougeMapEnum.LifeChangeStatus.Idle

	for _, info in ipairs(heroLifeList) do
		local mo = self.heroLifeMap[info.heroId]

		if mo then
			local _status = RougeMapHelper.getLifeChangeStatus(mo.life, info.life)

			if _status ~= RougeMapEnum.LifeChangeStatus.Idle then
				status = _status
			end

			mo:update(info)
		else
			mo = RougeHeroLifeMO.New()

			mo:init(info)

			self.heroLifeMap[mo.heroId] = mo

			table.insert(self.heroLifeList, mo)
		end
	end

	if status ~= RougeMapEnum.LifeChangeStatus.Idle then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onTeamLifeChange, status)
	end

	self:updateDeadHeroNum()
end

function RougeTeamInfoMO:getAllHeroCount()
	return #self.heroLifeList
end

function RougeTeamInfoMO:getAllHeroId()
	local heroIds = {}

	if self.heroLifeList then
		for _, heroLifeMO in ipairs(self.heroLifeList) do
			local heroId = heroLifeMO.heroId

			table.insert(heroIds, heroId)
		end
	end

	return heroIds
end

function RougeTeamInfoMO:updateDeadHeroNum()
	self.deadHeroNum = 0

	if self.heroLifeList then
		for _, heroLifeMO in ipairs(self.heroLifeList) do
			if heroLifeMO.life <= 0 then
				self.deadHeroNum = self.deadHeroNum + 1
			end
		end
	end
end

function RougeTeamInfoMO:getDeadHeroNum()
	return self.deadHeroNum
end

function RougeTeamInfoMO:getHeroInfo(heroId)
	return self.heroInfoMap and self.heroInfoMap[heroId]
end

return RougeTeamInfoMO
