-- chunkname: @modules/logic/warmup/v3a8/view/V3a8_WarmUpOpItem.lua

module("modules.logic.warmup.v3a8.view.V3a8_WarmUpOpItem", package.seeall)

local V3a8_WarmUpOpItem = class("V3a8_WarmUpOpItem", RougeSimpleItemBase)

function V3a8_WarmUpOpItem:onInitView()
	self._txtanswer = gohelper.findChildText(self.viewGO, "#txt_answer")
	self._goyes = gohelper.findChild(self.viewGO, "#go_yes")
	self._gono = gohelper.findChild(self.viewGO, "#go_no")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8_WarmUpOpItem:addEvents()
	return
end

function V3a8_WarmUpOpItem:removeEvents()
	return
end

function V3a8_WarmUpOpItem:ctor(...)
	V3a8_WarmUpOpItem.super.ctor(self, ...)
end

function V3a8_WarmUpOpItem:onDestroyView()
	V3a8_WarmUpOpItem.super.onDestroyView(self)
end

function V3a8_WarmUpOpItem:_editableAddEvents()
	self._click:AddClickListener(self._onClick, self)
end

function V3a8_WarmUpOpItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function V3a8_WarmUpOpItem:_editableInitView()
	V3a8_WarmUpOpItem.super._editableInitView(self)

	self._click = gohelper.findChildButtonWithAudio(self.viewGO, "")
	self._txtanswer.text = ""

	self:_clearResult()
end

function V3a8_WarmUpOpItem:setData(mo)
	V3a8_WarmUpOpItem.super.setData(self, mo)

	self._txtanswer.text = mo or ""

	self:_clearResult()
end

function V3a8_WarmUpOpItem:_onClick(mo)
	local bingo = self:_isBingo()

	self:_setActiveYes(bingo)

	if bingo then
		local p = self:parent()

		p:_playAnimAfterSwipe()
	end
end

function V3a8_WarmUpOpItem:_setActive_goyes(bActive)
	gohelper.setActive(self._goyes, bActive)
end

function V3a8_WarmUpOpItem:_setActive_gono(bActive)
	gohelper.setActive(self._gono, bActive)
end

function V3a8_WarmUpOpItem:_setActiveYes(bActive)
	self:_setActive_goyes(bActive)
	self:_setActive_gono(not bActive)
end

function V3a8_WarmUpOpItem:_clearResult()
	self:_setActive_goyes(false)
	self:_setActive_gono(false)
end

function V3a8_WarmUpOpItem:_showResult()
	local bingo = self:_isBingo()

	self:_setActive_goyes(bingo)
end

function V3a8_WarmUpOpItem:_isBingo()
	local playCO = self:_getPlayCO()

	return playCO.answer == self:index()
end

function V3a8_WarmUpOpItem:_getPlayCO()
	local p = self:parent()

	return p:_getPlayCO()
end

return V3a8_WarmUpOpItem
