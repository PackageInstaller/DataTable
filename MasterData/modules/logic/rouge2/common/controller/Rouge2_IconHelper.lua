-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_IconHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_IconHelper", package.seeall)

local Rouge2_IconHelper = class("Rouge2_IconHelper")

function Rouge2_IconHelper.setItemIconAndRare(itemId, simageIcon, imageRare, rareIconType, itemIconType)
	Rouge2_IconHelper.setGameItemIcon(itemId, simageIcon, itemIconType)
	Rouge2_IconHelper.setGameItemRare(itemId, imageRare, rareIconType)
end

function Rouge2_IconHelper.setGameItemIcon(itemId, simageIcon, itemIconType)
	local itemType = Rouge2_BackpackHelper.itemId2BagType(itemId)

	if itemType == Rouge2_Enum.BagType.Relics then
		Rouge2_IconHelper.setRelicsIcon(itemId, simageIcon)
	elseif itemType == Rouge2_Enum.BagType.Buff then
		Rouge2_IconHelper.setBuffIcon(itemId, simageIcon, itemIconType)
	elseif itemType == Rouge2_Enum.BagType.ActiveSkill then
		Rouge2_IconHelper.setActiveSkillIcon(itemId, simageIcon)
	elseif itemType == Rouge2_Enum.BagType.AttrBuff then
		Rouge2_IconHelper.setBuffIcon(itemId, simageIcon, itemIconType)
	else
		logError(string.format("肉鸽构筑物图标加载失败: 未定义的构筑物类型: itemId = %s, itemType = %s", itemId, itemType))
	end
end

function Rouge2_IconHelper.setGameItemRare(itemId, imageRare, rareIconType)
	local itemType = Rouge2_BackpackHelper.itemId2BagType(itemId)

	if itemType == Rouge2_Enum.BagType.Relics then
		Rouge2_IconHelper.setRelicsRareIcon(itemId, imageRare, rareIconType)
	elseif itemType == Rouge2_Enum.BagType.Buff then
		Rouge2_IconHelper.setBuffRareIcon(itemId, imageRare, rareIconType)
	elseif itemType == Rouge2_Enum.BagType.ActiveSkill then
		Rouge2_IconHelper.setActiveSkillRareIcon(itemId, imageRare, rareIconType)
	elseif itemType == Rouge2_Enum.BagType.AttrBuff then
		Rouge2_IconHelper.setAttrBuffRareIcon(itemId, imageRare, rareIconType)
	else
		logError(string.format("肉鸽构筑物图标加载失败: 未定义的构筑物类型: itemId = %s, itemType = %s", itemId, itemType))
	end
end

function Rouge2_IconHelper.setAttributeIcon(attrId, imageIcon, suffix)
	if not imageIcon then
		logError("Rouge2_IconHelper.setAttributeIcon error imageIcon is nil")

		return
	end

	if not attrId or string.nilorempty(attrId) or tonumber(attrId) == 0 then
		gohelper.setActive(imageIcon.gameObject, false)

		return
	end

	gohelper.setActive(imageIcon.gameObject, true)

	local attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(attrId)

	if not attrCo then
		return
	end

	suffix = suffix or Rouge2_Enum.AttrIconSuffix.Small

	local iconFullName = string.format("%s%s", attrCo.icon, suffix)

	if suffix == Rouge2_Enum.AttrIconSuffix.Large then
		UISpriteSetMgr.instance:setRouge8Sprite(imageIcon, iconFullName, true)
	else
		UISpriteSetMgr.instance:setRouge6Sprite(imageIcon, iconFullName, true)
	end
end

function Rouge2_IconHelper.setActiveSkillIcon(skillId, simageIcon)
	local skillCo = Rouge2_BackpackHelper.getItemConfig(skillId)

	if not skillCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setActiveSkillIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRougeIcon("collection/" .. skillCo.icon))
end

function Rouge2_IconHelper.setRelicsIcon(relicsId, simageIcon)
	local relicsCo = Rouge2_BackpackHelper.getItemConfig(relicsId)

	if not relicsCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setRelicsIcon error simageIcon is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRougeIcon("collection/" .. relicsCo.icon))
end

