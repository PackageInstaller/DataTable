-- chunkname: @modules/logic/room/controller/RoomSkinController.lua

module("modules.logic.room.controller.RoomSkinController", package.seeall)

local RoomSkinController = class("RoomSkinController", BaseController)

function RoomSkinController:onInit()
	return
end

function RoomSkinController:reInit()
	return
end

function RoomSkinController:addConstEvents()
	return
end

function RoomSkinController:clearPreviewRoomSkin()
	RoomSkinListModel.instance:setCurPreviewSkinId()
	self:dispatchEvent(RoomSkinEvent.ChangePreviewRoomSkin)
end

function RoomSkinController:setRoomSkinListVisible(selectPartId)
	local isShow = selectPartId ~= nil
	local curSelectPartId = RoomSkinListModel.instance:getSelectPartId()
	local isShowSkinList = RoomSkinModel.instance:getIsShowRoomSkinList()
	local isSameShowStatus = isShowSkinList == isShow
	local isSamePart = selectPartId == curSelectPartId

	if isSameShowStatus and isSamePart then
		return
	end

	local defaultSelectSkin

	RoomSkinModel.instance:setIsShowRoomSkinList(isShow)

	if isShow then
		RoomSkinListModel.instance:setRoomSkinList(selectPartId)

		defaultSelectSkin = RoomSkinModel.instance:getEquipRoomSkin(selectPartId)
	end

	RoomSkinListModel.instance:setCurPreviewSkinId(defaultSelectSkin)
	self:setRoomSkinMark(defaultSelectSkin)

	local playSwitchAnim = not isSameShowStatus

	self:dispatchEvent(RoomSkinEvent.SkinListViewShowChange, playSwitchAnim)
end

function RoomSkinController:selectPreviewRoomSkin(skinId)
	if not skinId then
		return
	end

	local curPreviewSkinId = RoomSkinListModel.instance:getCurPreviewSkinId()

	if curPreviewSkinId and curPreviewSkinId == skinId then
		return
	end

	RoomSkinListModel.instance:setCurPreviewSkinId(skinId)
	self:setRoomSkinMark(skinId)
	self:dispatchEvent(RoomSkinEvent.ChangePreviewRoomSkin)
end

function RoomSkinController:setRoomSkinMark(skinId)
	if not skinId then
		return
	end

	local isNew = RoomSkinModel.instance:isNewRoomSkin(skinId)

	if isNew then
		RoomRpc.instance:sendReadRoomSkinRequest(skinId)
	end
end

function RoomSkinController:clearInitBuildingEntranceReddot(partId)
	partId = partId or 0

	local newSkinReddot = RoomInitBuildingEnum.InitBuildingSkinReddot[partId]

	if not newSkinReddot then
		return
	end

	local isDotShow = RedDotModel.instance:isDotShow(newSkinReddot, 0)

	if isDotShow then
		RedDotRpc.instance:sendShowRedDotRequest(newSkinReddot, false)
	end
end

function RoomSkinController:confirmEquipPreviewRoomSkin()
	local selectPartId = RoomSkinListModel.instance:getSelectPartId()
	local curPreviewSkinId = RoomSkinListModel.instance:getCurPreviewSkinId()

	if not selectPartId or not curPreviewSkinId then
		return
	end

	local isUnlock = RoomSkinModel.instance:isUnlockRoomSkin(curPreviewSkinId)

	if not isUnlock then
		GameFacade.showToast(ToastEnum.SeasonEquipUnlock)

		return
	end

	local equippedSkin = RoomSkinModel.instance:getEquipRoomSkin(selectPartId)

	if curPreviewSkinId == equippedSkin then
		GameFacade.showToast(ToastEnum.HasChangeRoomSink)

		return
	end

	RoomRpc.instance:sendSetRoomSkinRequest(selectPartId, curPreviewSkinId)
end

RoomSkinController.instance = RoomSkinController.New()

return RoomSkinController
