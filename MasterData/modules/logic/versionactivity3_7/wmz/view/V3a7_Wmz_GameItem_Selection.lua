-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItem_Selection.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItem_Selection", package.seeall)

local V3a7_Wmz_GameItem_Selection = class("V3a7_Wmz_GameItem_Selection", V3a7_Wmz_GameItemFrameImpl)

function V3a7_Wmz_GameItem_Selection:onInitView()
	self._goTopLeft = gohelper.findChild(self.viewGO, "#go_TopLeft")
	self._goLeft = gohelper.findChild(self.viewGO, "#go_Left")
	self._goBottomLeft = gohelper.findChild(self.viewGO, "#go_BottomLeft")
	self._goBottom = gohelper.findChild(self.viewGO, "#go_Bottom")
	self._goBottomRight = gohelper.findChild(self.viewGO, "#go_BottomRight")
	self._goRight = gohelper.findChild(self.viewGO, "#go_Right")
	self._goTopRight = gohelper.findChild(self.viewGO, "#go_TopRight")
	self._goTop = gohelper.findChild(self.viewGO, "#go_Top")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_GameItem_Selection:addEvents()
	return
end

function V3a7_Wmz_GameItem_Selection:removeEvents()
	return
end

function V3a7_Wmz_GameItem_Selection:ctor(...)
	V3a7_Wmz_GameItem_Selection.super.ctor(self, ...)
end

function V3a7_Wmz_GameItem_Selection:_editableInitView()
	V3a7_Wmz_GameItem_Selection.super._editableInitView(self)
end

function V3a7_Wmz_GameItem_Selection:onDestroyView()
	V3a7_Wmz_GameItem_Selection.super.onDestroyView(self)
end

function V3a7_Wmz_GameItem_Selection:setData(mo)
	V3a7_Wmz_GameItem_Selection.super.setData(self, mo)
	UIDockingHelper.setDock(UIDockingHelper.Dock.MM_M, self:transform(), mo:transform())

	if isDebugBuild then
		self:setName(string.format("%s", mo:indexStr()))
	end
end

return V3a7_Wmz_GameItem_Selection
