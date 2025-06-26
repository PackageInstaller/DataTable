-- chunkname: @IQIGame\\UIExternalApi\\BattleUIApi.lua

BattleUIApi = BaseLangApi:Extend()

function BattleUIApi:GetSkillTypeTips(skillType)
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

function BattleUIApi:GetConfirmTips(isConfirm)
	return self:GetCfgText(isConfirm and 3060002 or 3060003)
end

function BattleUIApi:GetRoundTips()
	return self:GetCfgText(2001008)
end

function BattleUIApi:GetAutoTips(isAuto)
	return self:GetCfgText(isAuto and 6050011 or 6050010)
end

function BattleUIApi:GetProfessionUrl(imageName)
	return string.format(self:GetResUrl(1100025), imageName)
end

function BattleUIApi:GetBattleUIRestActionImageUrl()
	return self:GetResUrl(1100031)
end

function BattleUIApi:GetBattleUIMoveActionImageUrl()
	return self:GetResUrl(1100031)
end

function BattleUIApi:GetBattleUnitViewName(isFriendly)
	return isFriendly and self:GetCfgText(6050013) or self:GetCfgText(6050014)
end

function BattleUIApi:GetFightEndStepText()
	return self:GetCfgText(6050015)
end

function BattleUIApi:GetFightStartStepText()
	return self:GetCfgText(6050016)
end

function BattleUIApi:GetDIYSkillQualityImg(quality)
	return string.format(BaseLangApi:GetResUrl(2400), quality)
end

function BattleUIApi:GetBattleActionOrderText(order)
	if order == 1 then
		return self:GetCfgText(1)
	elseif order == 2 then
		return self:GetCfgText(2)
	elseif order == 3 then
		return self:GetCfgText(3)
	elseif order == 4 then
		return self:GetCfgText(4)
	elseif order == 5 then
		return self:GetCfgText(5)
	elseif order == 6 then
		return self:GetCfgText(6)
	elseif order == 7 then
		return self:GetCfgText(7)
	elseif order == 8 then
		return self:GetCfgText(8)
	elseif order == 9 then
		return self:GetCfgText(9)
	elseif order == 10 then
		return self:GetCfgText(10)
	end

	return self:GetCfgText(11)
end

function BattleUIApi:GetSpeedText(speed)
	if speed == 1 then
		return string.format("<color=#b3b3b3>%d</color>", speed)
	end

	return string.format("<color=#9B63DB>%d</color>", speed)
end

function BattleUIApi:GetSpeedTextX(speed)
	if speed == 1 then
		return "<color=#b3b3b3>x</color>"
	end

	return "<color=#9B63DB>x</color>"
end

function BattleUIApi:GetSKillNotifySkillTypeTips(cfgId)
	return self:GetCfgText(2004000 + cfgId)
end

function BattleUIApi:GetBuffPropertyTipsText(updateType, buffName)
	if updateType == 1 then
		return buffName
	elseif updateType == 2 then
		return self:GetCfgText(2003002) .. buffName
	elseif updateType == 3 then
		return self:GetCfgText(2003003) .. buffName
	elseif updateType == 4 then
		return self:GetCfgText(2003004) .. buffName
	elseif updateType == 5 then
		return self:GetCfgText(2003005) .. buffName
	end

	return buffName
end

function BattleUIApi:GetWakeIcon(icon)
	return string.format(self:GetResUrl(1100028), icon)
end

function BattleUIApi:GetHPImage(isPlayer)
	if isPlayer then
		return self:GetResUrl(2404)
	end

	return self:GetResUrl(2403)
end

function BattleUIApi:GetHpColor(isPlayer)
	if isPlayer then
		return UnityEngine.Color.New(0.525, 0.905, 0.388, 1)
	end

	return UnityEngine.Color.New(0.867, 0.29, 0.29, 1)
end

