-- chunkname: @modules/logic/sp01/library/AssassinLibraryBaseInfoItem.lua

module("modules.logic.sp01.library.AssassinLibraryBaseInfoItem", package.seeall)

local AssassinLibraryBaseInfoItem = class("AssassinLibraryBaseInfoItem", ListScrollCell)

function AssassinLibraryBaseInfoItem:init(go)
	self.go = go
	self._gounlocked = gohelper.findChild(self.go, "go_unlocked")
	self._goreddot = gohelper.findChild(self.go, "go_unlocked/go_reddot")
	self._golocked = gohelper.findChild(self.go, "go_locked")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "btn_click")
	self._txtname = gohelper.findChildText(self.go, "go_unlocked/txt_name")
	self._simageicon = gohelper.findChildSingleImage(self.go, "go_unlocked/Mask/simage_icon")
end

function AssassinLibraryBaseInfoItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UpdateLibraryReddot, self.tryRefreshUI, self)
end

function AssassinLibraryBaseInfoItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function AssassinLibraryBaseInfoItem:_btnclickOnClick()
	if self._status == AssassinEnum.LibraryStatus.Locked then
		return
	end

	AssassinController.instance:openAssassinLibraryDetailView(self._libraryId)
end

function AssassinLibraryBaseInfoItem:onUpdateMO(libraryCo)
	self:setIsUsing(true)

	self._libraryCo = libraryCo
	self._libraryId = libraryCo and libraryCo.id

	self:tryRefreshUI()
end

function AssassinLibraryBaseInfoItem:tryRefreshUI()
	if not self._isUsing then
		return
	end

	self:refreshUI()
end

function AssassinLibraryBaseInfoItem:refreshUI()
	self._status = AssassinLibraryModel.instance:getLibraryStatus(self._libraryId)
	self._txtname.text = self._libraryCo.title

	AssassinHelper.setLibraryIcon(self._libraryId, self._simageicon)
	gohelper.setActive(self._golocked, self._status == AssassinEnum.LibraryStatus.Locked)
	gohelper.setActive(self._gounlocked, self._status ~= AssassinEnum.LibraryStatus.Locked)
	self:refreshRedDot()

	local isNeedPlayUnlockAnim = AssassinLibraryModel.instance:isLibraryNeedPlayUnlockAnim(self._libraryId)

	if isNeedPlayUnlockAnim then
		self:playUnlockAnim()
		AssassinLibraryModel.instance:markLibraryHasPlayUnlockAnim(self._libraryId)
	end
end

function AssassinLibraryBaseInfoItem:refreshRedDot()
	if not self._isUsing then
		return
	end

	self._redDot = RedDotController.instance:addNotEventRedDot(self._goreddot, self._reddotCheckFunc, self, AssassinEnum.LibraryReddotStyle)

	self._redDot:refreshRedDot()
end

function AssassinLibraryBaseInfoItem:_reddotCheckFunc()
	return self._status == AssassinEnum.LibraryStatus.New
end

function AssassinLibraryBaseInfoItem:playUnlockAnim()
	return
end

function AssassinLibraryBaseInfoItem:setIsUsing(isUsing)
	self._isUsing = isUsing

	gohelper.setActive(self.go, isUsing)
end

function AssassinLibraryBaseInfoItem:setLibraryBg(imageComp)
	local activityId = self._libraryCo.activityId
	local type = self._libraryCo.type
	local bgKey = AssassinHelper.multipleKeys2OneKey(activityId, type)
	local bgName = bgKey and AssassinEnum.ActId2LibraryInfoBgName[bgKey]

	UISpriteSetMgr.instance:setSp01AssassinSprite(imageComp, bgName)
end

return AssassinLibraryBaseInfoItem
