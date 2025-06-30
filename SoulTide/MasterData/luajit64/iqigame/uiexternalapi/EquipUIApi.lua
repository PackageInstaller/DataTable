-- chunkname: @IQIGame\\UIExternalApi\\EquipUIApi.lua

EquipUIApi = BaseLangApi:Extend()

function EquipUIApi:Init()
	self:RegisterApi("goEquipName", self.GetEquipName)
	self:RegisterApi("goSoulName", self.GetSoulName)
	self:RegisterApi("curMainAttValue", self.GetCurMainAttValue)
	self:RegisterApi("secAttDesc", self.GetSecAttDesc)
	self:RegisterApi("goAttName", self.GetAttName)
	self:RegisterApi("goCoinDesc", self.GetCoinDesc)
	self:RegisterApi("goCoinNum", self.GetCoinNum)
	self:RegisterApi("qualityIconPath", self.GetQualityIconPath)
	self:RegisterApi("goViewTitle", self.GetViewTitle)
	self:RegisterApi("goEffectDesc1", self.GetEffectDesc1)
	self:RegisterApi("pabilityName", self.GetPabilityName)
	self:RegisterApi("goEffectDesc2", self.GetEffectDesc2)
	self:RegisterApi("goEffectDesc2Name", self.GetEffectDesc2Name)
	self:RegisterApi("goToggleName", self.GetToggleName)
	self:RegisterApi("goToggleEnglishName", self.GetToggleEnglishName)
	self:RegisterApi("goSignClip", self.GetSignClipDesc)
	self:RegisterApi("goEquipDesc", self.GetEquipDesc)
	self:RegisterApi("goTitle1", self.GetTitle1)
	self:RegisterApi("goTitle2", self.GetTitle2)
	self:RegisterApi("goTitle3", self.GetTitle3)
	self:RegisterApi("goSuitTitle", self.GetSuitTitle)
	self:RegisterApi("SuitEffectNameText", self.GetSuitEffectNameText)
	self:RegisterApi("SuitEffectDescText", self.GetSuitEffectDescText)
	self:RegisterApi("goEquipDescTitle", self.GetEquipDescTitle)
	self:RegisterApi("goEffectDesc2Title", self.GetEffectDesc2Title)
	self:RegisterApi("goStoryTitle", self.GetStoryTitle)
	self:RegisterApi("goSpecialDesc", self.GetSpecialDesc)
	self:RegisterApi("goSpecialName", self.GetSpecialName)
	self:RegisterApi("goDialogBtn", self.GetDialogBtnTxt)
	self:RegisterApi("goDialogTip", self.GetDialogTip)
	self:RegisterApi("goBgQualityPath", self.GetBgQualityPath)
	self:RegisterApi("goSpecialStory", self.GetSpecialStory)
	self:RegisterApi("goToggleSwitch", self.GetToggleSwitchTxt)
	self:RegisterApi("goNormalStoryContent", self.GetNormalStoryContent)
	self:RegisterApi("goNormalStoryLockDesc", self.GetNormalStoryLockDesc)
	self:RegisterApi("goToggleLockTxt", self.GetToggleLockTxt)
	self:RegisterApi("goBtnTakeOffTxt", self.GetBtnTakeOffTxt)
	self:RegisterApi("suitCellAttIndex", self.GetSuitCellAttIndex)
	self:RegisterApi("suitCellAttName", self.GetSuitCellAttName)
	self:RegisterApi("suitCellAttDesc", self.GetSuitCellAttDesc)
	self:RegisterApi("recastViewTitle1", self.GetRecastViewTitle1)
	self:RegisterApi("recastViewTitle2", self.GetRecastViewTitle2)
	self:RegisterApi("recastViewTitle3", self.GetRecastViewTitle3)
	self:RegisterApi("recastViewRecastEquipCount", self.GetRecastViewRecastEquipCount)
	self:RegisterApi("recastViewMoneyCost", self.GetRecastViewMoneyCost)
	self:RegisterApi("recastViewBtnResetTxt", self.GetRecastViewBtnResetTxt)
	self:RegisterApi("goCostNum", self.GetCostNum)
	self:RegisterApi("goBtnUpStar", self.GetBtnUpStarTxt)
	self:RegisterApi("goPabilityDeltaValue", self.GetPabilityDeltaValue)
	self:RegisterApi("goTittleItemTab", self.GetTitleItemTab)
	self:RegisterApi("goTittleAttTab", self.GetTitleAttTab)
	self:RegisterApi("goBtnFilterTitle2", self.GetBtnFilterTitle2)
	self:RegisterApi("goStarTitle", self.GetStarTitle)
	self:RegisterApi("goBtnUp", self.GetBtnUpTxt)
	self:RegisterApi("btnClearTxt", self.GetBtnClearTxt)
	self:RegisterApi("attValueBuildNow", self.GetAttValueBuildNow)
	self:RegisterApi("attValueBuildNext", self.GetAttValueBuildNex)
	self:RegisterApi("goLvDesc", self.GetLvDesc)
	self:RegisterApi("goDeltaLvImgPath", self.GetDeltaLvImgPath)
	self:RegisterApi("goBtnMaxTxt", self.GetBtnMaxTxt)
	self:RegisterApi("goExpPre", self.GetExpPre)
	self:RegisterApi("goExpProgressSpeed", self.GetExpProgressSpeed)
	self:RegisterApi("goSelectedNum", self.GetSelectedNuM)
	self:RegisterApi("goExp", self.GetCellExpDesc)
	self:RegisterApi("costItemName", self.GetCostItemName)
	self:RegisterApi("goCellFrame", self.GetCellFrame)
	self:RegisterApi("goCellBg", self.GetCellBg)
	self:RegisterApi("goCellMoon", self.GetCellMoon)
	self:RegisterApi("goEquipLv", self.GetEquipLv)
	self:RegisterApi("goDescCurWore", self.GetDescCurWore)
	self:RegisterApi("SkinView_OriginEquipNameLabel", self.GetSkinView_OriginEquipNameLabel)
	self:RegisterApi("SkinView_Cell_UsingViewText", self.GetSkinView_Cell_UsingViewText)
	self:RegisterApi("SkinView_PageText", self.GetSkinView_PageText)
	self:RegisterApi("SkinView_ChangeSkinBtnText", self.GetSkinView_ChangeSkinBtnText)
	self:RegisterApi("SkinView_GoBuyBtnText", self.GetSkinView_GoBuyBtnText)
	self:RegisterApi("SkinView_LockedHiddenStoryText", self.GetSkinView_LockedHiddenStoryText)
