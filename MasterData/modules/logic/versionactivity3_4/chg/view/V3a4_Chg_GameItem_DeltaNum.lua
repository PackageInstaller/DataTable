-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameItem_DeltaNum.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameItem_DeltaNum", package.seeall)

local V3a4_Chg_GameItem_DeltaNum = class("V3a4_Chg_GameItem_DeltaNum", RougeSimpleItemBase)

function V3a4_Chg_GameItem_DeltaNum:ctor(...)
	V3a4_Chg_GameItem_DeltaNum.super.ctor(self, ...)
end

function V3a4_Chg_GameItem_DeltaNum:_editableInitView()
	V3a4_Chg_GameItem_DeltaNum.super._editableInitView(self)

	self._txt = gohelper.findChildText(self.viewGO, "")

	self:stop()
end

function V3a4_Chg_GameItem_DeltaNum:play(str)
	gohelper.setActive(self.viewGO, true)

	self._txt.text = str
end

function V3a4_Chg_GameItem_DeltaNum:stop()
	gohelper.setActive(self.viewGO, false)
end

return V3a4_Chg_GameItem_DeltaNum
