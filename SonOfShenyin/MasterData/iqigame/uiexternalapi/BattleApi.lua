-- chunkname: @IQIGame\\UIExternalApi\\BattleApi.lua

BattleApi = BaseLangApi:Extend()

function BattleApi:GetTimelineUrl(timelineName)
	return string.format("Assets/03_Prefabs/%s.prefab", timelineName)
end

function BattleApi:GetTimelineEffectPath(isFriendly)
	return self:GetResUrl(isFriendly and 1100021 or 1100022)
end

function BattleApi:GetTimelineEffectUrl(name, isFriendly)
	return string.format(self:GetResUrl(isFriendly and 1100021 or 1100022), name)
end

function BattleApi:GetTimelinePrefabUrl(timelinePrefabName)
	return string.format(self:GetResUrl(1100023), timelinePrefabName)
end

function BattleApi:GetPostProcessPrefabUrl(prefabName)
	return UIGlobalApi.ArtPrefabRootPath .. prefabName .. ".prefab"
end

function BattleApi:GetBehaviorUrl(name)
	return string.format(self:GetResUrl(1100029), name)
end

function BattleApi:GetEffectUrl(effectPrefabName)
	return string.format("Assets/03_Prefabs/%s.prefab", effectPrefabName)
end

function BattleApi:GetDamageEffectUrl(effectPrefabName)
	return string.format("Assets/03_Prefabs/Battle/Effect/DamageEffect/%s.prefab", effectPrefabName)
end

function BattleApi:GetAttributeIconUrl(name)
	return string.format(self:GetResUrl(1100028), name)
end

function BattleApi:GetElementShieldUrl(elementType)
	return string.format(self:GetResUrl(1100026), elementType)
end

function BattleApi:GetSpinePrefabUrl(prefabName)
	return string.format(self:GetResUrl(1100027), prefabName)
end

function BattleApi:GetSceneRenderConfigUrl(sceneID)
	return string.format(self:GetResUrl(1100030), CfgSceneListTable[sceneID].RenderConfig)
end

function BattleApi:GetSceneRenderConfigPath(renderConfig)
	return string.format(self:GetResUrl(1100030), renderConfig)
end

function BattleApi:GetSpecialBuffIcon(tagId)
	if tagId == 501 then
		return "Assets/05_Images/Icon/Attribute/Buff_ZhangQi.png"
	elseif tagId == 502 then
		return "Assets/05_Images/Icon/Attribute/Buff_ZhangQi.png"
	elseif tagId == 503 then
		return "Assets/05_Images/Icon/Attribute/Buff_ZhangQi.png"
	elseif tagId == 504 then
		return "Assets/05_Images/Icon/Attribute/Buff_ZhangQi.png"
	elseif tagId == 505 then
		return "Assets/05_Images/Icon/Attribute/Buff_ZhangQi.png"
	end

	return "Assets/05_Images/Icon/Attribute/Buff_ZhangQi.png"
end

function BattleApi:GetTerrainEffectUrl(effectCid)
	local effectConfig = CfgEffectTable[effectCid]

	if effectConfig == nil then
		return ""
	end

	local effectEntityConfig = CfgEffectEntityTable[effectConfig.EntityID]

	if effectEntityConfig == nil then
		return ""
	end

	return self:GetEffectUrl(effectEntityConfig.PrefabName)
end

function BattleApi:GetMonsterHeadIconPath(headIcon)
	return string.format(self:GetResUrl(1600012), headIcon)
end

function BattleApi:GetMonsterBustPath(monsterCid)
	if type(monsterCid) == "string" then
		monsterCid = tonumber(monsterCid)
	end

	local monsterConfig = CfgMonsterTable[monsterCid]

	if monsterConfig ~= nil then
		return string.format(self:GetResUrl(1600013), monsterConfig.bust)
	else
		logError("BattleApi:GetMonsterBustPath : monsterCid={0} is invalid.", monsterCid)
	end

	return ""
end

function BattleApi:GetBattleDialogPicture(name)
	return "Assets/05_Images/DataResource/RoleResources/HeroResource" .. name .. ".png"
end

function BattleApi:GetBattleActionButtonSelectTargetYValue()
	return 15
end

function BattleApi:GetBattleActionButtonSelectTargetScaleValue(isSelect)
	return isSelect and Vector3.New(1.2, 1.2, 1.2) or Vector3.one
end

function BattleApi:GetTileBlockImage(isPlayer)
	if isPlayer then
		return "Assets/05_Images/DataResource/BattleResource/Ground/friendlyGround.png"
	else
		return "Assets/05_Images/DataResource/BattleResource/Ground/enemyGround.png"
	end
end

function BattleApi:GetWakeBreakEffectID()
	return 80044
end

function BattleApi:GetWakeBreakSoundID()
	return 21100001
end

function BattleApi:GetHeroMoveHalfTimer()
	return 0.25
end

function BattleApi:GetHeroMoveTimer()
	return 0.5
end

function BattleApi:BattleUnitSelectTargetSoundID()
	return 11400002
end

function BattleApi:BattleUnitSetTurnOrderSoundID()
	return 11400002
end

function BattleApi:BattleStartSoundID()
	return 11400003
end

function BattleApi:BattleAttackTurnStartSoundID()
	return 11400004
end

function BattleApi:BattleDefineTurnStartSoundID()
	return 11400004
end

function BattleApi:BattleActorStandbyTimer()
	return 15
end

function BattleApi:NeedShowSkillAreaWarning(battleSkillData)
	if battleSkillData.skillType == Constant.SkillType.TYPE_ULTIMATE then
		return true
	end

	return false
end

function BattleApi:ShowSkillAreaWarningSecond()
	return 0.5
end

function BattleApi:GetMonsterElementPath(elementType)
	return string.format(self:GetResUrl(17001), elementType)
end

function BattleApi:GetBattleLineSampPos(startTileIndex, startPos, endTileIndex, endPos)
	local result = Vector3.New(0, 7, 0)

	result.x = (startPos.x + endPos.x) / 2

	local distance = math.sqrt((startPos.x - endPos.x) * (startPos.x - endPos.x) + (startPos.z - endPos.z) * (startPos.z - endPos.z))

	result.y = (distance - 1.85) / 12.73 * 3.5 + 3.5

	if startPos.x > 0 and endPos.x < 0 then
		result.y = result.y * 0.9
	end

	return result
end
