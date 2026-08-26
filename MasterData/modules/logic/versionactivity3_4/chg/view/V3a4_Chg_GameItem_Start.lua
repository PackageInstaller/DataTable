-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameItem_Start.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameItem_Start", package.seeall)

local V3a4_Chg_GameItem_Start = class("V3a4_Chg_GameItem_Start", V3a4_Chg_GameItem_StartEndImpl)

function V3a4_Chg_GameItem_Start:onInitView()
	self._txtNum = gohelper.findChildText(self.viewGO, "Image_NumBG/#txt_Num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_GameItem_Start:addEvents()
	return
end

function V3a4_Chg_GameItem_Start:removeEvents()
	return
end

function V3a4_Chg_GameItem_Start:ctor(ctorParam)
	V3a4_Chg_GameItem_Start.super.ctor(self, ctorParam)
end

function V3a4_Chg_GameItem_Start:_editableInitView()
	self._Image_Prop = gohelper.findChildImage(self.viewGO, "Image_BG")
	self._Image_PropTrans = self._Image_Prop.transform

	V3a4_Chg_GameItem_Start.super._editableInitView(self)
end

function V3a4_Chg_GameItem_Start:setIcon(name, setNativeSize)
	return
end

return V3a4_Chg_GameItem_Start
