-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameView_GridItem_PieceBase.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_PieceBase", package.seeall)

local V3a1_GaoSiNiao_GameView_GridItem_PieceBase = class("V3a1_GaoSiNiao_GameView_GridItem_PieceBase", RougeSimpleItemBase)

function V3a1_GaoSiNiao_GameView_GridItem_PieceBase:ctor(ctorParam)
	V3a1_GaoSiNiao_GameView_GridItem_PieceBase.super.ctor(self, ctorParam)
end

function V3a1_GaoSiNiao_GameView_GridItem_PieceBase:_editableInitView()
	V3a1_GaoSiNiao_GameView_GridItem_PieceBase.super._editableInitView(self)
end

function V3a1_GaoSiNiao_GameView_GridItem_PieceBase:hideBlood()
	gohelper.setActive(self._image_Blood, false)
	gohelper.setActive(self._image_Blood_hui, false)
end

function V3a1_GaoSiNiao_GameView_GridItem_PieceBase:setGray_Blood(isGrey)
	gohelper.setActive(self._image_Blood, not isGrey)
	gohelper.setActive(self._image_Blood_hui, isGrey)
end

function V3a1_GaoSiNiao_GameView_GridItem_PieceBase:resetRotate()
	self:localRotateZ(0)
end

function V3a1_GaoSiNiao_GameView_GridItem_PieceBase:getPieceSprite()
	return self._imgCmpPiece.sprite
end

function V3a1_GaoSiNiao_GameView_GridItem_PieceBase:index()
	return self:parent():index()
end

return V3a1_GaoSiNiao_GameView_GridItem_PieceBase