function Rouge2_IconHelper.setRelicsRareIcon(relicsId, imageIcon, iconType)
	local relicsCo = Rouge2_BackpackHelper.getItemConfig(relicsId)

	if not relicsCo then
		return
	end

	if not imageIcon then
		logError("Rouge2_IconHelper.setRelicsRareIcon error imageIcon is nil")

		return
	end

	iconType = iconType or Rouge2_Enum.ItemRareIconType.Default

	if iconType == Rouge2_Enum.ItemRareIconType.Default then
		UISpriteSetMgr.instance:setRouge6Sprite(imageIcon, string.format("rouge2_backpackrelics_rare%02d", relicsCo.rare), true)
	elseif iconType == Rouge2_Enum.ItemRareIconType.Bg then
		imageIcon:LoadImage(ResUrl.getRouge2Icon("map/rouge2_relics_panelbg_" .. relicsCo.rare))
	elseif iconType == Rouge2_Enum.ItemRareIconType.NameBg then
		UISpriteSetMgr.instance:setRouge7Sprite(imageIcon, "rouge2_backpackrelics_itemnamebg_" .. relicsCo.rare)
	else
		logError(string.format("肉鸽未定义造物品质图标类型 buffId = %s, iconType = %s", relicsId, iconType))
	end
end

function Rouge2_IconHelper.setAttrBuffRareIcon(attrBuffId, imageIcon, iconType)
	local buffCo = Rouge2_BackpackHelper.getItemConfig(attrBuffId)

	if not buffCo then
		return
	end

	if not imageIcon then
		logError("Rouge2_IconHelper.setBuffRareIcon error imageIcon is nil")

		return
	end

	iconType = iconType or Rouge2_Enum.ItemRareIconType.Default

	local rare = buffCo.rare

	if iconType == Rouge2_Enum.ItemRareIconType.Default then
		UISpriteSetMgr.instance:setRouge8Sprite(imageIcon, string.format("rouge2_new_rare_%s_2", rare), true)
	elseif iconType == Rouge2_Enum.ItemRareIconType.NameBg then
		UISpriteSetMgr.instance:setRouge8Sprite(imageIcon, "rouge2_new_rare_" .. rare)
	elseif iconType == Rouge2_Enum.ItemRareIconType.Bg then
		imageIcon:LoadImage(ResUrl.getRouge2Icon("new/rouge2_new_rare_" .. rare))
	elseif iconType == Rouge2_Enum.ItemRareIconType.TagBg then
		UISpriteSetMgr.instance:setRouge8Sprite(imageIcon, string.format("rouge2_new_rare_%s_1", rare))
	elseif iconType == Rouge2_Enum.ItemRareIconType.CircleBg then
		UISpriteSetMgr.instance:setRouge8Sprite(imageIcon, string.format("rouge2_new_rare_%s_3", rare))
	else
		logError(string.format("肉鸽未定义属性谐波品质图标类型 buffId = %s, iconType = %s", attrBuffId, iconType))
	end
end

function Rouge2_IconHelper.setActiveSkillRareIcon(skillId, imageIcon, iconType)
	local skillCo = Rouge2_BackpackHelper.getItemConfig(skillId)

	if not skillCo then
		return
	end

	if not imageIcon then
		logError("Rouge2_IconHelper.setActiveSkillRareIcon error imageIcon is nil")

		return
	end

	iconType = iconType or Rouge2_Enum.ItemRareIconType.Default

	local rare = skillCo.rare

	if iconType == Rouge2_Enum.ItemRareIconType.Default then
		UISpriteSetMgr.instance:setRouge8Sprite(imageIcon, string.format("rouge2_new_rare_%s_2", rare), true)
	elseif iconType == Rouge2_Enum.ItemRareIconType.NameBg then
		UISpriteSetMgr.instance:setRouge8Sprite(imageIcon, "rouge2_new_rare_" .. rare, true)
	elseif iconType == Rouge2_Enum.ItemRareIconType.Bg then
		imageIcon:LoadImage(ResUrl.getRouge2Icon("new/rouge2_new_rare_" .. rare .. "_2"))
	elseif iconType == Rouge2_Enum.ItemRareIconType.TagBg then
		UISpriteSetMgr.instance:setRouge8Sprite(imageIcon, string.format("rouge2_new_rare_%s_1", rare), true)
	elseif iconType == Rouge2_Enum.ItemRareIconType.CircleBg then
		UISpriteSetMgr.instance:setRouge8Sprite(imageIcon, string.format("rouge2_new_rare_%s_3", rare), true)
	elseif iconType == Rouge2_Enum.ItemRareIconType.CircleIcon then
		UISpriteSetMgr.instance:setRouge8Sprite(imageIcon, string.format("rouge2_new_rare_%s_4", rare), true)
	else
		logError(string.format("肉鸽未定义主动技能品质图标类型 skillId = %s, iconType = %s", skillId, iconType))
	end
