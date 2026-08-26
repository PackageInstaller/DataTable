-- chunkname: @modules/logic/versionactivity2_7/act191/model/Act191GameMO.lua

module("modules.logic.versionactivity2_7.act191.model.Act191GameMO", package.seeall)

local Act191GameMO = pureTable("Act191GameMO")

function Act191GameMO:ctor()
	self.mainTeamSize = Activity191Enum.BaseTeamSlot.Main
	self.subTeamSize = Activity191Enum.BaseTeamSlot.Sub
end

function Act191GameMO:init(info)
	self.actId = Activity191Model.instance:getCurActId()
	self.coin = info.coin
	self.curStage = info.curStage
	self.curNode = info.curNode
	self.nodeInfo = info.nodeInfo
	self.curTeamIndex = 1
	self.teamInfo = info.teamInfo

	self:updateWareHouseInfo(info.warehouseInfo)

	self.score = info.score
	self.state = info.state
	self.rank = info.rank
	self.rankMark = 0
	self.recordInfo = info.recordInfo
	self.initBuildInfo = info.initBuildInfo
end

function Act191GameMO:update(info)
	if self.curNode ~= info.curNode then
		self.nodeChange = true
	end

	self.coin = info.coin
	self.curStage = info.curStage
	self.curNode = info.curNode
	self.nodeInfo = info.nodeInfo
	self.teamInfo = info.teamInfo

	self:updateWareHouseInfo(info.warehouseInfo)

	self.score = info.score
	self.state = info.state

	self:updateRank(info.rank)

	self.recordInfo = info.recordInfo
	self.initBuildInfo = info.initBuildInfo
end

function Act191GameMO:updateRank(rank)
	self.rankMark = rank > self.rank and 1 or rank < self.rank and -1 or 0
	self.rank = rank
end

function Act191GameMO:updateWareHouseInfo(info)
	local addSlot = 0

	self.warehouseInfo = info
	self.heroId2ExtraFetterMap = {}
	self.teamExtraFetterMap = {}
	self.teamPosExtraFetterMap = {}

	for _, effect in ipairs(info.effect) do
		local effectCo = lua_activity191_effect.configDict[effect.id]

		if effectCo then
			local params = string.split(effectCo.typeParam, "#")

			if effectCo.type == Activity191Enum.EffectType.HeroExtraFetter then
				local heroId = tonumber(params[1])
				local fetterTbl = self.heroId2ExtraFetterMap[heroId]

				if not fetterTbl then
					fetterTbl = {}
					self.heroId2ExtraFetterMap[heroId] = fetterTbl
				end

				table.insert(fetterTbl, params[2])
			elseif effectCo.type == Activity191Enum.EffectType.AddSubTeamSlot then
				addSlot = addSlot + tonumber(params[1])
			elseif effectCo.type == Activity191Enum.EffectType.TeamExtraFetter then
				local tag = params[1]
				local cnt = tonumber(params[2])

				self.teamExtraFetterMap[tag] = self.teamExtraFetterMap[tag] and self.teamExtraFetterMap[tag] + cnt or cnt
			elseif effectCo.type == Activity191Enum.EffectType.TeamPosExtraFetter then
				local pos = tonumber(params[1])

				self.teamPosExtraFetterMap[pos] = self.teamPosExtraFetterMap[pos] or {}

				table.insert(self.teamPosExtraFetterMap[pos], params[2])
			end
		end
	end

	self.subTeamSize = Activity191Enum.BaseTeamSlot.Sub + addSlot
end

function Act191GameMO:updateTeamInfo(teamIndex, teamInfo)
	self.curTeamIndex = teamIndex

	local isFind = false

	for k, info in ipairs(self.teamInfo) do
		if info.index == teamIndex then
			self.teamInfo[k] = teamInfo
			isFind = true

			break
		end
	end

	if not isFind then
		table.insert(self.teamInfo, teamInfo)
	end
end

function Act191GameMO:updateCurNodeInfo(nodeInfo)
	for i = 1, #self.nodeInfo do
		if self.nodeInfo[i].nodeId == self.curNode then
			self.nodeInfo[i] = nodeInfo
		end
	end
