-- chunkname: @modules/logic/equip/controller/EquipHelper.lua

module("modules.logic.equip.controller.EquipHelper", package.seeall)

local EquipHelper = {}

EquipHelper.sortType = {
	sortLvDown = "sortLvDown",
	sortQualityDown = "sortQualityDown",
	sortQualityUp = "sortQualityUp",
	sortLvUp = "sortLvUp"
}
EquipHelper.equipSkillAddHighAttr = {
	"cri",
	"recri",
	"criDmg",
	"criDef",
	"addDmg",
	"dropDmg",
	"revive",
	"absorb",
	"clutch",
	"heal",
	"defenseIgnore"
}
EquipHelper.equipSkillAddHighAttrSortPriority = {
	absorb = 5,
	cri = 2,
	defenseIgnore = 4,
	dropDmg = 8,
	revive = 9,
	recri = 10,
	addDmg = 1,
	criDmg = 3,
	heal = 7,
	criDef = 11,
	clutch = 6
}
EquipHelper.CareerValue = {
	All = "0",
	Wisdom = "6",
	Animal = "4",
	Star = "2",
	Rock = "1",
	Spirit = "5",
	Wood = "3",
	SAW = "5_6"
}
EquipHelper.EquipSkillColor = {
	["0"] = "#FFFFFF",
	["1"] = "#8C6838",
	["5|6"] = "#765A79",
	["2"] = "#4C7199",
	["3"] = "#3F8C52",
	["4"] = "#B35959"
}
EquipHelper.DefaultEquipSkillColorIndex = "0"

function EquipHelper.getEquipSkillDes(id, refine_lv, common_color, refine_private_color)
	local equip_config = EquipConfig.instance:getEquipCo(id)
	local equip_skill_config = EquipConfig.instance:getEquipSkillCfg(equip_config.skillType, refine_lv)

	if not equip_skill_config then
		return ""
	end

	local str = EquipHelper.getEquipSkillAdvanceAttrDes(id, refine_lv, refine_private_color)
	local base_des = EquipHelper.calEquipSkillBaseDes(equip_skill_config.baseDesc)

	if not string.nilorempty(str) and not string.nilorempty(base_des) then
		base_des = "，" .. base_des
	end

	str = str .. base_des

	if not string.nilorempty(equip_skill_config.spDesc) then
		str = str .. "\n" .. EquipHelper.getSpecialSkillDes(id, refine_lv)
	end

	if common_color then
		str = HeroSkillModel.instance:skillDesToSpot(str, nil, nil, true)
	end

	return str
end

function EquipHelper.calEquipSkillBaseDes(base_des, color)
	color = color or "#C66030"
	base_des = string.gsub(base_des, "%{", string.format("<color=%s>", color))
	base_des = string.gsub(base_des, "%}", "</color>")

	return base_des
end

function EquipHelper.getEquipSkillAdvanceAttrDes(id, refine_lv, refine_private_color)
	local equip_config = EquipConfig.instance:getEquipCo(id)
	local equip_skill_config = EquipConfig.instance:getEquipSkillCfg(equip_config.skillType, refine_lv)

	if not equip_skill_config then
		return ""
	end

	local str = ""
	local config

	for i, v in ipairs(EquipHelper.equipSkillAddHighAttr) do
		if not equip_skill_config[v] then
			if equip_skill_config[v] ~= 0 then
				str = str .. HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(v)).name .. luaLang("equip_skill_upgrade") .. equip_skill_config[v] / 10 .. "%，"
			end
		end
	end

	if not string.nilorempty(str) then
		str = luaLang("equip_refine_memory") .. str
		str = string.sub(str, 1, #str - GameUtil.charsize(string.byte("，")))
	end

	if refine_private_color then
		str = HeroSkillModel.instance:skillDesToSpot(str, nil, nil, true)
	end

	return str
end

function EquipHelper.getEquipSkillAdvanceAttrDesTab(id, refine_lv, percentColorParam)
	local equip_config = EquipConfig.instance:getEquipCo(id)
	local equip_skill_config = EquipConfig.instance:getEquipSkillCfg(equip_config.skillType, refine_lv)

	if not equip_skill_config then
		logError(string.format("not found equipSKill config, equipId : %s, equip SkillType : %s, refine level : %s", id, equip_config.skillType, refine_lv))

		return nil
	end

	local descList = {}
	local descItem, config, desc

	for i, v in ipairs(EquipHelper.equipSkillAddHighAttr) do
		if not equip_skill_config[v] then
			if equip_skill_config[v] ~= 0 then
				descItem = {}
				desc = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(v)).name .. luaLang("equip_skill_upgrade") .. "<space=0.45em>" .. equip_skill_config[v] / 10 .. "%"

				if percentColorParam then
					desc = HeroSkillModel.instance:skillDesToSpot(desc, percentColorParam, nil, true)
				end

				descItem.desc = desc
				descItem.key = v
				descItem.value = equip_skill_config[v]

				table.insert(descList, descItem)
			end
		end
	end

	table.sort(descList, function(descItemA, descItemB)
		if descItemA.value ~= descItemB.value then
			return descItemA.value > descItemB.value
		end

		return EquipHelper.equipSkillAddHighAttrSortPriority[descItemA.key] < EquipHelper.equipSkillAddHighAttrSortPriority[descItemB.key]
	end)

	local descTable = {}

	for i = 1, #descList do
		table.insert(descTable, descList[i].desc)
	end

	return descTable
