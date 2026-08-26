-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_LevelItem__Normal.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_LevelItem__Normal", package.seeall)

local V3a7_Wmz_LevelItem__Normal = class("V3a7_Wmz_LevelItem__Normal", V3a7_Wmz_LevelItemStyleImpl)

function V3a7_Wmz_LevelItem__Normal:onInitView()
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_LevelItem__Normal:addEvents()
	return
end

function V3a7_Wmz_LevelItem__Normal:removeEvents()
	return
end

function V3a7_Wmz_LevelItem__Normal:ctor(...)
	V3a7_Wmz_LevelItem__Normal.super.ctor(self, ...)
end

function V3a7_Wmz_LevelItem__Normal:_editableInitView()
	V3a7_Wmz_LevelItem__Normal.super._editableInitView(self)
end

function V3a7_Wmz_LevelItem__Normal:onDestroyView()
	V3a7_Wmz_LevelItem__Normal.super.onDestroyView(self)
end

return V3a7_Wmz_LevelItem__Normal
