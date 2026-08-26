-- chunkname: @modules/logic/store/view/DecorateStoreGoodsTipView.lua

module("modules.logic.store.view.DecorateStoreGoodsTipView", package.seeall)

local DecorateStoreGoodsTipView = class("DecorateStoreGoodsTipView", RoomMaterialTipView)

function DecorateStoreGoodsTipView:_editableInitView()
	DecorateStoreGoodsTipView.super._editableInitView(self)

	self._simagetheme = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/iconmask/simage_theme")
	self._goitemContent = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/go_itemContent")
	self._simageinfobg = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/simage_infobg")
	self._txtdesc = gohelper.findChildText(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/txt_desc")
	self._txtname = gohelper.findChildText(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/txt_desc/txt_name")
	self._goslider = gohelper.findChild(self.viewGO, "left/banner/#go_slider")
	self._gospecialTag = gohelper.findChild(self._txtname.gameObject, "go_playercardTag")
	self._goswitch = gohelper.findChild(self.viewGO, "left/#go_switch")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "left/#go_switch/#btn_right")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "left/#go_switch/#btn_left")
	self._btnoverview = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_overview")
	self._goslider = gohelper.findChild(self.viewGO, "left/banner/#go_slider")
	self._gosliderPoint = gohelper.findChild(self.viewGO, "left/banner/#go_slider/go_bannerSelectItem")

	gohelper.setActive(self._gosliderPoint.gameObject, false)

	self._pagePointItems = self:getUserDataTb_()
end

local PageCount = 2

function DecorateStoreGoodsTipView:onClickModalMask()
	self:closeThis()
end

function DecorateStoreGoodsTipView:addEvents()
	DecorateStoreGoodsTipView.super.addEvents(self)
	self._btnoverview:AddClickListener(self._btnoverviewOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
end

function DecorateStoreGoodsTipView:removeEvents()
	DecorateStoreGoodsTipView.super.removeEvents(self)
	self._btnoverview:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnleft:RemoveClickListener()
end

function DecorateStoreGoodsTipView:_btnoverviewOnClick()
	PlayerCardController.instance:ShowChangeBgSkin(self._config.id, nil, true)
end

function DecorateStoreGoodsTipView:_btnrightOnClick()
	local index

	self:_refreshSpecialInfo(self._showIndex >= PageCount and 1 or self._showIndex + 1)
end

function DecorateStoreGoodsTipView:_btnleftOnClick()
	local index

	self:_refreshSpecialInfo(self._showIndex <= 1 and PageCount or self._showIndex - 1)
end

function DecorateStoreGoodsTipView:_refreshUI()
	DecorateStoreGoodsTipView.super._refreshUI(self)
	gohelper.setActive(self._goitemContent.gameObject, false)
	gohelper.setActive(self._goslider.gameObject, false)

	self._txtdesc.text = self._config.desc
	self._txtname.text = self._config.name

	self._simageinfobg:LoadImage(ResUrl.getRoomImage("bg_zhezhao_yinying"))

	local isSpecial = PlayerCardModel.instance:isSpecialCardSkin(self._config.id)

	if isSpecial then
		self:_refreshSpecialUI()
	else
		self:_refreshThemeImage(self._config.id)
	end

	gohelper.setActive(self._gospecialTag.gameObject, isSpecial)
	gohelper.setActive(self._goswitch.gameObject, isSpecial)
	gohelper.setActive(self._btnoverview.gameObject, isSpecial)
	gohelper.setActive(self._btnright.gameObject, isSpecial)
	gohelper.setActive(self._btnleft.gameObject, isSpecial)
	gohelper.setActive(self._goslider.gameObject, isSpecial)
end

function DecorateStoreGoodsTipView:_refreshThemeImage(icon)
	self._simagetheme:LoadImage(ResUrl.getDecorateStoreBuyBannerFullPath(icon), function()
		ZProj.UGUIHelper.SetImageSize(self._simagetheme.gameObject)
	end, self)
end

function DecorateStoreGoodsTipView:_refreshSpecialUI()
	self:_refreshSpecialInfo(1)
end

function DecorateStoreGoodsTipView:_refreshSpecialInfo(index)
	self._showIndex = index

	local imageName = self._config.id

	imageName = index > 1 and imageName .. "_" .. index - 1 or imageName

	self:_refreshThemeImage(imageName)

	for i = 1, PageCount do
		local item = self:_getPagePoint(i)

		gohelper.setActive(item.go.gameObject, true)
		gohelper.setActive(item.gonormal.gameObject, index ~= i)
		gohelper.setActive(item.golight.gameObject, index == i)
	end
end

function DecorateStoreGoodsTipView:_getPagePoint(index)
	local item = self._pagePointItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gosliderPoint)
		item.gonormal = gohelper.findChild(item.go, "go_nomalstar")
		item.golight = gohelper.findChild(item.go, "go_lightstar")
		self._pagePointItems[index] = item
	end

	return item
end

function DecorateStoreGoodsTipView:onDestroyView()
	DecorateStoreGoodsTipView.super.onDestroyView(self)
	self._simagetheme:UnLoadImage()
	self._simageinfobg:UnLoadImage()
end

return DecorateStoreGoodsTipView
