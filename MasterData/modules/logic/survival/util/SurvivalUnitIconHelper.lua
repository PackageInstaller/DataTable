-- chunkname: @modules/logic/survival/util/SurvivalUnitIconHelper.lua

module("modules.logic.survival.util.SurvivalUnitIconHelper", package.seeall)

local SurvivalUnitIconHelper = class("SurvivalUnitIconHelper")
local iconPref = "survival_map_icon_"
local bgPref = "survival_map_bubble_"
local arrowPref = "survival_map_icon_arrow0"
local Icons = {
	Exit = 8,
	Shop = 15,
	Door = 9,
	Search = 3,
	Search_High = 27,
	Fight_Elite_Skip = 24,
	Fight = 6,
	Unknown = 11,
	Fight_Elite = 7,
	Fight_Skip = 23,
	Hero = 10,
	Task = 1,
	NPC_High = 25,
	Searched_High = 26,
	Treasure = 5,
	NPC = 2,
	Searched = 4
}
local Colors = {
	Gold = {
		"gold",
		"3"
	},
	Green = {
		"green",
		"2"
	},
	Red = {
		"red",
		"1"
	},
	Yellow = {
		"yellow",
		"3"
	}
}
local IconBgs = {
	[Icons.Task] = Colors.Green,
	[Icons.NPC] = Colors.Green,
	[Icons.Search] = Colors.Green,
	[Icons.Searched] = Colors.Green,
	[Icons.Treasure] = Colors.Green,
	[Icons.Shop] = Colors.Green,
	[Icons.Fight] = Colors.Red,
	[Icons.Fight_Elite] = Colors.Red,
	[Icons.Exit] = Colors.Gold,
	[Icons.Door] = Colors.Yellow,
	[Icons.Hero] = Colors.Green,
	[Icons.Unknown] = Colors.Green,
	[Icons.NPC_High] = Colors.Gold,
	[Icons.Fight_Skip] = Colors.Green,
	[Icons.Fight_Elite_Skip] = Colors.Green,
	[Icons.Searched_High] = Colors.Gold,
	[Icons.Search_High] = Colors.Gold
}
local unitTypeToIcon = {
	[SurvivalEnum.UnitType.Task] = Icons.Task,
	[SurvivalEnum.UnitType.NPC] = Icons.NPC,
	[SurvivalEnum.UnitType.Treasure] = Icons.Treasure,
	[SurvivalEnum.UnitType.Exit] = Icons.Exit,
	[SurvivalEnum.UnitType.Door] = Icons.Door
}
local unitSubTypeToIcon = {
	[53] = Icons.NPC_High,
	[SurvivalEnum.UnitSubType.Shop] = Icons.Shop
}
local RelationIcon = {
	[SurvivalEnum.ReputationType.People] = "survival_map_icon_31",
	[SurvivalEnum.ReputationType.Zeno] = "survival_map_icon_29",
	[SurvivalEnum.ReputationType.Foundation] = "survival_map_icon_30",
	[SurvivalEnum.ReputationType.Laplace] = "survival_map_icon_28"
}

function SurvivalUnitIconHelper:getUnitIconAndBg(unitMo)
	local icon = Icons.Unknown

	if unitMo.visionVal ~= 8 then
		local unitType = unitMo.unitType

		if unitMo.co then
			local subType = unitMo.co.subType

			icon = unitTypeToIcon[unitType] or icon
			icon = unitSubTypeToIcon[subType] or icon

			if unitType == SurvivalEnum.UnitType.Search then
				local isSearched = unitMo:isSearched()

				icon = subType == 392 and (isSearched and Icons.Searched_High or Icons.Search_High) or isSearched and Icons.Searched or Icons.Search
			elseif unitType == SurvivalEnum.UnitType.Battle then
				local isElite = subType == 41 or subType == 43
				local roleLevel = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo.level
				local fightLv = unitMo.co.fightLevel
				local canSkip = unitMo.co.skip == 1 and fightLv <= roleLevel

				icon = canSkip and (isElite and Icons.Fight_Elite_Skip or Icons.Fight_Skip) or isElite and Icons.Fight_Elite or Icons.Fight
			end
		end
	end

	return iconPref .. icon, bgPref .. IconBgs[icon][1], arrowPref .. IconBgs[icon][2]
end

function SurvivalUnitIconHelper:getRelationIcon(reputationType)
	return RelationIcon[reputationType]
end

function SurvivalUnitIconHelper:setNpcIcon(singleImage, iconName, cb, cbobj)
	singleImage:LoadImage(string.format("singlebg/chess/%s.png", iconName), cb, cbobj)
end

SurvivalUnitIconHelper.instance = SurvivalUnitIconHelper.New()

return SurvivalUnitIconHelper
