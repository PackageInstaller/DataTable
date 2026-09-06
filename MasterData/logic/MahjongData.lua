-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/model/MahjongData.lua

module("logic.extensions.mahjongbattle.model.MahjongData", package.seeall)

local MahjongData = class("MahjongData")

MahjongData.TileType = {
	Tiao = 2,
	Tong = 1,
	Wan = 3
}

function MahjongData:ctor()
	self.typeId = 0
	self.value = 0
	self.extraParams = {}
end

function MahjongData:setTileData(typeId, value)
	self.typeId = typeId
	self.value = value
end

function MahjongData:getTileType()
	return self.typeId
end

function MahjongData:getTileValue()
	return self.value
end

function MahjongData:setExtraParam(key, value)
	self.extraParams[key] = value
end

function MahjongData:getExtraParam(key)
	return self.extraParams[key]
end

function MahjongData:getUniqueKey()
	return self.typeId .. "_" .. self.value
end

return MahjongData