end

function Rouge2_IconHelper.setCareerIcon(careerId, imageIcon, suffix)
	local careerCo = Rouge2_CareerConfig.instance:getCareerConfig(careerId)

	if not careerCo then
		return
	end

	if not imageIcon then
		logError("Rouge2_IconHelper.setCareerIcon error imageIcon is nil")

		return
	end

	suffix = suffix or Rouge2_Enum.CareerIconSuffix.Tab

	if suffix == Rouge2_Enum.CareerIconSuffix.Bag then
		local iconUrl = ResUrl.getRouge2Icon(string.format("backpack/%s%s", careerCo.icon, Rouge2_Enum.CareerIconSuffix.Bag))

		imageIcon:LoadImage(iconUrl)
	else
		local iconName = string.format("%s%s", careerCo.icon, suffix)

		UISpriteSetMgr.instance:setRouge6Sprite(imageIcon, iconName, true)
	end
end

function Rouge2_IconHelper.setCareerName(careerId, txtName, setColor)
	local careerCo = Rouge2_CareerConfig.instance:getCareerConfig(careerId)

	if not careerCo then
		return
	end

	txtName.text = careerCo and careerCo.name

	if setColor then
		SLFramework.UGUI.GuiHelper.SetColor(txtName, string.format("#%s", careerCo.nameColor))
	end
end

function Rouge2_IconHelper.setBuffIcon(buffId, simageIcon, iconType)
	local buffCo = Rouge2_BackpackHelper.getItemConfig(buffId)

	if not buffCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setBuffIcon error simageIcon is nil")

		return
	end

	iconType = iconType or Rouge2_Enum.ItemIconType.Default

	simageIcon:LoadImage(ResUrl.getRouge2Icon("buff/" .. buffCo.icon .. iconType))
end

function Rouge2_IconHelper.setBuffRareIcon(buffId, imageIcon, iconType)
	local buffCo = Rouge2_BackpackHelper.getItemConfig(buffId)

	if not buffCo then
		return
	end

	if not imageIcon then
		logError("Rouge2_IconHelper.setBuffRareIcon error imageIcon is nil")

		return
	end

	iconType = iconType or Rouge2_Enum.ItemRareIconType.Default

	if iconType == Rouge2_Enum.ItemRareIconType.Default then
		UISpriteSetMgr.instance:setRouge6Sprite(imageIcon, "rouge2_buff_quality_" .. buffCo.rare, true)
	elseif iconType == Rouge2_Enum.ItemRareIconType.Bg then
		UISpriteSetMgr.instance:setRouge7Sprite(imageIcon, "rouge2_mapchoice_itembg_" .. buffCo.rare)
	elseif iconType == Rouge2_Enum.ItemRareIconType.NameBg then
		UISpriteSetMgr.instance:setRouge7Sprite(imageIcon, "rouge2_buff_namebg_" .. buffCo.rare)
	elseif iconType == Rouge2_Enum.ItemRareIconType.TagBg then
		UISpriteSetMgr.instance:setRouge7Sprite(imageIcon, "rouge2_bufftag_" .. buffCo.rare)
	else
		logError(string.format("肉鸽未定义谐波品质图标类型 buffId = %s, iconType = %s", buffId, iconType))
	end
end

function Rouge2_IconHelper.setWeatherIcon(weatherId, imageIcon, suffix)
	local weatherCo = Rouge2_MapConfig.instance:getWeatherConfig(weatherId)

	if not weatherCo then
		return
	end

	if not imageIcon then
		logError("Rouge2_IconHelper.setWeatherIcon error imageIcon is nil")

		return
	end

	suffix = suffix or Rouge2_MapEnum.WeatherIconSuffix.Normal

	local iconName = string.format("%s%s", weatherCo.icon, suffix)

	UISpriteSetMgr.instance:setRouge6Sprite(imageIcon, iconName)
