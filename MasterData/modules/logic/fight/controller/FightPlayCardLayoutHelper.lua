-- chunkname: @modules/logic/fight/controller/FightPlayCardLayoutHelper.lua

module("modules.logic.fight.controller.FightPlayCardLayoutHelper", package.seeall)

local FightPlayCardLayoutHelper = _M
local DataType = {
	Anchor = 1,
	Scale = 2
}
local defaultAnchor = Vector2(0, 0)
local defaultScale = 1

FightPlayCardLayoutHelper.PlayCardOperateType = {
	PlayCard = 1,
	MusicNote = 2,
	DeviceCard = 3
}

function FightPlayCardLayoutHelper.getPlayCardLayoutKey(...)
	local value = 0
	local n = select("#", ...)

	for i = 1, n do
		local type = select(i, ...)
		local tempValue = bit.lshift(1, type - 1)

		value = bit.bor(value, tempValue)
	end

	return value
end

local getKeyFunc = FightPlayCardLayoutHelper.getPlayCardLayoutKey
local PlayCardOperateType = FightPlayCardLayoutHelper.PlayCardOperateType

FightPlayCardLayoutHelper.PlayCardLayoutDict = {
	[FightPlayCardLayoutHelper.getPlayCardLayoutKey(PlayCardOperateType.PlayCard)] = {
		{
			[PlayCardOperateType.PlayCard] = Vector2(0, 256)
		},
		{
			[PlayCardOperateType.PlayCard] = 1
		}
	},
	[FightPlayCardLayoutHelper.getPlayCardLayoutKey(PlayCardOperateType.PlayCard, PlayCardOperateType.MusicNote)] = {
		{
			[PlayCardOperateType.PlayCard] = Vector2(0, 256),
			[PlayCardOperateType.MusicNote] = Vector2(0, 380)
		},
		{
			[PlayCardOperateType.PlayCard] = 1,
			[PlayCardOperateType.MusicNote] = 1
		}
	},
	[FightPlayCardLayoutHelper.getPlayCardLayoutKey(PlayCardOperateType.PlayCard, PlayCardOperateType.DeviceCard)] = {
		{
			[PlayCardOperateType.PlayCard] = Vector2(0, 256),
			[PlayCardOperateType.DeviceCard] = Vector2(0, -25.6)
		},
		{
			[PlayCardOperateType.PlayCard] = 0.9,
			[PlayCardOperateType.DeviceCard] = 1
		}
	},
	[FightPlayCardLayoutHelper.getPlayCardLayoutKey(PlayCardOperateType.PlayCard, PlayCardOperateType.DeviceCard, PlayCardOperateType.MusicNote)] = {
		{
			[PlayCardOperateType.PlayCard] = Vector2(0, 256),
			[PlayCardOperateType.DeviceCard] = Vector2(0, -25.6),
			[PlayCardOperateType.MusicNote] = Vector2(0, 380)
		},
		{
			[PlayCardOperateType.PlayCard] = 1,
			[PlayCardOperateType.DeviceCard] = 1,
			[PlayCardOperateType.MusicNote] = 1
		}
	}
}

local TempTypeList = {}

function FightPlayCardLayoutHelper.getCurTypeList()
	tabletool.clear(TempTypeList)
	table.insert(TempTypeList, FightPlayCardLayoutHelper.PlayCardOperateType.PlayCard)

	if FightDataHelper.hasDeviceArea() then
		table.insert(TempTypeList, FightPlayCardLayoutHelper.PlayCardOperateType.DeviceCard)
	end

	if FightDataHelper.hasMusicInfo() then
		table.insert(TempTypeList, FightPlayCardLayoutHelper.PlayCardOperateType.MusicNote)
	end

	return TempTypeList
end

function FightPlayCardLayoutHelper.getAnchorPosAndScale(type)
	local curTypeList = FightPlayCardLayoutHelper.getCurTypeList()
	local key = getKeyFunc(unpack(curTypeList))
	local configList = FightPlayCardLayoutHelper.PlayCardLayoutDict[key]

	configList = configList or FightPlayCardLayoutHelper.PlayCardLayoutDict[getKeyFunc(PlayCardOperateType.PlayCard)]

	return configList[DataType.Anchor][type] or defaultAnchor, configList[DataType.Scale][type] or defaultScale
end

return FightPlayCardLayoutHelper