end

function Act191GameMO:getStageNodeInfoList(stageId)
	local nodeInfoList = {}

	stageId = stageId or self.curStage

	for _, info in ipairs(self.nodeInfo) do
		if info.stage == stageId then
			nodeInfoList[#nodeInfoList + 1] = info
		end
	end

	table.sort(nodeInfoList, function(a, b)
		return a.nodeId < b.nodeId
	end)

	return nodeInfoList
end

function Act191GameMO:getNodeInfoById(nodeId)
	for _, info in ipairs(self.nodeInfo) do
		if info.nodeId == nodeId then
			return info
		end
	end
end

function Act191GameMO:getNodeDetailMo(nodeId, notError)
	nodeId = nodeId or self.curNode

	local nodeInfo = self:getNodeInfoById(nodeId)

	if not nodeInfo or string.nilorempty(nodeInfo.nodeStr) then
		if not notError then
			logError("NodeInfo中不存在节点ID: " .. nodeId)
		end

		return
	end

	local mo = Act191NodeDetailMO.New()

	mo:init(nodeInfo.nodeStr)

	return mo
end

function Act191GameMO:getTeamInfo()
	local teamInfo = Activity191Helper.matchKeyInArray(self.teamInfo, self.curTeamIndex)

	if not teamInfo then
		teamInfo = Activity191Module_pb.Act191BattleTeamInfo()
		teamInfo.index = self.curTeamIndex
		teamInfo.auto = false

		table.insert(self.teamInfo, teamInfo)
	end

	return teamInfo
end

function Act191GameMO:getPreviewFetterCntDic(heroIdDic)
	local cntDic = tabletool.copy(self.teamExtraFetterMap)

	for index, heroId in pairs(heroIdDic) do
		local heroInfo = self:getHeroInfoInWarehouse(heroId)

		if heroInfo then
			local roleCo = Activity191Config.instance:getRoleCoByNativeId(heroId, heroInfo.star)

			if roleCo then
				local fetterArr = string.split(roleCo.tag, "#")

				for _, tag in ipairs(fetterArr) do
					Activity191Helper.addOneCount(cntDic, tag)
				end
			end
		end

		local fetterTbl = self.heroId2ExtraFetterMap[heroId]

		if fetterTbl then
			for _, tag in ipairs(fetterTbl) do
				Activity191Helper.addOneCount(cntDic, tag)
			end
		end

		fetterTbl = self.teamPosExtraFetterMap[index]

		if self.teamPosExtraFetterMap[index] then
			for _, tag in ipairs(fetterTbl) do
				Activity191Helper.addOneCount(cntDic, tag)
			end
		end
	end

	return cntDic
end

function Act191GameMO:getTeamFetterCntDic()
	local cntDic = tabletool.copy(self.teamExtraFetterMap)
	local teamInfo = self:getTeamInfo()

	for _, info in ipairs(teamInfo.battleHeroInfo) do
		if info.heroId ~= 0 then
			local heroInfo = self:getHeroInfoInWarehouse(info.heroId)

			if heroInfo then
				local roleCo = Activity191Config.instance:getRoleCoByNativeId(info.heroId, heroInfo.star)

				if roleCo and not string.nilorempty(roleCo.tag) then
					local fetterArr = string.split(roleCo.tag, "#")

					for _, tag in ipairs(fetterArr) do
						Activity191Helper.addOneCount(cntDic, tag)
					end
				end
			else
				logError("仓库中找不到编队角色" .. info.heroId)
			end

			local fetterTbl = self.heroId2ExtraFetterMap[info.heroId]

			if fetterTbl then
				for _, tag in ipairs(fetterTbl) do
					Activity191Helper.addOneCount(cntDic, tag)
				end
			end

			fetterTbl = self.teamPosExtraFetterMap[info.index]

			if self.teamPosExtraFetterMap[info.index] then
				for _, tag in ipairs(fetterTbl) do
					Activity191Helper.addOneCount(cntDic, tag)
				end
			end
		end
	end

	for _, info in ipairs(teamInfo.subHeroInfo) do
		local heroInfo = self:getHeroInfoInWarehouse(info.heroId)

		if heroInfo then
			local roleCo = Activity191Config.instance:getRoleCoByNativeId(info.heroId, heroInfo.star)

			if roleCo and not string.nilorempty(roleCo.tag) then
				local fetterArr = string.split(roleCo.tag, "#")

				for _, tag in ipairs(fetterArr) do
					Activity191Helper.addOneCount(cntDic, tag)
				end
			end
		end

		local fetterTbl = self.heroId2ExtraFetterMap[info.heroId]

		if fetterTbl then
			for _, tag in ipairs(fetterTbl) do
				Activity191Helper.addOneCount(cntDic, tag)
			end
		end
	end

	return cntDic
end

function Act191GameMO:getFetterHeroList(tag)
	local fetterHeroList = {}
	local roleCoList = lua_activity191_role.configList

	for _, roleCo in ipairs(roleCoList) do
		local heroId = roleCo.roleId

		if roleCo.activityId == self.actId and roleCo.star == 1 then
			local transfer = 0
			local inBag = 0

			if self:isHeroInTeam(heroId) then
				inBag = 2
			elseif self:getHeroInfoInWarehouse(heroId, true) then
				inBag = 1
			end

			local fetterArr = string.split(roleCo.tag, "#")

			if tabletool.indexOf(fetterArr, tag) then
				fetterHeroList[#fetterHeroList + 1] = {
					config = roleCo,
					inBag = inBag,
					transfer = transfer
				}
			end

			local fetterTbl = self.heroId2ExtraFetterMap[heroId]

			if fetterTbl and tabletool.indexOf(fetterTbl, tag) then
				fetterHeroList[#fetterHeroList + 1] = {
					transfer = 2,
					config = roleCo,
					inBag = inBag
				}
			end
		end
	end

	table.sort(fetterHeroList, Activity191Helper.sortFetterHeroList)

	return fetterHeroList
end

function Act191GameMO:setAutoFight(isAuto)
	local teamInfo = self:getTeamInfo()

	teamInfo.auto = isAuto

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
end

function Act191GameMO:getHeroInfoInWarehouse(heroId, notError)
	local info

	for _, heroInfo in ipairs(self.warehouseInfo.hero) do
		if heroId == heroInfo.heroId then
			info = heroInfo

			break
		end
	end

	if not notError and not info then
		logError(string.format("heroId : %s, heroInfo not found", heroId))
	end

	return info
end

function Act191GameMO:getBattleHeroInfoInTeam(heroId)
	local teamInfo = self:getTeamInfo()

	for _, heroInfo in ipairs(teamInfo.battleHeroInfo) do
		if heroInfo.heroId == heroId then
			return heroInfo
		end
	end
end

function Act191GameMO:getSubHeroInfoInTeam(heroId)
	local teamInfo = self:getTeamInfo()

	for _, heroInfo in ipairs(teamInfo.subHeroInfo) do
		if heroInfo.heroId == heroId then
			return heroInfo
		end
	end
end

function Act191GameMO:isHeroInTeam(heroId, release)
	local teamInfo = self:getTeamInfo()

	for _, heroInfo in ipairs(teamInfo.battleHeroInfo) do
		if heroInfo.heroId == heroId then
			if release then
				heroInfo.heroId = 0
			end

			return true
		end
	end

	for _, heroInfo in ipairs(teamInfo.subHeroInfo) do
		if heroInfo.heroId == heroId then
			if release then
				heroInfo.heroId = 0
			end

			return true
		end
	end
end

function Act191GameMO:teamHasMainHero()
	local teamInfo = self:getTeamInfo()

	for _, info in ipairs(teamInfo.battleHeroInfo) do
		if info.heroId ~= 0 then
			return true
		end
	end

	return false
end

function Act191GameMO:saveQuickGroupInfo(index2HeroMap)
	local teamInfo = self:getTeamInfo()

	for i = 1, self.mainTeamSize do
		local battleHeroInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, i)

		battleHeroInfo.heroId = index2HeroMap[i] or 0
	end

	for i = 1, self.subTeamSize do
		local subHeroInfo = Activity191Helper.getWithBuildSubHeroInfo(teamInfo.subHeroInfo, i)

		subHeroInfo.heroId = index2HeroMap[i + self.mainTeamSize] or 0
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
end