end

function EquipUIApi:GetSuitCellAttIndex(index)
	if index == 1 then
		return "Ⅰ"
	elseif index == 2 then
		return "Ⅱ"
	elseif index == 3 then
		return "Ⅲ"
	else
		return "???"
	end
end

function EquipUIApi:GetSuitCellAttName(name, woreCount, needCount)
	return name .. "(" .. woreCount .. "/" .. needCount .. ")"
end

function EquipUIApi:GetSuitCellAttDesc(desc)
	return desc
end

function EquipUIApi:GetRecastViewTitle1()
	return self:GetCfgText(1314343)
end

function EquipUIApi:GetRecastViewTitle2()
	return self:GetCfgText(1314344)
end

function EquipUIApi:GetRecastViewTitle3()
	return self:GetCfgText(1314345)
end

function EquipUIApi:GetRecastViewRecastEquipCount(count)
	return "x " .. count
end

function EquipUIApi:GetRecastViewMoneyCost(cost, ownCount)
	return cost .. "/" .. ownCount
end

function EquipUIApi:GetRecastViewBtnResetTxt()
	return self:GetCfgText(1314354)
end

function EquipUIApi:GetDescCurWore()
	return self:GetCfgText(1214059)
end

function EquipUIApi:GetEquipLv(lv)
	if lv == 0 then
		return ""
	else
		return lv
	end
end

