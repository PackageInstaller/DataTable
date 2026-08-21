-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/setting/BattleUISettingUtil.lua

module("logic.battle.battleflow.setting.BattleUISettingUtil", package.seeall)

local BattleUISettingUtil = {}

function BattleUISettingUtil.getSceneBloodColor(campId)
	local settingCO = BattleUISettings.getCampSettingCO(campId)

	return settingCO.sceneUIBloodColor
end

function BattleUISettingUtil.getSceneBloodHeadColor(campId)
	local settingCO = BattleUISettings.getCampSettingCO(campId)

	return settingCO.sceneUIBloodHeadColor
end

function BattleUISettingUtil.getUIBloodColor(campId)
	local settingCO = BattleUISettings.getCampSettingCO(campId)

	return settingCO.uiBloodColor
end

function BattleUISettingUtil.getUIBloodBgColor(campId)
	local settingCO = BattleUISettings.getCampSettingCO(campId)

	return settingCO.uiBloodBgColor
end

function BattleUISettingUtil.getUINameBgColor(campId)
	local settingCO = BattleUISettings.getCampSettingCO(campId)

	return settingCO.nameBgColor
end

function BattleUISettingUtil.getUINameColor(campId)
	local settingCO = BattleUISettings.getCampSettingCO(campId)

	return settingCO.nameColor
end

function BattleUISettingUtil.getPropertyUIUrl(campId, isComposite)
	local settingCO = BattleUISettings.getCampSettingCO(campId)

	return isComposite and settingCO.bossPropertyUIUrl or settingCO.propertyUIUrl
end

function BattleUISettingUtil.getPropertyBottomUIUrl(campId, isComposite)
	local settingCO = BattleUISettings.getCampSettingCO(campId)

	return isComposite and settingCO.bossPropertyBottomUIUrl or settingCO.propertyBottomUIUrl
end

function BattleUISettingUtil.getRelationType(campId)
	local settingCO = BattleUISettings.getCampSettingCO(campId)

	return settingCO.relationType
end

return BattleUISettingUtil
