-- chunkname: @modules/logic/sp01/library/AssassinLibraryVideoListItem.lua

module("modules.logic.sp01.library.AssassinLibraryVideoListItem", package.seeall)

local AssassinLibraryVideoListItem = class("AssassinLibraryVideoListItem", ListScrollCell)

function AssassinLibraryVideoListItem:init(go)
	self.go = go
	self._goleft = gohelper.findChild(self.go, "#go_Odd")
	self._goright = gohelper.findChild(self.go, "#go_Even")
	self._leftInfoIetem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goleft, AssassinLibraryVideoInfoItem)
	self._rightInfoIetem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goright, AssassinLibraryVideoInfoItem)
end

function AssassinLibraryVideoListItem:onUpdateMO(libraryCo)
	local isUseLeft = self._index % 2 == 1
	local allVideoCount = self._view._model:getCount()

	if isUseLeft then
		self._leftInfoIetem:updateIndex(allVideoCount, self._index)
		self._leftInfoIetem:onUpdateMO(libraryCo)
		self._rightInfoIetem:setIsUsing(false)
	else
		self._leftInfoIetem:setIsUsing(false)
		self._rightInfoIetem:updateIndex(allVideoCount, self._index)
		self._rightInfoIetem:onUpdateMO(libraryCo)
	end
end

return AssassinLibraryVideoListItem