function EquipUIApi:GetLvDesc(curLv, totalLv, deltaLv)
	if deltaLv > 0 then
		return self:GetCfgText(1314346) .. self:FontSize("LV.", 20) .. self:Space(1) .. self.TextColor[217] .. tostring(curLv) .. self.TextColor[0] .. self:Space(1) .. self:FontSize("/" .. self:Space(1) .. tostring(totalLv), 20)
	else
		return self:GetCfgText(1314346) .. self:FontSize("LV.", 20) .. self:Space(1) .. tostring(curLv) .. self:Space(1) .. self:FontSize("/" .. self:Space(1) .. tostring(totalLv), 20)
	end
end

function EquipUIApi:GetDeltaLvImgPath(num)
	if num == 0 then
		return self:GetResUrl(2600000)
	elseif num == 1 then
		return self:GetResUrl(2600001)
	elseif num == 2 then
		return self:GetResUrl(2600002)
	elseif num == 3 then
		return self:GetResUrl(2600003)
	elseif num == 4 then
		return self:GetResUrl(2600004)
	elseif num == 5 then
		return self:GetResUrl(2600005)
	elseif num == 6 then
		return self:GetResUrl(2600006)
	elseif num == 7 then
		return self:GetResUrl(2600007)
	elseif num == 8 then
		return self:GetResUrl(2600008)
	elseif num == 9 then
		return self:GetResUrl(2600009)
	end
end

function EquipUIApi:GetCostItemName(name)
	return name
end

function EquipUIApi:GetBtnMaxTxt()
	return "MAX"
end

function EquipUIApi:GetExpPre(curExp, needExp)
	return "EXP " .. curExp .. self.TextColor[214] .. "/" .. needExp .. self.TextColor[0]
end

function EquipUIApi:GetExpProgressSpeed()
	return 0.02
end

function EquipUIApi:GetCellMoon(isSpecial, quality)
	if isSpecial then
		return self:GetResUrl(1301001)
	elseif quality == 1 then
		return self:GetResUrl(1301002)
	elseif quality == 2 then
		return self:GetResUrl(1301003)
	elseif quality == 3 then
		return self:GetResUrl(1301004)
	elseif quality == 4 then
		return self:GetResUrl(1301005)
	elseif quality == 5 then
		return self:GetResUrl(1301006)
	end
end

function EquipUIApi:GetCellBg(quality)
	if quality == 1 then
		return self:GetResUrl(1301007)
	elseif quality == 2 then
		return self:GetResUrl(1301008)
	elseif quality == 3 then
		return self:GetResUrl(1301009)
	elseif quality == 4 then
		return self:GetResUrl(1301010)
	elseif quality == 5 then
		return self:GetResUrl(1301011)
	end
end

function EquipUIApi:GetCellFrame(isSpecial, quality)
	if isSpecial then
		return self:GetResUrl(1301012)
	elseif quality == 1 then
		return self:GetResUrl(1301013)
	elseif quality == 2 then
		return self:GetResUrl(1301014)
	elseif quality == 3 then
		return self:GetResUrl(1301015)
	elseif quality == 4 then
		return self:GetResUrl(1301016)
	elseif quality == 5 then
		return self:GetResUrl(1301017)
	end
end

function EquipUIApi:GetSignClipDesc()
	return self:GetCfgText(1314427)
end

function EquipUIApi:GetSoulName(name)
	if name == nil or name == "" then
		return ""
	end

	return self.TextColor[29] .. name .. self.TextColor[0] .. self:GetCfgText(1314433)
end

function EquipUIApi:GetEquipName(name)
	return name
end

function EquipUIApi:GetCostNum(cost, needCount)
	if cost < needCount then
		CountColor = 28
	else
		CountColor = 29
	end

	return self:GetCfgText(1314403) .. "：\n" .. "<size=24>" .. self.TextColor[CountColor] .. cost .. self.TextColor[0] .. "</size>" .. "/" .. needCount
end

function EquipUIApi:GetBtnUpStarTxt()
	return self:GetCfgText(1314404)
end

function EquipUIApi:GetPabilityDeltaValue(delta)
	return delta
end

function EquipUIApi:GetTitleItemTab()
	return self:GetCfgText(1314347)
end

