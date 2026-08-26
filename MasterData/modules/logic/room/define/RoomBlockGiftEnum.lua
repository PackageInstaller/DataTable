-- chunkname: @modules/logic/room/define/RoomBlockGiftEnum.lua

module("modules.logic.room.define.RoomBlockGiftEnum", package.seeall)

local RoomBlockGiftEnum = _M

RoomBlockGiftEnum.SubType = {
	MaterialEnum.MaterialType.BlockPackage,
	MaterialEnum.MaterialType.Building
}
RoomBlockGiftEnum.SubTypeInfo = {
	[MaterialEnum.MaterialType.BlockPackage] = {
		NumSortTxt = "p_roomblockpackageview_filtrate",
		SubType = 1,
		ListModel = RoomBlockGiftListModel,
		AllColloctToast = ToastEnum.RoomBlockAllCollectBlock,
		CellSize = {
			298,
			360
		},
		CellSpacing = {
			40,
			10
		}
	},
	[MaterialEnum.MaterialType.Building] = {
		NumSortTxt = "roombuildinggift_placingrange",
		SubType = 2,
		ListModel = RoomBuildingGiftListModel,
		AllColloctToast = ToastEnum.RoomBlockAllCollectBuilding,
		CellSize = {
			400,
			234
		},
		CellSpacing = {
			35,
			0
		}
	}
}
RoomBlockGiftEnum.SortType = {
	Reverse = 2,
	Order = 1,
	None = 0
}

return RoomBlockGiftEnum
