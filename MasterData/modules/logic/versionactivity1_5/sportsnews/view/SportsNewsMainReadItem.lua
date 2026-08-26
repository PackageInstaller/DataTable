-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsMainReadItem.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsMainReadItem", package.seeall)

local SportsNewsMainReadItem = class("SportsNewsMainReadItem", LuaCompBase)

function SportsNewsMainReadItem:onInitView()
	self._imageItemBG = gohelper.findChildImage(self.viewGO, "#image_ItemBG")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Info/Click")
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "txt_TitleEn")
	self._scrolldesc = gohelper.findChild(self.viewGO, "Scroll View")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Scroll View/Viewport/#txt_Descr")
	self._goredpoint = gohelper.findChild(self.viewGO, "#go_redpoint")
	self._imagepic = gohelper.findChildSingleImage(self.viewGO, "image_Pic")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SportsNewsMainReadItem:addEvents()
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
end

function SportsNewsMainReadItem:removeEvents()
	self._btnInfo:RemoveClickListener()
end

function SportsNewsMainReadItem:_btnInfoOnClick()
	if self.orderMO.status ~= ActivityWarmUpEnum.OrderStatus.Finished then
		local actId = VersionActivity1_5Enum.ActivityId.SportsNews

		SportsNewsModel.instance:onReadEnd(actId, self.orderMO.id)
	end

	ViewMgr.instance:openView(ViewName.SportsNewsReadView, {
		orderMO = self.orderMO
	})
end

function SportsNewsMainReadItem:_editableInitView()
	return
end

function SportsNewsMainReadItem:onUpdateParam()
	return
end

function SportsNewsMainReadItem:onOpen()
	return
end

function SportsNewsMainReadItem:onClose()
	return
end

function SportsNewsMainReadItem:onDestroyView()
	self:removeEvents()
	self._imagepic:UnLoadImage()
end

function SportsNewsMainReadItem:initData(go, index)
	self.viewGO = go
	self.index = index

	self:onInitView()
	self:addEvents()
end

function SportsNewsMainReadItem:onRefresh(orderMO)
	self.orderMO = orderMO
	self._txttitle.text = tostring(orderMO.cfg.name)
	self._txtTitleEn.text = tostring(orderMO.cfg.titledesc)
	self._txtDescr.text = self.orderMO.cfg.desc

	local iconName = orderMO.cfg.bossPic

	self._imagepic:LoadImage(ResUrl.getV1a5News(iconName))
	RedDotController.instance:addRedDot(self._goredpoint, RedDotEnum.DotNode.v1a5NewsOrder, orderMO.id)

	local _descscroll = self._scrolldesc:GetComponent(gohelper.Type_LimitedScrollRect)

	_descscroll.verticalNormalizedPosition = 1
end

function SportsNewsMainReadItem:onFinish()
	return
end

function SportsNewsMainReadItem:StopAnim()
	return
end

return SportsNewsMainReadItem