end

function Rouge2_IconHelper.setBandHeroIcon(bandId, simageIcon)
	local bandCo = Rouge2_MapConfig.instance:getBandConfig(bandId)

	if not bandCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setWeatherIcon error simageIcon is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getHeadIconSmall(bandCo.icon))
end

function Rouge2_IconHelper.setSummonerTalentIcon(talentId, status, imageIcon)
	local iconUrl = Rouge2_CareerConfig.instance:getTalentIcon(talentId, status)

	if string.nilorempty(iconUrl) then
		return
	end

	if not imageIcon then
		logError("Rouge2_IconHelper.setSummonerTalentIcon error imageIcon is nil")

		return
	end

	UISpriteSetMgr.instance:setRouge7Sprite(imageIcon, iconUrl, true)
end

function Rouge2_IconHelper.setSummonerTalentStageIcon(talentId, simageIcon)
	local talentCo = Rouge2_CareerConfig.instance:getTalentConfig(talentId)
	local skinId = talentCo and talentCo.skinId

	if not skinId then
		logError(string.format("Rouge2_IconHelper.setSummonerTalentStageIcon error skinId is nil, talentId = %s", talentId))

		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setSummonerTalentStageIcon error simageIcon is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRouge2Icon("talent/" .. talentCo.petIcon))
end

function Rouge2_IconHelper.setTeamSystemIcon(systemId, simageIcon, imageBg, iconType)
	local systemCo = Rouge2_CareerConfig.instance:getSystemConfig(systemId)

	if not systemCo then
		return
	end

	iconType = iconType or Rouge2_Enum.SystemIconType.Black

	if iconType == Rouge2_Enum.SystemIconType.Black then
		simageIcon:LoadImage(ResUrl.getRouge2Icon("buff/" .. systemCo.icon .. "_1"))
	elseif iconType == Rouge2_Enum.SystemIconType.White then
		simageIcon:LoadImage(ResUrl.getRouge2Icon("buff/" .. systemCo.icon .. "_2"))

		local imageIcon = gohelper.onceAddComponent(simageIcon.gameObject, gohelper.Type_Image)
		local iconColor = string.format("#%s", (not systemCo.color or nil) and "FFFFFF")

		SLFramework.UGUI.GuiHelper.SetColor(imageIcon, iconColor)

		local bgColor = string.format("#%s", systemCo.bgColor or "FFFFFF")

		SLFramework.UGUI.GuiHelper.SetColor(imageBg, bgColor)
	end
end

function Rouge2_IconHelper.setTalentIcon(talentId, simageIcon)
	local talentCo = Rouge2_OutSideConfig.instance:getTalentConfigById(talentId)

	if not talentCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setTalentIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRouge2Icon("talent/" .. talentCo.icon))
end

function Rouge2_IconHelper.setFormulaIcon(formulaId, simageIcon)
	local formulaCo = Rouge2_OutSideConfig.instance:getFormulaConfig(formulaId)

	if not formulaCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setFormulaIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRougeIcon("collection/" .. formulaCo.icon))
end

function Rouge2_IconHelper.setMaterialIcon(materialId, simageIcon)
	local materialCo = Rouge2_OutSideConfig.instance:getMaterialConfig(materialId)

	if not materialCo then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setMaterialIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRougeIcon("collection/" .. materialCo.icon))
end

function Rouge2_IconHelper.setFormulaRareBg(rare, iconImageComp)
	if not iconImageComp then
		logError("Rouge2_IconHelper.setFormulaRareBg error iconImageComp is nil")

		return
	end

	local path = "rouge2_quality_circle_" .. rare

	UISpriteSetMgr.instance:setRouge6Sprite(iconImageComp, path)
end

function Rouge2_IconHelper.setMaterialRareBg(rare, iconImageComp)
	if not iconImageComp then
		logError("Rouge2_IconHelper.setMaterialRareBg error iconImageComp is nil")

		return
	end

	local path = "rouge2_quality_square_" .. rare

	UISpriteSetMgr.instance:setRouge6Sprite(iconImageComp, path)
end

function Rouge2_IconHelper.setAlchemyRareBg(rare, iconImageComp)
	if not iconImageComp then
		logError("Rouge2_IconHelper.setAlchemyRareBg error iconImageComp is nil")

		return
	end

	local path = "rouge2_quality_square_" .. rare

	UISpriteSetMgr.instance:setRouge6Sprite(iconImageComp, path)
