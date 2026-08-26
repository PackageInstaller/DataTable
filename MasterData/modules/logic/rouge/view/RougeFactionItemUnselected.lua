-- chunkname: @modules/logic/rouge/view/RougeFactionItemUnselected.lua

module("modules.logic.rouge.view.RougeFactionItemUnselected", package.seeall)

local RougeFactionItemUnselected = class("RougeFactionItemUnselected", RougeFactionItem_Base)

function RougeFactionItemUnselected:onInitView()
	self._goBg = gohelper.findChild(self.viewGO, "#go_Bg")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txten = gohelper.findChildText(self.viewGO, "#txt_name/#txt_en")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._txtscrollDesc = gohelper.findChildText(self.viewGO, "#scroll_desc/viewport/content/#txt_scrollDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFactionItemUnselected:addEvents()
	return
end

function RougeFactionItemUnselected:removeEvents()
	return
end

function RougeFactionItemUnselected:_editableInitView()
	RougeFactionItem_Base._editableInitView(self)

	local limitScrollRectCmp = self._scrolldesc.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)

	self:_onSetScrollParentGameObject(limitScrollRectCmp)
end

function RougeFactionItemUnselected:onDestroyView()
	RougeFactionItem_Base.onDestroyView(self)
end

function RougeFactionItemUnselected:setData(mo)
	RougeFactionItem_Base.setData(self, mo)
end

return RougeFactionItemUnselected
