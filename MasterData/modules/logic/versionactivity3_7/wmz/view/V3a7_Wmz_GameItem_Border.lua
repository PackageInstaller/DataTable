-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItem_Border.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItem_Border", package.seeall)

local V3a7_Wmz_GameItem_Border = class("V3a7_Wmz_GameItem_Border", V3a7_Wmz_GameItemFrameImpl)

function V3a7_Wmz_GameItem_Border:onInitView()
	self._goLeft = gohelper.findChild(self.viewGO, "#go_Left")
	self._goBottom = gohelper.findChild(self.viewGO, "#go_Bottom")
	self._goRight = gohelper.findChild(self.viewGO, "#go_Right")
	self._goTop = gohelper.findChild(self.viewGO, "#go_Top")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_GameItem_Border:addEvents()
	return
end

function V3a7_Wmz_GameItem_Border:removeEvents()
	return
end

function V3a7_Wmz_GameItem_Border:ctor(...)
	V3a7_Wmz_GameItem_Border.super.ctor(self, ...)
end

function V3a7_Wmz_GameItem_Border:_editableInitView()
	V3a7_Wmz_GameItem_Border.super._editableInitView(self)
end

function V3a7_Wmz_GameItem_Border:onDestroyView()
	V3a7_Wmz_GameItem_Border.super.onDestroyView(self)
end

return V3a7_Wmz_GameItem_Border
