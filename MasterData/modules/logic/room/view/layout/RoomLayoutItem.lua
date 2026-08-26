-- chunkname: @modules/logic/room/view/layout/RoomLayoutItem.lua

module("modules.logic.room.view.layout.RoomLayoutItem", package.seeall)

local RoomLayoutItem = class("RoomLayoutItem", ListScrollCellExtend)

function RoomLayoutItem:onInitView()
	self._btnitem = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_item")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._simagecover = gohelper.findChildSingleImage(self.viewGO, "#go_content/bg/mask/#simage_cover")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#go_content/bg/mask/#simage_mask")
	self._simagemaskcopy = gohelper.findChildSingleImage(self.viewGO, "#go_content/bg/mask/#simage_mask_copy")
	self._btnlookinfo = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/Right/Btn/#btn_lookinfo")
	self._golookinfonormal = gohelper.findChild(self.viewGO, "#go_content/Right/Btn/#btn_lookinfo/#go_lookinfonormal")
	self._golookinfoselect = gohelper.findChild(self.viewGO, "#go_content/Right/Btn/#btn_lookinfo/#go_lookinfoselect")
	self._btnchange = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/Right/Btn/#btn_change")
	self._gochangenormal = gohelper.findChild(self.viewGO, "#go_content/Right/Btn/#btn_change/#go_changenormal")
	self._gochangeselect = gohelper.findChild(self.viewGO, "#go_content/Right/Btn/#btn_change/#go_changeselect")
	self._btndelete = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/Right/Btn/#btn_delete")
	self._godeletenormal = gohelper.findChild(self.viewGO, "#go_content/Right/Btn/#btn_delete/#go_deletenormal")
	self._godeletedisabled = gohelper.findChild(self.viewGO, "#go_content/Right/Btn/#btn_delete/#go_deletedisabled")
	self._txtshareCount = gohelper.findChildText(self.viewGO, "#go_content/Top/#txt_shareCount")
	self._txtdegree = gohelper.findChildText(self.viewGO, "#go_content/Top/#txt_degree")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_content/Top/#txt_num")
	self._gousing = gohelper.findChild(self.viewGO, "#go_content/#go_using")
	self._btnshare = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#btn_share")
	self._gosharing = gohelper.findChild(self.viewGO, "#go_content/#btn_share/#go_sharing")
	self._gonotshare = gohelper.findChild(self.viewGO, "#go_content/#btn_share/#go_notshare")
	self._txtlayoutname = gohelper.findChildText(self.viewGO, "#go_content/RightBottom/#txt_layoutname")
	self._btneditname = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/RightBottom/#txt_layoutname/#btn_editname")
	self._gosharecode = gohelper.findChild(self.viewGO, "#go_content/RightBottom/#go_sharecode")
	self._txtsharecode = gohelper.findChildText(self.viewGO, "#go_content/RightBottom/#go_sharecode/#txt_sharecode")
	self._btncopysharecode = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/RightBottom/#go_sharecode/#btn_copysharecode")
	self._gosharetag = gohelper.findChild(self.viewGO, "#go_content/#go_sharetag")
	self._goadd = gohelper.findChild(self.viewGO, "#go_add")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_add/#btn_add")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomLayoutItem:addEvents()
	self._btnitem:AddClickListener(self._btnitemOnClick, self)
	self._btnlookinfo:AddClickListener(self._btnlookinfoOnClick, self)
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
	self._btndelete:AddClickListener(self._btndeleteOnClick, self)
	self._btnshare:AddClickListener(self._btnshareOnClick, self)
	self._btneditname:AddClickListener(self._btneditnameOnClick, self)
	self._btncopysharecode:AddClickListener(self._btncopysharecodeOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
end

function RoomLayoutItem:removeEvents()
	self._btnitem:RemoveClickListener()
	self._btnlookinfo:RemoveClickListener()
	self._btnchange:RemoveClickListener()
	self._btndelete:RemoveClickListener()
	self._btnshare:RemoveClickListener()
	self._btneditname:RemoveClickListener()
	self._btncopysharecode:RemoveClickListener()
	self._btnadd:RemoveClickListener()
end

function RoomLayoutItem:_btnshareOnClick()
	if not self._layoutMO or self._layoutMO:isEmpty() then
		return
	end

	local curTime = Time.time

	if self._lastShareTime and curTime > self._lastShareTime then
		return
	end

	if self._layoutMO:isSharing() then
		RoomRpc.instance:sendDeleteRoomShareRequest(self._layoutMO.id)
	else
		local canShareCount = RoomLayoutModel.instance:getCanShareCount()

		if canShareCount <= 0 then
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanShareCodeNotNum)

			return
		end

		if canShareCount <= CommonConfig.instance:getConstNum(ConstEnum.RoomPlanCanShareTipNum) then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutPlanCanShareCount, MsgBoxEnum.BoxType.Yes_No, self._sendShareRoomPlanRequest, nil, nil, self, nil, nil, canShareCount)
		else
			self:_sendShareRoomPlanRequest()
		end
	end
