-- chunkname: @IQIGame\\UIExternalApi\\RoleDevelopmentApi.lua

RoleDevelopmentApi = BaseLangApi:Extend()

function RoleDevelopmentApi:GetCurExpText(curExp, MaxExp)
	return curExp .. string.format(ColorCfg.RoleUpdate.gray, "/" .. MaxExp)
end

function RoleDevelopmentApi:GetBreachStateImg(breachLv)
	return string.format(self:GetResUrl(1700002), breachLv)
end

function RoleDevelopmentApi:GetNextBreachStateImg(breachLv)
	return string.format(self:GetResUrl(1700006), breachLv)
end

function RoleDevelopmentApi:GetPreviewBreachStateImg(breachLv)
	return string.format(self:GetResUrl(1700101), breachLv)
end

function RoleDevelopmentApi:GetNoPreviewBreachStateImg(breachLv)
	return string.format(self:GetResUrl(1700102), breachLv)
end

function RoleDevelopmentApi:GetBreachFontImg(breachLv)
	return string.format(self:GetResUrl(1700003), breachLv)
end

function RoleDevelopmentApi:GetNextBreachFontImg(breachLv)
	return string.format(self:GetResUrl(1700001), breachLv)
end

function RoleDevelopmentApi:GetNextBreachFontImg1(breachLv)
	return string.format(self:GetResUrl(1001), breachLv)
end

function RoleDevelopmentApi:GetSkillBreachLvImg(strengthLv)
	return string.format(self:GetResUrl(1100040), strengthLv)
end

function RoleDevelopmentApi:GetSkillExp(exp, needexp)
	return exp .. self.TextColor[1] .. "/" .. needexp .. self.TextColor[0]
end

function RoleDevelopmentApi:GetSkillBreachLvImg(strengthLv)
	return string.format(self:GetResUrl(1100040), strengthLv)
end

function RoleDevelopmentApi:GetPersonalityLvImg(lv)
	return string.format(self:GetResUrl(1700004), lv)
end

function RoleDevelopmentApi:GetSkillQualityBg(quality)
	return string.format(self:GetResUrl(1700005), quality)
end

function RoleDevelopmentApi:GetRoleStarImg(lv)
	return string.format(self:GetResUrl(1700007), lv)
end

function RoleDevelopmentApi:GetRoleStarQualityImg(lv)
	return string.format(self:GetResUrl(1700008), lv)
end

function RoleDevelopmentApi:GetSkillCostStr(cost)
	return self:GetCfgText(6050009)
end

function RoleDevelopmentApi:GetColorStr(type, str)
	local strs = ""

	if type == 1 then
		strs = self.TextColor[3] .. str
	elseif type == 2 then
		strs = self.TextColor[4] .. str
	elseif type == 3 then
		strs = self.TextColor[1] .. str
	end

	return strs .. self.TextColor[0]
end

function RoleDevelopmentApi:GetSkillDescValue(str)
	return self:SkillValueColor(str, 2)
end

function RoleDevelopmentApi:GetSkillAttrColor(str, isHas)
	if isHas then
		str = self.TextColor[5] .. str .. self.TextColor[0]
	else
		str = self.TextColor[4] .. str .. self.TextColor[0]
	end

	return str
end

function RoleDevelopmentApi:GetBreakIconPath(BreakLv)
	return string.format(self:GetResUrl(1400003), BreakLv)
end

function RoleDevelopmentApi:GetSmartIcon(cid)
	return string.format(self:GetResUrl(1100003), cid)
end

function RoleDevelopmentApi:GetItemIipsDesc(tipsId)
	return self:GetCfgText(tipsId)
end

function RoleDevelopmentApi:GetMaxText()
	return self:GetCfgText(200001)
end

function RoleDevelopmentApi:GetLvFormat(lv)
	return self:GetCfgText(6000035) .. lv
end

function RoleDevelopmentApi:GetAttarTitle()
	return self:GetCfgText(200002)
end

function RoleDevelopmentApi:GetSkillType(skillType)
	if skillType == Constant.SkillType.TYPE_NORMAL then
		return self:GetCfgText(2001001)
	elseif skillType == Constant.SkillType.TYPE_ULTIMATE then
		return self:GetCfgText(2001002)
	elseif skillType == Constant.SkillType.TYPE_PASSIVE then
		return self:GetCfgText(2001003)
	elseif skillType == Constant.SkillType.TYPE_DISPLACEMENT then
		return self:GetCfgText(2001013)
	end

	return self:GetCfgText(skillType + 2001000)
end

