-- chunkname: @modules/logic/rouge/view/RougeFactionIllustrationItem.lua

module("modules.logic.rouge.view.RougeFactionIllustrationItem", package.seeall)

local RougeFactionIllustrationItem = class("RougeFactionIllustrationItem", ListScrollCellExtend)

function RougeFactionIllustrationItem:onInitView()
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._goBg = gohelper.findChild(self.viewGO, "#go_Locked/#go_Bg")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_Locked/#image_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_Locked/#txt_name")
	self._txten = gohelper.findChildText(self.viewGO, "#go_Locked/#txt_name/#txt_en")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#go_Locked/#scroll_desc")
	self._txtscrollDesc = gohelper.findChildText(self.viewGO, "#go_Locked/#scroll_desc/viewport/content/#txt_scrollDesc")
	self._txtlocked = gohelper.findChildText(self.viewGO, "#go_Locked/bg/#txt_locked")
	self._goUnselect = gohelper.findChild(self.viewGO, "#go_Unselect")
	self._goBg2 = gohelper.findChild(self.viewGO, "#go_Unselect/#go_Bg2")
	self._gonew = gohelper.findChild(self.viewGO, "#go_Unselect/#go_new")
	self._imageicon2 = gohelper.findChildImage(self.viewGO, "#go_Unselect/#image_icon2")
	self._txtname2 = gohelper.findChildText(self.viewGO, "#go_Unselect/#txt_name2")
	self._txten2 = gohelper.findChildText(self.viewGO, "#go_Unselect/#txt_name2/#txt_en2")
	self._scrolldesc2 = gohelper.findChildScrollRect(self.viewGO, "#go_Unselect/#scroll_desc2")
	self._txtscrollDesc2 = gohelper.findChildText(self.viewGO, "#go_Unselect/#scroll_desc2/viewport/content/#txt_scrollDesc2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFactionIllustrationItem:addEvents()
	return
end

function RougeFactionIllustrationItem:removeEvents()
	return
end

function RougeFactionIllustrationItem:_editableInitView()
	self._click = gohelper.getClickWithDefaultAudio(self._goBg2, self)
	self._clickLocked = gohelper.getClickWithDefaultAudio(self._goLocked, self)

	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateFavoriteReddot, self._updateNewFlag, self)
end

function RougeFactionIllustrationItem:_editableAddEvents()
	self._click:AddClickListener(self._onClickHandler, self)
	self._clickLocked:AddClickListener(self._onClickLockedHandler, self)
end

function RougeFactionIllustrationItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
	self._clickLocked:RemoveClickListener()
end

function RougeFactionIllustrationItem:onUpdateMO(mo)
	self._isUnlocked = mo.isUnLocked
	self._mo = mo.styleCO

	gohelper.setActive(self._goUnselect, self._isUnlocked)
	gohelper.setActive(self._goLocked, not self._isUnlocked)

	if not self._isUnlocked then
		local cfg = RougeOutsideModel.instance:config()

		self._txtlocked.text = cfg:getStyleLockDesc(self._mo.id)

		self:_updateInfo(self._txtname, self._txten, self._txtscrollDesc, self._imageicon)
	else
		self:_updateInfo(self._txtname2, self._txten2, self._txtscrollDesc2, self._imageicon2)
		self:_updateNewFlag()
	end
end

function RougeFactionIllustrationItem:_updateNewFlag()
	self._showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Faction, self._mo.id) ~= nil

	gohelper.setActive(self._gonew, self._showNewFlag)
end

function RougeFactionIllustrationItem:_updateInfo(txtname, txten, txtscrollDesc, imageicon)
	txtname.text = self._mo.name
	txtscrollDesc.text = self._mo.desc

	UISpriteSetMgr.instance:setRouge2Sprite(imageicon, string.format("%s_light", self._mo.icon))
	gohelper.setActive(txten, false)
end

function RougeFactionIllustrationItem:_onClickLockedHandler()
	GameFacade.showToast(ToastEnum.RougeFactionLockTip)
end

function RougeFactionIllustrationItem:_onClickHandler()
	RougeController.instance:openRougeFactionIllustrationDetailView(self._mo)
end

function RougeFactionIllustrationItem:onSelect(isSelect)
	return
end

function RougeFactionIllustrationItem:onDestroyView()
	return
end

return RougeFactionIllustrationItem