end

function RoomLayoutItem:_sendShareRoomPlanRequest()
	if not self._layoutMO then
		return
	end

	if not self._layoutMO:haveEdited() then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotCanShare)

		return
	end

	RoomRpc.instance:sendShareRoomPlanRequest(self._layoutMO.id)
end

function RoomLayoutItem:_btncopysharecodeOnClick()
	if self._layoutMO then
		RoomLayoutController.instance:copyShareCodeTxt(self._layoutMO:getShareCode())
	end
end

function RoomLayoutItem:_btnitemOnClick()
	self:_selectThis()
end

function RoomLayoutItem:_btneditnameOnClick()
	self:_selectThis()

	if self._layoutMO then
		RoomLayoutController.instance:openRenameView(self._layoutMO.name, self._onRenameCallback, self)
	end
end

function RoomLayoutItem:_btnlookinfoOnClick()
	self:_selectThis()

	if self._layoutMO then
		if not self._layoutMO.blockCount or self._layoutMO.blockCount < 1 then
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanMapNothing)

			return
		end

		local px, py, pz = transformhelper.getPos(self._gocontentTrs)

		RoomLayoutController.instance:openTips(self._layoutMO.id, Vector3(px, py, pz), self._halfWidth, self._halfHeight)
		self:_setLookinfoState(true)
	end
end

function RoomLayoutItem:_btnchangeOnClick()
	self:_selectThis()

	if self._layoutMO then
		local px, py, pz = transformhelper.getPos(self._gocontentTrs)

		RoomLayoutController.instance:openBgSelectView(Vector3(px, py, pz), self._halfWidth, self._halfHeight)
		self:_setChangeState(true)
	end
end

function RoomLayoutItem:_btndeleteOnClick()
	if not self._layoutMO then
		return
	end

	self:_selectThis()

	if self._layoutMO:isUse() then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotDelete)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
	GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutDelete, MsgBoxEnum.BoxType.Yes_No, function()
		self:_sendDeleteRequest()
	end)
end

function RoomLayoutItem:_sendDeleteRequest()
	if self._layoutMO then
		RoomRpc.instance:sendDeleteRoomPlanRequest(self._layoutMO.id)
	end
end

function RoomLayoutItem:_onRenameCallback(nameStr)
	if self._layoutMO and not string.nilorempty(nameStr) and self._layoutMO.name ~= nameStr then
		if self._txtlayoutname then
			self._txtlayoutname.text = nameStr
		end

		RoomLayoutController.instance:sendSetRoomPlanNameRpc(self._layoutMO.id, nameStr)
	end
end

function RoomLayoutItem:_btnaddOnClick()
	if self._layoutMO then
		self:_selectThis()
	end
end

function RoomLayoutItem:_onCreateCallblck(isSelect)
	if RoomController.instance:isVisitMode() then
		RoomLayoutController.instance:sendVisitCopyRpc(self._layoutMO, isSelect)
		ViewMgr.instance:closeView(ViewName.RoomLayoutView)
	else
		RoomLayoutController.instance:sendCreateRpc(self._layoutMO, isSelect)
	end
end

function RoomLayoutItem:_editableInitView()
	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._gousing, false)

	self._goRight = gohelper.findChild(self.viewGO, "#go_content/Right")
	self._goTop = gohelper.findChild(self.viewGO, "#go_content/Top")
	self._goTopTrs = self._goTop.transform
	self._topTrsPx, self._topTrsPy, self._topTrsPz = transformhelper.getLocalPos(self._goTopTrs)
	self._goRightWidth = recthelper.getWidth(self._goRight.transform)
	self._gocontentTrs = self._gocontent.transform
	self._halfWidth = recthelper.getWidth(self._gocontentTrs.transform) * 0.5 + 20
	self._halfHeight = recthelper.getHeight(self._gocontentTrs.transform) * 0.5

	if RoomController.instance:isVisitMode() then
		self:_setHideGoRight(true)
	end
