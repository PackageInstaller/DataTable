-- chunkname: @modules/logic/character/model/extra/CharacterExtraSkillTalentMO.lua

module("modules.logic.character.model.extra.CharacterExtraSkillTalentMO", package.seeall)

local CharacterExtraSkillTalentMO = class("CharacterExtraSkillTalentMO")

function CharacterExtraSkillTalentMO:ctor()
	self:_initRankTalentSkillPoint()
end

function CharacterExtraSkillTalentMO:isUnlockSystem()
	if self._unlockSystemRank then
		return self.heroMo.rank >= self._unlockSystemRank
	end
end

function CharacterExtraSkillTalentMO:refreshMo(extraStr, heroMo)
	self.heroMo = heroMo

	self:initConfig()

	self._extra = {}

	if not string.nilorempty(extraStr) then
		local split = GameUtil.splitString2(extraStr, false, "|", "#")

		for _, v in ipairs(split) do
			if not string.nilorempty(v[1]) then
				local sub = tonumber(v[1])

				if not string.nilorempty(v[2]) then
					self._extra[sub] = string.splitToNumber(v[2], ",")
				end
			end
		end
	end

	self:refreshStatus()
end

function CharacterExtraSkillTalentMO:_initRankTalentSkillPoint()
	self._rankTalentSkillPoint = {}

	local constCo = lua_fight_const.configDict[CharacterExtraEnum.UnlockTalentPointCountConst]
	local rankPoint = GameUtil.splitString2(constCo.value, true)

	for _, v in ipairs(rankPoint) do
		self._rankTalentSkillPoint[v[1]] = v[2]
		self._unlockSystemRank = self._unlockSystemRank and math.min(self._unlockSystemRank, v[1]) or v[1]
	end
end

function CharacterExtraSkillTalentMO:isNotLight()
	return not LuaUtil.tableNotEmpty(self._extra)
end

function CharacterExtraSkillTalentMO:getExtraCount()
	return self._extra and tabletool.len(self._extra) or 0
end

function CharacterExtraSkillTalentMO:getSubExtra()
	return self._extra
end

function CharacterExtraSkillTalentMO:getMainFieldMo()
	if self:isNotLight() then
		return
	end

	local exSkillLevel = self.heroMo.exSkillLevel
	local count = tabletool.len(self._extra)

	for sub, list in pairs(self._extra) do
		if list and #list > 0 and (count == 1 or #list == 3) then
			table.sort(list, function(a, b)
				return b < a
			end)

			for _, id in ipairs(list) do
				local mo = self:getMoById(sub, id)
				local fieldDesc = mo:getFieldDesc(exSkillLevel)

				if not string.nilorempty(fieldDesc) then
					return mo
				end
			end
		end
	end
end

function CharacterExtraSkillTalentMO:_checkIsAllLight(sub, idList)
	local treeMo = self:getTreeMosBySub(sub)

	for _, mo in ipairs(treeMo:getTreeMoList()) do
		if not LuaUtil.tableContains(idList, mo.id) then
			return false
		end
	end

	return true
end

function CharacterExtraSkillTalentMO:showReddot()
	if not self.heroMo or not self.heroMo:isOwnHero() then
		return
	end

	return self:getTalentpoint() > 0
end

function CharacterExtraSkillTalentMO:refreshStatus()
	local remainPoint = self:getTalentpoint()
	local lightTreeNodeCount = {}
	local totalCount = 0

	if self._extra then
		for i, v in pairs(self._extra) do
			local count = v and tabletool.len(v) or 0

			lightTreeNodeCount[i] = count
			totalCount = totalCount + count
		end
	end

	for i = 1, CharacterExtraEnum.TalentSkillSubCount do
		local treeMo = self:getTreeMosBySub(i)
		local moList = treeMo:getTreeMoList()

		if not lightTreeNodeCount[i] then
			local lightCount = 0

			for j, mo in ipairs(moList) do
				local needPoint = j - lightCount
				local status = CharacterExtraEnum.SkillTreeNodeStatus.Lock

				if totalCount == 0 then
					status = CharacterExtraEnum.SkillTreeNodeStatus.Normal
				elseif lightCount > 0 then
					if j <= lightCount then
						status = CharacterExtraEnum.SkillTreeNodeStatus.Light
					elseif needPoint <= remainPoint then
						status = CharacterExtraEnum.SkillTreeNodeStatus.Normal
					end
				elseif totalCount >= CharacterExtraEnum.TalentSkillTreeNodeCount and needPoint <= remainPoint then
					status = CharacterExtraEnum.SkillTreeNodeStatus.Normal
				end

				mo:setStatus(status)
			end
		end
	end
end

function CharacterExtraSkillTalentMO:initConfig()
	if self._treeMoList then
		return
	end

	local list = CharacterExtraConfig.instance:getSkillTalentCos()

	if not list then
		return
	end

	self._treeMoList = {}

	for sub, coList in pairs(list) do
		local mo = CharacterSkillTalentTreeMO.New()

		mo:initMo(sub, coList)

		self._treeMoList[sub] = mo
	end
end

function CharacterExtraSkillTalentMO:getTreeMosBySub(sub)
	return self._treeMoList and self._treeMoList[sub]
end

