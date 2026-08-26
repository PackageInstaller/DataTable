-- chunkname: @modules/logic/room/view/manufacture/RoomCritterOneKeyView.lua

module("modules.logic.room.view.manufacture.RoomCritterOneKeyView", package.seeall)

local RoomCritterOneKeyView = class("RoomCritterOneKeyView", BaseView)

function RoomCritterOneKeyView:onInitView()
	self._gotitlebefore = gohelper.findChild(self.viewGO, "title/#go_titlebefore")
	self._gotitleafter = gohelper.findChild(self.viewGO, "title/#go_titleafter")
	self._btnclose = gohelper.findChildClickWithAudio(self.viewGO, "#btn_close")
	self._godragarea = gohelper.findChild(self.viewGO, "#go_dragArea")
	self._goLayout = gohelper.findChild(self.viewGO, "#go_content/#go_Layout")
	self._gocarditem = gohelper.findChild(self.viewGO, "#go_content/#go_Layout/#go_carditem")
	self._gocomplete = gohelper.findChild(self.viewGO, "#go_complete")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterOneKeyView:addEvents()
	self._drag:AddDragBeginListener(self._onBeginDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomCritterOneKeyView:removeEvents()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._btnclose:RemoveClickListener()
end

function RoomCritterOneKeyView:_onBeginDrag(param, pointerEventData)
	self._isDrag = true
end

function RoomCritterOneKeyView:_onEndDrag(param, pointerEventData)
	self._isDrag = false
end

function RoomCritterOneKeyView:_btncloseOnClick()
	self:closeThis()
end

function RoomCritterOneKeyView:_onCardItemDrag(param, pointerEventData)
	self:_onBeginDrag()
	self:_onCardItemHover(param)
end

function RoomCritterOneKeyView:_onCardItemHover(critterUid)
	if not self._isDrag then
		return
	end

	self:_callCritter(critterUid)
end

function RoomCritterOneKeyView:_callCritter(critterUid)
	if not self._waitCallCritterDict or not self._waitCallCritterDict[critterUid] then
		return
	end

	local cardItem = self._cardItemDict[critterUid]

	if cardItem then
		cardItem.animator:Play("card", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_fenpai)
	end

	self._waitCallCritterDict[critterUid] = nil

	self:checkComplete()
end

function RoomCritterOneKeyView:_editableInitView()
	self:clearVar()

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godragarea)
	self._goclosebtn = self._btnclose.gameObject
end

function RoomCritterOneKeyView:onUpdateParam()
	if not self.viewParam then
		return
	end

	self.type = self.viewParam.type
	self.infoList = self.viewParam.infoList or {}

	for _, info in ipairs(self.infoList) do
		for _, critterUid in ipairs(info.critterUids) do
			self._waitCallCritterDict[critterUid] = true
		end
	end
end

function RoomCritterOneKeyView:onOpen()
	self:onUpdateParam()
	self:initCritterCardItem()
	self:checkComplete()
end

function RoomCritterOneKeyView:initCritterCardItem()
	local list = {}

	for critterUid, _ in pairs(self._waitCallCritterDict) do
		list[#list + 1] = critterUid
	end

	gohelper.CreateObjList(self, self.onSetCritterCardItem, list, self._goLayout, self._gocarditem)
end

function RoomCritterOneKeyView:onSetCritterCardItem(obj, data, index)
	local cardItem = self:getUserDataTb_()

	cardItem.go = obj
	cardItem.critterUid = data
	cardItem.animator = cardItem.go:GetComponent(gohelper.Type_Animator)
	cardItem.imagecardfrontbg = gohelper.findChildImage(obj, "#simage_cardfrontbg")
	cardItem.simagecritter = gohelper.findChildSingleImage(obj, "#simage_cardfrontbg/#simage_critter")
	cardItem.simagecardback = gohelper.findChildSingleImage(obj, "#simage_cardback")

	cardItem.animator:Play("idle", 0, 0)

	local critterMO = CritterModel.instance:getCritterMOByUid(cardItem.critterUid)

	if critterMO then
		local critterId = critterMO:getDefineId()
		local critterLargeIcon = ResUrl.getCritterLargeIcon(critterId)

		cardItem.simagecritter:LoadImage(critterLargeIcon)

		local catalogueId = CritterConfig.instance:getCritterCatalogue(critterId)
		local baseCard = CritterConfig.instance:getBaseCard(catalogueId)

		UISpriteSetMgr.instance:setCritterSprite(cardItem.imagecardfrontbg, baseCard)
	else
		logError(string.format("RoomCritterOneKeyView:onSetCritterCardItem no critterMO, critterUid:%s", data))
	end

	cardItem.click = SLFramework.UGUI.UIClickListener.Get(cardItem.go)
	cardItem.drag = SLFramework.UGUI.UIDragListener.Get(cardItem.go)
	cardItem.press = SLFramework.UGUI.UILongPressListener.Get(cardItem.go)

	cardItem.click:AddClickListener(self._callCritter, self, data)
	cardItem.drag:AddDragBeginListener(self._onCardItemDrag, self, data)
	cardItem.drag:AddDragEndListener(self._onEndDrag, self)
	cardItem.press:AddHoverListener(self._onCardItemHover, self, data)

	self._cardItemDict[data] = cardItem
end

function RoomCritterOneKeyView:checkComplete()
	local isComplete = not next(self._waitCallCritterDict)

	if isComplete then
		RoomRpc.instance:sendRouseCrittersRequest(self.type, self.infoList)
	end

	gohelper.setActive(self._gotitlebefore, not isComplete)
	gohelper.setActive(self._godragarea, not isComplete)
	gohelper.setActive(self._gotitleafter, isComplete)
	gohelper.setActive(self._goclosebtn, isComplete)
	gohelper.setActive(self._gocomplete, isComplete)
end

function RoomCritterOneKeyView:clearVar()
	self._waitCallCritterDict = {}

	if self._cardItemDict then
		for _, cardItem in pairs(self._cardItemDict) do
			cardItem.simagecritter:UnLoadImage()
			cardItem.simagecardback:UnLoadImage()
			cardItem.click:RemoveClickListener()
			cardItem.drag:RemoveDragBeginListener()
			cardItem.drag:RemoveDragEndListener()
			cardItem.press:RemoveHoverListener()
		end
	end

	self._cardItemDict = {}
	self._isDrag = false
end

function RoomCritterOneKeyView:onClose()
	return
end

function RoomCritterOneKeyView:onDestroyView()
	self:clearVar()
end

return RoomCritterOneKeyView