function Act191GameMO:replaceHeroInTeam(heroId, slotIndex)
	self:isHeroInTeam(heroId, true)

	local teamInfo = self:getTeamInfo()

	if slotIndex <= self.mainTeamSize then
		local battleHeroInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, slotIndex)

		battleHeroInfo.heroId = heroId
	else
		local subHeroInfo = Activity191Helper.getWithBuildSubHeroInfo(teamInfo.subHeroInfo, slotIndex - self.mainTeamSize)

		subHeroInfo.heroId = heroId
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
end

function Act191GameMO:removeHeroInTeam(heroId)
	local teamInfo = self:getTeamInfo()

	for _, info in ipairs(teamInfo.battleHeroInfo) do
		if info.heroId == heroId then
			info.heroId = 0

			Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)

			return
		end
	end

	for _, info in ipairs(teamInfo.subHeroInfo) do
		if info.heroId == heroId then
			info.heroId = 0

			Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)

			return
		end
	end
end

function Act191GameMO:exchangeHero(from, to)
	local teamInfo = self:getTeamInfo()
	local fromInfo, toInfo

	fromInfo = from <= self.mainTeamSize and Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, from) or Activity191Helper.getWithBuildSubHeroInfo(teamInfo.subHeroInfo, from - self.mainTeamSize)
	toInfo = to <= self.mainTeamSize and Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, to) or Activity191Helper.getWithBuildSubHeroInfo(teamInfo.subHeroInfo, to - self.mainTeamSize)
	fromInfo.heroId = toInfo.heroId
	toInfo.heroId = fromInfo.heroId

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
end

