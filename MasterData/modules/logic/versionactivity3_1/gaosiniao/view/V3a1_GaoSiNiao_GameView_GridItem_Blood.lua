-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameView_GridItem_Blood.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_Blood", package.seeall)

local V3a1_GaoSiNiao_GameView_GridItem_Blood = class("V3a1_GaoSiNiao_GameView_GridItem_Blood", V3a1_GaoSiNiao_GameView_GridItem_PieceBase)

function V3a1_GaoSiNiao_GameView_GridItem_Blood:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Blood:addEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Blood:removeEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Blood:ctor(ctorParam)
	V3a1_GaoSiNiao_GameView_GridItem_Blood.super.ctor(self, ctorParam)
end

function V3a1_GaoSiNiao_GameView_GridItem_Blood:_editableInitView()
	V3a1_GaoSiNiao_GameView_GridItem_Blood.super._editableInitView(self)

	self._image_Piece = gohelper.findChild(self.viewGO, "#image_Piece")
	self._image_Blood = gohelper.findChild(self.viewGO, "#image_Blood")
	self._image_Blood_hui = gohelper.findChild(self.viewGO, "#image_Blood_hui")
	self._imgCmpPiece = self._image_Piece:GetComponent(gohelper.Type_Image)

	self:hideBlood()
end

return V3a1_GaoSiNiao_GameView_GridItem_Blood