end

function RoomLayoutItem:_setHideGoRight(isHide)
	gohelper.setActive(self._goRight, not isHide)
	gohelper.setActive(self._btneditname, not isHide)

	if isHide then
		if not self._goRightWidth then
			local offsetX = 0

			transformhelper.setLocalPos(self._goTopTrs, self._topTrsPx + offsetX, self._topTrsPy, self._topTrsPz)
		end
	end
end

function RoomLayoutItem:_selectThis()
	if self._layoutMO then
		RoomLayoutListModel.instance:setSelect(self._layoutMO.id)
		RoomLayoutController.instance:dispatchEvent(RoomEvent.UISelectLayoutPlanItem)
	end
end

function RoomLayoutItem:_editableAddEvents()
	RoomLayoutController.instance:registerCallback(RoomEvent.UISelectLayoutPlanCoverItem, self._onUpdateCoverBg, self)
	RoomLayoutController.instance:registerCallback(RoomEvent.UICancelLayoutPlanItemTab, self._onCancelItemTab, self)
end

function RoomLayoutItem:_editableRemoveEvents()
	RoomLayoutController.instance:unregisterCallback(RoomEvent.UISelectLayoutPlanCoverItem, self._onUpdateCoverBg, self)
	RoomLayoutController.instance:unregisterCallback(RoomEvent.UICancelLayoutPlanItemTab, self._onCancelItemTab, self)
end

function RoomLayoutItem:onUpdateMO(mo)
	self._layoutMO = mo

	if mo == nil then
		return
	end

	local isEmpty = mo:isEmpty()

	gohelper.setActive(self._gocontent, not isEmpty)
	gohelper.setActive(self._goadd, isEmpty)

	if not isEmpty then
		local isUse = mo:isUse()

		gohelper.setActive(self._gousing, isUse)

		self._txtlayoutname.text = mo:getName()
		self._txtdegree.text = mo.buildingDegree
		self._txtnum.text = mo.blockCount

		gohelper.setActive(self._godeletenormal, not isUse)
		gohelper.setActive(self._godeletedisabled, isUse)

		local imagPath = mo:getCoverResPath()

		if not string.nilorempty(imagPath) then
			self._simagecover:LoadImage(imagPath)
		else
			logError("can not find config. excel:X小屋.xlsx export_封面 coverId:%s", mo:getCoverId())
		end

		local isSharing = mo:isSharing()

		gohelper.setActive(self._gonotshare, not isSharing)
		gohelper.setActive(self._gosharing, isSharing)
		gohelper.setActive(self._gosharecode, isSharing)
		gohelper.setActive(self._txtshareCount, isSharing)

		local isObMode = RoomController.instance:isObMode()

		gohelper.setActive(self._btnshare, isObMode)
		gohelper.setActive(self._gosharetag, not isObMode and isSharing)

		if isSharing then
			self._txtsharecode.text = mo:getShareCode()
			self._txtshareCount.text = mo:getUseCount()
		end
	end
end

function RoomLayoutItem:_setLookinfoState(isSelect)
	gohelper.setActive(self._golookinfonormal, not isSelect)
	gohelper.setActive(self._golookinfoselect, isSelect)
end

function RoomLayoutItem:_setChangeState(isSelect)
	gohelper.setActive(self._gochangenormal, not isSelect)
	gohelper.setActive(self._gochangeselect, isSelect)
end

function RoomLayoutItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goselect, isSelect)
end

function RoomLayoutItem:onDestroyView()
	self._simagecover:UnLoadImage()
end

function RoomLayoutItem:_onUpdateCoverBg()
	if self._isSelect then
		local bgResMO = RoomLayoutBgResListModel.instance:getSelectMO()

		if bgResMO then
			self._simagecover:LoadImage(bgResMO:getResPath())
		end
	end
end

function RoomLayoutItem:_onCancelItemTab()
	self:_setLookinfoState(false)
	self:_setChangeState(false)
end

RoomLayoutItem.prefabUrl = "ui/viewres/room/layout/roomlayoutitem.prefab"

return RoomLayoutItem
