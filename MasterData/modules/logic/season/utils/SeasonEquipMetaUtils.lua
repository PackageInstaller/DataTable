-- chunkname: @modules/logic/season/utils/SeasonEquipMetaUtils.lua

module("modules.logic.season.utils.SeasonEquipMetaUtils", package.seeall)

local SeasonEquipMetaUtils = class("SeasonEquipMetaUtils")

SeasonEquipMetaUtils.attrKey = {
	atk = "attack",
	def = "defense",
	dropDmg = "dropDmg",
	cri = "cri",
	revive = "revive",
	recri = "recri",
	mdef = "mdefense",
	defenseIgnore = "defenseIgnore",
	addDmg = "addDmg",
	absorb = "absorb",
	hp = "hp",
	criDmg = "criDmg",
	heal = "heal",
	criDef = "criDef",
	normalSkillRate = "normalSkillRate",
	clutch = "clutch"
}

function SeasonEquipMetaUtils.getEquipPropsDescStr(itemId)
	local resultStr = ""
	local itemCO = SeasonConfig.instance:getSeasonEquipCo(itemId)

	if itemCO then
		local attrList = SeasonEquipMetaUtils.getEquipPropsStrList(itemCO.attrId)

		for i, str in ipairs(attrList) do
			resultStr = string.nilorempty(resultStr) and resultStr .. str or resultStr .. "\n" .. str
		end

		local skillList = SeasonEquipMetaUtils.getSkillEffectStrList(itemCO)

		for i, str in ipairs(skillList) do
			local skillDescStr = string.format(luaLang("season_effect_desc_template"), str)

			resultStr = string.nilorempty(resultStr) and resultStr .. skillDescStr or resultStr .. "\n" .. skillDescStr
		end

		if string.nilorempty(resultStr) then
			resultStr = resultStr .. "\n"
		end

		return resultStr
	else
		logError(string.format("can't find season equip config, id = [%s]", itemId))
	end

	return resultStr
end

SeasonEquipMetaUtils.PropValueColorPattern = "<color=#d2c197>%s</color>"

function SeasonEquipMetaUtils.getEquipPropsStrList(attrId, skipColorFormat)
	local list = {}
	local attrCO

	if attrId then
		attrCO = SeasonConfig.instance:getSeasonEquipAttrCo(attrId)
	end

	if not attrCO then
		return list
	end

	for seasonAttrKey, charAttrKey in pairs(SeasonEquipMetaUtils.attrKey) do
		local attrValue = attrCO[seasonAttrKey]

		if attrValue and attrValue ~= 0 then
			local charAttrId = HeroConfig.instance:getIDByAttrType(charAttrKey)
			local charAttrCO = HeroConfig.instance:getHeroAttributeCO(charAttrId)

			if charAttrCO then
				local attrStr = charAttrCO.name
				local perStr = charAttrCO.showType == 1 and "%" or ""
				local rate = charAttrCO.showType == 1 and 10 or 1
				local appendValuePattern = SeasonEquipMetaUtils.PropValueColorPattern

				if skipColorFormat then
					appendValuePattern = "%s"
				end

				attrStr = attrValue > 0 and attrStr .. luaLang("season_attr_up") .. " " .. string.format(appendValuePattern, tostring(attrValue / rate) .. perStr) or attrStr .. luaLang("season_attr_down") .. " " .. string.format(appendValuePattern, tostring(-attrValue / rate) .. perStr)

				table.insert(list, attrStr)
			end
		end
	end

	return list
end

function SeasonEquipMetaUtils.getSkillEffectStrList(itemCO)
	local skillId = itemCO.skillId
	local list = {}
	local attrCO

	if skillId then
		local cfgIds

		if itemCO.rare == Activity104Enum.MainRoleRare then
			local strArr = string.split(skillId, "|")

			cfgIds = {}

			for _, str in ipairs(strArr) do
				local strNumArr = string.splitToNumber(str, "#")

				if #strNumArr >= 2 and strNumArr[2] ~= nil then
					table.insert(cfgIds, strNumArr[2])
				end
			end
		else
			cfgIds = string.splitToNumber(skillId, "#")
		end

		for _, cfgId in ipairs(cfgIds) do
			local skillCfg = FightConfig.instance:getSkillEffectCO(cfgId)

			if skillCfg then
				table.insert(list, FightConfig.instance:getSkillEffectDesc(nil, skillCfg))
			else
				logError(string.format("can't find skill config ID = [%s]", cfgId))
			end
		end
	end

	return list
