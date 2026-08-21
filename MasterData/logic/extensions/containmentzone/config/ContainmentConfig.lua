-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/config/ContainmentConfig.lua

module("logic.extensions.containmentzone.config.ContainmentConfig", package.seeall)

local M = class("ContainmentConfig", BaseConfig)

function M:onInit()
	self._const = {}
	self._cfgProtomer = {}
	self._cfgProtomerInfo = {}
	self._cfgProtomerInfoUnlock = {}
	self._cfgAttr = {}
	self._cfgTouch = {}
	self._cfgTouchDefine = {}
	self._cfgModule = {}
	self._cfgResearch = {}
	self._cfgProtomerPrototype = {}
	self._cfgProtomerDegree = {}
	self._cfgHoldReportDesc = {}
	self._cfgEvaluate = {}
	self._itemIdToProtomerId = {}
end

function M:getNames()
	return {
		ConfigName.HouseHoldConst,
		ConfigName.HouseHoldProtomer,
		ConfigName.HouseProtomerInfo,
		ConfigName.HouseProtomerInfoUnlock,
		ConfigName.HouseHoldAttr,
		ConfigName.HouseHoldTouch,
		ConfigName.HouseProtomerTouchDefine,
		ConfigName.HouseHoldModule,
		ConfigName.HouseHoldResearch,
		ConfigName.HouseProtomerEvaluate,
		ConfigName.HouseProtomerPrototype,
		ConfigName.HouseProtomerDegree,
		ConfigName.HouseHoldReportDesc,
		ConfigName.HouseProtomerPreferen
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	local index = 1

	if name == ConfigName.HouseHoldConst then
		self._const = content
	elseif name == ConfigName.HouseHoldProtomer then
		for k, v in pairs(content.dataList or {}) do
			if not self._cfgProtomer[v.degree] then
				self._cfgProtomer[v.degree] = {}
			end

			self._cfgProtomer[v.degree][v.id] = v
		end
	elseif name == ConfigName.HouseProtomerInfo then
		for k, v in pairs(content.dataList or {}) do
			self._cfgProtomerInfo[v.id] = v
		end
	elseif name == ConfigName.HouseProtomerInfoUnlock then
		for k, v in pairs(content.dataList or {}) do
			if not self._cfgProtomerInfoUnlock[v.code] then
				self._cfgProtomerInfoUnlock[v.code] = {}
			end

			if not self._cfgProtomerInfoUnlock[v.code][v.typ] then
				self._cfgProtomerInfoUnlock[v.code][v.typ] = {}
			end

			table.insert(self._cfgProtomerInfoUnlock[v.code][v.typ], v)
		end
	elseif name == ConfigName.HouseHoldAttr then
		self._cfgAttr = content
	elseif name == ConfigName.HouseHoldTouch then
		self._cfgTouch = content
	elseif name == ConfigName.HouseProtomerTouchDefine then
		for k, v in pairs(content.dataList or {}) do
			if not self._cfgTouchDefine[v.id] then
				self._cfgTouchDefine[v.id] = {}
			end

			self._cfgTouchDefine[v.id] = v
		end
	elseif name == ConfigName.HouseHoldModule then
		for k, v in pairs(content.dataList or {}) do
			if not self._cfgModule[v.id] then
				self._cfgModule[v.id] = {}
			end

			if not self._cfgModule[v.id][v.module] then
				self._cfgModule[v.id][v.module] = {}
			end

			self._cfgModule[v.id][v.module] = v
		end
	elseif name == ConfigName.HouseHoldResearch then
		for k, v in pairs(content.dataList or {}) do
			if not self._cfgResearch[v.code] then
				self._cfgResearch[v.code] = {}
			end

			if not self._cfgResearch[v.code][v.level] then
				self._cfgResearch[v.code][v.level] = {}
			end

			self._cfgResearch[v.code][v.level] = v
		end
	elseif name == ConfigName.HouseProtomerPrototype then
		for k, v in pairs(content.dataList or {}) do
			self._cfgProtomerPrototype[v.id] = v
		end
	elseif name == ConfigName.HouseProtomerDegree then
		for k, v in pairs(content.dataList or {}) do
			self._cfgProtomerDegree[v.id] = v
		end
	elseif name == ConfigName.HouseHoldReportDesc then
		for k, v in pairs(content.dataList or {}) do
			self._cfgHoldReportDesc[v.id] = v
		end
	elseif name == ConfigName.HouseProtomerEvaluate then
		for k, v in pairs(content.dataList or {}) do
			if not self._cfgEvaluate[v.code] then
				self._cfgEvaluate[v.code] = {}
			end

			table.insert(self._cfgEvaluate[v.code], v)
		end

		for code, cfgLst in pairs(self._cfgEvaluate) do
			local lst = cfgLst

			table.sort(lst, function(a, b)
				return a.key >= b.key
			end)

			self._cfgEvaluate[code] = lst
		end
	end
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConstByKey(key)
	return self._const[key] and self._const[key].numValue or 0
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

function M:getPreferenCfg(key)
	return self:getConfigByKey(ConfigName.HouseProtomerPreferen, key)
end

function M:getEvaluateLst(code)
	if self._cfgEvaluate[code] then
		return self._cfgEvaluate[code]
	end

	printError(string.format("无法从[t_%s]找到code[%s]的配置", ConfigName.HouseProtomerEvaluate, code))

	return {}
end

function M:getEvaluate(code, key)
	local lst = self:getEvaluateLst(code)
	local finalCfg

	if lst and #lst > 0 then
		for index, cfg in ipairs(lst) do
			if cfg.key == key then
				finalCfg = cfg

				break
			end
		end
	end

	if not finalCfg then
		printError(string.format("无法从[t_%s]找到code[%s],key[%s]的配置", ConfigName.HouseProtomerEvaluate, code, key))
	end

	return finalCfg
end

function M:getProtomerDegreeCoByDegreeId(degreeId)
	return self._cfgProtomerDegree[degreeId]
end

function M:getProtomerDegreeCoByProtomerId(protomerId)
	local info = self:getProtomerCoById(protomerId)
	local degreeId = info.degree

	return self:getProtomerDegreeCoByDegreeId(degreeId)
end

function M:getProtomerInfoById(protomerId)
	return self._cfgProtomerInfo[protomerId]
end

function M:getProtomerInfoByShelterRoomTyp(subRoomTyp)
	local protomerCfg = self:getProtomerCoByShelterRoomTyp(subRoomTyp)
	local cfg

	if protomerCfg then
		cfg = self:getProtomerInfoById(protomerCfg.id)
	end

	return cfg
end

function M:getProtomerPrototypeCoLstByProtomerId(protomerId)
	local protomerInfoCfg = self:getProtomerInfoById(protomerId)
	local lst = {}

	if protomerInfoCfg then
		local prototypeIdLst = protomerInfoCfg.prototype

		for _, theId in pairs(prototypeIdLst or {}) do
			local item = self:getProtomerPrototype(theId)

			table.insert(lst, item)
		end
	end

	return lst
end

function M:getProtomerPrototype(typeId)
	if self._cfgProtomerPrototype[typeId] then
		return self._cfgProtomerPrototype[typeId]
	else
		printError(string.format("无法获取原体类型[%d]，将返回类型1", typeId))

		return self:getProtomerPrototype(1)
	end
end

function M:getProtomerBackpackCfg(protomerId)
	return BackpackConfig.instance:getItemInfoByItemId(protomerId)
end

function M:getProtomerCoByClassAndId(degree, id)
	return self._cfgProtomer[degree][id]
end

function M:getProtomerCoById(id)
	local info = false

	for oClass, items in pairs(self._cfgProtomer) do
		info = items[id]

		if info then
			break
		end
	end

	return info
end

function M:getProtomerCoByShelterRoomTyp(shelterRoomType)
	local info = false

	for oClass, items in pairs(self._cfgProtomer) do
		for id, value in pairs(items or {}) do
			if value.shelterRoomType == shelterRoomType then
				info = value

				break
			end
		end
	end

	return info
end

function M:getProtomerCoLstByDegree(degree)
	local group = self._cfgProtomer[degree]
	local lst = {}

	if group then
		for k, v in pairs(group) do
			table.insert(lst, v)
		end
	end

	return lst
end

function M:getProtomerCoLstByClassSort()
	local sortLst = {}
	local lst = {}

	for _, v in pairs(self._cfgProtomerDegree) do
		table.insert(sortLst, v.id)
	end

	table.sort(sortLst, function(a, b)
		return b < a
	end)

	for _, v in pairs(sortLst) do
		local coLst = self:getProtomerCoLstByDegree(v)

		table.sort(coLst, ContainmentUtil.sortProtomerCfgCompare)

		for key, value in pairs(coLst) do
			table.insert(lst, value)
		end
	end

	return lst
end

function M:getProtomerInfoCoById(id)
	return self._cfgProtomerInfo[id]
end

function M:getProtomerInfoUnlockCoByCode(code)
	return self._cfgProtomerInfoUnlock[code]
end

function M:getInfoUnlockCo(code, id)
	local result

	if self._cfgProtomerInfoUnlock[code] then
		for _typ, typTable in pairs(self._cfgProtomerInfoUnlock[code] or {}) do
			for index, value in ipairs(typTable or {}) do
				if id == value.item then
					result = value

					break
				end
			end
		end
	end

	return result
end

function M:getProtomerInfoTypAndTypIndex(code, id)
	local typ = 0
	local typIndex = 0

	if self._cfgProtomerInfoUnlock[code] then
		for _typ, typTable in pairs(self._cfgProtomerInfoUnlock[code] or {}) do
			for index, value in ipairs(typTable or {}) do
				if id == value.item then
					typ = value.typ
					typIndex = index

					break
				end
			end
		end
	end

	if typ == 0 then
		printWarn(string.format("无法找到解锁信息code[%d]id[%d]", code, id))

		typ = 1
		typIndex = 1
	end

	return typ, typIndex
end

function M:getHouseModelCoLstByCode(code)
	return self._cfgModule[code]
end

function M:getHouseModelCoByCodeAndModule(code, moduleId)
	return self._cfgModule[code][moduleId]
end

function M:getHouseResearchCoByCode(code)
	return self._cfgResearch[code]
end

function M:getHouseResearchCoByCodeAndLv(code, level)
	local t = self:getHouseResearchCoByCode(code)

	return t[level]
end

function M:getHouseAttrCoByCode(code)
	return self._cfgAttr[code]
end

function M:getHouseTouchCoByCode(code)
	return self._cfgTouch[code]
end

function M:getTouchDefine(id)
	return self._cfgTouchDefine[id]
end

function M:getReportDescById(id)
	return self._cfgHoldReportDesc[id] and self._cfgHoldReportDesc[id].desc or ""
end

function M:findProtomerByRewardItemId(itemId)
	local protomerId = 0

	if self._itemIdToProtomerId[itemId] then
		local len = #self._itemIdToProtomerId[itemId]

		if len > 0 then
			protomerId = self._itemIdToProtomerId[itemId][1]
		end
	else
		local tmpTable = {}

		for threatLevel, items in pairs(self._cfgProtomer or {}) do
			for id, protomerCfg in pairs(items or {}) do
				local goodsRewardId = protomerCfg.goodsReward

				if goodsRewardId > 0 then
					local rewardCO = RewardConfig.instance:getRewardCfgByCode(goodsRewardId)

					for _, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
						if v.code and v.code == itemId then
							tmpTable[id] = 1
						end
					end

					for _, v in ipairs(rewardCO.randomReward1 and rewardCO.randomReward1 or {}) do
						if v.code and v.code == itemId then
							tmpTable[id] = 1
						end
					end

					for _, v in ipairs(rewardCO.randomReward2 and rewardCO.randomReward2 or {}) do
						if v.code and v.code == itemId then
							tmpTable[id] = 1
						end
					end

					for _, v in ipairs(rewardCO.randomReward3 and rewardCO.randomReward3 or {}) do
						if v.code and v.code == itemId then
							tmpTable[id] = 1
						end
					end
				end
			end
		end

		self._itemIdToProtomerId[itemId] = {}

		for id, _ in pairs(tmpTable) do
			table.insert(self._itemIdToProtomerId[itemId], id)
		end

		protomerId = self:findProtomerByRewardItemId(itemId)
	end

	return protomerId
end

M.instance = M.New()

return M
