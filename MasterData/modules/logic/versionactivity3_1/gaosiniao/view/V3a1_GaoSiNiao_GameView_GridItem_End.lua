-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameView_GridItem_End.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_End", package.seeall)

local V3a1_GaoSiNiao_GameView_GridItem_End = class("V3a1_GaoSiNiao_GameView_GridItem_End", V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl)

function V3a1_GaoSiNiao_GameView_GridItem_End:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_End:addEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_End:removeEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_End:ctor(ctorParam)
	V3a1_GaoSiNiao_GameView_GridItem_End.super.ctor(self, ctorParam)
end

function V3a1_GaoSiNiao_GameView_GridItem_End:_editableInitView()
	V3a1_GaoSiNiao_GameView_GridItem_End.super._editableInitView(self)
end

return V3a1_GaoSiNiao_GameView_GridItem_End