end

function EquipHelper.getEquipSkillBaseDes(id, refine_lv, numColor)
	local equip_config = EquipConfig.instance:getEquipCo(id)
	local equip_skill_config = EquipConfig.instance:getEquipSkillCfg(equip_config.skillType, refine_lv)

	if not equip_skill_config then
		return ""
	end

	local result = {}

	if not string.nilorempty(equip_skill_config.baseDesc) then
		table.insert(result, EquipHelper.calEquipSkillBaseDes(equip_skill_config.baseDesc, numColor))
	end

	return result
end

function EquipHelper.getEquipSkillDescList(id, refine_lv, numColor)
	local equip_config = EquipConfig.instance:getEquipCo(id)
	local equip_skill_config = EquipConfig.instance:getEquipSkillCfg(equip_config.skillType, refine_lv)
	local result = {}

	if not equip_skill_config then
		return {}
	end

	if not string.nilorempty(equip_skill_config.baseDesc) then
		table.insert(result, EquipHelper.calEquipSkillBaseDes(equip_skill_config.baseDesc, numColor))
	end

	return result
end

function EquipHelper.getSpecialSkillDes(id, refine_lv)
	local equip_config = EquipConfig.instance:getEquipCo(id)
	local equip_skill_config = EquipConfig.instance:getEquipSkillCfg(equip_config.skillType, refine_lv)

	if not equip_skill_config or string.nilorempty(equip_skill_config.spDesc) then
		return ""
	end

	return string.format("<#4b93d6><u><link='%s'>[%s]:</link></u></color>", id, equip_config.feature) .. equip_skill_config.spDesc, equip_config.feature, equip_skill_config.spDesc
end

function EquipHelper.isRefineUniversalMaterials(id)
	return id == EquipConfig.instance:getEquipUniversalId()
end

function EquipHelper.isExpEquip(equipConfig)
	return equipConfig and equipConfig.isExpEquip == 1
end

function EquipHelper.isConsumableEquip(id)
	local equip_config = EquipConfig.instance:getEquipCo(id)

	return EquipHelper.isRefineUniversalMaterials(id) or EquipHelper.isExpEquip(equip_config)
end

function EquipHelper.isSpRefineEquip(equipConfig)
	return equipConfig and equipConfig.isSpRefine ~= 0
end

function EquipHelper.isNormalEquip(equipConfig)
	return equipConfig and not EquipHelper.isExpEquip(equipConfig) and not EquipHelper.isRefineUniversalMaterials(equipConfig.id) and not EquipHelper.isSpRefineEquip(equipConfig)
end

function EquipHelper.sortLvUp(item1, item2)
	if item1.level == item2.level then
		if item1.config.rare == item2.config.rare then
			return item1.id > item2.id
		else
			return item1.config.rare > item2.config.rare
		end
	else
		return item1.level > item2.level
	end
end

function EquipHelper.sortLvDown(item1, item2)
	if item1.level == item2.level then
		if item1.config.rare == item2.config.rare then
			return item1.id > item2.id
		else
			return item1.config.rare > item2.config.rare
		end
	else
		return item1.level < item2.level
	end
end

function EquipHelper.sortQualityUp(item1, item2)
	if item1.config.rare == item2.config.rare then
		if item1.level == item2.level then
			return item1.id > item2.id
		else
			return item1.level > item2.level
		end
	else
		return item1.config.rare > item2.config.rare
	end
end

