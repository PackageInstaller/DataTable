-- chunkname: @modules/logic/sp01/library/AssassinLibraryListInfoItem.lua

module("modules.logic.sp01.library.AssassinLibraryListInfoItem", package.seeall)

local AssassinLibraryListInfoItem = class("AssassinLibraryListInfoItem", AssassinLibraryBaseInfoItem)

function AssassinLibraryListInfoItem:init(go)
	AssassinLibraryListInfoItem.super.init(self, go)

	self._txtindex = gohelper.findChildText(self.go, "txt_index")
	self._imagebg = gohelper.findChildImage(self.go, "image_BG")
end

function AssassinLibraryListInfoItem:onUpdateMO(libraryCo)
	AssassinLibraryListInfoItem.super.onUpdateMO(self, libraryCo)

	self._txtindex.text = string.format("%2d", self._index)

	self:setLibraryBg(self._imagebg)
end

return AssassinLibraryListInfoItem
