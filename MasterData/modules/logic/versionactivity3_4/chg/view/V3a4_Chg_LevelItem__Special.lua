-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_LevelItem__Special.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_LevelItem__Special", package.seeall)

local V3a4_Chg_LevelItem__Special = class("V3a4_Chg_LevelItem__Special", V3a4_Chg_LevelItemStyleImpl)

function V3a4_Chg_LevelItem__Special:onInitView()
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_LevelItem__Special:addEvents()
	return
end

function V3a4_Chg_LevelItem__Special:removeEvents()
	return
end

function V3a4_Chg_LevelItem__Special:ctor(...)
	V3a4_Chg_LevelItem__Special.super.ctor(self, ...)
end

function V3a4_Chg_LevelItem__Special:_editableInitView()
	V3a4_Chg_LevelItem__Special.super._editableInitView(self)
end

function V3a4_Chg_LevelItem__Special:onDestroyView()
	V3a4_Chg_LevelItem__Special.super.onDestroyView(self)
end

return V3a4_Chg_LevelItem__Special
