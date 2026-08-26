-- chunkname: @modules/logic/room/view/RoomInitBuildingSkinView.lua

module("modules.logic.room.view.RoomInitBuildingSkinView", package.seeall)

local RoomInitBuildingSkinView = class("RoomInitBuildingSkinView", BaseView)

function RoomInitBuildingSkinView:onInitView()
	self._txttitle = gohelper.findChildText(self.viewGO, "right/#go_skin/title/txt")
	self._txttitleEn = gohelper.findChildText(self.viewGO, "right/#go_skin/title/txt/txtEn")
	self._imageicon = gohelper.findChildImage(self.viewGO, "right/#go_skin/title/icon")
	self._gochange = gohelper.findChild(self.viewGO, "right/#go_skin/bottom/#btn_change")
	self._btnchange = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_skin/bottom/#btn_change")
	self._gousing = gohelper.findChild(self.viewGO, "right/#go_skin/bottom/#go_using")
	self._goget = gohelper.findChild(self.viewGO, "right/#go_skin/bottom/#btn_get")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_skin/bottom/#btn_get")
	self._btnclose = gohelper.findChildClickWithDefaultAudio(self.viewGO, "right/#go_skin/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInitBuildingSkinView:addEvents()
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, self.onSkinListViewShowChange, self)
	self.addEventCb(self, RoomSkinController.instance, RoomSkinEvent.ChangePreviewRoomSkin, self.onChangeRoomSkin, self)
	self.addEventCb(self, RoomSkinController.instance, RoomSkinEvent.ChangeEquipRoomSkin, self.onChangeRoomSkin, self)
end

function RoomInitBuildingSkinView:removeEvents()
	self._btnchange:RemoveClickListener()
	self._btnget:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, self.onSkinListViewShowChange, self)
	self.removeEventCb(self, RoomSkinController.instance, RoomSkinEvent.ChangePreviewRoomSkin, self.onChangeRoomSkin, self)
	self.removeEventCb(self, RoomSkinController.instance, RoomSkinEvent.ChangeEquipRoomSkin, self.onChangeRoomSkin, self)
end

function RoomInitBuildingSkinView:_btnchangeOnClick()
	RoomSkinController.instance:confirmEquipPreviewRoomSkin()
end

function RoomInitBuildingSkinView:_btngetOnClick()
	local selectPartId = RoomSkinListModel.instance:getSelectPartId()
	local curPreviewSkinId = RoomSkinListModel.instance:getCurPreviewSkinId()

	if not selectPartId or not curPreviewSkinId then
		return
	end

	local actId = RoomConfig.instance:getRoomSkinActId(curPreviewSkinId)
	local hasActId = actId and actId ~= 0

	if not ((hasActId or nil) and ActivityModel.instance:isActOnLine(actId)) then
		GameFacade.showToast(ToastEnum.SkinNotInGetTime)

		return
	end

	local data = {
		canJump = true,
		roomSkinId = curPreviewSkinId
	}

	MaterialTipController.instance:showMaterialInfoWithData(MaterialEnum.MaterialType.Building, selectPartId, data)
end

function RoomInitBuildingSkinView:_btncloseOnClick()
	RoomSkinController.instance:setRoomSkinListVisible()
end

function RoomInitBuildingSkinView:onSkinListViewShowChange()
	self:refreshTitle()
	self:refreshBtns()
end

function RoomInitBuildingSkinView:onChangeRoomSkin()
	self:refreshBtns()
end

function RoomInitBuildingSkinView:_editableInitView()
	return
end

function RoomInitBuildingSkinView:onUpdateParam()
	return
end

function RoomInitBuildingSkinView:onOpen()
	self:refreshTitle()
	self:refreshBtns()
end

function RoomInitBuildingSkinView:refreshTitle()
	local selectPartId = RoomSkinListModel.instance:getSelectPartId()

	if not selectPartId then
		return
	end

	if selectPartId == RoomInitBuildingEnum.InitBuildingId.Hall then
		UISpriteSetMgr.instance:setRoomSprite(self._imageicon, "bg_init")

		self._txttitle.text = luaLang("room_initbuilding_title")
		self._txttitleEn.text = "Paleohall"
	else
		UISpriteSetMgr.instance:setRoomSprite(self._imageicon, "bg_part" .. selectPartId)

		local partConfig = RoomConfig.instance:getProductionPartConfig(selectPartId)

		self._txttitle.text = partConfig.name
		self._txttitleEn.text = partConfig.nameEn
	end
end

function RoomInitBuildingSkinView:refreshBtns()
	local curPreviewSkinId = RoomSkinListModel.instance:getCurPreviewSkinId()

	if not curPreviewSkinId then
		return
	end

	local isShowChange = false
	local isEquipped = false
	local isShowGet = false

	if curPreviewSkinId then
		::label_13_0::

		local isUnlock = RoomSkinModel.instance:isUnlockRoomSkin(curPreviewSkinId)

		if isUnlock then
			local selectPartId = RoomSkinListModel.instance:getSelectPartId()
			local equippedSkin = RoomSkinModel.instance:getEquipRoomSkin(selectPartId)

			if curPreviewSkinId == equippedSkin then
				isEquipped = true
			else
				isShowChange = true
			end
		else
			isShowGet = true
		end

		gohelper.setActive(self._gochange, isShowChange)
		gohelper.setActive(self._gousing, isEquipped)
		gohelper.setActive(self._goget, isShowGet)
	end
end

function RoomInitBuildingSkinView:onClose()
	return
end

function RoomInitBuildingSkinView:onDestroyView()
	return
end

return RoomInitBuildingSkinView