function EquipUIApi:GetTitleAttTab()
	return self:GetCfgText(1314340)
end

function EquipUIApi:GetBtnFilterTitle2()
	return self:GetCfgText(1314348)
end

function EquipUIApi:GetStarTitle(isMax)
	if isMax then
		return self:GetCfgText(1314349)
	end

	return self:GetCfgText(1314350)
end

function EquipUIApi:GetSelectedNuM(num)
	if num == 0 then
		return ""
	else
		return "<size=16>" .. num .. "</size>"
	end
end

function EquipUIApi:GetCellExpDesc(exp)
	return self.TextColor[31] .. "<size=16>" .. self:GetCfgText(1314405) .. "</size>" .. self.TextColor[0] .. "\n" .. exp
end

function EquipUIApi:GetAttMain(curShowValue, addValue, nextShowValue)
	if addValue ~= 0 then
		return curShowValue .. BaseLangApi.TextColor[30] .. nextShowValue .. BaseLangApi.TextColor[0]
	else
		return curShowValue
	end
end

function EquipUIApi:GetAttName(type, isMain)
	if isMain == true then
		return AttributeModule.GetAttName(type)
	else
		return AttributeModule.GetAttName(type)
	end
end

function EquipUIApi:GetCurMainAttValue(value, isPreview)
	if isPreview then
		return self.TextColor[207] .. value .. self.TextColor[0]
	else
		return self.TextColor[12] .. value .. self.TextColor[0]
	end
end

function EquipUIApi:GetSecAttDesc(type, value)
	local name = AttributeModule.GetAttName(type)

	return name .. "+" .. value
end

function EquipUIApi:GetBtnUpTxt()
	return self:GetCfgText(1314409)
end

function EquipUIApi:GetCoinDesc(type)
	if type == 1 then
		return self:GetCfgText(1314410)
	elseif type == 2 then
		return self:GetCfgText(1314411)
	end
end

function EquipUIApi:GetCoinNum(num, ownCount)
	if ownCount < num then
		return self.TextColor[28] .. ownCount .. self.TextColor[0] .. "/" .. num
	else
		return self.TextColor[29] .. ownCount .. self.TextColor[0] .. "/" .. num
	end
end

function EquipUIApi:GetViewTitle()
	return self:GetCfgText(1314412)
end

function EquipUIApi:GetEffectDesc1(desc, isPreview)
	return self:SkillValueColor(desc, 43)
end

function EquipUIApi:GetPabilityName(name, isPreview)
	return name
end

function EquipUIApi:GetEffectDesc2(desc, isPreview)
	if isPreview then
		return self.TextColor[201] .. self:SkillValueColor(desc, 43) .. self.TextColor[0]
	else
		return self:SkillValueColor(desc, 43)
	end
end

function EquipUIApi:GetEffectDesc2Name(name, isPreview)
	if isPreview then
		return self.TextColor[201] .. name .. self.TextColor[0]
	else
		return name
	end
end

function EquipUIApi:GetToggleName(index)
	if index == 1 then
		return self:GetCfgText(1314413)
	elseif index == 2 then
		return self:GetCfgText(1314415)
	elseif index == 3 then
		return self:GetCfgText(1314417)
	elseif index == 4 then
		return self:GetCfgText(1314424)
	elseif index == 5 then
		return self:GetCfgText(1314435)
	end
end

function EquipUIApi:GetToggleEnglishName(index)
	if index == 1 then
		return self:GetCfgText(1314414)
	elseif index == 2 then
		return self:GetCfgText(1314416)
	elseif index == 3 then
		return self:GetCfgText(1314418)
	elseif index == 4 then
		return self:GetCfgText(1314423)
	elseif index == 5 then
		return self:GetCfgText(1314436)
	end
end

function EquipUIApi:GetTitle1()
	return self:GetCfgText(1314419)
end

function EquipUIApi:GetTitle2()
	return self:GetCfgText(1314420)
end

function EquipUIApi:GetTitle3()
	return self:GetCfgText(1314428)
end

function EquipUIApi:GetSuitTitle()
	return self:GetCfgText(1314434)