function EquipHelper.sortQualityDown(item1, item2)
	if item1.config.rare == item2.config.rare then
		if item1.level == item2.level then
			return item1.id > item2.id
		else
			return item1.level > item2.level
		end
	else
		return item1.config.rare < item2.config.rare
	end
end

function EquipHelper.typeSort(config1, config2, descend)
	local sortResult
	local sorted = true

	if EquipHelper.isRefineUniversalMaterials(config1.id) ~= EquipHelper.isRefineUniversalMaterials(config2.id) then
		sortResult = not not EquipHelper.isRefineUniversalMaterials(config1.id)
	elseif EquipHelper.isSpRefineEquip(config1) ~= EquipHelper.isSpRefineEquip(config2) then
		sortResult = not not EquipHelper.isSpRefineEquip(config1)
	elseif EquipHelper.isNormalEquip(config1) ~= EquipHelper.isNormalEquip(config2) then
		sortResult = not not EquipHelper.isNormalEquip(config1)
	else
		sorted = false
	end

	if descend then
		return not sortResult, sorted
	else
		return sortResult, sorted
	end
end

function EquipHelper.sortRefineList(item1, item2)
	local config1 = item1.config
	local config2 = item2.config
	local sortResult, sorted = EquipHelper.typeSort(config1, config2)

	if sorted then
		return sortResult
	end

	if item1.refineLv ~= item2.refineLv then
		return item1.refineLv < item2.refineLv
	else
		return item1.level < item2.level
	end

	return false
end

function EquipHelper.createMaxLevelEquipMo(equipId, id)
	local equipCo = EquipConfig.instance:getEquipCo(equipId)
	local isNormalEquip = EquipHelper.isNormalEquip(equipCo)
	local equipMo = EquipMO.New()

	equipMo.config = equipCo
	equipMo.equipId = equipCo.id

	if id then
		equipMo.id = id
	end

	if isNormalEquip then
		equipMo.level = EquipConfig.instance:getMaxLevel(equipCo)
		equipMo.refineLv = EquipConfig.instance:getEquipRefineLvMax()
		equipMo.breakLv = EquipConfig.instance:getEquipMaxBreakLv(equipCo.rare)
	else
		equipMo.level = 1
		equipMo.refineLv = EquipHelper.getRefineLvByEquipCo(equipCo)
		equipMo.breakLv = 1
	end

	return equipMo
end

function EquipHelper.createMinLevelEquipMo(equipId, id)
	local equipCo = EquipConfig.instance:getEquipCo(equipId)
	local equipMo = EquipMO.New()

	equipMo.config = equipCo
	equipMo.equipId = equipCo.id

	if id then
		equipMo.id = id
	end

	equipMo.level = 1
	equipMo.refineLv = EquipHelper.getRefineLvByEquipCo(equipCo)
	equipMo.breakLv = 0

	return equipMo
end

function EquipHelper.getRefineLvByEquipCo(equipCo)
	if equipCo and equipCo.amplify then
		return math.max(1, tonumber(equipCo.amplify))
	end

	return 1
end

function EquipHelper.sortByLevelFunc(a, b)
	local config1 = a.config
	local config2 = b.config
	local sortResult, sorted = EquipHelper.typeSort(config1, config2)

	if sorted then
		return sortResult
	end

	if a.level ~= b.level then
		if CharacterBackpackEquipListModel.instance._levelAscend then
			return a.level < b.level
		else
			return a.level > b.level
		end
	elseif a.config.rare ~= b.config.rare then
		return a.config.rare > b.config.rare
	elseif a.equipId ~= b.equipId then
		return a.equipId > b.equipId
	elseif a.config.rare == b.config.rare then
		if a.refineLv ~= b.refineLv then
			return a.refineLv > b.refineLv
		else
			return a.uid < b.uid
		end
	else
		return a.uid < b.uid
	end
end

function EquipHelper.sortByLevelFuncChooseListModel(a, b)
	if EquipHelper.isNormalEquip(a.config) ~= EquipHelper.isNormalEquip(b.config) then
		if EquipHelper.isNormalEquip(a.config) then
			return false
		else
			return true
		end
	elseif a.level ~= b.level then
		if EquipChooseListModel.instance._levelAscend then
			return a.level < b.level
		else
			return a.level > b.level
		end
	elseif a.config.rare ~= b.config.rare then
		if EquipChooseListModel.instance._qualityAscend then
			return a.config.rare < b.config.rare
		else
			return a.config.rare > b.config.rare
		end

		return a.config.rare > b.config.rare
	elseif a.equipId ~= b.equipId then
		return a.equipId > b.equipId
	elseif a.config.rare == b.config.rare then
		if a.refineLv ~= b.refineLv then
			return a.refineLv > b.refineLv
		else
			return a.uid < b.uid
		end
	else
		return a.uid < b.uid
	end
