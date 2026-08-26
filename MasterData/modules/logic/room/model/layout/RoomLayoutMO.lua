-- chunkname: @modules/logic/room/model/layout/RoomLayoutMO.lua

module("modules.logic.room.model.layout.RoomLayoutMO", package.seeall)

local RoomLayoutMO = pureTable("RoomLayoutMO")

function RoomLayoutMO:init(id)
	if self.id ~= id then
		self:clear()
	end

	self.id = id
end

function RoomLayoutMO:clear()
	self.blockCount = 0
	self.coverId = 1
	self.name = nil
	self.buildingDegree = 0
	self.infos = nil
	self.buildingInfo = nil
	self._isEmpty = nil
	self.shareCode = nil
	self.useCount = 0
	self.roomSkinInfo = {}
end

function RoomLayoutMO:updateInfo(info)
	if info.name then
		self:setName(info.name)
	end

	if info.coverId then
		self:setCoverId(info.coverId)
	end

	if info.buildingDegree then
		self:setBuildingDegree(info.buildingDegree)
	end

	if info.blockCount then
		self:setBlockCount(info.blockCount)
	end

	if info.infos then
		self:setBlockInfos(info.infos)
	end

	if info.buildingInfos then
		self:setBuildingInfos(info.buildingInfos)
	end

	if info.shareCode then
		self:setShareCode(info.shareCode)
	end

	if info.useCount then
		self:setUseCount(info.useCount)
	end

	if info.skins then
		self:setSkinInfo(info.skins)
	end

	if string.nilorempty(self.name) then
		self:setName(formatLuaLang("room_layoutplan_default_name", ""))
	end
end

function RoomLayoutMO:setBlockCount(num)
	self.blockCount = num or 0
end

function RoomLayoutMO:setBuildingDegree(num)
	self.buildingDegree = num or 0
end

function RoomLayoutMO:setName(name)
	self.name = name
end

function RoomLayoutMO:setCoverId(coverId)
	self.coverId = coverId or 1
end

function RoomLayoutMO:setBlockInfos(blockInfos)
	self.infos = blockInfos or {}
end

function RoomLayoutMO:setBuildingInfos(buildingInfos)
	self.buildingInfos = buildingInfos or {}
end

function RoomLayoutMO:setEmpty(isEmpty)
	self._isEmpty = isEmpty
end

function RoomLayoutMO:setShareCode(shareCode)
	self.shareCode = shareCode
end

function RoomLayoutMO:setUseCount(useCount)
	self.useCount = useCount
end

function RoomLayoutMO:setSkinInfo(skinInfoList)
	self.skinInfo = {}

	for _, skinInfo in ipairs(skinInfoList) do
		self.skinInfo[skinInfo.id] = skinInfo.skinId
	end
end

function RoomLayoutMO:isSharing()
	if string.nilorempty(self.shareCode) then
		return false
	end

	return true
end

function RoomLayoutMO:getShareCode()
	return self.shareCode
end

function RoomLayoutMO:getUseCount()
	return self.useCount or 0
end

function RoomLayoutMO:isHasBlockBuildingInfo()
	if self.infos == nil or self.buildingInfos == nil then
		return false
	end

	if #self.infos ~= self.blockCount then
		return false
	end

	return true
end

function RoomLayoutMO:getName()
	return self.name
end

function RoomLayoutMO:getCoverResPath()
	local cfg = RoomConfig.instance:getPlanCoverConfig(self.coverId)

	if cfg then
		return cfg.coverResPath
	end

	return nil
end

function RoomLayoutMO:getCoverId()
	return self.coverId
end

function RoomLayoutMO:isUse()
	return self.id == 0
end

function RoomLayoutMO:isEmpty()
	if self.id == 0 then
		return false
	end

	if self._isEmpty ~= nil then
		return self._isEmpty
	end

	return self.blockCount <= 0
end

function RoomLayoutMO:haveEdited()
	return (self.blockCount or nil) and self.blockCount > 0
end

return RoomLayoutMO
