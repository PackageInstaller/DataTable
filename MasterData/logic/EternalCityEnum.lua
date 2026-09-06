-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/data/EternalCityEnum.lua

module("logic.extensions.eternalcity.view.data.EternalCityEnum", package.seeall)

local EternalCityEnum = {}

EternalCityEnum.GridUIState_Empty = 0
EternalCityEnum.GridUIState_SelectNotEmpty = 1
EternalCityEnum.GridUIState_SelectDisconnected = 2
EternalCityEnum.GridUIState_SelectCorrect = 3
EternalCityEnum.TreeOnlyId = -1
EternalCityEnum.EmptyOnlyId = 0
EternalCityEnum.TreeBuildingId = -1
EternalCityEnum.EmptyBuildingId = 0
EternalCityEnum.OperationType_Place = "Place"
EternalCityEnum.OperationType_Recycle = "Recycle"
EternalCityEnum.OperationType_Craft = "Craft"
EternalCityEnum.OperationType_Restore = "Restore"
EternalCityEnum.PoolOperationType_Lock = 1
EternalCityEnum.PoolOperationType_Unlock = 2
EternalCityEnum.BuildingEffectType_RecruitPet = 1
EternalCityEnum.BuildingEffectType_RefreshPool = 2
EternalCityEnum.BuildingEffectType_BattleBuff = 3

return EternalCityEnum