end

function EquipHelper.sortByQualityFunc(a, b)
	local config1 = a.config
	local config2 = b.config
	local sortResult, sorted = EquipHelper.typeSort(config1, config2)

	if sorted then
		return sortResult
	end

	if a.config.rare ~= b.config.rare then
		if CharacterBackpackEquipListModel.instance._qualityAscend then
			return a.config.rare < b.config.rare
		else
			return a.config.rare > b.config.rare
		end
	elseif a.level ~= b.level then
		return a.level > b.level
	elseif a.equipId ~= b.equipId then
		return a.equipId > b.equipId
	elseif a.level == b.level then
		return a.uid < b.uid
	else
		return a.uid < b.uid
	end
end

function EquipHelper.sortByQualityFuncChooseListModel(a, b)
	if EquipHelper.isNormalEquip(a.config) ~= EquipHelper.isNormalEquip(b.config) then
		if EquipHelper.isNormalEquip(a.config) then
			return false
		else
			return true
		end
	elseif a.config.rare ~= b.config.rare then
		if EquipChooseListModel.instance._qualityAscend then
			return a.config.rare < b.config.rare
		else
			return a.config.rare > b.config.rare
		end
	elseif a.level ~= b.level then
		if EquipChooseListModel.instance._levelAscend then
			return a.level < b.level
		else
			return a.level > b.level
		end
	elseif a.equipId ~= b.equipId then
		return a.equipId > b.equipId
	elseif a.level == b.level then
		return a.uid < b.uid
	else
		return a.uid < b.uid
	end
end

function EquipHelper.sortByTimeFunc(a, b)
	local config1 = a.config
	local config2 = b.config
	local sortResult, sorted = EquipHelper.typeSort(config1, config2)

	if sorted then
		return sortResult
	end

	if a.id ~= b.id then
		if CharacterBackpackEquipListModel.instance._timeAscend then
			return a.id < b.id
		else
			return a.id > b.id
		end
	elseif a.level ~= b.level then
		return a.level > b.level
	else
		return a.config.rare > b.config.rare
	end
end

function EquipHelper.detectEquipSkillSuited(hero_id, skill_type, refine_lv)
	local hero_config = HeroConfig.instance:getHeroCO(hero_id)
	local equip_skill_config = EquipConfig.instance:getEquipSkillCfg(skill_type, refine_lv)

	if not hero_config then
		return false
	end

	if not equip_skill_config then
		logError("装备技能表找不到id：", skill_type, "LV:", refine_lv)

		return
	end

	local career = string.splitToNumber(equip_skill_config.career, "|") or {}

	if #career == 0 then
		return true
	end

	for i, v in ipairs(career) do
		if v == hero_config.career then
			return true
		end
	end

	return false
end

function EquipHelper.getEquipSkillCareer(id, refine_lv)
	return nil
end

function EquipHelper.isEqualCareer(equipMo, career)
	if career == EquipHelper.CareerValue.All then
		return true
	end

	local careerStr = EquipHelper.getEquipSkillCareer(equipMo.config.id, equipMo.refineLv)
	local careerList = string.splitToNumber(careerStr, "|")
	local filterCareerList = string.splitToNumber(career, "_")

	for _, filterCareer in ipairs(filterCareerList) do
		for _, car in ipairs(careerList) do
			if car == filterCareer then
				return true
			end
		end
	end

	return false
end

function EquipHelper.isEqualCareerByCo(equipCo, career)
	if career == EquipHelper.CareerValue.All then
		return true
	end

	local careerStr = EquipHelper.getEquipSkillCareer(equipCo.id, 1)
	local careerList = string.splitToNumber(careerStr, "|")
	local filterCareerList = string.splitToNumber(career, "_")

	for _, filterCareer in ipairs(filterCareerList) do
		for _, car in ipairs(careerList) do
			if car == filterCareer then
				return true
			end
		end
	end

	return false
end

function EquipHelper.getSkillBaseDescAndIcon(id, refine_lv, numColor)
	local equipCarrer = EquipHelper.getEquipSkillCareer(id, refine_lv)
	local skillNameColor = EquipHelper.getSkillBaseNameColor(equipCarrer)
	local carrerIconName = EquipHelper.getSkillCarrerIconName(equipCarrer)
	local skillBaseDesList = EquipHelper.getEquipSkillBaseDes(id, refine_lv, numColor)

	return skillBaseDesList, carrerIconName, skillNameColor
