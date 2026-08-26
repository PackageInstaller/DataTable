-- chunkname: @modules/logic/partygame/view/collatingsort/CollatingSortGameBallItem.lua

module("modules.logic.partygame.view.collatingsort.CollatingSortGameBallItem", package.seeall)

local CollatingSortGameBallItem = class("CollatingSortGameBallItem", ListScrollCellExtend)

function CollatingSortGameBallItem:onInitView()
	self._imageball = gohelper.findChildImage(self.viewGO, "#image_ball")
	self._imagemask = gohelper.findChildImage(self.viewGO, "#image_mask")
	self._imagesticker = gohelper.findChildImage(self.viewGO, "#image_sticker")
	self._gorate = gohelper.findChild(self.viewGO, "#go_rate")
	self._gopoint = gohelper.findChild(self.viewGO, "#go_point")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollatingSortGameBallItem:addEvents()
	return
end

function CollatingSortGameBallItem:removeEvents()
	return
end

local dropTypeEnum = {
	Normal2 = 2,
	Double3 = 7,
	Normal1 = 1,
	Double2 = 6,
	Double1 = 5,
	Wrong = 4,
	Normal3 = 3
}

function CollatingSortGameBallItem:_editableInitView()
	return
end

function CollatingSortGameBallItem:_editableAddEvents()
	return
end

function CollatingSortGameBallItem:_editableRemoveEvents()
	return
end

function CollatingSortGameBallItem:getPoint()
	return self._gopoint
end

function CollatingSortGameBallItem:_getBallImgType(dropType, dropType1, dropType2)
	if dropType <= dropTypeEnum.Normal3 then
		return dropType
	end

	if dropType >= dropTypeEnum.Double1 and dropType <= dropTypeEnum.Double3 then
		return dropType - 4
	end

	for i = dropTypeEnum.Normal1, dropTypeEnum.Normal3 do
		if i ~= dropType1 and i ~= dropType2 then
			return i
		end
	end
end

function CollatingSortGameBallItem:onUpdateMO(dropType, dropType1, dropType2)
	local imgType = self:_getBallImgType(dropType, dropType1, dropType2)

	UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imageball, "v3a4_party_game12_ball" .. imgType)
	UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagemask, "v3a4_party_game12_ball" .. imgType .. "_1")
	UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagesticker, "v3a4_party_game12_ball" .. imgType .. "_2")
	gohelper.setActive(self._gorate, dropType >= dropTypeEnum.Double1)
end

function CollatingSortGameBallItem:setInitPos(initPosX, initPosY)
	self._initPosX = initPosX
	self._initPosY = initPosY
end

function CollatingSortGameBallItem:setMoveScale(scale)
	self._moveScale = scale
end

function CollatingSortGameBallItem:setOffset(offsetX, offsetY, offsetZ)
	self._offsetX = offsetX
	self._offsetY = offsetY
	self._offsetZ = offsetZ
end

function CollatingSortGameBallItem:setEcsGo(go)
	self._ecsGoTrans = go.transform
	self._ecsGoPosX, self._ecsGoPosY = transformhelper.getLocalPos(self._ecsGoTrans)
	self._lastRotaionDir = 0
	self._fastRotation = 10
	self._slowRotation = 1
	self._rotationZ = 0
	self._rotationTrans = self._imageball.transform
	self._rotationTrans2 = self._imagesticker.transform

	TaskDispatcher.cancelTask(self._updateRotation, self)
	TaskDispatcher.runRepeat(self._updateRotation, self, 0)
end

function CollatingSortGameBallItem:cancelUpdateRotation()
	TaskDispatcher.cancelTask(self._updateRotation, self)
end

function CollatingSortGameBallItem:_updateEcsGoPos()
	local posX, posY, posZ = transformhelper.getPos(self._ecsGoTrans)
	local deltaX = posX - self._initPosX
	local deltaY = posY - self._initPosY

	deltaX = deltaX * self._moveScale
	deltaY = deltaY * self._moveScale

	local scalePosX = self._initPosX + deltaX
	local scalePosY = self._initPosY + deltaY
	local newPosX = scalePosX + (self._offsetX or 0)
	local newPosY = scalePosY + (self._offsetY or 0)

	transformhelper.setPos(self.viewGO.transform, newPosX, newPosY, posZ)
end

function CollatingSortGameBallItem:_updateRotation()
	if gohelper.isNil(self._ecsGoTrans) then
		return
	end

	self:_updateEcsGoPos()

	local posX, posY = transformhelper.getLocalPos(self._ecsGoTrans)
	local deltaX = posX - self._ecsGoPosX

	self._ecsGoPosX = posX

	local deltaY = posY - self._ecsGoPosY

	self._ecsGoPosY = posY

	if math.abs(deltaX) < 0.01 then
		if math.abs(deltaY) >= 0.01 then
			self._rotationZ = self._rotationZ + self._lastRotaionDir * self._slowRotation

			transformhelper.setLocalRotation(self._rotationTrans, 0, 0, self._rotationZ)
			transformhelper.setLocalRotation(self._rotationTrans2, 0, 0, self._rotationZ)
		end

		return
	end

	self._lastRotaionDir = deltaX < 0 and 1 or -1
	self._rotationZ = self._rotationZ + self._lastRotaionDir * self._fastRotation

	transformhelper.setLocalRotation(self._rotationTrans, 0, 0, self._rotationZ)
	transformhelper.setLocalRotation(self._rotationTrans2, 0, 0, self._rotationZ)
end

function CollatingSortGameBallItem:onSelect(isSelect)
	return
end

function CollatingSortGameBallItem:onDestroyView()
	TaskDispatcher.cancelTask(self._updateRotation, self)
end

return CollatingSortGameBallItem
