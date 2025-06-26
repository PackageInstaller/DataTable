-- chunkname: @IQIGame\\UIExternalApi\\MainUIAPI.lua

MainUIAPI = BaseLangApi:Extend()

function MainUIAPI:FormatDayTime(month, day)
	return month .. self:GetCfgText(1010014) .. day .. self:GetCfgText(1010015)
end

function MainUIAPI:FormatWeek(week)
	if week == "1" then
		return self:GetCfgText(1300051)
	elseif week == "2" then
		return self:GetCfgText(1300052)
	elseif week == "3" then
		return self:GetCfgText(1300053)
	elseif week == "4" then
		return self:GetCfgText(1300054)
	elseif week == "5" then
		return self:GetCfgText(1300055)
	elseif week == "6" then
		return self:GetCfgText(1300056)
	elseif week == "0" then
		return self:GetCfgText(1300057)
	end
end

function MainUIAPI:GetVirtualCameraPath()
	return "/UI/_Main/mainCityCamera.prefab"
end

function MainUIAPI:GetPlayerSpinePath(playerEntityId)
	return "/" .. CfgElementEntityTable[playerEntityId].PrefabName .. ".prefab"
end

function MainUIAPI:GetLotteryTitle()
	return self:GetCfgText(1300058)
end

function MainUIAPI:GetActivityTitle()
	return self:GetCfgText(1300059)
end

function MainUIAPI:GetShopTiltle()
	return self:GetCfgText(1300007)
end

function MainUIAPI:GetFormationTitle()
	return self:GetCfgText(1300013)
end

function MainUIAPI:GetWarehouseTitle()
	return self:GetCfgText(1300011)
end

function MainUIAPI:GetPassTitle()
	return self:GetCfgText(1300060)
end

function MainUIAPI:GetTaskTitle()
	return self:GetCfgText(1300004)
end

function MainUIAPI:GetTaskManualTitle()
	return self:GetCfgText(1300066)
end

function MainUIAPI:GetHomeTitle()
	return self:GetCfgText(1300061)
end

function MainUIAPI:GetHeroTitle()
	return self:GetCfgText(1300009)
end

function MainUIAPI:GetCopyTitle()
	return self:GetCfgText(1010004)
end

function MainUIAPI:GetHeroEnTitle()
	return self:GetCfgText(1300062)
end

function MainUIAPI:GetTaskEnTitle()
	return self:GetCfgText(1300063)
end

function MainUIAPI:GetHomeEnTitle()
	return self:GetCfgText(1300064)
end

function MainUIAPI:GetNetworkName()
	return self:GetCfgText(1300018)
end

function MainUIAPI:GetSwitchRoleDisplayFailNoticeCid()
	return 51023
end

function MainUIAPI:GetGreetingType(hour)
	if hour >= 7 and hour < 9 then
		return 1
	end

	if hour >= 12 and hour < 14 then
		return 2
	end

	if hour >= 18 and hour < 22 then
		return 3
	end

	if hour >= 0 and hour < 4 then
		return 4
	end

	return 0
end

function MainUIAPI:GetTagIconPath(type)
	if type == Constant.RPGTagType.MainTag then
		return "Assets/05_Images/UI/Rpg/RpgWorldArea/Rpg_Map_icon_4.png"
	elseif type == Constant.RPGTagType.BranchTag then
		return "Assets/05_Images/UI/Rpg/RpgWorldArea/Rpg_Map_icon_5.png"
	elseif type == Constant.RPGTagType.BranchTag_RPG then
		return "Assets/05_Images/UI/Rpg/RpgWorldArea/Rpg_Map_icon_6.png"
	elseif type == Constant.RPGTagType.SaunterEvent then
		return "Assets/05_Images/UI/Rpg/RpgWorldArea/Rpg_Map_icon_7.png"
	elseif type == Constant.RPGTagType.SmallEvent then
		return "Assets/05_Images/UI/Rpg/RpgWorldArea/Rpg_Map_icon_8.png"
	end
end

function MainUIAPI:GetSelectArrowIconPath()
	return "Assets/05_Images/UI/StoryPart/StoryThread/StoryThreadUI/PlotThreadUI_TalkImg_03.png"
end