end

function EquipHelper.getSkillCarrerIconName(equipCarrer)
	local carrerIconName = "bg_shuxing"

	if string.nilorempty(equipCarrer) then
		carrerIconName = "bg_shuxing_0"
	else
		local careers = string.splitToNumber(equipCarrer, "|")

		for i, v in ipairs(careers) do
			carrerIconName = carrerIconName .. "_" .. v
		end
	end

	return carrerIconName
end

function EquipHelper.getSkillCarrerSpecialIconName(equipCarrer)
	local carrerIconName

	if string.nilorempty(equipCarrer) then
		carrerIconName = "lssx_0"
	else
		carrerIconName = "jinglian"

		local careers = string.splitToNumber(equipCarrer, "|")

		for i, v in ipairs(careers) do
			carrerIconName = carrerIconName .. "_" .. v
		end
	end

	return carrerIconName
end

function EquipHelper.getSkillCareerNewIconName(career, careerIconName)
	if string.nilorempty(career) then
		careerIconName = careerIconName and careerIconName .. "_0" or "lssx_0"
	else
		careerIconName = careerIconName or "career"

		local careers = string.splitToNumber(career, "|")

		for i, v in ipairs(careers) do
			careerIconName = careerIconName .. "_" .. v
		end
	end

	return careerIconName
end

function EquipHelper.loadEquipCareerNewIcon(equipConfig, imageIcon, refineLv, careerIconName)
	local equipCareer = EquipHelper.getEquipSkillCareer(equipConfig.id, refineLv or 1)
	local isHasSkillBaseDesc = EquipHelper.isHasSkillBaseDesc(equipConfig.id, refineLv or 1)

	if not string.nilorempty(equipCareer) and isHasSkillBaseDesc then
		local skillCareerIconName = EquipHelper.getSkillCareerNewIconName(equipCareer, careerIconName)

		UISpriteSetMgr.instance:setCommonSprite(imageIcon, skillCareerIconName)
		gohelper.setActive(imageIcon.gameObject, true)
	else
		gohelper.setActive(imageIcon.gameObject, false)
	end
end

function EquipHelper.isHasSkillBaseDesc(id, refine_lv)
	local equip_config = EquipConfig.instance:getEquipCo(id)
	local equip_skill_config = EquipConfig.instance:getEquipSkillCfg(equip_config.skillType, refine_lv)

	if not equip_skill_config or string.nilorempty(equip_skill_config.baseDesc) then
		return false
	end

	return true
end

function EquipHelper.getSkillBaseNameColor(carrer)
	return EquipHelper.EquipSkillColor[EquipHelper.DefaultEquipSkillColorIndex]
end

function EquipHelper.getDefaultColor()
	return EquipHelper.EquipSkillColor[EquipHelper.DefaultEquipSkillColorIndex]
end

function EquipHelper.getEquipIconLoadPath(commonequipicon)
	local isExp = commonequipicon.isExpEquip
	local icon = commonequipicon._config.icon
	local targetPath = isExp and ResUrl.getEquipIcon(string.format("%s_equip", icon)) or ResUrl.getEquipIcon(icon)

	commonequipicon._simageicon:LoadImage(targetPath, commonequipicon._loadImageFinish, commonequipicon)
end

function EquipHelper.getEquipDefaultIconLoadPath(commonequipicon)
	local icon = commonequipicon._config.icon
	local targetPath = ResUrl.getHeroDefaultEquipIcon(icon)

	commonequipicon._simageicon:LoadImage(targetPath, EquipHelper.getEquipDefaultIconLoadEnd, commonequipicon)
end

function EquipHelper.getEquipDefaultIconLoadEnd(commonequipicon)
	commonequipicon._simageicon:GetComponent(gohelper.Type_Image):SetNativeSize()
	commonequipicon:_loadImageFinish()
end

function EquipHelper.getAttrPercentValueStr(value)
	return GameUtil.noMoreThanOneDecimalPlace(value / 10) .. "%"
end

function EquipHelper.getAttrBreakText(attrId)
	return HeroConfig.instance:getHeroAttributeCO(attrId).name
end

function EquipHelper.getEquipSkillDesc(desc)
	desc = SkillHelper.addLink(desc)
	desc = SkillHelper.addBracketColor(desc)

	return desc
end

return EquipHelper
