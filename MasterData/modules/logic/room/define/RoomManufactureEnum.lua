-- chunkname: @modules/logic/room/define/RoomManufactureEnum.lua

module("modules.logic.room.define.RoomManufactureEnum", package.seeall)

local RoomManufactureEnum = _M

RoomManufactureEnum.InvalidBuildingUid = "0"
RoomManufactureEnum.ConstId = {
	OrderPriceMul = 10,
	CritterMaxMood = 2,
	CultivatingIcon = 9
}
RoomManufactureEnum.ItemCountY = 36
RoomManufactureEnum.ItemCountBgY = 37
RoomManufactureEnum.AudioDelayTime = 0.5
RoomManufactureEnum.ManufactureState = {
	Stop = 2,
	Running = 1,
	Wait = 0
}
RoomManufactureEnum.OneKeyType = {
	Customize = 5,
	ShortTime = 1,
	LowQuantity = 3,
	TracedOrder = 4,
	LongTime = 2
}
RoomManufactureEnum.ManufactureWrongType = {
	LackPreMat = 1,
	NoCritter = 5,
	NoLinkPath = 3,
	WaitPreMat = 4,
	PreMatNotUnlock = 2
}
RoomManufactureEnum.DefaultPauseIcon = "room_trade_icon_1"
RoomManufactureEnum.ManufactureWrongDisplay = {
	[RoomManufactureEnum.ManufactureWrongType.LackPreMat] = {
		jumpDesc = "room_manufacture_jump_add",
		icon = "room_trade_icon_2",
		desc = "room_manufacture_lack_mat"
	},
	[RoomManufactureEnum.ManufactureWrongType.PreMatNotUnlock] = {
		jumpDesc = "room_manufacture_jump_level_up_unlock",
		icon = "room_trade_icon_2",
		desc = "room_manufacture_lack_mat_level_up"
	},
	[RoomManufactureEnum.ManufactureWrongType.NoLinkPath] = {
		jumpDesc = "room_manufacture_jump_link_path",
		icon = "room_trade_icon_3",
		desc = "room_manufacture_lack_mat_link_path"
	},
	[RoomManufactureEnum.ManufactureWrongType.WaitPreMat] = {
		desc = "room_manufacture_wait_mat",
		icon = "room_trade_icon_4"
	},
	[RoomManufactureEnum.ManufactureWrongType.NoCritter] = {
		jumpDesc = "room_manufacture_jump_place_critter",
		icon = "room_trade_icon_1",
		desc = "room_manufacture_no_critter"
	}
}
RoomManufactureEnum.WrongTypeHandlerFunc = {
	[RoomManufactureEnum.ManufactureWrongType.LackPreMat] = ManufactureController._addPreMat,
	[RoomManufactureEnum.ManufactureWrongType.PreMatNotUnlock] = ManufactureController._lvUpBuilding,
	[RoomManufactureEnum.ManufactureWrongType.NoLinkPath] = ManufactureController._linPath
}
RoomManufactureEnum.SlotItemSpace = 10
RoomManufactureEnum.OverviewSlotItemSpace = 15
RoomManufactureEnum.FirstSlotPriority = 0
RoomManufactureEnum.SlotState = {
	Stop = 3,
	Running = 1,
	Wait = 2,
	Complete = 4,
	Locked = 5,
	None = 0
}
RoomManufactureEnum.SlotOperation = {
	Cancel = 1,
	MoveTop = 4,
	Add = 0,
	MoveBottom = 5
}
RoomManufactureEnum.RareImageMap = {
	"critter_manufacture_itemquality1",
	"critter_manufacture_itemquality2",
	"critter_manufacture_itemquality3",
	"critter_manufacture_itemquality4",
	"critter_manufacture_itemquality5"
}
RoomManufactureEnum.TradeLevelUnlock = {
	Trade = 2
}
RoomManufactureEnum.LuckyItemType = {
	All = 1,
	ItemId = 2
}

return RoomManufactureEnum
