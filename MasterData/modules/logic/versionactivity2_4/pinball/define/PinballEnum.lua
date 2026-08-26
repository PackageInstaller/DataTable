-- chunkname: @modules/logic/versionactivity2_4/pinball/define/PinballEnum.lua

module("modules.logic.versionactivity2_4.pinball.define.PinballEnum", package.seeall)

local PinballEnum = _M

PinballEnum.Shape = {
	Rect = 1,
	Circle = 2
}
PinballEnum.Dir = {
	Down = -1,
	Up = 1,
	Right = -2,
	Left = 2,
	None = 0
}
PinballEnum.UnitType = {
	MarblesElasticity = 5,
	MarblesDivision = 2,
	TriggerBlackHole = 101,
	MarblesGlass = 3,
	MarblesNormal = 1,
	TriggerElasticity = 104,
	TriggerRefresh = 102,
	ResStone = 201,
	ResFood = 202,
	ResWood = 203,
	MarblesExplosion = 4,
	ResSmallFood = 301,
	ResMine = 204,
	TriggerObstacle = 103,
	TriggerNone = 105,
	CommonEffect = 302
}
PinballEnum.UnitLayers = {
	{
		PinballEnum.UnitType.TriggerBlackHole
	},
	{
		PinballEnum.UnitType.ResStone,
		PinballEnum.UnitType.ResFood,
		PinballEnum.UnitType.ResWood,
		PinballEnum.UnitType.ResMine,
		PinballEnum.UnitType.ResSmallFood
	},
	{
		PinballEnum.UnitType.TriggerRefresh
	},
	{
		PinballEnum.UnitType.TriggerObstacle,
		PinballEnum.UnitType.TriggerElasticity,
		PinballEnum.UnitType.TriggerNone
	}
}
PinballEnum.UnitTypeToLayer = {}

for layer, list in pairs(PinballEnum.UnitLayers) do
	for _, unitType in pairs(list) do
		PinballEnum.UnitTypeToLayer[unitType] = layer
	end
end

PinballEnum.BuildingType = {
	Food = 4,
	Talent = 2,
	MainCity = 1,
	House = 3
}
PinballEnum.ResType = {
	Complaint = 12,
	Play = 11,
	Mine = 2,
	Score = 21,
	Food = 4,
	Stone = 3,
	Wood = 1
}
PinballEnum.OperType = {
	Rest = 2,
	Episode = 1,
	None = 0
}
PinballEnum.BuildingOperType = {
	Remove = 3,
	Upgrade = 2,
	Build = 1
}
PinballEnum.ConditionType = {
	Score = 2,
	Talent = 1
}
PinballEnum.TalentEffectType = {
	MarblesNum = 2,
	UnlockMarbles = 1,
	AddResPer = 4,
	EpisodeCostDec = 5,
	MarblesLevel = 8,
	AutoGainFoodAdd = 7,
	PlayDec = 6,
	MarblesHoleNum = 3
}
PinballEnum.BuildingEffectType = {
	CostFood = 5,
	AddScore = 1,
	AddFood = 2,
	AddPlayDemand = 7,
	AddPlay = 6,
	TriggerBubble = 3,
	UnlockTalent = 4
}
PinballEnum.ConstId = {
	NoPlayAddComplaint = 9,
	PlayEnoughSubComplaint = 12,
	ComplaintLimit = 5,
	ResetDay = 17,
	ComplaintThresholdSubHoleNum = 20,
	ComplaintMaxSubHoleNum = 21,
	ComplaintThresholdAddCost = 10,
	DefaultMarblesNum = 3,
	FoodEnoughSubComplaint = 11,
	DefaultMarblesHoleNum = 4,
	NoFoodAddComplaint = 8,
	RestSubComplaint = 7,
	EpisodeCost = 13,
	ComplaintThreshold = 6
}
PinballEnum.UnitTypeToName = {}

for name, index in pairs(PinballEnum.UnitType) do
	PinballEnum.UnitTypeToName[index] = name
end

return PinballEnum
