-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/config/authority/HeroPowerConfig.lua

module("logic.extensions.charactersystem.config.authority.HeroPowerConfig", package.seeall)

local M = class("HeroPowerConfig", BaseConfig)
local json = require("cjson")

M.PowerNodeEffectEnum = {
	HOUSE = 3,
	POWER_LEVEL_UP = 5,
	UNLOCK_DRAW = 6,
	ATTR_ADD = 1,
	SKILL_UPGRADE = 2,
	UNLOCK_TEXT = 4
}

function M:getNames()
	return {
		ConfigName.HeroPowerNode,
		ConfigName.HeroPowerCost
	}
end

function M:onInit()
	self._heroSkillInfos = {}
	self._heroAttrInfos = {}
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

function M:getCharacterNodes(heroId)
	local tableInfo = self._dict[ConfigName.HeroPowerNode]
	local findInfo = tableInfo and tableInfo[heroId] or false

	if findInfo then
		local nodes = {}

		for k, v in ipairs(findInfo) do
			if v.type == 1 or v.type == 0 then
				table.insert(nodes, v.code)
			end
		end

		return nodes
	else
		printError(string.format("角色%d没有亲和度节点配置", heroId))

		return {}
	end
end

function M:getCharacterNodeInfos(heroId)
	local tableInfo = self._dict[ConfigName.HeroPowerNode]
	local findInfo = tableInfo and tableInfo[heroId] or false

	if findInfo then
		local nodes = {}

		for k, v in ipairs(findInfo) do
			if v.type == 1 or v.type == 0 then
				table.insert(nodes, v)
			end
		end

		return nodes
	else
		return {}
	end
end

function M:getCharacterAllNodeInfos(heroId)
	local tableInfo = self._dict[ConfigName.HeroPowerNode]
	local findInfo = tableInfo and tableInfo[heroId] or false

	if findInfo then
		local nodes = {}

		for k, v in pairs(findInfo) do
			table.insert(nodes, v)
		end

		return nodes
	else
		return {}
	end
end

function M:getMaxPowerGroupCount(heroId)
	local nodes = self:getCharacterAllNodeInfos(heroId)

	return #nodes / 5
end

function M:getMaxPowerLevel(heroId)
	local maxPowerLv = 0
	local nodes = self:getCharacterAllNodeInfos(heroId)

	for _, _cfg in ipairs(nodes or {}) do
		if _cfg.effect and #_cfg.effect > 0 and table.indexof(_cfg.effect, M.PowerNodeEffectEnum.POWER_LEVEL_UP) then
			maxPowerLv = maxPowerLv + 1
		end
	end

	return maxPowerLv
end

function M:getCharacterNodeIndex(heroId, code)
	local nodes = self:getCharacterNodes(heroId)

	for i = 1, #nodes do
		if nodes[i] == code then
			return i
		end
	end

	return 1
end

function M:getCharacterExtNodes(heroId)
	local tableInfo = self._dict[ConfigName.HeroPowerNode]
	local findInfo = tableInfo and tableInfo[heroId] or false

	if findInfo then
		local nodes = {}

		for k, v in ipairs(findInfo) do
			if v.type == 2 then
				table.insert(nodes, v.code)
			end
		end

		return nodes
	else
		return {}
	end
end

function M:getCharacterExtNodeInfos(heroId)
	local tableInfo = self._dict[ConfigName.HeroPowerNode]
	local findInfo = tableInfo and tableInfo[heroId] or false

	if findInfo then
		local nodes = {}

		for k, v in ipairs(findInfo) do
			if v.type == 2 then
				table.insert(nodes, v)
			end
		end

		return nodes
	else
		return {}
	end
end

function M:getNodeInfo(heroId, nodeId)
	local tableInfo = self._dict[ConfigName.HeroPowerNode]
	local findInfo = tableInfo and tableInfo[heroId] or {}

	return findInfo[nodeId]
end

function M:checkHaveNodeConfig(heroId)
	local tableInfo = self._dict[ConfigName.HeroPowerNode]

	return tableInfo[heroId] ~= nil
end

function M:getAllNodeListByEffect(heroId, effect)
	local lst = {}
	local tableInfo = self._dict[ConfigName.HeroPowerNode]
	local findInfo = tableInfo and tableInfo[heroId] or {}

	for _, _cfg in ipairs(findInfo) do
		if _cfg.effect and #_cfg.effect > 0 and table.indexof(_cfg.effect, effect) then
			table.insert(lst, _cfg)
		end
	end

	return lst
end

function M:getAllAddSkillNodeLst(heroId)
	local lst = {}
	local tableInfo = self._dict[ConfigName.HeroPowerNode]
	local findInfo = tableInfo and tableInfo[heroId] or {}

	for _, _cfg in ipairs(findInfo) do
		if _cfg.skillId and _cfg.skillId > 0 then
			table.insert(lst, {
				nodeId = _cfg.code,
				skillId = _cfg.skillId
			})
		end
	end

	return lst
end

function M:getSkillNodeCoList(heroId)
	local result = {}
	local heroNodeList = self._dict[ConfigName.HeroPowerNode][heroId] or {}

	for _, cfg in ipairs(heroNodeList) do
		if cfg.skillId and cfg.skillId > 0 then
			table.insert(result, cfg)
		end
	end

	return result
end

