-- chunkname: @modules/logic/room/view/transport/RoomTransportPathFailTips.lua

module("modules.logic.room.view.transport.RoomTransportPathFailTips", package.seeall)

local RoomTransportPathFailTips = class("RoomTransportPathFailTips", BaseView)

function RoomTransportPathFailTips:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#btn_tips")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/expand/#btn_close")
	self._scrolldec = gohelper.findChildScrollRect(self.viewGO, "#go_content/expand/bg/#scroll_dec")
	self._godecitem = gohelper.findChild(self.viewGO, "#go_content/expand/bg/#scroll_dec/viewport/content/#go_decitem")
	self._txtdec = gohelper.findChildText(self.viewGO, "#go_content/expand/bg/#scroll_dec/viewport/content/#go_decitem/#txt_dec")
	self._txtfailcount = gohelper.findChildText(self.viewGO, "#go_content/#txt_failcount")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTransportPathFailTips:addEvents()
	self._btntips:AddClickListener(self._btntipsOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomTransportPathFailTips:removeEvents()
	self._btntips:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function RoomTransportPathFailTips:_btntipsOnClick()
	self._isShow = true

	gohelper.setActive(self._goexpand, true)
	gohelper.setActive(self._btntips, false)
	self._animatorPlayer:Play(UIAnimationName.Open, self._animDone, self)
end

function RoomTransportPathFailTips:_btncloseOnClick()
	self._isShow = false

	self._animatorPlayer:Play(UIAnimationName.Close, self._animDone, self)
end

function RoomTransportPathFailTips:_editableInitView()
	self._goexpand = gohelper.findChild(self.viewGO, "#go_content/expand")

	gohelper.setActive(self._goexpand, false)

	self._isShow = false
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self._goexpand)
	self._slotDataList = {
		{
			slotType = RoomBuildingEnum.BuildingType.Collect
		},
		{
			slotType = RoomBuildingEnum.BuildingType.Process
		},
		{
			slotType = RoomBuildingEnum.BuildingType.Manufacture
		}
	}
	self._tbItemList = {
		self:_createTB(self._godecitem)
	}

	for i = 1, #self._slotDataList do
		local tbItem = self._tbItemList[i]

		if tbItem == nil then
			local go = gohelper.cloneInPlace(self._godecitem)

			tbItem = self:_createTB(go)

			table.insert(self._tbItemList, tbItem)
		end

		tbItem.dataMO = self._slotDataList[i]

		local langKey = RoomTransportPathEnum.TipLang[tbItem.dataMO.slotType]

		tbItem._txtdec.text = luaLang(langKey)
	end
end

function RoomTransportPathFailTips:_animDone()
	if not self._isShow then
		gohelper.setActive(self._goexpand, false)
		gohelper.setActive(self._btntips, true)
	end
end

function RoomTransportPathFailTips:onUpdateParam()
	return
end

function RoomTransportPathFailTips:onOpen()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TransportPathLineChanged, self.refreshUI, self)
	self:refreshUI()
end

function RoomTransportPathFailTips:onClose()
	return
end

function RoomTransportPathFailTips:onDestroyView()
	return
end

function RoomTransportPathFailTips:refreshUI()
	local tRoomMapTransportPathModel = RoomMapTransportPathModel.instance
	local failCount = tRoomMapTransportPathModel:getLinkFailCount()

	if self._lastFailCount ~= failCount then
		self._lastFailCount = failCount

		gohelper.setActive(self._gocontent, failCount > 0)

		self._txtfailcount.text = failCount
	end

	if failCount > 0 then
		self:_refreshItemTbList()
	end
end

function RoomTransportPathFailTips:_refreshItemTbList()
	local tRoomMapTransportPathModel = RoomMapTransportPathModel.instance

	for i = 1, #self._tbItemList do
		local tbItem = self._tbItemList[i]
		local fromType, toType = RoomTransportHelper.getSiteFromToByType(tbItem.dataMO.slotType)
		local transportPathMO = tRoomMapTransportPathModel:getTransportPathMOBy2Type(fromType, toType)

		gohelper.setActive(tbItem.go, (transportPathMO and transportPathMO:isLinkFinish() or nil) and false)
	end
end

function RoomTransportPathFailTips:_createTB(go)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb._txtdec = gohelper.findChildText(go, "#txt_dec")

	return tb
end

RoomTransportPathFailTips.prefabPath = "ui/viewres/room/transport/roomtransportpathfailtips.prefab"

return RoomTransportPathFailTips
