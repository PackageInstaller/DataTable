-- chunkname: @modules/logic/v3a8_dragonboat/view/V3a8_DragonBoatActivity_BoatItem.lua

module("modules.logic.v3a8_dragonboat.view.V3a8_DragonBoatActivity_BoatItem", package.seeall)

local V3a8_DragonBoatActivity_BoatItem = class("V3a8_DragonBoatActivity_BoatItem", V3a8_DragonBoatActivity_BubbleItem)

function V3a8_DragonBoatActivity_BoatItem:onInitView()
	self._gotag = gohelper.findChild(self.viewGO, "#go_tag")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_tag/#txt_desc")
	self._gowin = gohelper.findChild(self.viewGO, "#go_win")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8_DragonBoatActivity_BoatItem:addEvents()
	return
end

function V3a8_DragonBoatActivity_BoatItem:removeEvents()
	return
end

function V3a8_DragonBoatActivity_BoatItem:ctor(...)
	V3a8_DragonBoatActivity_BoatItem.super.ctor(self, ...)
end

function V3a8_DragonBoatActivity_BoatItem:_editableInitView()
	V3a8_DragonBoatActivity_BoatItem.super._editableInitView(self)

	self._waveGo = gohelper.findChild(self.viewGO, "go_boat/img_boat/node_wavespeed")

	self:setActive_goWin(false)
	self:setActive_waveGo(false)
	self:setBubbleType(V3a8_DragonBoatEnum.BubbleType.Boat)
end

function V3a8_DragonBoatActivity_BoatItem:onDestroyView()
	V3a8_DragonBoatActivity_BoatItem.super.onDestroyView(self)
end

function V3a8_DragonBoatActivity_BoatItem:setData(mo)
	V3a8_DragonBoatActivity_BoatItem.super.setData(self, mo)
	self:setActive_goWin(self:bWin())
end

function V3a8_DragonBoatActivity_BoatItem:setActive_goWin(bActive)
	gohelper.setActive(self._gowin, bActive)
end

function V3a8_DragonBoatActivity_BoatItem:setActive_waveGo(bActive)
	gohelper.setActive(self._waveGo, bActive)

	if bActive then
		local c = self:baseViewContainer()

		c:play_ui_shiji_vote_success()
	end
end

function V3a8_DragonBoatActivity_BoatItem:eOp()
	return self._mo.optionId
end

function V3a8_DragonBoatActivity_BoatItem:bBlue()
	return self:eOp() == V3a8_DragonBoatEnum.Op.Blue
end

function V3a8_DragonBoatActivity_BoatItem:bRed()
	return self:eOp() == V3a8_DragonBoatEnum.Op.Red
end

function V3a8_DragonBoatActivity_BoatItem:bWin()
	local c = self:baseViewContainer()

	return self:bBlue() and c:bBlueWin() or c:bRedWin()
end

return V3a8_DragonBoatActivity_BoatItem
