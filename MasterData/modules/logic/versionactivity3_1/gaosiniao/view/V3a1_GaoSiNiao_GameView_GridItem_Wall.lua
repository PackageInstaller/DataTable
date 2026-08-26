-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameView_GridItem_Wall.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_Wall", package.seeall)

local V3a1_GaoSiNiao_GameView_GridItem_Wall = class("V3a1_GaoSiNiao_GameView_GridItem_Wall", V3a1_GaoSiNiao_GameView_GridItem_PieceBase)

function V3a1_GaoSiNiao_GameView_GridItem_Wall:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Wall:addEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Wall:removeEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Wall:ctor(ctorParam)
	V3a1_GaoSiNiao_GameView_GridItem_Wall.super.ctor(self, ctorParam)
end

function V3a1_GaoSiNiao_GameView_GridItem_Wall:_editableInitView()
	V3a1_GaoSiNiao_GameView_GridItem_Wall.super._editableInitView(self)

	self._image_Piece = gohelper.findChild(self.viewGO, "#image_Piece1")
	self._imgCmpPiece = self._image_Piece:GetComponent(gohelper.Type_Image)
end

function V3a1_GaoSiNiao_GameView_GridItem_Wall:hideBlood()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Wall:setGray_Blood(isGrey)
	return
end

return V3a1_GaoSiNiao_GameView_GridItem_Wall
