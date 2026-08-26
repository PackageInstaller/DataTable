-- chunkname: @modules/logic/character/view/CharacterDataUttuView.lua

module("modules.logic.character.view.CharacterDataUttuView", package.seeall)

local CharacterDataUttuView = class("CharacterDataUttuView", BaseView)

function CharacterDataUttuView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simageredcircle1 = gohelper.findChildSingleImage(self.viewGO, "contentview/viewport/content/uttu1/icon/#simage_redcircle1")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "contentview/viewport/content/uttu2/icon/#simage_line")
	self._txtcontent1 = gohelper.findChildText(self.viewGO, "contentview/viewport/content/uttu2/txt/#txt_content1")
	self._txtcontent2 = gohelper.findChildText(self.viewGO, "contentview/viewport/content/uttu2/txt/#txt_content2")
	self._txtcontent3 = gohelper.findChildText(self.viewGO, "contentview/viewport/content/uttu3/txt/#txt_content3")
	self._gosign = gohelper.findChild(self.viewGO, "contentview/viewport/content/uttu3/icon/qianming/#go_sign")
	self._goexplain = gohelper.findChild(self.viewGO, "contentview/viewport/content/uttu3/icon/shouming/#go_explain")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDataUttuView:addEvents()
	return
end

function CharacterDataUttuView:removeEvents()
	return
end

function CharacterDataUttuView:_editableInitView()
	gohelper.setActive(self._gosign, false)
	gohelper.setActive(self._goexplain, false)
	self._simagebg:LoadImage(ResUrl.getCharacterDataIcon("full/bg.png"))
	self._simageredcircle1:LoadImage(ResUrl.getCharacterDataIcon("quan1.png"))
	self._simageline:LoadImage(ResUrl.getCharacterDataIcon("fengexian.png"))

	self._scrollbar = gohelper.findChildScrollbar(self.viewGO, "contentview/contentscrollbar")

	self._scrollbar:AddOnValueChanged(self._onValueChanged, self)

	self._contentEffect1 = gohelper.onceAddComponent(self._txtcontent1.gameObject, typeof(ZProj.TMPEffect))
	self._contentEffect2 = gohelper.onceAddComponent(self._txtcontent2.gameObject, typeof(ZProj.TMPEffect))
	self._contentEffect3 = gohelper.onceAddComponent(self._txtcontent3.gameObject, typeof(ZProj.TMPEffect))
	self._maxValue = 0
	self._content1LineCount = self._txtcontent1:GetTextInfo(self._txtcontent1.text).lineCount
	self._content2LineCount = self._txtcontent2:GetTextInfo(self._txtcontent2.text).lineCount
	self._content3LineCount = self._txtcontent3:GetTextInfo(self._txtcontent3.text).lineCount
end

function CharacterDataUttuView:_onValueChanged(value)
	if self._maxValue > 1 - value then
		self._maxValue = self._maxValue or 1 - value
	end

	if value < 0.1 then
		gohelper.setActive(self._goexplain, true)
	end

	if value < 0.01 then
		gohelper.setActive(self._gosign, true)
	end

	if self._maxValue > 0.1 then
		self._contentEffect1.line = self._content1LineCount * 6 * (self._maxValue - 0.1)
	end

	if self._maxValue > 0.3 then
		self._contentEffect2.line = self._content2LineCount * 6 * (self._maxValue - 0.3)
	end

	if self._maxValue > 0.56 then
		self._contentEffect3.line = self._content3LineCount * 6 * (self._maxValue - 0.56)
	end

	self._contentEffect1:ForceUpdate()
	self._contentEffect2:ForceUpdate()
	self._contentEffect3:ForceUpdate()
end

function CharacterDataUttuView:onUpdateParam()
	return
end

function CharacterDataUttuView:onOpen()
	return
end

function CharacterDataUttuView:onClose()
	return
end

function CharacterDataUttuView:onDestroyView()
	self._scrollbar:RemoveOnValueChanged()
	self._simagebg:UnLoadImage()
	self._simageredcircle1:UnLoadImage()
	self._simageline:UnLoadImage()
end

return CharacterDataUttuView
