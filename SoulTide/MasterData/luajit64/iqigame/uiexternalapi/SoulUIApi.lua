-- chunkname: @IQIGame\\UIExternalApi\\SoulUIApi.lua

SoulUIApi = BaseLangApi:Extend()

function SoulUIApi:Init()
	self:RegisterApi("UpViewUpBtnTxt", self.GetUpViewUpBtnTxt)
	self:RegisterApi("UpViewBtnTxtEng", self.GetUpViewUpBtnTxtEng)
	self:RegisterApi("UpViewAddExp", self.GetUpViewAddExp)
	self:RegisterApi("UpViewProgressDesc", self.GetUpViewProgressDesc)
	self:RegisterApi("UpViewProgressPercent", self.GetUpViewProgressPercent)
	self:RegisterApi("UpViewLvTitle", self.GetUpViewLvTitle)
	self:RegisterApi("maxLv", self.GetMaxLv)
	self:RegisterApi("UpViewLvBtnMaxTxt", self.GetUpViewLvBtnMaxTxt)
	self:RegisterApi("UpViewLvBtnClearTxt", self.GetUpViewLvBtnClearTxt)
	self:RegisterApi("UpViewItemQualityBg", self.GetUpViewItemQualityBg)
	self:RegisterApi("UpViewProgressSpeed", self.GetUpViewProgressSpeed)
	self:RegisterApi("goMoneyCost", self.GetMoneyCost)
	self:RegisterApi("goSoulName", self.GetSoulName)
	self:RegisterApi("goSoulEnglishName", self.GetSoulEnglishName)
	self:RegisterApi("goViewTitle", self.GetViewTitle)
	self:RegisterApi("soulAttIconPath", self.GetSoulAttIconPath)
	self:RegisterApi("goAttNameEng", self.GetAttNameEng)
	self:RegisterApi("imgLvPath", self.GetImgLvPath)
	self:RegisterApi("TitleEng", self.GetTitleEng)
	self:RegisterApi("Title", self.GetTitle)
	self:RegisterApi("TitleHelp", self.GetTitleHelp)
	self:RegisterApi("SoulHeadIcon", self.GetSoulHeadIcon)
	self:RegisterApi("btnAttDetailTxt", self.GetBtnAttDetailTxt)
	self:RegisterApi("infoViewAttName", self.GetInfoViewAttName)
	self:RegisterApi("goCv", self.GetCvName)
	self:RegisterApi("infoViewFeatureName", self.GetInfoViewFeatureName)
	self:RegisterApi("infoViewFeatureName2", self.GetInfoViewFeatureName2)
	self:RegisterApi("featureInfoViewFeatureName", self.GetFeatureInfoViewFeatureName)
	self:RegisterApi("attViewAttName", self.GetAttViewAttName)
	self:RegisterApi("attViewAttValue", self.GetAttViewAttValue)
	self:RegisterApi("fightAttSort", self.GetFightAttSort)
	self:RegisterApi("infoViewLvTitle", self.GetInfoViewLvTitle)
	self:RegisterApi("infoViewStarTitle", self.GetInfoViewStarTitle)
	self:RegisterApi("infoViewFeatureTitle", self.GetFeatureTitle)
	self:RegisterApi("infoViewFeatureUnlockDesc", self.GetInfoViewFeatureUnlockDesc)
	self:RegisterApi("infoViewFeatureDesc", self.GetInfoViewFeatureDesc)
	self:RegisterApi("infoViewFeatureTipTitle", self.GetInfoViewFeatureTipTitle)
	self:RegisterApi("infoViewFeatureTipTitle2", self.GetInfoViewFeatureTipTitle2)
	self:RegisterApi("infoViewBtnSkillTxt", self.GetInfoViewBtnSkillTxt)
	self:RegisterApi("infoViewExpProgress", self.GetInfoViewExpProgress)
	self:RegisterApi("infoViewBtnTalentTitle_1", self.GetInfoViewBtnTalentTitle_1)
	self:RegisterApi("infoViewBtnTalentTitle_2", self.GetInfoViewBtnTalentTitle_2)
	self:RegisterApi("infoViewTalentProgress", self.GetInfoViewTalentProgress)
	self:RegisterApi("infoViewClassTipContent", self.GetInfoViewClassTipContent)
	self:RegisterApi("infoViewMemoryUnlockDesc", self.GetInfoViewMemoryUnlockDesc)
	self:RegisterApi("infoViewMemoryTotalCount", self.GetInfoViewMemoryTotalCount)
	self:RegisterApi("infoViewMemoryDesc", self.GetInfoViewMemoryDesc)
	self:RegisterApi("infoViewBtnSpiritTxt", self.GetInfoViewBtnSpiritTxt)
	self:RegisterApi("infoViewCvDesc", self.GetInfoViewCvDesc)
	self:RegisterApi("infoViewBtnJewelryLabel", self.GetinfoViewBtnJewelryLabel)
	self:RegisterApi("skillVieGroupName", self.GetSkillViewGroupName)
	self:RegisterApi("skillViewGroupUnlockCondition", self.GetSkillViewGroupUnlockCondition)
	self:RegisterApi("skillViewSkillLv", self.GetSkillViewSkillLv)
	self:RegisterApi("skillViewSkillSp", self.GetSkillViewSkillSp)
	self:RegisterApi("skillViewAttBlockTitle", self.GetSkillViewAttBlockTitle)
	self:RegisterApi("skillViewMoneyCount", self.GetSkillViewMoneyCount)
	self:RegisterApi("skillViewCondition", self.GetSkillViewCondition)
	self:RegisterApi("skillViewMaxDesc", self.GetSkillViewMaxDesc)
	self:RegisterApi("skillViewBtnUpTxt", self.GetSkillViewBtnUpTxt)
	self:RegisterApi("skillViewAttChangeDesc", self.GetSkillViewAttChangeDesc)
	self:RegisterApi("skillViewSkillDesc", self.GetSkillViewSkillDesc)
	self:RegisterApi("skillViewUnlockDescGroup3", self.GetSkillViewUnlockDescGroup3)
	self:RegisterApi("skillViewTipBtnJumpTxt", self.GetSkillViewTipBtnJumpTxt)
	self:RegisterApi("skillViewSpDesc", self.GetSkillViewSpDesc)
	self:RegisterApi("starViewBtnUpTxt", self.GetStarViewBtnUpTxt)
	self:RegisterApi("starViewMapPath", self.GetStarViewMapPath)
	self:RegisterApi("starViewMoneyNum", self.GetStarViewMoneyNum)
	self:RegisterApi("starViewMaxDesc", self.GetStarViewMaxDesc)
	self:RegisterApi("starViewFeatureTitle", self.GetStarViewFeatureTitle)
	self:RegisterApi("starViewFeatureName", self.GetStarViewFeatureName)
	self:RegisterApi("starViewAttDeltaDesc", self.GetStarViewAttDeltaDesc)
	self:RegisterApi("starViewGrowDeltaDesc", self.GetStarViewGrowDeltaDesc)
	self:RegisterApi("starViewGrowRateName", self.GetStarViewGrowRateName)
	self:RegisterApi("starViewDesc", self.GetStarViewDesc)
	self:RegisterApi("talentViewProgress", self.GetTalentViewProgress)
	self:RegisterApi("talentViewTalentAttDesc", self.GetTalentViewTalentAttDesc)
	self:RegisterApi("talentViewBtnActivateTalentTxt", self.GetTalentViewBtnActivateTalentTxt)
	self:RegisterApi("talentViewBtnActivateChapterTxt", self.GetTalentViewBtnActivateChapterTxt)
	self:RegisterApi("talentViewChapterAttDesc", self.GetTalentViewChapterAttDesc)
	self:RegisterApi("talentViewCondition", self.GetTalentViewCondition)
	self:RegisterApi("talentViewMaxDesc", self.GetTalentViewMaxDesc)
	self:RegisterApi("talentViewBgPath", self.GetTalentViewBgPath)
	self:RegisterApi("talentViewProgressTitle", self.GetTalentProgressTitle)
	self:RegisterApi("iconStarPath", self.GetIconStarPath)
	self:RegisterApi("talentBgPath", self.GetTalentBgPath)
	self:RegisterApi("talentFramePath1", self.GetTalentFramePath1)
	self:RegisterApi("talentFramePath2", self.GetTalentFramePath2)
	self:RegisterApi("talentIconPath1", self.GetTalentIconPath1)
	self:RegisterApi("talentIconPath2", self.GetTalentIconPath2)
	self:RegisterApi("talentNameBgPath", self.GetTalentNameBgPath)
	self:RegisterApi("talentGroupEffectNormal", self.GetTalentGroupEffectNormal)
	self:RegisterApi("talentEffectWaitToActive", self.GetTalentEffectWaitToActive)
	self:RegisterApi("talentGroupEffectUp", self.GetTalentGroupEffectUp)
	self:RegisterApi("attTipViewTitle1", self.GetAttTipViewTitle1)
	self:RegisterApi("attTipViewTitle2", self.GetAttTipViewTitle2)
	self:RegisterApi("attTipViewTitle3", self.GetAttTipViewTitle3)
	self:RegisterApi("attTipViewAttName", self.GetAttTipViewAttName)
	self:RegisterApi("attTipViewAttValue", self.GetAttTipViewAttValue)
	self:RegisterApi("attTipViewGrowUpName", self.GetAttTipViewGroupUpName)
	self:RegisterApi("attTipViewGrowUpValue", self.GetAttTipViewGrowUpValue)
	self:RegisterApi("attTipViewFeatureName", self.GetAttTipViewFeatureName)
	self:RegisterApi("attTipViewFeatureDesc", self.GetAttTipViewFeatureDesc)
	self:RegisterApi("attTipViewFeatureLockDesc", self.GetAttTipViewFeatureLockDesc)
	self:RegisterApi("cvFrameWidth", self.GetCVFrameWidth)
