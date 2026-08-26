-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameItem_None.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameItem_None", package.seeall)

local V3a4_Chg_GameItem_None = class("V3a4_Chg_GameItem_None", V3a4_Chg_GameItem_ObjBase)

function V3a4_Chg_GameItem_None:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_GameItem_None:addEvents()
	return
end

function V3a4_Chg_GameItem_None:removeEvents()
	return
end

function V3a4_Chg_GameItem_None:ctor(...)
	V3a4_Chg_GameItem_None.super.ctor(self, ...)
end

function V3a4_Chg_GameItem_None:_editableInitView()
	V3a4_Chg_GameItem_None.super._editableInitView(self)
end

return V3a4_Chg_GameItem_None