function Act191GameMO:getItemInfoInWarehouse(itemUid)
	for _, itemInfo in ipairs(self.warehouseInfo.item) do
		if itemInfo.uid == itemUid then
			return itemInfo
		end
	end

	logError(string.format("itemUid : %s, itemInfo not found", itemUid))
end

function Act191GameMO:isItemInTeam(itemUid, release)
	local teamInfo = self:getTeamInfo()

	for _, heroInfo in ipairs(teamInfo.battleHeroInfo) do
		if heroInfo.itemUid1 == itemUid then
			if release then
				heroInfo.itemUid1 = 0
			end

			return true
		end
	end
end

function Act191GameMO:replaceItemInTeam(itemUid, teamPos)
	self:isItemInTeam(itemUid, true)

	local teamInfo = self:getTeamInfo()
	local battleHeroInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, teamPos)

	battleHeroInfo.itemUid1 = itemUid

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
end

function Act191GameMO:removeItemInTeam(itemUid)
	local remove = false
	local teamInfo = self:getTeamInfo()

	for _, info in ipairs(teamInfo.battleHeroInfo) do
		if info.itemUid1 == itemUid then
			info.itemUid1 = 0
			remove = true
		end
	end

	if remove then
		Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
	end
end

function Act191GameMO:exchangeItem(from, to)
	local teamInfo = self:getTeamInfo()
	local fromInfo, toInfo

	fromInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, from)
	toInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, to)
	fromInfo.itemUid1 = toInfo.itemUid1
	toInfo.itemUid1 = fromInfo.itemUid1

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
end

function Act191GameMO:autoFill(callback, callbackObj)
	local teamInfo = self:getTeamInfo()

	for k, v in ipairs(self.warehouseInfo.hero) do
		if k <= self.mainTeamSize then
			local battleHeroInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, k)

			battleHeroInfo.heroId = v.heroId
		else
			local subHeroInfo = Activity191Helper.getWithBuildSubHeroInfo(teamInfo.subHeroInfo, k - self.mainTeamSize)

			subHeroInfo.heroId = v.heroId
		end
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, 1, teamInfo, callback, callbackObj)
end

function Act191GameMO:getAct191Effect(effectId)
	for _, effect in ipairs(self.warehouseInfo.effect) do
		if effect.id == effectId then
			return effect
		end
	end
end

function Act191GameMO:getBestFetterTag()
	local fetterCntDic = self:getTeamFetterCntDic()
	local fetterInfoList = Activity191Helper.getActiveFetterInfoList(fetterCntDic)

	if next(fetterInfoList) then
		return fetterInfoList[1].config.tag
	end
end

function Act191GameMO:clearRankMark()
	self.rankMark = 0
end

function Act191GameMO:getActiveBossId(tag)
	local bossCgfMap = Activity191Config.instance:getBossCfgMap()
	local tagBossList = bossCgfMap[tag]

	if tagBossList then
		local fetterCntDic = self:getTeamFetterCntDic()

		if not fetterCntDic[tag] then
			local count = 0

			for i = #tagBossList, 1, -1 do
				local config = tagBossList[i]

				if config then
					local conditions = string.splitToNumber(config.condition, "#")
					local type = conditions[1]
					local value = conditions[2]

					if type == Activity191Enum.ActiveBossType.Remodeling then
						local activeLvl = Activity191Helper.getFetterActiveLvl(tag, count)

						if activeLvl > 0 and value <= self.recordInfo.remodelingValue then
							return config.bossId
						end
					elseif type == Activity191Enum.ActiveBossType.RelationPerson and value <= count then
						return config.bossId
					end
				end
			end
		end
	else
		logError(string.format("羁绊: %s 不存在协战Boss", tag))
	end
end