end

function SoulUIApi:GetinfoViewBtnJewelryLabel()
	return self:GetCfgText(1229119)
end

function SoulUIApi:GetAttTipViewTitle1()
	return self:GetCfgText(1228006)
end

function SoulUIApi:GetAttTipViewTitle2()
	return self:GetCfgText(1229090)
end

function SoulUIApi:GetAttTipViewTitle3()
	return self:GetCfgText(1229111)
end

function SoulUIApi:GetAttTipViewAttName(name)
	return name
end

function SoulUIApi:GetAttTipViewAttValue(value)
	return value
end

function SoulUIApi:GetAttTipViewGroupUpName(name)
	return name
end

function SoulUIApi:GetAttTipViewGrowUpValue(value)
	return value
end

function SoulUIApi:GetAttTipViewFeatureName(name, isUnlock)
	return name
end

function SoulUIApi:GetAttTipViewFeatureDesc(desc, isUnlock)
	desc = self:SkillValueColor(desc, 29)

	return desc
end

function SoulUIApi:GetAttTipViewFeatureLockDesc()
	return self:GetCfgText(1015021)
end

function SoulUIApi:GetTalentViewBgPath(index)
	return self:GetResUrl(1400014)
end

function SoulUIApi:GetTalentProgressTitle()
	return self:GetCfgText(1229107)
