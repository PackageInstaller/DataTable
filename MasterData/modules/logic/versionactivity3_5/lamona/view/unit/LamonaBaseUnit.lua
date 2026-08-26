-- chunkname: @modules/logic/versionactivity3_5/lamona/view/unit/LamonaBaseUnit.lua

module("modules.logic.versionactivity3_5.lamona.view.unit.LamonaBaseUnit", package.seeall)

local LamonaBaseUnit = class("LamonaBaseUnit", LuaCompBase)

function LamonaBaseUnit:ctor(ctorParam)
	self._uid = ctorParam and ctorParam.uid
	self._view = ctorParam and ctorParam.view
end

function LamonaBaseUnit:init(go)
	self.go = go
	self.trans = go.transform
	self._goDir = gohelper.findChild(self.go, "direction")

	local mo = self:getMO()
	local id = mo and mo:getId()
	local icon = LamonaConfig.instance:getLamonaUnitImgName(id)

	if not gohelper.isNil(self._goDir) then
		self._dirDict = self:getUserDataTb_()

		for _, dir in pairs(LamonaEnum.Direction) do
			self._dirDict[dir] = gohelper.findChild(self._goDir, dir)

			local imagedirIcon = gohelper.findChildImage(self._goDir, dir)

			UISpriteSetMgr.instance:setV3a5LamonaSprite(imagedirIcon, string.format("%s_%s", icon, LamonaEnum.DirectionSuffix[dir]))
		end
	end

	local imageicon = gohelper.findChildImage(self.go, "#simage_icon")

	if imageicon then
		UISpriteSetMgr.instance:setV3a5LamonaSprite(imageicon, icon)
	end

	self:onInit()
	self:refresh()
end

function LamonaBaseUnit:addEventListeners()
	return
end

function LamonaBaseUnit:removeEventListeners()
	return
end

function LamonaBaseUnit:onUpdate()
	if self._moveTweenId and self._waitChangeParentGO then
		local mo = self:getMO()
		local curDir = mo and mo:getDirection()

		if curDir == LamonaEnum.Direction.Up or curDir == LamonaEnum.Direction.Down then
			local gridX, gridY = mo:getGridXY()
			local _, curPosY = transformhelper.getLocalPos(self.trans)
			local _, targetPosY = LamonaHelper.getGridPos(gridX, gridY)
			local _, gridSizeY = LamonaConfig.instance:getGridSize()
			local factor = 0.5

			if curDir == LamonaEnum.Direction.Up then
				factor = 0.8
			elseif curDir == LamonaEnum.Direction.Down then
				factor = 0.2
			end

			local sizeRangeY = gridSizeY * factor
			local dy = math.abs(curPosY - targetPosY)

			if dy <= sizeRangeY then
				self:refreshParentGO()
			end
		end
	end
end

function LamonaBaseUnit:onInit()
	return
end

function LamonaBaseUnit:onRefresh(isPlay)
	return
end

function LamonaBaseUnit:refresh(isPlay)
	self:onRefresh(isPlay)
	self:refreshPosition()
	self:refreshDirection()
	self:refreshParentGO()
end

function LamonaBaseUnit:refreshPosition()
	local mo = self:getMO()

	if not mo then
		return
	end

	self:_killMoveTween()

	local gridX, gridY = mo:getGridXY()
	local x, y = LamonaHelper.getGridPos(gridX, gridY)

	transformhelper.setLocalPos(self.trans, x, y, 0)
end

function LamonaBaseUnit:refreshDirection()
	local mo = self:getMO()

	if not mo then
		return
	end

	if not self._dirDict then
		return
	end

	local curDir = mo:getDirection()

	for dir, go in pairs(self._dirDict) do
		gohelper.setActive(go, dir == curDir)
	end
end

function LamonaBaseUnit:refreshParentGO()
	if not self._view then
		return
	end

	local parentGO = self._view:getUnitParentGO(self._uid)

	self:setLevelParent(parentGO)

	self._waitChangeParentGO = nil
end

function LamonaBaseUnit:playMove(finishCb, finishCbObj, finishCbParam)
	self:refreshDirection()

	local mo = self:getMO()
	local moveTime = mo and mo:getMoveTime()

	if not moveTime or moveTime <= 0 then
		return
	end

	local gridX, gridY = mo:getGridXY()
	local targetPosX, targetPosY = LamonaHelper.getGridPos(gridX, gridY)
	local curPosX, curPosY = transformhelper.getLocalPos(self.trans)

	if curPosX == targetPosX and curPosY == targetPosY then
		ArcadeGameHelper.callCallbackFunc(finishCb, finishCbObj, finishCbParam)
	else
		self:_killMoveTween()

		self._finishMoveCb = finishCb
		self._finishMoveCbObj = finishCbObj
		self._finishMoveCbParam = finishCbParam
		self._waitChangeParentGO = true
		self._moveTweenId = ZProj.TweenHelper.DOLocalMove(self.trans, targetPosX, targetPosY, 0, moveTime, self._onMoveTweenFinish, self, nil, EaseType.OutExpo)
	end
end

function LamonaBaseUnit:_onMoveTweenFinish()
	local cb = self._finishMoveCb
	local cbObj = self._finishMoveCbObj
	local cbParam = self._finishMoveCbParam

	self:refreshPosition()
	ArcadeGameHelper.callCallbackFunc(cb, cbObj, cbParam)
end

function LamonaBaseUnit:_killMoveTween()
	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)
	end

	self._moveTweenId = nil
	self._finishMoveCb = nil
	self._finishMoveCbObj = nil
	self._finishMoveCbParam = nil
end

function LamonaBaseUnit:setLevelParent(parentGO)
	if gohelper.isNil(parentGO) then
		return
	end

	gohelper.setParent(self.go, parentGO)
end

function LamonaBaseUnit:getMO()
	return LamonaGameModel.instance:getUnitByUid(self._uid)
end

function LamonaBaseUnit:getIsTweenMoving()
	return self._moveTweenId
end

function LamonaBaseUnit:destroy()
	self:onDestroy()
	gohelper.destroy(self.go)
end

function LamonaBaseUnit:onDestroy()
	if self._isDestroyed then
		return
	end

	self._isDestroyed = true
	self._view = nil

	self:_killMoveTween()
end

return LamonaBaseUnit
