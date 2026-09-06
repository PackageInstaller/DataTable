-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/config/RuneConfig.lua

module("logic.extensions.rune.config.RuneConfig", package.seeall)

local RuneConfig = class("RuneConfig", BaseConfig)

RuneConfig.MAX_RUNE_LVL = 4
RuneConfig.MAX_RUNE_SLOT_COUNT = 8

function RuneConfig:onInit()
	RuneConfig.super.onInit(self)
end

function RuneConfig:getNames()
	return {
		"rune_suit_define",
		"rune_define",
		"rune_level_define",
		"rune_common_config",
		"rune_suit_effect_define",
		"rune_suit_pet_limit_define",
		"rune_type"
	}
end

function RuneConfig:handleConfig(name, content)
	if name == "rune_suit_define" then
		self.runeSuitContent = content
	elseif name == "rune_define" then
		self.runeContent = content
	elseif name == "rune_level_define" then
		self.runeLvlContent = content
	elseif name == "rune_common_config" then
		self.constCfg = content
	elseif name == "rune_suit_effect_define" then
		self.suitEffCfg = content
	elseif name == "rune_suit_pet_limit_define" then
		self.rune_suit_pet_limit_define = content
	elseif name == "rune_type" then
		self.runeTypeCfg = content
	end
end

function RuneConfig:getCurrCoutByStars(id, totalStar)
	local tem = self:getSuitPetCountCfg(id)

	for i = #tem, 1, -1 do
		local cfg = tem[i]

		if totalStar >= cfg.needLevel then
			return cfg.petLimit
		end
	end

	return 0
end

function RuneConfig:getSuitPetCountCfg(id)
	local arr = self.rune_suit_pet_limit_define[id]
	local tem = {}

	for k, v in pairs(arr or {}) do
		table.insert(tem, v)
	end

	ArraySort.sortOn(tem, "needLevel")

	return tem
end

function RuneConfig:getSuitPetMax(id)
	local arr = self:getSuitPetCountCfg(id)

	if arr and #arr > 0 then
		return arr[#arr].petLimit
	end

	return 0
end

function RuneConfig:getTypeName(type)
	if self.runeTypeCfg[type] then
		return self.runeTypeCfg[type].name
	end

	return ""
end

function RuneConfig:getConst(key)
	return self.constCfg[key].value
end

function RuneConfig:getAllSuit()
	return self.runeSuitContent.dataList
end

function RuneConfig:getSuitById(id)
	return self.runeSuitContent[id]
end

function RuneConfig:getSuitEffById(id)
	local cf = self.suitEffCfg[id]
	local arr = {}

	for k, v in pairs(cf) do
		table.insert(arr, v)
	end

	ArraySort.sortOn(arr, {
		"needLevel"
	})

	return arr
end

function RuneConfig:getSuitEffsById(id)
	local t = {}

	for _, v in pairs(self.suitEffCfg[id]) do
		table.insert(t, v)
	end

	table.sort(t, function(a, b)
		return a.needLevel < b.needLevel
	end)

	return t
end

function RuneConfig:getSuitEffByIdAndLv(id, level)
	local t = self:getSuitEffsById(id)
	local i = 1

	while i <= #t and level >= t[i].needLevel do
		i = i + 1
	end

	i = i - 1

	return t[i]
end

function RuneConfig:getRuneCfg(id)
	return self.runeContent[id]
end

function RuneConfig:getAllRunes()
	return self.runeContent.dataList
end

function RuneConfig:getRuneLvlCfg(id, lvl)
	if self.runeLvlContent[id] then
		return self.runeLvlContent[id][lvl]
	end
end

function RuneConfig:getSuitLimitPetCount(cfg, mo)
	return checknumber(cfg.limitPetNum)
end

function RuneConfig:getRuneMaxLevel(id)
	local list = self.runeLvlContent[id]

	if list then
		return #list
	end

	return 0
end

function RuneConfig:getLvlupInfo(id, exp)
	local list = self.runeLvlContent[id]
	local maxLvl = #list
	local lvl = 1

	for i = maxLvl, 1, -1 do
		local cfg = list[i]

		if exp >= cfg.exp then
			lvl = i

			break
		end
	end

	return lvl, maxLvl, lvl < maxLvl and self:getRuneLvlCfg(id, lvl + 1).exp or self:getRuneLvlCfg(id, maxLvl).exp
end

function RuneConfig:getRuneAttrs(id, level)
	local cfg = self:getRuneLvlCfg(id, level)
	local attrs = {}

	if cfg ~= nil and not string.nilorempty(cfg.propertyApp) then
		local t = string.split(cfg.propertyApp, "#")

		for _, str in ipairs(t) do
			local t2 = string.split(cfg.propertyApp, "+")

			attrs[t2[1]] = t2[2]
		end
	end

	return attrs
end

function RuneConfig:propToString(arr)
	if arr then
		local obj = GameUtil.propToList(arr)
		local str = ""

		for k, v in pairs(obj) do
			str = str .. v.name .. ":+" .. v.value
		end

		return str
	else
		return ""
	end
end

function RuneConfig:getRuneZDL(id, lvl)
	local cfg = self:getRuneLvlCfg(id, lvl)

	if cfg then
		local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyApp) or {}
		local power = 0

		for k, v in pairs(attrs) do
			local attrStr = GameEnum.AttrTypeName[k]
			local value = CharacterConfig.instance:getPropZdlValue(attrStr)

			power = power + v * value
		end

		return math.round(power)
	end

	return 0