end

function SoulUIApi:GetSkillViewGroupName(name)
	return name
end

function SoulUIApi:GetSkillViewGroupUnlockCondition(lv)
	return string.format(self:GetCfgText(1227026), lv)
end

function SoulUIApi:GetSkillViewSkillLv(lv)
	if lv == 0 then
		return ""
	end

	return "+" .. tostring(lv)
end

function SoulUIApi:GetSkillViewSkillSp(value)
	if value == 0 then
		return "--"
	end

	return tostring(value)
end

function SoulUIApi:GetSkillViewAttBlockTitle()
	return self:GetCfgText(1229091)
end

function SoulUIApi:GetInfoViewLvTitle()
	return self:GetCfgText(1229092)
end

function SoulUIApi:GetInfoViewStarTitle()
	return self:GetCfgText(1229093)
end

function SoulUIApi:GetFeatureTitle()
	return self:GetCfgText(1229111)
end

function SoulUIApi:GetInfoViewFeatureUnlockDesc(isUnlock)
	if isUnlock then
		return ""
	else
		return self.TextColor[215] .. self:GetCfgText(1219009) .. self.TextColor[0]
	end
end

function SoulUIApi:GetInfoViewFeatureDesc(desc, isUnlock)
	if isUnlock then
		return self:SkillValueColor(desc, 29)
	else
		return self.TextColor[215] .. self:SkillValueColor(desc, 29) .. self.TextColor[0]
	end