function BattleUIApi:GetHpTweenColor(isPlayer)
	if isPlayer then
		return UnityEngine.Color.New(1, 0.931, 0.306, 1)
	end

	return UnityEngine.Color.New(1, 0.931, 0.306, 1)
end

function BattleUIApi:GetShieldColor(isPlayer)
	if isPlayer then
		return UnityEngine.Color.New(1, 1, 1, 1)
	end

	return UnityEngine.Color.New(1, 1, 1, 1)
end

function BattleUIApi:GetUltimateSkillShaderColor(elementType)
	if elementType == 1 then
		return Color.New(0.223, 0.749, 0.609, 1)
	elseif elementType == 2 then
		return Color.New(0.749, 0.223, 0.235, 1)
	elseif elementType == 3 then
		return Color.New(0.472, 0.223, 0.749, 1)
	elseif elementType == 4 then
		return Color.New(0.322, 0.447, 0.735, 1)
	else
		return Color.New(1, 1, 1, 1)
	end
end

function BattleUIApi:GetBattleTeamActionUnitItemViewScale()
	return 1.12
end

function BattleUIApi:GetUltimateSkillEffectMaxFillAmount()
	return 0.8
end

function BattleUIApi:GetMultipleWaveText(wave, maxWave)
	return string.format(self:GetCfgText(6070002), wave, maxWave)
end

function BattleUIApi:GetMonsterReserveNumText(isMultiple, monsterNum)
	if isMultiple then
		return string.format(self:GetCfgText(6070000), monsterNum)
	else
		return string.format(self:GetCfgText(6070001), monsterNum)
	end
end

function BattleUIApi:GetBattleDialogTextSpeed()
	return 0.1
end

function BattleUIApi:GetBattleDialogTextDuration()
	return 0.1
end

function BattleUIApi:GetBattleDialogTextUseTimeScale()
	return false
end

function BattleUIApi:GetDamageImmunityText()
	return "免疫"
end

function BattleUIApi:GetDamageDodgeText()
	return "闪避"
end

function BattleUIApi:GetCutinElementImgBG(elementType)
	return string.format(self:GetResUrl(2407), elementType)
end

function BattleUIApi:GetCutinElementImgBig(elementType)
	return string.format(self:GetResUrl(2408), elementType)
end

function BattleUIApi:GetCutinElementImgSmall(elementType)
	return string.format(self:GetResUrl(2409), elementType)
end

function BattleUIApi:GetCutinElementImgWord(elementType)
	return string.format(self:GetResUrl(2410), elementType)
end

function BattleUIApi:GetCutinEffectAnimName()
	return "CutinRoot"
end

function BattleUIApi:GetWakeChangeEffectAnimName()
	return "FX_UI_Weak_Change"
end

function BattleUIApi:GetGuideUITabIndexCorrespondingType(index)
	if index == 1 then
		return {
			1,
			2,
			3
		}
	elseif index == 2 then
		return {
			1
		}
	elseif index == 3 then
		return {
			2
		}
	elseif index == 4 then
		return {
			3
		}
	end
end

function BattleUIApi:GetGuideUIMouldNameByType(guideType)
	if guideType == 1 then
		return "Mould1"
	elseif guideType == 2 then
		return "Mould2"
	elseif guideType == 3 then
		return "Mould3"
	else
		logError("战斗引导界面类型错误 {0}", guideType)
	end

	return ""
end

function BattleUIApi:GetGuideUIImagePath(imgPath)
	return string.format("Assets/05_Images/UI/BattleGuide/%s.png", imgPath)
end

function BattleUIApi:GetSkillCanNotSelectTargetNoticeCid()
	return 49012
end

function BattleUIApi:GetBuffLeftCountText(leftCount)
	return string.format("剩余%s回合", leftCount)
end

function BattleUIApi:GetBattleDamagePopupDetail()
	return 0.15
end

function BattleUIApi:GetChallengeWorldBossNameText(bossLevel, bossName)
	return "LV." .. bossLevel .. " " .. bossName
end
