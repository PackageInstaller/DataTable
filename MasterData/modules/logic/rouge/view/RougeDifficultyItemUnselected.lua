-- chunkname: @modules/logic/rouge/view/RougeDifficultyItemUnselected.lua

module("modules.logic.rouge.view.RougeDifficultyItemUnselected", package.seeall)

local RougeDifficultyItemUnselected = class("RougeDifficultyItemUnselected", RougeDifficultyItem_Base)

function RougeDifficultyItemUnselected:onInitView()
	self._goBg1 = gohelper.findChild(self.viewGO, "bg/#go_Bg1")
	self._goBg2 = gohelper.findChild(self.viewGO, "bg/#go_Bg2")
	self._goBg3 = gohelper.findChild(self.viewGO, "bg/#go_Bg3")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "num/#txt_num1")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "num/#txt_num2")
	self._txtnum3 = gohelper.findChildText(self.viewGO, "num/#txt_num3")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txten = gohelper.findChildText(self.viewGO, "#txt_name/#txt_en")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._txtScrollDesc = gohelper.findChildText(self.viewGO, "#scroll_desc/viewport/content/#txt_ScrollDesc")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeDifficultyItemUnselected:addEvents()
	return
end

function RougeDifficultyItemUnselected:removeEvents()
	return
end

function RougeDifficultyItemUnselected:_editableInitView()
	RougeDifficultyItem_Base._editableInitView(self)

	self._scrolldescLimitScrollRectCmp = self._scrolldesc.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)

	self:_onSetScrollParentGameObject(self._scrolldescLimitScrollRectCmp)
end

function RougeDifficultyItemUnselected:onDestroyView()
	RougeDifficultyItem_Base.onDestroyView(self)
end

function RougeDifficultyItemUnselected:setData(mo)
	RougeDifficultyItem_Base.setData(self, mo)

	local difficultyCO = mo.difficultyCO

	self._txtScrollDesc.text = difficultyCO.desc
end

return RougeDifficultyItemUnselected