end

function SoulUIApi:GetInfoViewFeatureTipTitle()
	return self:GetCfgText(1229094)
end

function SoulUIApi:GetInfoViewFeatureTipTitle2()
	return self:GetCfgText(1229095)
end

function SoulUIApi:GetInfoViewBtnSkillTxt()
	return self:GetCfgText(1227020)
end

function SoulUIApi:GetSkillViewBtnUpTxt()
	return self:GetCfgText(1226003)
end

function SoulUIApi:GetSkillViewMoneyCount(count, ownCount)
	if count < ownCount then
		return self.TextColor[207] .. tostring(ownCount) .. self.TextColor[0] .. "/" .. count
	else
		return self.TextColor[203] .. tostring(ownCount) .. self.TextColor[0] .. "/" .. count
	end
end

function SoulUIApi:GetSkillViewAttChangeDesc(name, value, id)
	return name .. "+" .. value * 100 .. "%"
end

function SoulUIApi:GetSkillViewCondition(unlockLv)
	return self.TextColor[203] .. self:GetCfgText(1226005) .. tostring(unlockLv) .. self.TextColor[0]
end

function SoulUIApi:GetSkillViewMaxDesc()
	return self:GetCfgText(1229096)
end

function SoulUIApi:GetStarViewBtnUpTxt()
	return self:GetCfgText(1229115)
end

function SoulUIApi:GetStarViewMapPath(soulCid)
	local soulRange

	soulRange = soulCid % 10000

	if soulRange < 10 then
		soulRange = "0" .. tostring(soulRange)
	else
		soulRange = tostring(soulRange)
	end

	return UIGlobalApi.GetPrefabRoot("/UI/_SoulUI/SoulEvolutionMould_" .. soulRange .. ".prefab")
end

function SoulUIApi:GetStarViewMoneyNum(needNum, ownNum)
	if needNum < ownNum then
		return self.TextColor[207] .. tostring(ownNum) .. self.TextColor[0] .. "/" .. needNum
	else
		return self.TextColor[203] .. tostring(ownNum) .. self.TextColor[0] .. "/" .. needNum
	end
end

function SoulUIApi:GetStarViewMaxDesc()
	return self:GetCfgText(1229097)
end

function SoulUIApi:GetStarViewFeatureTitle(index)
	return self.TextColor[12] .. self:GetCfgText(1229098) .. tostring(index) .. self.TextColor[0]
end

function SoulUIApi:GetStarViewFeatureName(name)
	return name
end

function SoulUIApi:GetStarViewAttDeltaDesc(name, value)
	return name .. " " .. self.TextColor[29] .. "+" .. tostring(value) .. self.TextColor[0]
end

function SoulUIApi:GetStarViewGrowDeltaDesc(name, value)
	return name .. " " .. self.TextColor[29] .. "+" .. tostring(value) .. self.TextColor[0]
end

function SoulUIApi:GetStarViewGrowRateName(type)
	if type == 1 then
		return self:GetCfgText(1229099)
	elseif type == 2 then
		return ""
	elseif type == 3 then
		return self:GetCfgText(1229100)
	elseif type == 4 then
		return ""
	elseif type == 5 then
		return self:GetCfgText(1229101)
	elseif type == 6 then
		return ""
	end
end

function SoulUIApi:GetStarViewDesc()
	return self:GetCfgText(1229102)
end

function SoulUIApi:GetUpViewUpBtnTxt()
	return self:GetCfgText(1221002)
end

