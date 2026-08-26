-- chunkname: @modules/logic/rouge/view/RougeIllustrationListItem.lua

module("modules.logic.rouge.view.RougeIllustrationListItem", package.seeall)

local RougeIllustrationListItem = class("RougeIllustrationListItem", ListScrollCellExtend)

function RougeIllustrationListItem:onInitView()
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._goUnlocked = gohelper.findChild(self.viewGO, "#go_Unlocked")
	self._gonew = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_new")
	self._simageItemPic = gohelper.findChildSingleImage(self.viewGO, "#go_Unlocked/#simage_ItemPic")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_Unlocked/#txt_Name")
	self._txtNameEn = gohelper.findChildText(self.viewGO, "#go_Unlocked/#txt_Name/#txt_NameEn")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Unlocked/#btn_click")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeIllustrationListItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeIllustrationListItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RougeIllustrationListItem:_btnclickOnClick()
	RougeController.instance:openRougeIllustrationDetailView(self._mo)
end

function RougeIllustrationListItem:_editableInitView()
	gohelper.setActive(self._goSelected, false)

	self._click = gohelper.getClickWithDefaultAudio(self._goLocked, self)

	self._click:AddClickListener(self._onClick, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateFavoriteReddot, self._updateNewFlag, self)
end

function RougeIllustrationListItem:_onClick()
	GameFacade.showToast(ToastEnum.RougeIllustrationLockTip)
end

function RougeIllustrationListItem:_editableAddEvents()
	return
end

function RougeIllustrationListItem:_editableRemoveEvents()
	return
end

function RougeIllustrationListItem:onUpdateMO(mo)
	self._mo = mo.config

	self._simageItemPic:LoadImage(self._mo.image)

	self._txtName.text = self._mo.name
	self._txtNameEn.text = self._mo.nameEn

	if UnityEngine.Time.frameCount - RougeIllustrationListModel.instance.startFrameCount < 10 then
		self._aniamtor = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

		self._aniamtor:Play("open")
	end

	local isUnlock = RougeOutsideModel.instance:passedAnyEventId(mo.eventIdList)

	gohelper.setActive(self._goUnlocked, isUnlock)
	gohelper.setActive(self._goLocked, not isUnlock)

	if isUnlock then
		self:_updateNewFlag()
	end
end

function RougeIllustrationListItem:_updateNewFlag()
	self._showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Illustration, self._mo.id) ~= nil

	gohelper.setActive(self._gonew, self._showNewFlag)
end

function RougeIllustrationListItem:onSelect(isSelect)
	return
end

function RougeIllustrationListItem:onDestroyView()
	if self._click then
		self._click:RemoveClickListener()
	end
end

return RougeIllustrationListItem
