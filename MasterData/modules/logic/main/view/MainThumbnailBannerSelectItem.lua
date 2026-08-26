-- chunkname: @modules/logic/main/view/MainThumbnailBannerSelectItem.lua

module("modules.logic.main.view.MainThumbnailBannerSelectItem", package.seeall)

local MainThumbnailBannerSelectItem = class("MainThumbnailBannerSelectItem", LuaCompBase)

function MainThumbnailBannerSelectItem:init(param)
	self._go = param.go
	self._pageIndex = param.index
	self._normalGo = gohelper.findChild(self._go, "#go_nomalstar")
	self._selectedGo = gohelper.findChild(self._go, "#go_lightstar")

	transformhelper.setLocalPos(self._go.transform, param.pos, 0, 0)
end

function MainThumbnailBannerSelectItem:updateItem(index, maxIndex)
	local isTarget = self._pageIndex == index

	gohelper.setActive(self._selectedGo, isTarget and maxIndex > 1)
	gohelper.setActive(self._normalGo, not isTarget and maxIndex > 1)
end

function MainThumbnailBannerSelectItem:destroy()
	return
end

return MainThumbnailBannerSelectItem
