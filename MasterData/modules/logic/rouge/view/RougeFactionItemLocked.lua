-- chunkname: @modules/logic/rouge/view/RougeFactionItemLocked.lua

module("modules.logic.rouge.view.RougeFactionItemLocked", package.seeall)

local RougeFactionItemLocked = class("RougeFactionItemLocked", RougeFactionItem_Base)

function RougeFactionItemLocked:onInitView()
	self._goBg = gohelper.findChild(self.viewGO, "#go_Bg")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txten = gohelper.findChildText(self.viewGO, "#txt_name/#txt_en")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._txtscrollDesc = gohelper.findChildText(self.viewGO, "#scroll_desc/viewport/content/#txt_scrollDesc")
	self._txtlocked = gohelper.findChildText(self.viewGO, "bg/#txt_locked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFactionItemLocked:addEvents()
	return
end

function RougeFactionItemLocked:removeEvents()
	return
end

function RougeFactionItemLocked:_editableInitView()
	RougeFactionItem_Base._editableInitView(self)

	local limitScrollRectCmp = self._scrolldesc.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)

	self:_onSetScrollParentGameObject(limitScrollRectCmp)

	self._txtlocked.text = ""
end

function RougeFactionItemLocked:_onItemClick()
	return
end

function RougeFactionItemLocked:onDestroyView()
	RougeFactionItem_Base.onDestroyView(self)
end

function RougeFactionItemLocked:setData(mo)
	RougeFactionItem_Base.setData(self, mo)

	local styleCO = mo.styleCO
	local cfg = RougeOutsideModel.instance:config()

	self._txtlocked.text = cfg:getStyleLockDesc(styleCO.id)
end

return RougeFactionItemLocked
