-- chunkname: @modules/logic/activity/view/V1a5_DoubleFestival_WishPanel.lua

module("modules.logic.activity.view.V1a5_DoubleFestival_WishPanel", package.seeall)

local V1a5_DoubleFestival_WishPanel = class("V1a5_DoubleFestival_WishPanel", BaseView)

function V1a5_DoubleFestival_WishPanel:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "#txt_TitleEn")
	self._txtDescr = gohelper.findChildText(self.viewGO, "scroll/viewport/content/#txt_Descr")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "scroll/viewport/content/#txt_Descr/#image_Icon")
	self._txtDec = gohelper.findChildText(self.viewGO, "#txt_Dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a5_DoubleFestival_WishPanel:addEvents()
	return
end

function V1a5_DoubleFestival_WishPanel:removeEvents()
	return
end

local actId = ActivityEnum.Activity.DoubleFestivalSign_1_5
local sImageHeight
local kMinTxtHeight = 294

function V1a5_DoubleFestival_WishPanel:_editableInitView()
	self._txtDescrTran = self._txtDescr.transform
	self._scroll = gohelper.findChildComponent(self.viewGO, "scroll", gohelper.Type_ScrollRect)
	self._imageIconTran = self._imageIcon.transform
	self._scrollContentTran = self._scroll.content

	self._simagePanelBG:LoadImage(ResUrl.getV1a5SignSingleBg("v1a5_news_bigitembg"))

	sImageHeight = sImageHeight or recthelper.getHeight(self._imageIconTran)
	self._txtDescr.text = ""
	self._txtTitle.text = ""
	self._txtTitleEn.text = ""
	self._txtDec.text = ""
end

function V1a5_DoubleFestival_WishPanel:onOpen()
	local viewParam = self.viewParam
	local day = viewParam.day

	self:_refresh(day)

	local textHeight = self._txtDescrTran.sizeDelta.y

	recthelper.setHeight(self._scrollContentTran, (textHeight <= kMinTxtHeight or nil) and 630)
end

function V1a5_DoubleFestival_WishPanel:_refresh(day)
	local co = ActivityType101Config.instance:getDoubleFestivalCOByDay(actId, day)

	GameUtil.setActive01(self._imageIconTran, co ~= nil)

	if not co then
		return
	end

	UISpriteSetMgr.instance:setV1a5DfSignSprite(self._imageIcon, co.blessSpriteName)

	self._txtTitle.text = co.blessTitle
	self._txtTitleEn.text = co.blessTitleEn
	self._txtDescr.text = co.blessContent
	self._txtDec.text = co.blessDesc
	self._txtDescrTran.sizeDelta = Vector2(self._txtDescrTran.sizeDelta.x, math.max(kMinTxtHeight, self._txtDescr.preferredHeight))
end

function V1a5_DoubleFestival_WishPanel:onClickModalMask()
	self:closeThis()
end

function V1a5_DoubleFestival_WishPanel:onClose()
	local viewParam = self.viewParam

	if viewParam.popupViewBlockKey then
		PopupController.instance:setPause(viewParam.popupViewBlockKey, false)

		viewParam.popupViewBlockKey = nil
	end
end

function V1a5_DoubleFestival_WishPanel:onDestroyView()
	return
end

return V1a5_DoubleFestival_WishPanel