function SoulUIApi:GetUpViewUpBtnTxtEng()
	return self:GetCfgText(1229103)
end

function SoulUIApi:GetUpViewLvBtnMaxTxt()
	return self:GetCfgText(1015189)
end

function SoulUIApi:GetUpViewLvBtnClearTxt()
	return self:GetCfgText(1214067)
end

function SoulUIApi:GetUpViewProgressSpeed()
	return 0.04
end

function SoulUIApi:GetUpViewItemQualityBg(quality)
	if quality == 1 then
		return self:GetResUrl(2000055)
	elseif quality == 2 then
		return self:GetResUrl(2000056)
	elseif quality == 3 then
		return self:GetResUrl(2000057)
	elseif quality == 4 then
		return self:GetResUrl(2000058)
	elseif quality == 5 then
		return self:GetResUrl(2000059)
	end
end

function SoulUIApi:GetTitleEng(type)
	return ""
end

function SoulUIApi:GetTitle(type)
	if type == 1 then
		return self:GetCfgText(1229092)
	elseif type == 2 then
		return self:GetCfgText(1229104)
	elseif type == 3 then
		return self:GetCfgText(1229093)
	elseif type == 4 then
		return self:GetCfgText(1227020)
	end
end

function SoulUIApi:GetTitleHelp(type)
	return ""
end

function SoulUIApi:GetSoulHeadIcon(soulCid)
	local soulRange = 2001000

	soulRange = soulRange + soulCid % 10000

	return self:GetResUrl(soulRange)
end

function SoulUIApi:GetBtnAttDetailTxt()
	return self:GetCfgText(1229105)
end

function SoulUIApi:GetUpViewAddExp(addExp)
	if addExp > 0 then
		return self.TextColor[207] .. self:Space(1) .. "+" .. addExp .. self.TextColor[0]
	else
		return ""
	end
end

function SoulUIApi:GetUpViewProgressDesc(curExp, needExp)
	if needExp == 0 then
		return self:Space(2) .. "--/--"
	end

	return self:Space(2) .. curExp .. self.TextColor[31] .. "/" .. needExp .. self.TextColor[0]
end

function SoulUIApi:GetUpViewProgressPercent(curExp, needExp)
	if needExp == 0 then
		return "100%"
	elseif curExp / needExp < 0.01 and curExp > 0 then
		return "1%"
	elseif curExp / needExp > 0.9 and curExp < 1 then
		return "99%"
	end

	return tostring(math.floor(curExp / needExp * 100 + 0.5)) .. "%"
end

function SoulUIApi:GetUpViewLvTitle()
	return self:GetCfgText(1015022)
end

function SoulUIApi:GetCVFrameWidth(uiName)
	if uiName == Constant.UIControllerName.MainUI then
		return 350
	else
		return 350
	end
end

function SoulUIApi:GetTalentViewChapterAttDesc(name, value)
	return name .. "\n+" .. tostring(value)
end

function SoulUIApi:GetTalentGroupEffectUp()
	return 9001141
end

function SoulUIApi:GetTalentEffectWaitToActive()
	return 9001142
end

function SoulUIApi:GetTalentGroupEffectNormal()
	return 9001140
end

function SoulUIApi:GetTalentIconPath2(index)
	index = math.ceil(index / 3)

	if index == 1 then
		return ""
	elseif index == 2 then
		return ""
	elseif index == 3 then
		return ""
	elseif index == 4 then
		return ""
	end
end

function SoulUIApi:GetTalentNameBgPath(index)
	index = math.ceil(index / 3)

	if index == 1 then
		return ""
	elseif index == 2 then
		return ""
	elseif index == 3 then
		return ""
	elseif index == 4 then
		return ""
	end
end

function SoulUIApi:GetTalentIconPath1(index)
	index = math.ceil(index / 3)

	if index == 1 then
		return ""
	elseif index == 2 then
		return ""
	elseif index == 3 then
		return ""
	elseif index == 4 then
		return ""
	end
end

