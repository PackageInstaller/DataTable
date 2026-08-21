-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echoitem/config/EchoItemConfig.lua

module("logic.extensions.echoitem.config.EchoItemConfig", package.seeall)

local M = class("EchoItemConfig", BaseConfig)

function M:onInit()
	self._attr = {}
	self._maxLv = {}
end

function M:getNames()
	return {
		ConfigName.EchoAttr,
		ConfigName.EchoUpgrade
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.EchoAttr then
		for _, cfg in pairs(content.dataList or {}) do
			local id = cfg.id
			local level = cfg.level

			if not self._attr[id] then
				self._attr[id] = {}
			end

			self._attr[id][level] = cfg

			if not self._maxLv[id] then
				self._maxLv[id] = 1
			end

			if level >= self._maxLv[id] then
				self._maxLv[id] = level
			end
		end
	end
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

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getMaxLevel(id)
	if not self._maxLv[id] then
		printError(string.format("maxLv 没有id[%s] 的配置", id))

		return 6
	end

	return self._maxLv[id]
end

function M:getCfgMap(id)
	if self._attr[id] then
		return self._attr[id]
	end

	printError(string.format("无法从[t_%s]找到 id[%s]的配置", ConfigName.EchoAttr, id))

	return nil
end

function M:getCfg(id, level)
	local _map = self:getCfgMap(id)

	if not _map then
		return
	end

	if _map[level] then
		return self._attr[id][level]
	end

	printError(string.format("无法从[t_%s]找到 id[%s],level[%s]的配置", ConfigName.EchoAttr, id, level))

	return nil
end

function M:getUpgradeNeedCount(targetLv, quality)
	targetLv = targetLv - 1

	if not self._echoUpgradeCount then
		self._echoUpgradeCount = {}

		for _, _cfg in pairs(self:getConfigList(ConfigName.EchoUpgrade) or {}) do
			self._echoUpgradeCount[_cfg.quality] = _cfg.need
		end
	end

	local needCount = self._echoUpgradeCount[quality]

	if needCount and needCount[targetLv] then
		return needCount[targetLv]
	end

	return 1
end

function M:getUnlockDynamicEffectLevel(quality)
	if not self._echoUnlockState2Level then
		self._echoUnlockState2Level = {}

		for _, _cfg in pairs(self:getConfigList(ConfigName.EchoUpgrade) or {}) do
			self._echoUnlockState2Level[_cfg.quality] = _cfg.unlockLevel
		end
	end

	return self._echoUnlockState2Level[quality] or 1
end

function M:getAttrLst(id, level)
	local dataLst = {}
	local cfg = self:getCfg(id, level)

	if cfg then
		local iBegin = string.find(cfg.attr, "%{")
		local iEnd = string.find(cfg.attr, "%}")
		local attStr = string.sub(cfg.attr, iBegin + 1, iEnd - 1)
		local attArr = string.split(attStr, ",")

		for i, v in ipairs(attArr) do
			local arr = string.split(v, ":")

			table.insert(dataLst, {
				id = tonumber(arr[1]),
				num = tonumber(arr[2])
			})
		end
	end

	return dataLst
end

function M:getAttrDesc(id, level, colorAttr, colorSkill, split, highLightTags)
	local desc = ""
	local descSplit = {}

	if level > 1 then
		local attChange = {}
		local attLst = self:getAttrLst(id, level)
		local preAttLst = self:getAttrLst(id, level - 1)

		for _, curData in ipairs(attLst) do
			local find = false
			local offsetNum = curData.num

			for _, preData in ipairs(preAttLst) do
				if not find and preData.id == curData.id then
					offsetNum = curData.num - preData.num
					find = true
				end
			end

			if offsetNum > 0 then
				table.insert(attChange, {
					id = curData.id,
					num = offsetNum
				})
			end
		end

		for index, data in ipairs(attChange) do
			local cfg = AttributeDefineConfig.instance:getAttributePartDefineCO(data.id)
			local name = cfg and cfg.name or ""
			local offsetNumStr = data.num

			if data.num < 1 then
				offsetNumStr = string.format("%s", data.num * 100) .. "%"
			end

			local num = data.num > 0 and string.format("+%s", offsetNumStr) or offsetNumStr

			if colorAttr then
				num = string.format("<color=#bf404a>%s</color>", num)
			end

			local curStr = string.format("%s %s", name, num)

			if index > 1 then
				desc = string.format("%s，%s", desc, curStr)
			else
				desc = curStr
			end

			table.insert(descSplit, curStr)
		end

		local cfg = self:getCfg(id, level)
		local skillDesc

		if cfg and #cfg.skills > 1 then
			local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(cfg.skills[2])

			skillDesc = skillEnhanceCOWrapper:getDescriptionHighLightTag(highLightTags)
			skillDesc = ActiveSkillCOUtil.replaceDescriptionSpecialColor(skillDesc)

			if colorSkill and not string.nilorempty(skillDesc) then
				skillDesc = string.gsub(skillDesc, "+?%d+%%?", function(s)
					return string.format("<color=#bf404a>%s</color>", s)
				end)
			end
		end

		if skillDesc then
			if not string.nilorempty(desc) then
				desc = string.format("%s\n%s", desc, skillDesc)
			else
				desc = skillDesc
			end

			table.insert(descSplit, skillDesc)
		end
	end

	return split and descSplit or desc
end

function M:getAttrSkillEnhanceMO(id, level)
	local cfg = self:getCfg(id, level)

	if cfg and #cfg.skills > 1 then
		local skillEnhanceMO = SkillEnhanceMO.New(cfg.skills[1])

		if skillEnhanceMO then
			skillEnhanceMO:addSkillEnhanceCode(cfg.skills[2])
			skillEnhanceMO:rebuild()
		end

		return skillEnhanceMO
	else
		return nil
	end
end

function M:getUpgradeDesc(id, preLv, curLv, colorAttr)
	local preDesc, curDesc = "", ""
	local attChange = {}
	local attLst = self:getAttrLst(id, curLv)
	local preAttLst = self:getAttrLst(id, preLv)

	for _, curData in ipairs(attLst) do
		local find = false
		local offsetNum = curData.num

		for _, preData in ipairs(preAttLst) do
			if not find and preData.id == curData.id then
				offsetNum = curData.num - preData.num
				find = true
			end
		end

		if offsetNum > 0 then
			table.insert(attChange, {
				id = curData.id,
				num = offsetNum
			})
		end
	end

	if #attChange > 0 then
		for index, preData in ipairs(preAttLst) do
			local cfg = AttributeDefineConfig.instance:getAttributePartDefineCO(preData.id)
			local name = cfg and cfg.name or ""
			local num = preData.num > 0 and string.format("+%s", preData.num) or preData.num

			num = colorAttr and string.format("<color=#bf404a>%s</color>", num) or num

			if index > 1 then
				preDesc = string.format("%s,%s %s", preDesc, name, num)
			else
				preDesc = string.format("%s %s", name, num)
			end
		end

		for index, curData in ipairs(attLst) do
			local cfg = AttributeDefineConfig.instance:getAttributePartDefineCO(curData.id)
			local name = cfg and cfg.name or ""
			local num = curData.num > 0 and string.format("+%s", curData.num) or curData.num

			num = colorAttr and string.format("<color=#bf404a>%s</color>", num) or num

			if index > 1 then
				curDesc = string.format("%s,%s %s", curDesc, name, num)
			else
				curDesc = string.format("%s %s", name, num)
			end
		end
	end

	local cfgSkillCur = self:getCfg(id, curLv)
	local cfgSkillPre = self:getCfg(id, preLv)
	local countSkillCur = cfgSkillCur and cfgSkillCur.skills and #cfgSkillCur.skills or 0
	local countSkillPre = cfgSkillPre and cfgSkillPre.skills and #cfgSkillPre.skills or 0

	if countSkillCur ~= countSkillPre then
		if countSkillCur > 0 then
			local skillEnhanceMo = SkillEnhanceMO.New(cfgSkillCur.skills[1])

			if countSkillCur > 1 then
				skillEnhanceMo:clear()

				for i = 2, countSkillCur do
					skillEnhanceMo:addSkillEnhanceCode(cfgSkillCur.skills[i])
				end
			end

			skillEnhanceMo:rebuild()

			local skillDesc = skillEnhanceMo:getDescription()

			if colorSkill then
				skillDesc = string.gsub(skillDesc, "+?%d+%%?", function(s)
					return string.format("<color=#bf404a>%s</color>", s)
				end)
			end

			curDesc = string.nilorempty(curDesc) and skillDesc or string.format("%s\n%s", curDesc, skillDesc)
		end

		if countSkillPre > 0 then
			local skillEnhanceMo = SkillEnhanceMO.New(cfgSkillPre.skills[1])

			if countSkillPre > 1 then
				skillEnhanceMo:clear()

				for i = 2, countSkillPre do
					skillEnhanceMo:addSkillEnhanceCode(cfgSkillPre.skills[i])
				end
			end

			skillEnhanceMo:rebuild()

			local skillDesc = skillEnhanceMo:getDescription()

			preDesc = string.nilorempty(preDesc) and skillDesc or string.format("%s\n%s", preDesc, skillDesc)
		end
	end

	return preDesc, curDesc
end

M.instance = M.New()

return M
