-- chunkname: @modules/logic/room/define/RoomBuildingEnum.lua

module("modules.logic.room.define.RoomBuildingEnum", package.seeall)

local RoomBuildingEnum = _M

RoomBuildingEnum.BuildingState = {
	Revert = 4,
	Inventory = 3,
	Temp = 2,
	Map = 1
}
RoomBuildingEnum.BuildingType = {
	Collect = 1,
	Manufacture = 3,
	FishingStore = 9,
	Interact = 7,
	Process = 2,
	Trade = 5,
	Decoration = 0,
	Rest = 4,
	Fishing = 8,
	Transport = 6
}
RoomBuildingEnum.BuildingListViewResTabType = {
	All = 1,
	Play = 4,
	Adornment = 2,
	Produce = 3
}
RoomBuildingEnum.BuildingTypeAreName = {
	[RoomBuildingEnum.BuildingType.Collect] = "room_area_name_collect",
	[RoomBuildingEnum.BuildingType.Process] = "room_area_name_process",
	[RoomBuildingEnum.BuildingType.Manufacture] = "room_area_name_manufacture"
}
RoomBuildingEnum.BuildingTypeSiteLangKey = {
	[RoomBuildingEnum.BuildingType.Collect] = "room_building_sitename_collect",
	[RoomBuildingEnum.BuildingType.Process] = "room_building_sitename_process",
	[RoomBuildingEnum.BuildingType.Manufacture] = "room_building_sitename_manufacture"
}
RoomBuildingEnum.BuildingTypeLineIcon = {
	[RoomBuildingEnum.BuildingType.Collect] = "room_transport_icon_1",
	[RoomBuildingEnum.BuildingType.Process] = "room_transport_icon_2",
	[RoomBuildingEnum.BuildingType.Manufacture] = "room_transport_icon_3"
}
RoomBuildingEnum.CanDateleBuildingType = {
	[RoomBuildingEnum.BuildingType.Decoration] = true
}
RoomBuildingEnum.CanClickTouchBuildingType = {
	[RoomBuildingEnum.BuildingType.Collect] = true,
	[RoomBuildingEnum.BuildingType.Process] = true,
	[RoomBuildingEnum.BuildingType.Manufacture] = true,
	[RoomBuildingEnum.BuildingType.Trade] = true,
	[RoomBuildingEnum.BuildingType.Rest] = true,
	[RoomBuildingEnum.BuildingType.Interact] = true
}
RoomBuildingEnum.BuildingArea = {
	[RoomBuildingEnum.BuildingType.Collect] = true,
	[RoomBuildingEnum.BuildingType.Process] = true,
	[RoomBuildingEnum.BuildingType.Manufacture] = true
}
RoomBuildingEnum.BuildingMapUiIcon = {
	[RoomBuildingEnum.BuildingType.Interact] = "critter_buildingicon_5"
}
RoomBuildingEnum.FormulaBuildingType = {
	Gather = 1,
	ExpTree = 6,
	Machine = 2,
	Trade = 4,
	Change = 3
}
RoomBuildingEnum.FormulaType = {
	Gather = 4,
	Trade = 3,
	Machine = 1,
	Change = 2
}
RoomBuildingEnum.EffectType = {
	Reserve = 1,
	Slot = 3,
	Time = 2
}
RoomBuildingEnum.FormulaOrderType = {
	OrderDown = 6,
	CostTimeUp = 3,
	OrderUp = 5,
	RareDown = 2,
	CostTimeDown = 4,
	RareUp = 1
}
RoomBuildingEnum.FormulaMaxCountErrorCode = {
	TimeCountLimit = -3,
	HasQuantityLimit = -1,
	FitResourceLimit = -5,
	ReserveCountLimit = -4,
	AccelerateItemMaxCountLimit = -2
}
RoomBuildingEnum.ConfirmPlaceBuildingErrorCode = {
	InTransportPath = -6,
	ResourceArea = -3,
	NoAreaMainBuilding = -4,
	Foundation = -1,
	OutSizeAreaBuilding = -5,
	ResourceId = -2
}
RoomBuildingEnum.RareIcon = {
	"bg_jianzudi_2",
	"bg_jianzudi_3",
	"bg_jianzudi_4",
	"bg_jianzudi_5",
	"bg_jianzudi_6"
}
RoomBuildingEnum.RareFrame = {
	"room_qualityframe_1",
	"room_qualityframe_2",
	"room_qualityframe_3",
	"room_qualityframe_4",
	"room_qualityframe_5"
}
RoomBuildingEnum.MachineSlotMaxCount = 99
RoomBuildingEnum.AccelerateItemMaxCount = 999
RoomBuildingEnum.SpecialStrengthItemId = 190008
RoomBuildingEnum.BuildingAreaRange = 2
RoomBuildingEnum.Crossload = {
	[5009] = {
		AnimPath = "",
		AnimStatus = {
			{
				animName = "daqiao_a_close",
				audioId = 20009055,
				animTime = 2.1,
				resId = 6,
				replaceBlockRes = {
					{
						x = 0,
						y = 0,
						resPionts = {
							[0] = 6,
							nil,
							nil,
							6,
							nil,
							nil,
							6
						}
					},
					{
						x = 1,
						y = 0,
						resPionts = {
							[0] = 6,
							nil,
							nil,
							6,
							nil,
							nil,
							6
						}
					}
				}
			},
			{
				animName = "daqiao_a_open",
				audioId = 20009054,
				animTime = 2.1,
				resId = 4,
				replaceBlockRes = {
					{
						x = 0,
						y = 0,
						resPionts = {
							[0] = 0,
							nil,
							nil,
							4,
							nil,
							nil,
							0
						}
					},
					{
						x = 1,
						y = 0,
						resPionts = {
							[0] = 0,
							nil,
							nil,
							0,
							nil,
							nil,
							4
						}
					}
				}
			}
		}
	}
}
RoomBuildingEnum.AudioExtendType = {
	AnimatorEvent = 2,
	Clock12Hour = 1
}
RoomBuildingEnum.VehicleInitOffestY = 0.11
RoomBuildingEnum.VehicleTypeOffestY = {
	RoomBuildingEnum.VehicleInitOffestY
}
RoomBuildingEnum.NotPlaceBlockAnimDict = {
	[11311] = true
}
RoomBuildingEnum.AnimName = {
	Open = "open",
	Takeoff = "takeoff",
	Close = "close",
	Produce = "produce",
	Landing = "landing",
	Idel = "idel"
}
RoomBuildingEnum.TransportBuyTosatDic = {
	[22204] = 220910
}

return RoomBuildingEnum
