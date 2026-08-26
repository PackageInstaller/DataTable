-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGamePlaceBgItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGamePlaceBgItem", package.seeall)

local DianJiShiGamePlaceBgItem = class("DianJiShiGamePlaceBgItem", LuaCompBase)

function DianJiShiGamePlaceBgItem:init(go)
	self.go = go
	self._imageIcon = gohelper.findChildImage(self.go, "image_Icon")
end

function DianJiShiGamePlaceBgItem:addEventListeners()
	return
end

function DianJiShiGamePlaceBgItem:removeEventListeners()
	return
end

function DianJiShiGamePlaceBgItem:onUpdateMO(areaCo, index)
	self._areaCo = areaCo
	self._index = index

	self:refreshUI()
end

function DianJiShiGamePlaceBgItem:refreshUI()
	return
end

return DianJiShiGamePlaceBgItem