function Act191GameMO:getActiveBossIdList()
	local bossIdList = {}
	local fetterCntDic = self:getTeamFetterCntDic()
	local bossCgfMap = Activity191Config.instance:getBossCfgMap()

	for tag, cfgList in pairs(bossCgfMap) do
		for i = #cfgList, 1, -1 do
			local config = cfgList[i]
			local conditions = string.splitToNumber(config.condition, "#")
			local type = conditions[1]
			local value = conditions[2]

			if type == Activity191Enum.ActiveBossType.Remodeling then
				local activeLvl = Activity191Helper.getFetterActiveLvl(tag, fetterCntDic[tag])

				if activeLvl > 0 and value <= self.recordInfo.remodelingValue then
					bossIdList[#bossIdList + 1] = config.bossId

					break
				end
			elseif type == Activity191Enum.ActiveBossType.RelationPerson and fetterCntDic[tag] and value <= fetterCntDic[tag] then
				bossIdList[#bossIdList + 1] = config.bossId

				break
			end
		end
	end

	return bossIdList
end

function Act191GameMO:getActiveSummonIdList()
	local bossIdList = self:getActiveBossIdList()
	local summonIdList = bossIdList or {}
	local fetterCntDic = self:getTeamFetterCntDic()
	local fetterInfoList = Activity191Helper.getActiveFetterInfoList(fetterCntDic)

	for _, info in ipairs(fetterInfoList) do
		local config = info.config

		if config.summon ~= 0 then
			summonIdList[#summonIdList + 1] = config.summon
		end
	end

	return summonIdList
end

function Act191GameMO:getAttrUpDicByRoleId(roleId)
	local attrDic = {}
	local fetterList = {}

	for _, effect in ipairs(self.warehouseInfo.effect) do
		if effect.type == Activity191Enum.EffectType.AttrEffect then
			local roleIdList = string.splitToNumber(effect.param, "#")

			if tabletool.indexOf(roleIdList, roleId) then
				local effectCo = lua_activity191_effect.configDict[effect.id]

				if effectCo then
					local tag = effectCo.tag

					if not string.nilorempty(tag) and not tabletool.indexOf(fetterList, tag) then
						fetterList[#fetterList + 1] = tag
					end

					local attrString = string.split(effectCo.typeParam, "#")[2]
					local attrParams = GameUtil.splitString2(attrString, true, "|", ",")

					for i = 1, #attrParams do
						local key = attrParams[i][1]
						local value = attrParams[i][2]

						attrDic[key] = attrDic[key] or 0
						attrDic[key] = attrDic[key] + value
					end
				end
			end
		end
	end

	return attrDic, fetterList
end

function Act191GameMO:getBossAttr()
	local attack, technic, heroCnt = 0, 0, 0
	local teamInfo = self:getTeamInfo()

	for _, v in ipairs(teamInfo.battleHeroInfo) do
		if v.heroId and v.heroId ~= 0 then
			heroCnt = heroCnt + 1

			local heroCo = Activity191Config.instance:getRoleCoByNativeId(v.heroId, 1)

			if heroCo then
				local attrCo = lua_activity191_template.configDict[heroCo.id]

				if attrCo then
					local attrUpDic = self:getAttrUpDicByRoleId(v.heroId)

					if not attrUpDic[Activity191Enum.AttrIdList[1]] then
						if not attrUpDic[Activity191Enum.AttrIdList[3]] then
							local technicRatio = 0

							attack = attack + attrCo.attack * (1 + attrUpDic[Activity191Enum.AttrIdList[1]] / 1000)
							technic = technic + attrCo.technic * (1 + technicRatio / 1000)
						end
					end
				end
			end
		end
	end

	if heroCnt ~= 0 then
		attack = Mathf.Round(attack / heroCnt)
		technic = Mathf.Round(technic / heroCnt)
	end

	return attack, technic
end

function Act191GameMO:getRelationDesc(relationCo)
	if relationCo.tag == "remodeling" then
		local bossId = self:getActiveBossId(relationCo.tag)

		if bossId then
			local bossCo = lua_activity191_assist_boss.configDict[bossId]

			if bossCo then
				return GameUtil.getSubPlaceholderLuaLangTwoParam(relationCo.desc, self.recordInfo.remodelingValue, bossCo.name)
			else
				return relationCo.desc
			end
		else
			local count = 0
			local txt = string.gsub(relationCo.desc, "%b()", function(match)
				count = count + 1

				return count == 2 and "" or match
			end)

			return GameUtil.getSubPlaceholderLuaLangOneParam(txt, self.recordInfo.remodelingValue)
		end
	end

	local effects = relationCo.effects

	if not string.nilorempty(effects) then
		local effectIds = string.splitToNumber(effects, "|")

		for k, id in ipairs(effectIds) do
			local act191Effect = self:getAct191Effect(id)

			if act191Effect and (not act191Effect["end"] or k == #effectIds) then
				return GameUtil.getSubPlaceholderLuaLangOneParam(relationCo.desc, string.format("%d/%d", act191Effect.count, act191Effect.needCount))
			end
		end
	end

	return string.gsub(relationCo.desc, "（(.-)）", "")
end

function Act191GameMO:getStoneId(config)
	for _, v in ipairs(self.recordInfo.heroFacets) do
		if v.roleId == config.roleId then
			return v.facetsId
		end
	end

	if not string.nilorempty(config.facetsId) then
		return string.splitToNumber(config.facetsId, "#")[1]
	end
end

function Act191GameMO:updateStoneId(roleId, facetsId)
	local info

	for _, v in ipairs(self.recordInfo.heroFacets) do
		if v.roleId == roleId then
			info = v

			break
		end
	end

	if not info then
		info = Activity191Module_pb.Act191HeroFacetsIdInfo()
		info.roleId = roleId

		table.insert(self.recordInfo.heroFacets, info)
	end

	info.facetsId = facetsId
end

function Act191GameMO:getSkillCount(skillIds)
	local count = 0
	local skillCountMap = GameUtil.splitString2(self.recordInfo.globalSkillCountMap, true)

	if skillCountMap then
		for _, data in ipairs(skillCountMap) do
			if tabletool.indexOf(skillIds, data[1]) then
				count = count + data[2]
			end
		end
	end

	return count
end

return Act191GameMO