end

function RuneConfig:getSuitZDLByMo(suitMo)
	if suitMo then
		local suitId = suitMo.suitId
		local slots = suitMo.slots
		local count, zdl = self:_getSlotsZDLMo(slots)
		local suitZdl = self:_getCurLvlZDL(suitId, count)

		return zdl + suitZdl
	end

	return 0
end

function RuneConfig:_getSlotsZDLMo(slots)
	local count = 0
	local zdl = 0

	if slots then
		for k, v in pairs(slots) do
			local mo = v:getRuneMo()

			count = count + mo.level
			zdl = zdl + self:getRuneZDL(mo.runeDefineId, mo.level)
		end
	end

	return count, zdl
end

function RuneConfig:getMaxRuneZDL(raceId)
	local zdl = 0
	local petCo = CharacterConfig.instance:getPetCo(raceId)

	if petCo then
		local suitId = petCo.recmdRuneSuitId
		local slots = petCo.recmdRune
		local count = 0

		if slots then
			for k, v in pairs(slots) do
				local level = self:getRuneMaxLevel(v)

				count = count + level
				zdl = zdl + self:getRuneZDL(v, level)
			end
		end

		local suitZdl = self:_getCurLvlZDL(suitId, count)

		zdl = zdl + suitZdl
	end

	return zdl
end

function RuneConfig:getSuitZDL(runeSuit, isMyPackPet)
	if runeSuit then
		local suitId = runeSuit.runeSuitId

		if checkbool(isMyPackPet) then
			local suitMo = RuneModel.instance:getSuitMo(suitId)

			return self:getSuitZDLByMo(suitMo)
		else
			local slots = runeSuit.slots
			local count, zdl = self:_getSlotsZDL(slots)
			local suitZdl = self:_getCurLvlZDL(suitId, count)

			return zdl + suitZdl
		end
	end

	return 0
end

function RuneConfig:_getSlotsZDL(slots)
	local count = 0
	local zdl = 0

	if slots then
		for k, v in pairs(slots) do
			count = count + v.level
			zdl = zdl + self:getRuneZDL(v.defineId, v.level)
		end
	end

	return count, zdl
end

function RuneConfig:_getCurLvlZDL(suitId, totalStar)
	local zdl = 0

	if suitId and suitId > 0 then
		local cf = self:getSuitEffById(suitId)

		if cf then
			local arr = {}

			for k, v in pairs(cf) do
				table.insert(arr, v)
			end

			ArraySort.sortOn(arr, {
				"needLevel"
			})

			for i = #arr, 1, -1 do
				if totalStar >= arr[i].needLevel then
					local attrs = FightingPowerFormula.instance:parseAttrValues(arr[i].propertyApp) or {}

					for k, v in pairs(attrs) do
						local attrStr = GameEnum.AttrTypeName[k]
						local value = CharacterConfig.instance:getPropZdlValue(attrStr)

						zdl = zdl + v * value
					end

					break
				end
			end
		elseif enableDebug then
			error("符文配置表里面找不到  套装ID = " .. suitId .. " 的配置！！！！！！！")
		else
			printWarn("符文配置表里面找不到  套装ID = " .. suitId .. " 的配置！！！！！！！")
		end
	end

	return zdl
end

RuneConfig.instance = RuneConfig.New()

return RuneConfig
