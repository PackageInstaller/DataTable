-- chunkname: @modules/logic/versionactivity2_7/act191/model/Act191MatchMO.lua

module("modules.logic.versionactivity2_7.act191.model.Act191MatchMO", package.seeall)

local Act191MatchMO = pureTable("Act191MatchMO")

function Act191MatchMO:init(info)
	self.uid = info.uid
	self.rank = info.rank
	self.robot = info.robot
	self.playerUid = info.playerUid
	self.heroMap = info.heroMap
	self.subHeroMap = info.subHeroMap
	self.enhanceSet = info.enhanceSet

	self:updateWarehouseInfo(info.wareHouseInfo)
end

function Act191MatchMO:updateWarehouseInfo(info)
	self.wareHouseInfo = info
	self.heroId2ExtraFetterMap = {}
	self.teamExtraFetterMap = {}
	self.teamPosExtraFetterMap = {}

	if self.robot then
		local fetterCntDic = self:getTeamFetterCntDic()

		for tag, count in pairs(fetterCntDic) do
			local activeLvl = Activity191Helper.getFetterActiveLvl(tag, count)

			if activeLvl > 0 then
				local fetterCo = Activity191Config.instance:getRelationCo(tag, activeLvl)

				if fetterCo and not string.nilorempty(fetterCo.effects) then
					local effectIdList = string.splitToNumber(fetterCo.effects, "|")

					for _, effectId in ipairs(effectIdList) do
						local effectCo = lua_activity191_effect.configDict[effectId]

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
							elseif effectCo.type == Activity191Enum.EffectType.TeamExtraFetter then
								local tag1 = params[1]
								local cnt = tonumber(params[2])

								self.teamExtraFetterMap[tag1] = self.teamExtraFetterMap[tag1] and self.teamExtraFetterMap[tag1] + cnt or cnt
							elseif effectCo.type == Activity191Enum.EffectType.TeamPosExtraFetter then
								local pos = tonumber(params[1])

								self.teamPosExtraFetterMap[pos] = self.teamPosExtraFetterMap[pos] or {}

								table.insert(self.teamPosExtraFetterMap[pos], params[2])
							end
						end
					end
				end
			end
		end
	else
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
	end
end

function Act191MatchMO:getRoleCo(heroId)
	if self.robot then
		return Activity191Config.instance:getRoleCo(heroId)
	else
		local heroInfo = self:getHeroInfo(heroId, true)

		if heroInfo then
			return Activity191Config.instance:getRoleCoByNativeId(heroId, heroInfo.star)
		end
	end
end

function Act191MatchMO:getHeroInfo(heroId, error)
	heroId = tostring(heroId)

	local info = self.wareHouseInfo.heroInfoMap[heroId]

	if error and not info then
		logError("enemyHeroInfo not found" .. heroId)
	end

	return info
end

function Act191MatchMO:getItemCo(itemUid)
	local itemId

	if self.robot then
		itemId = itemUid
	else
		local itemInfo = self:getItemInfo(itemUid)

		itemId = itemInfo.itemId
	end

	return Activity191Config.instance:getCollectionCo(itemId)
end

function Act191MatchMO:getItemInfo(itemUid)
	itemUid = tostring(itemUid)

	local info = self.wareHouseInfo.itemInfoMap[itemUid]

	if info then
		return info
	else
		logError("enemyItemInfo not found" .. itemUid)
	end
end

function Act191MatchMO:getTeamFetterCntDic()
	local cntDic = tabletool.copy(self.teamExtraFetterMap)

	for _, info in pairs(self.heroMap) do
		if info.heroId ~= 0 then
			local roleCo = self:getRoleCo(info.heroId)

			if roleCo then
				local fetterArr = string.split(roleCo.tag, "#")

				for _, tag in ipairs(fetterArr) do
					Activity191Helper.addOneCount(cntDic, tag)
				end
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

	for _, heroId in pairs(self.subHeroMap) do
		local roleCo = self:getRoleCo(heroId)

		if roleCo and not string.nilorempty(roleCo.tag) then
			local fetterArr = string.split(roleCo.tag, "#")

			for _, tag in ipairs(fetterArr) do
				Activity191Helper.addOneCount(cntDic, tag)
			end
		end

		local fetterTbl = self.heroId2ExtraFetterMap[heroId]

		if fetterTbl then
			for _, tag in ipairs(fetterTbl) do
				Activity191Helper.addOneCount(cntDic, tag)
			end
		end
	end

	return cntDic
end

function Act191MatchMO:getFetterHeroList(tag)
	local actId = Activity191Model.instance:getCurActId()
	local fetterHeroList = {}
	local roleCoList = lua_activity191_role.configList

	for _, roleCo in ipairs(roleCoList) do
		if self.robot then
			if not roleCo.id then
				local heroId = roleCo.roleId

				if roleCo.activityId == actId and roleCo.star == 1 then
					local transfer = 0
					local inBag = 0

					if self:isHeroInTeam(heroId) then
						inBag = 2
					elseif not self.robot and self:getHeroInfo(heroId) then
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
		end
	end

	table.sort(fetterHeroList, Activity191Helper.sortFetterHeroList)

	return fetterHeroList
end

function Act191MatchMO:isHeroInTeam(heroId)
	for _, info in pairs(self.heroMap) do
		if info.heroId == heroId then
			return true
		end
	end

	for _, _heroId in pairs(self.subHeroMap) do
		if _heroId == heroId then
			return true
		end
	end
end

function Act191MatchMO:getBattleHeroInfoInTeam(heroId)
	for _, info in pairs(self.heroMap) do
		if info.heroId == heroId then
			return info
		end
	end
end

return Act191MatchMO
