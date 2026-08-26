-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl", package.seeall)

local V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl = class("V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl", V3a1_GaoSiNiao_GameView_GridItem_PieceBase)

function V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl:ctor(ctorParam)
	V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl.super.ctor(self, ctorParam)
end

function V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl:_editableInitView()
	V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl.super._editableInitView(self)

	self._image_Piece = gohelper.findChild(self.viewGO, "#image_Piece1")
	self._image_Blood1 = gohelper.findChild(self.viewGO, "#image_Blood1")
	self._image_Blood1_hui = gohelper.findChild(self.viewGO, "#image_Blood1_hui")
	self._image_Blood2 = gohelper.findChild(self.viewGO, "#image_Blood2")
	self._image_Blood2_hui = gohelper.findChild(self.viewGO, "#image_Blood2_hui")
	self._imgCmpPiece = self._image_Piece:GetComponent(gohelper.Type_Image)

	self:hideBlood()
end

function V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl:hideBlood()
	gohelper.setActive(self._image_Blood1, false)
	gohelper.setActive(self._image_Blood1_hui, false)
	gohelper.setActive(self._image_Blood2, false)
	gohelper.setActive(self._image_Blood2_hui, false)
end

function V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl:setGray_Blood(isGrey)
	gohelper.setActive(self._image_Blood1, not isGrey)
	gohelper.setActive(self._image_Blood1_hui, isGrey)
	gohelper.setActive(self._image_Blood2, not isGrey)
	gohelper.setActive(self._image_Blood2_hui, isGrey)
end

return V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl
