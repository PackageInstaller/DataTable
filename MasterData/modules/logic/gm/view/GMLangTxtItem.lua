-- chunkname: @modules/logic/gm/view/GMLangTxtItem.lua

module("modules.logic.gm.view.GMLangTxtItem", package.seeall)

local GMLangTxtItem = class("GMLangTxtItem", ListScrollCell)

function GMLangTxtItem:init(go)
	self._txt = gohelper.findChildText(go, "txt")
	self._click = SLFramework.UGUI.UIClickListener.Get(go)

	self._click:AddClickListener(self._onClick, self)
end

function GMLangTxtItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function GMLangTxtItem:onUpdateMO(mo)
	self._data = mo.txt
	self._txt.text = mo.txt
end

function GMLangTxtItem:_onClick()
	self._view.viewContainer:onLangTxtClick(self._data)
end

return GMLangTxtItem
