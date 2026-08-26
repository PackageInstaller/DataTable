-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameView_GridItem_Portal.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_Portal", package.seeall)

local V3a1_GaoSiNiao_GameView_GridItem_Portal = class("V3a1_GaoSiNiao_GameView_GridItem_Portal", V3a1_GaoSiNiao_GameView_GridItem_PieceBase)

function V3a1_GaoSiNiao_GameView_GridItem_Portal:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Portal:addEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem_Portal:removeEvents()
	return
end

local csAnimatorPlayer = SLFramework.AnimatorPlayer

function V3a1_GaoSiNiao_GameView_GridItem_Portal:ctor(ctorParam)
	V3a1_GaoSiNiao_GameView_GridItem_Portal.super.ctor(self, ctorParam)

	self._isConnected = false
end

function V3a1_GaoSiNiao_GameView_GridItem_Portal:_editableInitView()
	V3a1_GaoSiNiao_GameView_GridItem_Portal.super._editableInitView(self)

	self._image_Piece1 = gohelper.findChild(self.viewGO, "#image_Piece1")
	self._image_Piece2 = gohelper.findChild(self.viewGO, "#image_Piece2")
	self._image_Blood = gohelper.findChild(self.viewGO, "#image_Blood")
	self._image_Blood_hui = gohelper.findChild(self.viewGO, "#image_Blood_hui")
	self._imgCmpPiece1 = self._image_Piece1:GetComponent(gohelper.Type_Image)
	self._imgCmpPiece2 = self._image_Piece2:GetComponent(gohelper.Type_Image)
	self._image_Piece1 = gohelper.findChild(self.viewGO, "#image_Piece1")
	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)

	self:hideBlood()
end

function V3a1_GaoSiNiao_GameView_GridItem_Portal:getPieceSprite()
	return (self._isConnected or nil) and (self._imgCmpPiece2.sprite or self._imgCmpPiece1.sprite)
end

function V3a1_GaoSiNiao_GameView_GridItem_Portal:setIsConnected(isConnected)
	if not isConnected then
		self:setIsConnectedNoAnim(false)
		self:hideBlood()

		return
	end

	if self._isConnected == isConnected then
		return
	end

	self._isConnected = isConnected

	self._playAnim_switch(self, self._onAnimSwitchDone, self)

	if isConnected then
		AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_send)
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Portal:_onAnimSwitchDone()
	self:_playAnim_Idle(self._isConnected)

	if self._isConnected then
		self:setGray_Blood(true)
	end
end

function V3a1_GaoSiNiao_GameView_GridItem_Portal:setIsConnectedNoAnim(isConnected)
	if self._isConnected == isConnected then
		return
	end

	self._isConnected = isConnected

	self:_playAnim_Idle(isConnected)
end

function V3a1_GaoSiNiao_GameView_GridItem_Portal:rotateByZoneMask(eZoneMask)
	local zRot = 0

	if GaoSiNiaoEnum.ZoneMask.North == eZoneMask then
		zRot = 0
	elseif GaoSiNiaoEnum.ZoneMask.South == eZoneMask then
		zRot = 180
	elseif GaoSiNiaoEnum.ZoneMask.West == eZoneMask then
		zRot = 90
	elseif GaoSiNiaoEnum.ZoneMask.East == eZoneMask then
		zRot = -90
	end

	self:localRotateZ(zRot)
	self:localRotateZ(zRot)
end

function V3a1_GaoSiNiao_GameView_GridItem_Portal:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb, cbObj)
end

function V3a1_GaoSiNiao_GameView_GridItem_Portal:_playAnim_Idle(isConnected, cb, cbObj)
	self:_playAnim(isConnected and "piece2" or "piece1", cb, cbObj)
end

function V3a1_GaoSiNiao_GameView_GridItem_Portal:_playAnim_switch(cb, cbObj)
	self:_playAnim(UIAnimationName.Switch, cb, cbObj)
end

return V3a1_GaoSiNiao_GameView_GridItem_Portal
