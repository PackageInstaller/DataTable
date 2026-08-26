-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameView_GridItem_Start.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_Start", package.seeall)

local V3a1_GaoSiNiao_GameView_GridItem_Start = class("V3a1_GaoSiNiao_GameView_GridItem_Start", V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl)

function V3a1_GaoSiNiao_GameView_GridItem_Start:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Start:addEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Start:removeEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Start:ctor(ctorParam)
	V3a1_GaoSiNiao_GameView_GridItem_Start.super.ctor(self, ctorParam)
end

function V3a1_GaoSiNiao_GameView_GridItem_Start:_editableInitView()
	V3a1_GaoSiNiao_GameView_GridItem_Start.super._editableInitView(self)
end

return V3a1_GaoSiNiao_GameView_GridItem_Start
