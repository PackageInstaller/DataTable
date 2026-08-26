-- chunkname: @modules/logic/fight/view/FightInspirationView.lua

module("modules.logic.fight.view.FightInspirationView", package.seeall)

local FightInspirationView = class("FightInspirationView", BaseView)

function FightInspirationView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._godesc1 = gohelper.findChild(self.viewGO, "#go_desc1")
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "#go_desc1/#simage_icon1")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "#go_desc1/#simage_icon2")
	self._godesc2 = gohelper.findChild(self.viewGO, "#go_desc2")
	self._imagecareer4 = gohelper.findChildImage(self.viewGO, "#go_desc2/careers/#image_career4")
	self._imagecareer3 = gohelper.findChildImage(self.viewGO, "#go_desc2/careers/#image_career3")
	self._imagecareer2 = gohelper.findChildImage(self.viewGO, "#go_desc2/careers/#image_career2")
	self._imagecareer1 = gohelper.findChildImage(self.viewGO, "#go_desc2/careers/#image_career1")
	self._imagecareer6 = gohelper.findChildImage(self.viewGO, "#go_desc2/careers/#image_career6")
	self._imagecareer5 = gohelper.findChildImage(self.viewGO, "#go_desc2/careers/#image_career5")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightInspirationView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function FightInspirationView:removeEvents()
	self._btnclick:RemoveClickListener()
end

function FightInspirationView:_btnclickOnClick()
	if self._change then
		self:closeThis()

		return
	end

	gohelper.setActive(self._godesc1, false)
	gohelper.setActive(self._godesc2, true)

	self._change = true
end

function FightInspirationView:_editableInitView()
	gohelper.setActive(self._godesc1, true)
	gohelper.setActive(self._godesc2, false)
	self._simagebg:LoadImage(ResUrl.getFightIcon("bg_zhandouyindao_tanchuang") .. ".png")
	self._simageicon1:LoadImage(ResUrl.getFightIcon("bg_zhandouyindao_kezhi") .. ".png")
	self._simageicon2:LoadImage(ResUrl.getFightIcon("bg_zhandouyindao_beike") .. ".png")
end

function FightInspirationView:onUpdateParam()
	return
end

function FightInspirationView:onOpen()
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer1, "lssx_1")
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer2, "lssx_2")
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer3, "lssx_3")
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer4, "lssx_4")
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer5, "lssx_5")
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer6, "lssx_6")

	self._change = false
end

function FightInspirationView:onClose()
	return
end

function FightInspirationView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageicon1:UnLoadImage()
	self._simageicon2:UnLoadImage()
end

return FightInspirationView
