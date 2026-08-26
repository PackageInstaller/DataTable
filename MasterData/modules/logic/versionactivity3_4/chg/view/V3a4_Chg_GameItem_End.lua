-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameItem_End.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameItem_End", package.seeall)

local V3a4_Chg_GameItem_End = class("V3a4_Chg_GameItem_End", V3a4_Chg_GameItem_StartEndImpl)

function V3a4_Chg_GameItem_End:onInitView()
	self._txtNum = gohelper.findChildText(self.viewGO, "Image_NumBG/#txt_Num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_GameItem_End:addEvents()
	return
end

function V3a4_Chg_GameItem_End:removeEvents()
	return
end

function V3a4_Chg_GameItem_End:ctor(ctorParam)
	V3a4_Chg_GameItem_End.super.ctor(self, ctorParam)
end

function V3a4_Chg_GameItem_End:_editableInitView()
	self._Image_Prop = gohelper.findChildImage(self.viewGO, "Image_Head")
	self._Image_PropTrans = self._Image_Prop.transform

	V3a4_Chg_GameItem_End.super._editableInitView(self)
end

function V3a4_Chg_GameItem_End:setInvoked(bInvoked)
	if bInvoked then
		AudioMgr.instance:trigger(AudioEnum3_4.Chg.play_ui_bulaochun_cheng_connect_end)
	end
end

return V3a4_Chg_GameItem_End
