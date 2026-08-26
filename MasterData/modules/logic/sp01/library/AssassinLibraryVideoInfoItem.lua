-- chunkname: @modules/logic/sp01/library/AssassinLibraryVideoInfoItem.lua

module("modules.logic.sp01.library.AssassinLibraryVideoInfoItem", package.seeall)

local AssassinLibraryVideoInfoItem = class("AssassinLibraryVideoInfoItem", AssassinLibraryBaseInfoItem)

function AssassinLibraryVideoInfoItem:init(go)
	AssassinLibraryVideoInfoItem.super.init(self, go)

	self._txtindex = gohelper.findChildText(self.go, "txt_index")
	self._gostairs1 = gohelper.findChild(self.go, "#go_Stairs1")
	self._gostairs2 = gohelper.findChild(self.go, "#go_Stairs2")
	self._imagebg = gohelper.findChildImage(self.go, "image_BG")
	self._goplay = gohelper.findChild(self.go, "image_Play")
	self._txtname = gohelper.findChildText(self.go, "go_unlocked/image_TitleBG/txt_name")
end

function AssassinLibraryVideoInfoItem:updateIndex(allVideoCount, index)
	self._allVideoCount = allVideoCount
	self._index = index
end

function AssassinLibraryVideoInfoItem:onUpdateMO(libraryCo)
	AssassinLibraryVideoInfoItem.super.onUpdateMO(self, libraryCo)

	self._txtindex.text = string.format("%2d", self._index)

	gohelper.setActive(self._gostairs1, self._index > 1)
	gohelper.setActive(self._gostairs2, self._index < self._allVideoCount)
	self:setLibraryBg(self._imagebg)
end

function AssassinLibraryVideoInfoItem:refreshUI()
	AssassinLibraryVideoInfoItem.super.refreshUI(self)
	gohelper.setActive(self._goplay, self._status ~= AssassinEnum.LibraryStatus.Locked)
end

return AssassinLibraryVideoInfoItem
