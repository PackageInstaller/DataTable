-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/component/CharacterEquipSuitModelComponent.lua

module("logic.extensions.charactersystem.view.equip.component.CharacterEquipSuitModelComponent", package.seeall)

local M = class("CharacterEquipSuitModelComponent", EquipSuitModelComponent)

function M:build()
	self.modelScale = 0.25
	self.defaultYRotation = 180
	self._modelX = -0.7
	self._modelY = 0.23
	self._modelZ = -0.1

	M.super.build(self)
end

function M:onExit()
	M.super.onExit(self)
	self:disableRotation()
end

function M:refreshView()
	if not self._heroData or not self._isLoaded then
		return
	end

	local equipHeroData = self._heroData:getHeroEquipData()
	local aniName = self._loadedRefreshed and self._aniNameOnIdle or self._aniNameOnLoad
	local loop = self._loadedRefreshed
	local equipNum = equipHeroData:getEquipNum()

	if equipNum > 0 then
		self:setEnableRotation()

		for index = 1, EquipEnum.MaxPartType do
			self._equipModel:showEmptyGo(index, false)

			local equipMo = equipHeroData:getEquipByPart(EquipEnum.PartTypeList[index])

			self:_refreshOneEquip(index, equipMo, aniName, loop)
		end
	else
		self:disableRotation()

		for index = 1, EquipEnum.MaxPartType do
			self._equipModel:clearAttachEffect(index)
			self._equipModel:showEmptyGo(index, false)
		end

		self._equipModel:setEmptyPos(EquipUtil.EquipModelEmptyPosInCharacter)
	end

	self._equipModel:setTargetRotationY(self.defaultYRotation)

	self._loadedRefreshed = true
end

function M:disableRotation()
	self._equipModel:enableTouch(Handler.New(false, self), Handler.New(false, self), Handler.New(false, self), Handler.New(false, self))
end

function M:setEnableRotation()
	self._equipModel:enableTouch(Handler.New(self._clickEquipModel, self), Handler.New(self._beginDragEquipModel, self), Handler.New(self._onDragEquipModel, self), Handler.New(self._endDragEquipModel, self))
end

function M:_clickEquipModel()
	return
end

function M:_beginDragEquipModel(posX, posY, pointerId)
	self._beginX = posX
	self._lastFrame = Time.frameCount
end

function M:_onDragEquipModel(posX, posY, pointerId)
	DG.Tweening.DOTween.Kill(self._equipModel:getTransform())

	local deltaX = posX - self._beginX
	local currFrame = Time.frameCount
	local deltaFrame = currFrame - self._lastFrame

	self._dragSpeed = deltaX / deltaFrame

	self:_rotaEquipModel(deltaX)

	self._beginX = posX
	self._lastFrame = currFrame
end

function M:_endDragEquipModel(posX, posY, pointerId)
	local x, y, z = self._equipModel:getTargetRotation()

	Astral.TransformUtil.DOLocalRotate(self._equipModel:getTransform(), x, self.defaultYRotation, z, 0.5)
end

function M:beforeMergeAni()
	self.defaultYRotation = 220

	self:enableAutoRotation(false)
end

function M:onMergeAniEnd()
	self.defaultYRotation = 180

	local x, y, z = self._equipModel:getTargetRotation()

	Astral.TransformUtil.DOLocalRotate(self._equipModel:getTransform(), x, self.defaultYRotation, z, 0.3)
	self:enableAutoRotation(true)
end

function M:enableAutoRotation(isEnable)
	self._equipModel:setNeedAutoRotate(isEnable, isEnable)
end

function M:_rotaEquipModel(deltaX)
	if not deltaX then
		printError("校时器旋转失败，没有正确的拖拽值")

		return
	end

	local _, rotaY, _ = self._equipModel:getTargetRotation()

	self._equipModel:setDragRotationY(rotaY, -deltaX)
end

return M