function SoulUIApi:GetTalentFramePath2(index)
	index = math.ceil(index / 3)

	if index == 1 then
		return ""
	elseif index == 2 then
		return ""
	elseif index == 3 then
		return ""
	elseif index == 4 then
		return ""
	end
end

function SoulUIApi:GetTalentFramePath1(index)
	index = math.ceil(index / 3)

	if index == 1 then
		return ""
	elseif index == 2 then
		return ""
	elseif index == 3 then
		return ""
	elseif index == 4 then
		return ""
	end
end

function SoulUIApi:GetIconStarPath(index)
	index = math.ceil(index / 3)

	if index == 1 then
		return ""
	elseif index == 2 then
		return ""
	elseif index == 3 then
		return ""
	elseif index == 4 then
		return ""
	end
end

function SoulUIApi:GetTalentBgPath(index)
	index = math.ceil(index / 3)

	if index == 1 then
		return ""
	elseif index == 2 then
		return ""
	elseif index == 3 then
		return ""
	elseif index == 4 then
		return ""
	end
end

function SoulUIApi:GetTalentViewBtnActivateChapterTxt()
	return self:GetCfgText(1229056)
end

function SoulUIApi:GetTalentViewMaxDesc()
	return self:GetCfgText(1229057)
end

function SoulUIApi:GetTalentViewCondition(unlockLv)
	return "<color=#ff5757>" .. self:GetCfgText(1229058) .. tostring(unlockLv) .. "</color>"
end

function SoulUIApi:GetTalentViewTalentAttDesc(name, value)
	return name .. self:Space(1) .. "\n+" .. tostring(value)
end

function SoulUIApi:GetMoneyCost(costCount, ownCount)
	if costCount < ownCount then
		return self.TextColor[207] .. tostring(ownCount) .. self.TextColor[0] .. "/" .. costCount
	else
		return self.TextColor[203] .. tostring(ownCount) .. self.TextColor[0] .. "/" .. costCount
	end
end

function SoulUIApi:GetTalentViewProgress(cur, total)
	print(cur, total)

	local total = 30

	if cur == 0 then
		return "0%"
	elseif cur / total < 0.01 and cur > 0 then
		return "1%"
	elseif cur / total > 0.9 and cur < 1 then
		return "99%"
	end

	return tostring(math.floor(cur / total * 100 + 0.5)) .. "%"
end

function SoulUIApi:GetTalentViewBtnActivateTalentTxt()
	return self:GetCfgText(1229060)
end

function SoulUIApi:GetFightAttSort()
	return {
		7,
		9,
		10,
		11,
		14,
		22,
		24,
		26
	}
end

function SoulUIApi:GetBtnPrefabChangeTxt()
	return self:GetCfgText(1229012)
end

function SoulUIApi:GetSkillViewSkillDesc(skillTypeDesc, releaseTypeDesc, cdDesc, angerDesc)
	return skillTypeDesc .. " | " .. releaseTypeDesc .. " | " .. angerDesc
end

function SoulUIApi:GetSkillViewUnlockDescGroup3()
	return self:GetCfgText(1229112)
end

function SoulUIApi:GetSkillViewSpDesc()
	return self:GetCfgText(1229118)
end

function SoulUIApi:GetSkillViewTipBtnJumpTxt()
	return self:GetCfgText(1229113)
end

function SoulUIApi:GetAttNameEng(attType)
	return ""
end

function SoulUIApi:GetSoulAttIconPath(attType, isBlack)
	if isBlack then
		if attType == 7 then
			return self:GetResUrl(2000100)
		elseif attType == 9 then
			return self:GetResUrl(2000101)
		elseif attType == 10 then
			return self:GetResUrl(2000102)
		elseif attType == 11 then
			return self:GetResUrl(2000103)
		elseif attType == 14 then
			return self:GetResUrl(2000104)
		elseif attType == 22 then
			return self:GetResUrl(2000105)
		elseif attType == 24 then
			return self:GetResUrl(2000106)
		elseif attType == 26 then
			return self:GetResUrl(2000107)
		end
	elseif attType == 7 then
		return self:GetResUrl(2000041)
	elseif attType == 9 then
		return self:GetResUrl(2000042)
	elseif attType == 10 then
		return self:GetResUrl(2000043)
	elseif attType == 11 then
		return self:GetResUrl(2000044)
	elseif attType == 14 then
		return self:GetResUrl(2000045)
	elseif attType == 22 then
		return self:GetResUrl(2000046)
	elseif attType == 24 then
		return self:GetResUrl(2000047)
	elseif attType == 26 then
		return self:GetResUrl(2000048)
	end