end

function EquipUIApi:GetSuitEffectNameText(name, hasNum, needNum)
	if needNum < hasNum then
		hasNum = needNum
	end

	return string.format("%s(%s/%s)", name, hasNum, needNum)
end

function EquipUIApi:GetSuitEffectDescText(desc, isTrigger)
	local color

	color = isTrigger and "#40D4FF" or "#4C4C4C"

	return string.format("<color=%s>%s</color>", color, desc)
end

function EquipUIApi:GetEquipDescTitle()
	return self:GetCfgText(1314421)
end

function EquipUIApi:GetEffectDesc2Title(index)
	if index == 1 then
		return "I"
	elseif index == 2 then
		return "II"
	elseif index == 3 then
		return "III"
	else
		return "IV"
	end
end

function EquipUIApi:GetStoryTitle(isSpecial)
	if isSpecial then
		return self:GetCfgText(1314337)
	else
		return self:GetCfgText(1314338)
	end
end

function EquipUIApi:GetSpecialDesc()
	return ""
end

function EquipUIApi:GetSpecialStory(desc)
	return desc
end

function EquipUIApi:GetToggleSwitchTxt(isStory)
	if isStory then
		return self:GetCfgText(1314339)
	else
		return self:GetCfgText(1314340)
	end
end

function EquipUIApi:GetSpecialName(name)
	return name
end

function EquipUIApi:GetNormalStoryContent(content)
	return content
end

function EquipUIApi:GetNormalStoryLockDesc(star)
	return self:GetCfgText(1314341) .. "：" .. tostring(star)
end

function EquipUIApi:GetToggleLockTxt(isLock)
	if isLock then
		return self:GetCfgText(1314431)
	else
		return self:GetCfgText(1314430)
	end
end

function EquipUIApi:GetBtnTakeOffTxt()
	return self:GetCfgText(1314432)
end

function EquipUIApi:GetDialogBtnTxt()
	return self:GetCfgText(1314342)
end

function EquipUIApi:GetDialogTip(desc)
	return desc
end

function EquipUIApi:GetBgQualityPath(quality)
	if quality == 1 then
		return self:GetResUrl(1301018)
	elseif quality == 2 then
		return self:GetResUrl(1301019)
	elseif quality == 3 then
		return self:GetResUrl(1301020)
	elseif quality == 4 then
		return self:GetResUrl(1301021)
	elseif quality == 5 then
		return self:GetResUrl(1301022)
	end
end

function EquipUIApi:GetEquipDesc(desc)
	return desc
end

function EquipUIApi:GetBtnClearTxt()
	return self:GetCfgText(1314425)
end

function EquipUIApi:GetAttValueBuildNow(value)
	return value
end

function EquipUIApi:GetAttValueBuildNex(value)
	return self.TextColor[207] .. value .. self.TextColor[0]
end

function EquipUIApi:GetQualityIconPath(quality)
	if quality == 1 then
		return self:GetResUrl(1300001)
	elseif quality == 2 then
		return self:GetResUrl(1300002)
	elseif quality == 3 then
		return self:GetResUrl(1300003)
	elseif quality == 4 then
		return self:GetResUrl(1300004)
	elseif quality == 5 then
		return self:GetResUrl(1300005)
	end
end

function EquipUIApi:GetSkinView_OriginEquipNameLabel()
	return ""
end

function EquipUIApi:GetSkinView_Cell_UsingViewText()
	return self:GetCfgText(1314437)
end

function EquipUIApi:GetSkinView_PageText(page, maxPage)
	return page .. "/" .. maxPage
end

function EquipUIApi:GetSkinView_ChangeSkinBtnText(isUsingSkin)
	if isUsingSkin then
		return self:GetCfgText(1314438)
	else
		return self:GetCfgText(1314439)
	end
end

function EquipUIApi:GetSkinView_GoBuyBtnText()
	return self:GetCfgText(1314440)
end

function EquipUIApi:GetSkinView_LockedHiddenStoryText()
	return self:GetCfgText(1314441)
end

EquipUIApi:Init()