function CharacterExtraSkillTalentMO:getTreeNodeMoBySubLevel(sub, level)
	local mo = self._treeMoList[sub]

	if mo then
		return mo:getNodeMoByLevel(level)
	end
end

function CharacterExtraSkillTalentMO:getMoById(sub, id)
	local mo = self._treeMoList[sub]

	if mo then
		return mo:getMoById(id)
	end
end

function CharacterExtraSkillTalentMO:getLightOrCancelNodes(sub, level)
	local mo = self:getTreeNodeMoBySubLevel(sub, level)
	local mos = self._treeMoList[sub]:getTreeMoList()
	local list = {}

	for _, _mo in ipairs(mos) do
		if mo:isLight() then
			if mo.level <= _mo.level and _mo:isLight() then
				table.insert(list, _mo)
			end
		elseif mo.level >= _mo.level and not _mo:isLight() then
			table.insert(list, _mo)
		end
	end

	return list
end

function CharacterExtraSkillTalentMO:getRankTalentSkillPoint(rank)
	local point = 0

	for i = rank, 1, -1 do
		if self._rankTalentSkillPoint[i] then
			point = point + self._rankTalentSkillPoint[i]
		end
	end

	return point
end

function CharacterExtraSkillTalentMO:getTalentSkillPointByRank(rank)
	return self._rankTalentSkillPoint[rank] or 0
end

function CharacterExtraSkillTalentMO:getTalentpoint()
	local total = self:getRankTalentSkillPoint(self.heroMo.rank) or 0
	local lightCount = 0

	for _, list in pairs(self._extra) do
		for _, level in pairs(list) do
			lightCount = lightCount + 1
		end
	end

	local lightCount = lightCount

	return total - lightCount
end

function CharacterExtraSkillTalentMO:isNullTalentPonit()
	return self:getTalentpoint() == 0
end

function CharacterExtraSkillTalentMO:getUnlockSystemRank()
	return self._unlockSystemRank
end

function CharacterExtraSkillTalentMO:getUnlockRankStr(rank)
	local unlocktxt = {}

	if not self._unlockSystemRank then
		return
	end

	if self._unlockSystemRank == rank then
		local unlockFormat = luaLang("character_rankup_unlock_system")
		local txt = GameUtil.getSubPlaceholderLuaLangOneParam(unlockFormat, luaLang("character_rankup_system_1"))

		table.insert(unlocktxt, txt)
	end

	local point = self:getTalentSkillPointByRank(rank)

	if point and point > 0 then
		local format = luaLang("character_rankup_talentskilltree_add_point")
		local txt = GameUtil.getSubPlaceholderLuaLangOneParam(format, point)

		table.insert(unlocktxt, txt)
	end

	return unlocktxt
end

function CharacterExtraSkillTalentMO:getSmallSubIconPath(sub)
	return (string.format("characterskilltalent_job_0%s_small", sub))
end

function CharacterExtraSkillTalentMO:getWhiteSubIconPath(sub)
	return (string.format("charactertalent_job_0%s", sub))
end

function CharacterExtraSkillTalentMO:getSubIconPath(sub)
	local format = "characterskilltalent_job_0%s_%s"
	local count = self:getTreeLightCount(sub)

	return string.format(format, sub, count == 1 and 2 or count == 0 and 1 or count)
end

function CharacterExtraSkillTalentMO:getTreeLightCount(sub)
	if not self._extra then
		return 0
	end

	local count = tabletool.len(self._extra)
	local list = self._extra[sub]

	if list and #list > 0 and (count == 1 or #list == 3) then
		return #list
	end

	return 0
end

function CharacterExtraSkillTalentMO:getLightNodeAdditionalDesc(exSkillLevel)
	local desc = ""

	if not self._extra then
		return desc
	end

	for sub, _ in pairs(self._extra) do
		local treeMo = self:getTreeMosBySub(sub)

		desc = desc .. treeMo:getLightNodeAdditionalDesc(exSkillLevel)
	end

	return desc
end

function CharacterExtraSkillTalentMO:getReplaceSkills(skillIds)
	local replaceSkills = self:_getAllLightReplaceSkill()

	if replaceSkills then
		for i, id in pairs(skillIds) do
			for _, skillId in ipairs(replaceSkills) do
				local orignSkillId = skillId[1]
				local newSkillId = skillId[2]

				if skillIds[i] == orignSkillId then
					skillIds[i] = newSkillId
				end
			end
		end
	end

	return skillIds
end

function CharacterExtraSkillTalentMO:_getAllLightReplaceSkill()
	local skillIds = {}

	if not self.heroMo then
		return skillIds
	end

	if not self._extra then
		return skillIds
	end

	local exSkillLevel = self.heroMo.exSkillLevel
	local replaceSkill = {}

	for sub, list in pairs(self._extra) do
		for _, id in pairs(list) do
			local mo = self:getMoById(sub, id)
			local _replaceSkill = mo and mo:getReplaceSkill(exSkillLevel)
			local _info = {
				id = id,
				skills = _replaceSkill
			}

			table.insert(replaceSkill, _info)
		end
	end

	table.sort(replaceSkill, function(a, b)
		return a.id < b.id
	end)

	for _, info in ipairs(replaceSkill) do
		tabletool.addValues(skillIds, info.skills)
	end

	return skillIds
end

return CharacterExtraSkillTalentMO