function RoleDevelopmentApi:GetSkillShowType(skillShowType)
	return self:GetCfgText(skillShowType + 6090000)
end

function RoleDevelopmentApi:GetNotReachTitle(lv)
	return string.format(self:GetCfgText(2001006), lv)
end

function RoleDevelopmentApi:GetStrengthBtnTitle()
	return self:GetCfgText(6000006)
end

function RoleDevelopmentApi:GetBreachBtnTitle()
	return self:GetCfgText(200003)
end

function RoleDevelopmentApi:GetUpgradeBtnTitle()
	return self:GetCfgText(200004)
end

function RoleDevelopmentApi:GetReplaceBtnText()
	return self:GetCfgText(6000034)
end

function RoleDevelopmentApi:GetUnLoadTitle()
	return self:GetCfgText(6000005)
end

function RoleDevelopmentApi:GetSkillEffectitle()
	return self:GetCfgText(200005)
end

function RoleDevelopmentApi:GetCurEffectTitle()
	return self:GetCfgText(200006)
end

function RoleDevelopmentApi:GetNextEffectTitle()
	return self:GetCfgText(200007)
end

function RoleDevelopmentApi:GetCDTitle()
	return self:GetCfgText(200008)
end

function RoleDevelopmentApi:GetAPTitle()
	return self:GetCfgText(6000026)
end

function RoleDevelopmentApi:GetRangeTitle()
	return self:GetCfgText(6050004)
end

function RoleDevelopmentApi:GetElementTitle()
	return self:GetCfgText(1960005)
end

function RoleDevelopmentApi:GetCostTitle()
	return self:GetCfgText(200009)
end

function RoleDevelopmentApi:GetBreachTitle()
	return self:GetCfgText(200010)
end

function RoleDevelopmentApi:GetLvTitle()
	return self:GetCfgText(6000035)
end

function RoleDevelopmentApi:GetAttrTitle()
	return self:GetCfgText(200011)
end

function RoleDevelopmentApi:GetSkillInfoDescTitle()
	return self:GetCfgText(200005)
end

function RoleDevelopmentApi:GetConditionTitle()
	return self:GetCfgText(200012)
end

function RoleDevelopmentApi:GetEquipedText()
	return self:GetCfgText(2000003)
end

function RoleDevelopmentApi:GetEquipHeroDesc(heroName)
	return string.format(self:GetCfgText(2001011), heroName)
end

function RoleDevelopmentApi:GetQuickAddBtnText()
	return self:GetCfgText(6000027)
end

function RoleDevelopmentApi:GetBreachLevelTitle()
	return self:GetCfgText(200002)
end

function RoleDevelopmentApi:GetIsStrengthTitle()
	return self:GetCfgText(200013)
end

function RoleDevelopmentApi:GetAllToggleText()
	return self:GetCfgText(9050005)
end

function RoleDevelopmentApi:GetEquipedToggleText()
	return self:GetCfgText(6000016)
end

function RoleDevelopmentApi:GetNoneSkillTitle()
	return self:GetCfgText(200014)
end

function RoleDevelopmentApi:GetLvIsNoReachTitle(lv)
	return string.format(self:GetCfgText(2001007), lv)
end

function RoleDevelopmentApi:GetSkillOpenConditionText(lv)
	return string.format(self:GetCfgText(2001009), lv)
end

function RoleDevelopmentApi:GetCDAddContentText(cd)
	return cd .. self:GetCfgText(2001008)
end

function RoleDevelopmentApi:GetCritText(crit)
	return self:GetCfgText(200015) .. crit
end

function RoleDevelopmentApi:GetLvText()
	return self:GetCfgText(6000035)
end

function RoleDevelopmentApi:GetSreenTextList()
	return {
		self:GetCfgText(1000001),
		self:GetCfgText(1000002)
	}
end

function RoleDevelopmentApi:GetSkillScreenTextList()
	return {
		self:GetCfgText(200016),
		self:GetCfgText(1000001),
		self:GetCfgText(1000002)
	}
end

function RoleDevelopmentApi:GetSkillTextColorStr(type, str)
	local strs = ""

	if type == 1 then
		strs = self.TextColor[7] .. str
	elseif type == 2 then
		strs = self.TextColor[8] .. str
	elseif type == 3 then
		strs = self.TextColor[4] .. str
	end

	return strs .. self.TextColor[0]
end