end

function Rouge2_IconHelper.setRougeEventIcon2(id, iconImageComp)
	if not iconImageComp then
		logError("Rouge2_IconHelper.setRougeEventIcon error iconImageComp is nil")

		return
	end

	local path = string.format("rouge2_event_icon_%s_2", tostring(id))

	UISpriteSetMgr.instance:setRouge6Sprite(iconImageComp, path)
end

function Rouge2_IconHelper.setRougeIllustrationSmallIcon(id, simageIcon)
	local config = Rouge2_OutSideConfig.instance:getIllustrationConfig(id)

	if not config then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setRougeIllustrationSmallIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRouge2Icon("small/" .. config.image))
end

function Rouge2_IconHelper.setRougeIllustrationBigIcon(id, simageIcon)
	local config = Rouge2_OutSideConfig.instance:getIllustrationConfig(id)

	if not config then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setRougeIllustrationSmallIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRouge2Icon("choice/" .. config.fullImage))
end

function Rouge2_IconHelper.setItemIcon(itemId, simageIcon)
	local bagType = Rouge2_BackpackHelper.itemId2Tag(itemId)

	if not simageIcon then
		logError("Rouge2_IconHelper.setItemIcon error iconImageComp is nil")

		return
	end

	if bagType == Rouge2_OutsideEnum.CollectionListType.AutoBuff then
		Rouge2_IconHelper.setActiveSkillIcon(itemId, simageIcon)
	elseif bagType == Rouge2_OutsideEnum.CollectionListType.Buff then
		Rouge2_IconHelper.setBuffIcon(itemId, simageIcon)
	elseif bagType == Rouge2_OutsideEnum.CollectionListType.Collection then
		Rouge2_IconHelper.setRelicsIcon(itemId, simageIcon)
	else
		logError(string.format("Rouge2_BackpackHelper.getItemConfig 未定义背包类型, bagType = %s, itemId = %s", bagType, itemId))
	end
end

function Rouge2_IconHelper.setRougeAchievementIcon(id, simageIcon)
	local config = Rouge2_Config.instance:getRougeBadgeCO(id)

	if not config then
		return
	end

	if not simageIcon then
		logError("Rouge2_IconHelper.setRougeIllustrationSmallIcon error iconImageComp is nil")

		return
	end

	simageIcon:LoadImage(ResUrl.getRouge2Icon("achieve/" .. config.icon))
end

function Rouge2_IconHelper.setResultAssessIcon(score, imageAssess, imageAssess2, imageAssessBg)
	local assessCo = Rouge2_Config.instance:getAssessConfigByScore(score)

	if assessCo then
		if not assessCo.spriteName then
			local iconName = ""

			UISpriteSetMgr.instance:setRouge7Sprite(imageAssess, string.format("%s_2", iconName), true)
			UISpriteSetMgr.instance:setRouge7Sprite(imageAssess2, string.format("%s_3", iconName), true)

			if imageAssessBg then
				if assessCo then
					if not assessCo.spriteBgName then
						local iconBgName = ""

						UISpriteSetMgr.instance:setRouge7Sprite(imageAssessBg, iconBgName, true)
					end
				end
			end
		end
	end
end

function Rouge2_IconHelper.setBossAssessIcon(score, simageAssess)
	local assessCo = Rouge2_BossBattleConfig.instance:getAssessConfigByScore(score)
	local hasAssess = assessCo ~= nil

	gohelper.setActive(simageAssess.gameObject, hasAssess)

	if not hasAssess then
		return
	end

	simageAssess:LoadImage(ResUrl.getV1a4BossRushAssessIcon(assessCo.bossIcon))
end

function Rouge2_IconHelper.getScoreStr(num, symbol)
	assert(num >= 0)

	local a = math.modf(num / 10)
	local b = math.fmod(num, 10)
	local c = 1
	local str = tostring(b)

	symbol = symbol or ","

	while a > 0 do
		b = math.fmod(a, 10)

		if c >= 3 then
			str = symbol .. str
			c = 0
		end

		str = tostring(b) .. str
		a = math.modf(a / 10)
		c = c + 1
	end

	return str
end

return Rouge2_IconHelper
