-- chunkname: @modules/logic/room/define/RoomResourceEnum.lua

module("modules.logic.room.define.RoomResourceEnum", package.seeall)

local RoomResourceEnum = _M

RoomResourceEnum.ResourceId = {
	River = 4,
	None = 0,
	Building = 2,
	Road12 = 12,
	Flag = 5,
	Coast = 8,
	Railway = 9,
	Road10 = 10,
	Muddyway = 7,
	Road = 6,
	AirVehicle = 11,
	Plant = 1,
	Sculpture = 3,
	Empty = -1
}
RoomResourceEnum.ResourceRoadList = {
	RoomResourceEnum.ResourceId.Road,
	RoomResourceEnum.ResourceId.Muddyway,
	RoomResourceEnum.ResourceId.Coast,
	RoomResourceEnum.ResourceId.Railway,
	RoomResourceEnum.ResourceId.Road10,
	RoomResourceEnum.ResourceId.AirVehicle,
	RoomResourceEnum.ResourceId.Road12
}
RoomResourceEnum.ResourceIdCount = 4
RoomResourceEnum.ResourceLinkGOPath = {
	[RoomResourceEnum.ResourceId.Flag] = {
		"connect/001",
		nil,
		"connect/003",
		nil,
		"connect/005"
	}
}
RoomResourceEnum.ResourceList = {
	RoomResourceEnum.ResourceId.None,
	RoomResourceEnum.ResourceId.Plant,
	RoomResourceEnum.ResourceId.Building,
	RoomResourceEnum.ResourceId.Sculpture,
	RoomResourceEnum.ResourceId.River,
	RoomResourceEnum.ResourceId.Flag,
	RoomResourceEnum.ResourceId.Road,
	RoomResourceEnum.ResourceId.Muddyway,
	RoomResourceEnum.ResourceId.Coast,
	RoomResourceEnum.ResourceId.Railway
}
RoomResourceEnum.ResourceRes = {
	[RoomResourceEnum.ResourceId.Plant] = "plant",
	[RoomResourceEnum.ResourceId.Building] = "stone",
	[RoomResourceEnum.ResourceId.Sculpture] = "diaosu",
	[RoomResourceEnum.ResourceId.River] = "heliu"
}
RoomResourceEnum.ResourceBigIcon = {
	[RoomResourceEnum.ResourceId.None] = "fanzhi_icon_qingyuanda",
	[RoomResourceEnum.ResourceId.Plant] = "fanzhi_icon_zhibeida",
	[RoomResourceEnum.ResourceId.Building] = "fanzhi_icon_feixuda",
	[RoomResourceEnum.ResourceId.Sculpture] = "fanzhi_icon_yijida",
	[RoomResourceEnum.ResourceId.River] = "fanzhi_icon_shuiyuda"
}
RoomResourceEnum.ResourceColor = {
	[RoomResourceEnum.ResourceId.None] = "#FFFFFF",
	[RoomResourceEnum.ResourceId.Plant] = "#65C479",
	[RoomResourceEnum.ResourceId.Building] = "#A686AC",
	[RoomResourceEnum.ResourceId.Sculpture] = "#D9C882",
	[RoomResourceEnum.ResourceId.River] = "#6182C5"
}
RoomResourceEnum.ResourceAudioId = {
	[RoomResourceEnum.ResourceId.Empty] = AudioEnum.None,
	[RoomResourceEnum.ResourceId.None] = AudioEnum.None,
	[RoomResourceEnum.ResourceId.Plant] = AudioEnum.Room.play_amb_home_forest,
	[RoomResourceEnum.ResourceId.Building] = AudioEnum.Room.play_amb_home_ruins,
	[RoomResourceEnum.ResourceId.Sculpture] = AudioEnum.Room.play_amb_home_sculpture,
	[RoomResourceEnum.ResourceId.River] = AudioEnum.Room.play_amb_home_river
}
RoomResourceEnum.ResourceAudioPriority = {
	[RoomResourceEnum.ResourceId.Empty] = 0,
	[RoomResourceEnum.ResourceId.None] = 0,
	[RoomResourceEnum.ResourceId.Building] = 1,
	[RoomResourceEnum.ResourceId.Sculpture] = 2,
	[RoomResourceEnum.ResourceId.Plant] = 3,
	[RoomResourceEnum.ResourceId.River] = 4
}
RoomResourceEnum.PPVolume = {
	High = "ppassets/profiles/room_profile_high.asset",
	Middle = "ppassets/profiles/room_profile_middle.asset",
	Low = "ppassets/profiles/room_profile_low.asset"
}

for _, resId in pairs(RoomResourceEnum.ResourceId) do
	if resId ~= RoomResourceEnum.ResourceId.Empty then
		RoomResourceEnum.ResourceColor[resId] = RoomResourceEnum.ResourceColor[resId] or "#FFFFFF"
		RoomResourceEnum.ResourceAudioId[resId] = RoomResourceEnum.ResourceAudioId[resId] or AudioEnum.None
		RoomResourceEnum.ResourceAudioPriority[resId] = RoomResourceEnum.ResourceAudioPriority[resId] or 0

		if not tabletool.indexOf(RoomResourceEnum.ResourceList, resId) then
			table.insert(RoomResourceEnum.ResourceList, resId)
		end
	end
end

RoomResourceEnum.Block = {
	NoneList = {
		RoomResourceEnum.ResourceId.None
	},
	RiverList = {
		RoomResourceEnum.ResourceId.River
	}
}

for _, list in pairs(RoomResourceEnum.Block) do
	for i = #list + 1, 6 do
		table.insert(list, list[1] or RoomResourceEnum.ResourceId.None)
	end
end

RoomResourceEnum.EmptyDefineId = 1
RoomResourceEnum.EmptyPrefabPath = "undefined/empty.prefab"

return RoomResourceEnum