function RoleDevelopmentApi:GetPersonalityText(personalityLv)
	if personalityLv == 1 then
		return self:GetCfgText(1)
	elseif personalityLv == 2 then
		return self:GetCfgText(2)
	elseif personalityLv == 3 then
		return self:GetCfgText(3)
	elseif personalityLv == 4 then
		return self:GetCfgText(4)
	elseif personalityLv == 5 then
		return self:GetCfgText(5)
	elseif personalityLv == 6 then
		return self:GetCfgText(6)
	else
		return ""
	end
end

function RoleDevelopmentApi:GetLvNotReached(lv)
	return string.format(self:GetCfgText(2000006), lv)
end

function RoleDevelopmentApi:GetSkillUpgradeLevelLimitText(level)
	return string.format(self:GetCfgText(2001007), tostring(level))
end

function RoleDevelopmentApi:GetDIYSkillLockedTips(limitLV)
	return string.format("技能位置 %s 级开启", limitLV)
end

function RoleDevelopmentApi:GetRefineMaxText()
	return "-已达到升星上限-"
end

function RoleDevelopmentApi:GetStarConfirmText()
	return "升星"
end

function RoleDevelopmentApi:GetConsumMaterialTitleText()
	return "所需素材"
end

function RoleDevelopmentApi:GetPresentStarTitleText()
	return "星级"
end

function RoleDevelopmentApi:GetSkillQualityAndTypeImgPath(quality, type)
	return string.format(self:GetResUrl(2006), quality, type)
end

function RoleDevelopmentApi:GetSkillCostIsOverflow(isOverflow, cost)
	if isOverflow then
		return string.format(ColorCfg.Red, cost)
	else
		return string.format(ColorCfg.LightBlue, cost)
	end
end

function RoleDevelopmentApi:GetSkillElementImgPath(element)
	return string.format(self:GetResUrl(17001), element)
end

function RoleDevelopmentApi:GetRoleListIconBackground(roleQuality)
	if roleQuality == 5 then
		return "Assets/05_Images/UI/RoleCultivatePart/RoleMould/RoleDevelopmentPanel/RoleDevelopmentPanel_RoleList_Frame_1.png", "Assets/05_Images/UI/RoleCultivatePart/RoleMould/RoleDevelopmentPanel/RoleDevelopmentPanel_RoleList_Check_1.png"
	else
		return "Assets/05_Images/UI/RoleCultivatePart/RoleMould/RoleDevelopmentPanel/RoleDevelopmentPanel_RoleList_Frame_2.png", "Assets/05_Images/UI/RoleCultivatePart/RoleMould/RoleDevelopmentPanel/RoleDevelopmentPanel_RoleList_Check_2.png"
	end
end

function RoleDevelopmentApi:GetRoleWarehouseItemBackground(roleQuality)
	if roleQuality == 5 then
		return "Assets/05_Images/UI/RoleCultivatePart/RoleMould/RoleDevelopmentPanel/RoleWarehouse_Frame_2.png"
	else
		return "Assets/05_Images/UI/RoleCultivatePart/RoleMould/RoleDevelopmentPanel/RoleWarehouse_Frame_1.png"
	end
end

function RoleDevelopmentApi:GetRoleWarehouseItemRoleLv(roleLv)
	return string.format(self:GetCfgText(120006), roleLv)
end

function RoleDevelopmentApi:GetPromoteStrNotIncludNext(current)
	return "<color=#ff9845>" .. current .. "</color>"
end

function RoleDevelopmentApi:GetPromoteStr(current, next)
	return "<color=#ff9845>" .. current .. "</color><color=#92c74f>->" .. next .. "</color>"
end

function RoleDevelopmentApi:GetSkillNameByQuality(name, quality)
	if quality == 3 then
		return "<color=#6f8bfe>" .. name .. "</color>"
	elseif quality == 4 then
		return "<color=#a765e6>" .. name .. "</color>"
	elseif quality == 5 then
		return "<color=#ff9845>" .. name .. "</color>"
	end

	return "<color=#6f8bfe>" .. name .. "</color>"
end

function RoleDevelopmentApi:GetSkillNameBGByQuality(quality)
	return string.format("Assets/05_Images/UI/RoleCultivatePart/RoleMould/RoleDevelopmentPanel/Diyskill_Quality_Name_%s.png", quality)
end

function RoleDevelopmentApi:GetSkillTagBGByQuality(quality)
	return string.format("Assets/05_Images/UI/RoleCultivatePart/RoleMould/RoleDevelopmentPanel/Diyskill_Quality_Frame_%s.png", quality)
end

function RoleDevelopmentApi:GetRoleUpgradeViewPreviewAttrEffect(index)
	local _index = index + 2

	return string.format("Assets/03_Prefabs/Effect/FX_UI/FX_UI_saoguang_0%s.prefab", _index)
end
