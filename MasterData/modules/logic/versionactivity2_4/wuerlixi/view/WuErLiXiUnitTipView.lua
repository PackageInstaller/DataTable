-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiUnitTipView.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiUnitTipView", package.seeall)

local WuErLiXiUnitTipView = class("WuErLiXiUnitTipView", BaseView)

function WuErLiXiUnitTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrollunits = gohelper.findChildScrollRect(self.viewGO, "#scroll_units")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_units/Viewport/#go_content")
	self._gounititem = gohelper.findChild(self.viewGO, "#scroll_units/Viewport/#go_content/#go_unititem")
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WuErLiXiUnitTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
end

function WuErLiXiUnitTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnclose1:RemoveClickListener()
end

function WuErLiXiUnitTipView:_btncloseOnClick()
	self:closeThis()
end

function WuErLiXiUnitTipView:_btnclose1OnClick()
	self:closeThis()
end

function WuErLiXiUnitTipView:onClickModalMask()
	self:closeThis()
end

function WuErLiXiUnitTipView:_editableInitView()
	self._unitItems = {}
end

function WuErLiXiUnitTipView:onOpen()
	self:refreshUI()
end

function WuErLiXiUnitTipView:refreshUI()
	for _, v in pairs(self._unitItems) do
		v:hide()
	end

	local tipCos = WuErLiXiMapModel.instance:getUnlockElements()

	for _, co in ipairs(tipCos) do
		if not self._unitItems[co.id] then
			self._unitItems[co.id] = WuErLiXiUnitTipItem.New()

			local go = gohelper.cloneInPlace(self._gounititem)

			self._unitItems[co.id]:init(go)
		end

		self._unitItems[co.id]:setItem(co)
	end
end

return WuErLiXiUnitTipView
