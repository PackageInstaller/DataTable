-- chunkname: @modules/logic/sp01/library/AssassinLibraryHeroInfoItem.lua

module("modules.logic.sp01.library.AssassinLibraryHeroInfoItem", package.seeall)

local AssassinLibraryHeroInfoItem = class("AssassinLibraryHeroInfoItem", AssassinLibraryBaseInfoItem)

function AssassinLibraryHeroInfoItem:init(go)
	AssassinLibraryHeroInfoItem.super.init(self, go)

	self._simageicon = gohelper.findChildSingleImage(self.go, "go_unlocked/simage_icon")
	self._infoAnimator = gohelper.onceAddComponent(self._gounlocked, gohelper.Type_Animator)
end

function AssassinLibraryHeroInfoItem:initRoot(goroot)
	self._goroot = goroot
	self._gounlocked2 = gohelper.findChild(self._goroot, "go_unlocked")
	self._imagebg = gohelper.findChildImage(self._goroot, "image_EmptyBG")

	gohelper.addChild(goroot, self.go)
end

function AssassinLibraryHeroInfoItem:initBody(gobody)
	self._gobody = gobody
	self._gounlocked3 = gohelper.findChild(gobody, "go_unlocked")
	self._bodyAnimator = gohelper.onceAddComponent(self._gounlocked3, gohelper.Type_Animator)
end

function AssassinLibraryHeroInfoItem:refreshUI()
	AssassinLibraryHeroInfoItem.super.refreshUI(self)
	gohelper.setActive(self._gounlocked2, self._status ~= AssassinEnum.LibraryStatus.Locked)
	gohelper.setActive(self._gounlocked3, self._status ~= AssassinEnum.LibraryStatus.Locked)
	self:setLibraryBg(self._imagebg)
end

function AssassinLibraryHeroInfoItem:setIsUsing(isUsing)
	AssassinLibraryHeroInfoItem.super.setIsUsing(self, isUsing)
	gohelper.setActive(self._gobody, isUsing)
	gohelper.setActive(self._gounlocked2, isUsing)
end

function AssassinLibraryHeroInfoItem:playUnlockAnim()
	self._infoAnimator:Play("unlock", 0, 0)
	self._bodyAnimator:Play("unlock", 0, 0)
end

return AssassinLibraryHeroInfoItem
