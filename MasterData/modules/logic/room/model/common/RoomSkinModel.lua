-- chunkname: @modules/logic/room/model/common/RoomSkinModel.lua

module("modules.logic.room.model.common.RoomSkinModel", package.seeall)

local RoomSkinModel = class("RoomSkinModel", BaseModel)

function RoomSkinModel:onInit()
	self:clear()
end

function RoomSkinModel:reInit()
	return
end

function RoomSkinModel:clear()
	self:_clearData()
	RoomSkinModel.super.clear(self)
end

function RoomSkinModel:_clearData()
	self._isInitSkinMoList = false
	self._otherPlayerRoomSkinDict = nil

	self:setIsShowRoomSkinList(false)
end

function RoomSkinModel:initSkinMoList()
	local allSkinIdList = RoomConfig.instance:getAllSkinIdList()

	for _, skinId in ipairs(allSkinIdList) do
		local skinMO = self:getById(skinId)

		if not skinMO then
			skinMO = RoomSkinMO.New()

			skinMO:init(skinId)
			self:addAtLast(skinMO)
		end
	end

	self._isInitSkinMoList = true
end

function RoomSkinModel:updateRoomSkinInfo(roomSkinInfoList, isCheckInit)
	local hasSetSkinPartDict = {}

	if roomSkinInfoList then
		for _, skinInfo in ipairs(roomSkinInfoList) do
			self:setRoomSkinEquipped(skinInfo.id, skinInfo.skinId)

			hasSetSkinPartDict[skinInfo.id] = true
		end
	end

	if isCheckInit then
		for _, partId in pairs(RoomInitBuildingEnum.InitBuildingId) do
			if not hasSetSkinPartDict[partId] then
				self:setRoomSkinEquipped(partId, RoomInitBuildingEnum.InitRoomSkinId[partId])
			end
		end
	end
end

function RoomSkinModel:setRoomSkinEquipped(partId, skinId)
	if not partId or not skinId then
		return
	end

	local newSkinMo = self:getRoomSkinMO(skinId, true)

	if not newSkinMo then
		return
	end

	local lastEquipSkin = self:getEquipRoomSkin(partId)
	local lastSkinMo = lastEquipSkin and self:getRoomSkinMO(lastEquipSkin, true)

	if lastSkinMo then
		lastSkinMo:setIsEquipped(false)
	end

	newSkinMo:setIsEquipped(true)
end

function RoomSkinModel:setIsShowRoomSkinList(isShow)
	self._isShowRoomSkinList = isShow
end

function RoomSkinModel:setOtherPlayerRoomSkinDict(skinInfos)
	self._otherPlayerRoomSkinDict = {}

	if not skinInfos then
		return
	end

	for _, info in ipairs(skinInfos) do
		self._otherPlayerRoomSkinDict[info.id] = info.skinId
	end
end

function RoomSkinModel:getRoomSkinMO(skinId, nilError)
	if not self._isInitSkinMoList then
		self:initSkinMoList()
	end

	local result = skinId and self:getById(skinId)

	if not result and nilError then
		logError(string.format("RoomSkinModel:getRoomSkinMO error, skinMO is nil, skinId:%s", skinId))
	end

	return result
end

function RoomSkinModel:getIsShowRoomSkinList()
	return self._isShowRoomSkinList
end

function RoomSkinModel:getShowSkin(partId)
	if not partId then
		return
	end

	local skinId
	local isVisitMode = RoomController.instance:isVisitMode()

	if isVisitMode then
		local otherPlayerRoomSkinDict = self:getOtherPlayerRoomSkinDict()

		skinId = otherPlayerRoomSkinDict and otherPlayerRoomSkinDict[partId]

		if not skinId or skinId == 0 then
			skinId = RoomInitBuildingEnum.InitRoomSkinId[partId]
		end
	else
		local previewSkinId = RoomSkinListModel.instance:getCurPreviewSkinId()

		if previewSkinId then
			::label_12_0::

			local previewSkinBelongPart = RoomConfig.instance:getBelongPart(previewSkinId)

			skinId = previewSkinBelongPart and previewSkinBelongPart == partId and previewSkinId or self:getEquipRoomSkin(partId)
		end
	end

	if not skinId then
		logError(string.format("RoomSkinModel:getShowSkin error, show skin is nil, partId:%s", partId))

		skinId = RoomInitBuildingEnum.InitRoomSkinId[partId]
	end

	return skinId
end

function RoomSkinModel:getEquipRoomSkin(partId)
	local result

	if not partId then
		return result
	end

	local skinIdList = RoomConfig.instance:getSkinIdList(partId)

	for _, skinId in ipairs(skinIdList) do
		local isEquipped = self:isEquipRoomSkin(skinId)

		if isEquipped then
			result = skinId

			break
		end
	end

	return result
end

function RoomSkinModel:isUnlockRoomSkin(skinId)
	local result = false

	if not skinId then
		return result
	end

	local skinMo = self:getRoomSkinMO(skinId)

	result = skinMo and skinMo:isUnlock()

	return result
end

function RoomSkinModel:isNewRoomSkin(skinId)
	if not skinId then
		return false
	end

	return (RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomNewSkinItem, skinId))
end

function RoomSkinModel:isHasNewRoomSkin(partId)
	local result = false

	if not partId then
		return result
	end

	local skinIdList = RoomConfig.instance:getSkinIdList(partId)

	for _, skinId in ipairs(skinIdList) do
		local isNew = self:isNewRoomSkin(skinId)

		if isNew then
			result = true

			break
		end
	end

	return result
end

function RoomSkinModel:isEquipRoomSkin(skinId)
	local roomSkinMo = self:getRoomSkinMO(skinId, true)

	return (roomSkinMo or nil) and roomSkinMo:isEquipped()
end

function RoomSkinModel:isDefaultRoomSkin(partId, skinId)
	local result = false

	if not partId or not skinId then
		return result
	end

	local defaultSkinId = RoomInitBuildingEnum.InitRoomSkinId[partId]

	result = skinId == defaultSkinId

	return result
end

function RoomSkinModel:getOtherPlayerRoomSkinDict()
	return self._otherPlayerRoomSkinDict
end

RoomSkinModel.instance = RoomSkinModel.New()

return RoomSkinModel
