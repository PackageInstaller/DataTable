-- chunkname: @modules/logic/gm/view/GMErrorItem.lua

module("modules.logic.gm.view.GMErrorItem", package.seeall)

local GMErrorItem = class("GMErrorItem", ListScrollCell)

function GMErrorItem:init(go)
	self._go = go
	self._text = gohelper.findChildText(go, "text")
	self._click = gohelper.getClickWithAudio(go)
	self._selectGO = gohelper.findChild(go, "select")
end

function GMErrorItem:addEventListeners()
	self._click:AddClickListener(self._onClickThis, self)
end

function GMErrorItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function GMErrorItem:onUpdateMO(mo)
	self._mo = mo
	self._text.text = string.format("%s %s", os.date("%H:%M:%S", mo.time), mo.msg)
end

function GMErrorItem:onSelect(isSelect)
	gohelper.setActive(self._selectGO, isSelect)

	if isSelect then
		GMController.instance:dispatchEvent(GMEvent.GMLogView_Select, self._mo)
	end
end

function GMErrorItem:_onClickThis()
	self._view:setSelect(self._mo)
end

return GMErrorItem