end

function SeasonEquipMetaUtils.isMainRoleCard(rare)
	return rare == Activity104Enum.MainRoleRare
end

function SeasonEquipMetaUtils.getCurSeasonEquipCount(itemId)
	local seasonActId = Activity104Model.instance:getCurSeasonId()
	local isDataReady = Activity104Model.instance:isSeasonDataReady(seasonActId)

	if isDataReady then
		return SeasonEquipMetaUtils.getEquipCount(seasonActId, itemId)
	end

	return 0
end

SeasonEquipMetaUtils.Text_Career_Color_Bright_Bg = {
	["0"] = "#252525",
	["1"] = "#ac5320",
	["2"] = "#324bb6",
	["5"] = "#804885",
	["3"] = "#27682e",
	["4"] = "#9f342c"
}

function SeasonEquipMetaUtils.getCareerColorBrightBg(itemId)
	local cfg = SeasonConfig.instance:getSeasonEquipCo(itemId)

	if cfg and cfg.career then
		return SeasonEquipMetaUtils.Text_Career_Color_Bright_Bg[cfg.career] or SeasonEquipMetaUtils.Text_Career_Color_Bright_Bg["0"]
	end

	return SeasonEquipMetaUtils.Text_Career_Color_Bright_Bg["0"]
end

SeasonEquipMetaUtils.No_Effect_Alpha = "66"
SeasonEquipMetaUtils.Text_Career_Color_Dark_Bg = {
	["0"] = "#cac8c5",
	["1"] = "#e99b56",
	["2"] = "#6384e5",
	["5"] = "#804885",
	["3"] = "#65b96f",
	["4"] = "#d97373"
}

function SeasonEquipMetaUtils.getCareerColorDarkBg(itemId)
	local cfg = SeasonConfig.instance:getSeasonEquipCo(itemId)

	if cfg and cfg.career then
		return SeasonEquipMetaUtils.Text_Career_Color_Dark_Bg[cfg.career] or SeasonEquipMetaUtils.Text_Career_Color_Dark_Bg["0"]
	end

	return SeasonEquipMetaUtils.Text_Career_Color_Dark_Bg["0"]
end

function SeasonEquipMetaUtils.getEquipCount(actId, itemId)
	local itemMap = Activity104Model.instance:getAllItemMo(actId)

	if itemMap then
		local count = 0

		for _, itemMO in pairs(itemMap) do
			if itemMO.itemId == itemId then
				count = count + 1
			end

			return count
		end
	end

	return 0
end

function SeasonEquipMetaUtils.applyIconOffset(itemId, imageIcon, imageSignature)
	local cfg = SeasonConfig.instance:getSeasonEquipCo(itemId)

	if cfg then
		local iconOffsetX, iconOffsetY, iconScale = 0, 0, 1
		local signOffsetX, signOffsetY, signScale = 26, -180, 0.76

		if not string.nilorempty(cfg.iconOffset) then
			local numberArr = string.splitToNumber(cfg.iconOffset, "#")

			iconScale = numberArr[3]
			iconOffsetY = numberArr[2]
			iconOffsetX = numberArr[1]
		end

		if not string.nilorempty(cfg.signOffset) then
			local numberArr = string.splitToNumber(cfg.signOffset, "#")

			signScale = numberArr[3]
			signOffsetY = numberArr[2]
			signOffsetX = numberArr[1]
		end

		if imageIcon then
			transformhelper.setLocalScale(imageIcon.transform, iconScale, iconScale, 1)
			recthelper.setAnchor(imageIcon.transform, iconOffsetX, iconOffsetY)
		end

		if imageSignature then
			transformhelper.setLocalScale(imageSignature.transform, signScale, signScale, 1)
			recthelper.setAnchor(imageSignature.transform, signOffsetX, signOffsetY)
		end
	end
end

function SeasonEquipMetaUtils.isBanActivity(itemCo, actId)
	return itemCo.activityId ~= actId
end

function SeasonEquipMetaUtils.isContainTag(itemCo, tag)
	local list = string.splitToNumber(itemCo.tag, "#")

	return tabletool.indexOf(list, tag) ~= nil
end

return SeasonEquipMetaUtils