end

function SoulUIApi:GetSoulName(name)
	return name
end

function SoulUIApi:GetSoulEnglishName(name)
	return name
end

function SoulUIApi:GetAttViewAttName(name)
	return name
end

function SoulUIApi:GetAttViewAttValue(value)
	return value
end

function SoulUIApi:GetMaxLv(lv)
	return "/" .. tostring(lv)
end

function SoulUIApi:GetImgLvPath(value)
	if value == 0 then
		return self:GetResUrl(2000090)
	elseif value == 1 then
		return self:GetResUrl(2000091)
	elseif value == 2 then
		return self:GetResUrl(2000092)
	elseif value == 3 then
		return self:GetResUrl(2000093)
	elseif value == 4 then
		return self:GetResUrl(2000094)
	elseif value == 5 then
		return self:GetResUrl(2000095)
	elseif value == 6 then
		return self:GetResUrl(2000096)
	elseif value == 7 then
		return self:GetResUrl(2000097)
	elseif value == 8 then
		return self:GetResUrl(2000098)
	elseif value == 9 then
		return self:GetResUrl(2000099)
	end
end

function SoulUIApi:GetInfoViewExpProgress(curExp, needExp)
	if needExp == 0 then
		return self:GetCfgText(1229116) .. "--/--"
	else
		return self:GetCfgText(1229116) .. self.TextColor[207] .. tostring(curExp) .. self.TextColor[0] .. "/" .. tostring(needExp)
	end
end

function SoulUIApi:GetInfoViewBtnTalentTitle_1()
	return self:GetCfgText(1229104)
end

function SoulUIApi:GetInfoViewBtnTalentTitle_2()
	return ""
end

function SoulUIApi:GetInfoViewTalentProgress(cur, total)
	local total = 30
	local talentprogress = ""

	talentprogress = cur == 0 and "0%" or cur / total < 0.01 and cur > 0 and "1%" or cur / total > 0.9 and cur < 1 and "99%" or tostring(math.floor(cur / total * 100 + 0.5)) .. "%"

	return self:GetCfgText(1229107) .. talentprogress
end

function SoulUIApi:GetInfoViewClassTipContent(type)
	if type == 1 then
		return self:GetCfgText(1229108)
	elseif type == 2 then
		return self:GetCfgText(1229109)
	elseif type == 3 then
		return self:GetCfgText(1229110)
	end
end

function SoulUIApi:GetInfoViewMemoryUnlockDesc(count)
	if count < 10 then
		return "0" .. count
	else
		return count
	end
end

function SoulUIApi:GetInfoViewMemoryTotalCount(count)
	return "/" .. count
end

function SoulUIApi:GetInfoViewMemoryDesc()
	return self:GetCfgText(1229114)
end

function SoulUIApi:GetInfoViewBtnSpiritTxt()
	return self:GetCfgText(1229904)
end

function SoulUIApi:GetInfoViewCvDesc()
	return self:GetCfgText(1229117) .. ":"
end

function SoulUIApi:GetInfoViewAttName(name)
	return name
end

function SoulUIApi:GetCvName(name)
	return name
end

function SoulUIApi:GetInfoViewFeatureName(name, isUnlock, unlockStar)
	if isUnlock then
		return name
	else
		return name .. "（" .. unlockStar
	end
end

function SoulUIApi:GetInfoViewFeatureName2()
	return self:GetCfgText(1229114)
end

function SoulUIApi:GetFeatureInfoViewFeatureName(name, isUnlock)
	return name
end

function SoulUIApi:GetViewTitle()
	return self:GetCfgText(1229054)
end

SoulUIApi:Init()