function M:getAllSkillEnhanceNodeLst(heroId, skillId)
	local lst = {}
	local tableInfo = self._dict[ConfigName.HeroPowerNode]
	local findInfo = tableInfo and tableInfo[heroId] or {}

	for _, _cfg in ipairs(findInfo) do
		if not string.nilorempty(_cfg.skillEnchance) then
			local skills = json.decode(_cfg.skillEnchance)

			for k1, v1 in pairs(skills) do
				for k2, v2 in pairs(v1) do
					local _skillId = tonumber(k2)

					if _skillId == skillId then
						table.insert(lst, {
							nodeId = _cfg.code,
							skillId = _skillId,
							effectId = v2
						})
					end
				end
			end
		end
	end

	return lst
end

function M:getNodesBySkillId(heroId, skillId)
	self._heroSkillInfos[heroId] = self._heroSkillInfos[heroId] or {}

	if self._heroSkillInfos[heroId][skillId] then
		return self._heroSkillInfos[heroId][skillId]
	end

	local tableInfo = self._dict[ConfigName.HeroPowerNode]
	local findInfo = tableInfo and tableInfo[heroId] or {}
	local temp = {}

	for k, v in ipairs(findInfo) do
		if not string.nilorempty(v.skillEnchance) then
			local skills = json.decode(v.skillEnchance)

			for k1, v1 in ipairs(skills) do
				if v1[tostring(skillId)] ~= nil then
					local t = {}

					t.skill_enhance = v1[tostring(skillId)]
					t.co = v

					table.insert(temp, t)
				end
			end
		end
	end

	self._heroSkillInfos[heroId][skillId] = temp

	return temp
end

function M:getCharacterSkillActiveCount(heroId)
	local tableInfo = self._dict[ConfigName.HeroPowerNode]
	local findInfo = tableInfo and tableInfo[heroId] or {}
	local count = 0

	for k, v in ipairs(findInfo) do
		if v.skillEnchance ~= "" then
			count = count + 1
		end
	end

	return count
end

function M:getHeroAdditionAttr(heroId)
	if self._heroAttrInfos[heroId] then
		return self._heroAttrInfos[heroId]
	end

	local tableInfo = self._dict[ConfigName.HeroPowerNode]
	local findInfo = tableInfo and tableInfo[heroId] or {}
	local temp = {}

	for k, v in pairs(findInfo) do
		if v.attrs ~= "" then
			local attrs = json.decode(v.attrs)

			for k1, v1 in pairs(attrs) do
				local t = {}

				t.attr = v1
				t.co = v

				table.insert(temp, t)
			end
		end
	end

	self._heroSkillInfos[heroId] = temp

	return temp
end

function M:getConstByKey(key)
	local tableInfo = self._dict[ConfigName.HeroPowerCost]
	local findInfo = tableInfo and tableInfo[key] or false

	return findInfo
end

function M:getNodeSkillDesAndIcon(nodeCo)
	if nodeCo.effect then
		for k, v in pairs(nodeCo.effect) do
			if v == M.PowerNodeEffectEnum.SKILL_UPGRADE then
				local skills = json.decode(nodeCo.skillEnchance)

				for k1, v1 in pairs(skills) do
					for k2, v2 in pairs(v1) do
						local skillId = tonumber(k2)
						local effectId = v2
						local config1001 = SkillEnhanceMO.New(skillId)

						config1001:addSkillEnhanceCode(effectId)
						config1001:rebuild()

						local skillCO = config1001:getSkillCO()
						local enchanceText = config1001:getDescription() or ""
						local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(effectId)

						enchanceText = skillEnhanceCOWrapper:getDescription()

						local icon = ActiveSkillCOUtil.getSkillIcon(skillCO) or ""
						local skillUnlockText = {
							string.format(lang("tip_skill_s"), skillCO.name),
							enchanceText,
							icon
						}

						return skillUnlockText
					end
				end
			end
		end
	end

	return false
end

function M:getSkillEnhancedCode2AuthorityIndexMap(heroId)
	local map = {}
	local cfgLst = self:getCharacterAllNodeInfos(heroId)

	for _, _cfg in ipairs(cfgLst) do
		if not string.nilorempty(_cfg.skillEnchance) then
			local skills = json.decode(_cfg.skillEnchance)

			for k1, v1 in pairs(skills) do
				for k2, v2 in pairs(v1) do
					local effectId = tonumber(v2)

					map[effectId] = _cfg.code
				end
			end
		end
	end

	return map
end

function M:getSkillAllEnhancedDataLst(heroId, skillId)
	local lst = {}
	local cfgLst = self:getCharacterAllNodeInfos(heroId)

	for _, _cfg in ipairs(cfgLst) do
		if not string.nilorempty(_cfg.skillEnchance) then
			local skills = json.decode(_cfg.skillEnchance)

			for k1, v1 in pairs(skills) do
				for k2, v2 in pairs(v1) do
					local theSkillId = tonumber(k2)
					local theEffectId = tonumber(v2)

					if theSkillId == skillId then
						table.insert(lst, {
							nodeId = _cfg.code,
							enhancedCode = theEffectId
						})
					end
				end
			end
		end
	end

	if #lst > 0 then
		table.sort(lst, function(a, b)
			local valA = a.nodeId or 0
			local valB = b.nodeId or 0

			if valA ~= valB then
				return valA < valB
			end

			return false
		end)
	end

	return lst
end

function M:getTagNodeByHeroId(heroId, tagType)
	local conf = self:getCharacterAllNodeInfos(heroId)

	for idx, item in ipairs(conf) do
		if item.tagType == tagType then
			return idx
		end
	end

	return false
end

M.instance = M.New()

return M
