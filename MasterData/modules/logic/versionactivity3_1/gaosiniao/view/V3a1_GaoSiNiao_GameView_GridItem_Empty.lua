-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameView_GridItem_Empty.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_Empty", package.seeall)

local V3a1_GaoSiNiao_GameView_GridItem_Empty = class("V3a1_GaoSiNiao_GameView_GridItem_Empty", V3a1_GaoSiNiao_GameView_GridItem_PieceBase)

function V3a1_GaoSiNiao_GameView_GridItem_Empty:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Empty:addEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Empty:removeEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Empty:ctor(ctorParam)
	V3a1_GaoSiNiao_GameView_GridItem_Empty.super.ctor(self, ctorParam)
end

function V3a1_GaoSiNiao_GameView_GridItem_Empty:_editableInitView()
	V3a1_GaoSiNiao_GameView_GridItem_Empty.super._editableInitView(self)

	self._image_Piece = gohelper.findChild(self.viewGO, "image_Slot")
	self._imgCmpPiece = self._image_Piece:GetComponent(gohelper.Type_Image)
end

function V3a1_GaoSiNiao_GameView_GridItem_Empty:hideBlood()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Empty:resetRotate()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Empty:setGray_Blood(isGrey)
	return
end

return V3a1_GaoSiNiao_GameView_GridItem_Empty
