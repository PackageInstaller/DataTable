-- chunkname: @modules/logic/versionactivity4_0/deleike/view/comp/DeleikeSkill2Comp.lua

module("modules.logic.versionactivity4_0.deleike.view.comp.DeleikeSkill2Comp", package.seeall)

local DeleikeSkill2Comp = class("DeleikeSkill2Comp", LuaCompBase)
local SIDE_REP_DIST = 100

function DeleikeSkill2Comp:init(go)
	self.skillId = 2
	self.go = go
	self.transform = go.transform
	self.childItems = {}

	for _, v in pairs(DeleikeEnum.LineStatus) do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(go, tostring(v))
		item.anim = gohelper.findComponentAnim(item.go)
		self.childItems[v] = item
	end

	self.status = nil
	self.dragActive = false
	self._isDragging = false
	self._dragPerpX, self._dragPerpY = 0, 1
	self._dragOriginX, self._dragOriginY = 0, 0
	self._dragDirX, self._dragDirY = 1, 0
	self._dragLength = 1
	self._shiftedUnits = {}
	self._pressMouseProj = 0
	self._pressDotProj = 0
	self._lastShift = 0

	local goSceneRoot = DeleikeGameMgr.instance.sceneRoot

	self._goDragMask = gohelper.findChild(goSceneRoot, "go_SkillMask")
	self._trsMask = self._goDragMask.transform
	self._goCanCut = gohelper.findChild(self._goDragMask, "canCut")
	self._goMaskEffect = gohelper.findChild(self._goDragMask, "Effect")
	self._dragMaskX, self._dragMaskY = 0, 0
end

function DeleikeSkill2Comp:onDestroy()
	TaskDispatcher.cancelTask(self.delayHide, self)
	TaskDispatcher.cancelTask(self._hideMaskEffect, self)
end

function DeleikeSkill2Comp:resetForReuse()
	self.dragActive = false
	self._isDragging = false
	self._shiftedUnits = {}
	self._lastShift = 0
end

function DeleikeSkill2Comp:setLineStatus(status)
	if self.status == status then
		return
	end

	for k, item in pairs(self.childItems) do
		gohelper.setActive(item.go, k == status)
	end

	if self.status then
		self.childItems[status].anim:Play("switch_in", 0, 0)
	end

	self.status = status
end

function DeleikeSkill2Comp:onTrigger(leftQuad, rightQuad, centerX, centerY, dirX, dirY, length)
	if self.dragActive then
		return
	end

	if not leftQuad or not rightQuad then
		return
	end

	length = length or 1

	local perpX, perpY = -dirY, dirX
	local bx = centerX + dirX * length
	local by = centerY + dirY * length
	local toProcess = DeleikeHelper.getSharedTiles()

	for i = 1, #toProcess do
		local comp = toProcess[i]

		if not gohelper.isNil(comp.go) then
			DeleikeClipHelper.ClipTile(comp, leftQuad, rightQuad, false)
		end
	end

	DeleikeGameMgr.instance:addLineTile(centerX, centerY, dirX, dirY)
	self:_showDragMask(centerX, centerY, perpX, perpY)

	local useFrontSide = false
	local player = DeleikeGameMgr.instance.player

	if player then
		local px, py = player:getLogicPos()
		local frontDx = px - (centerX - dirX * SIDE_REP_DIST)
		local frontDy = py - (centerY - dirY * SIDE_REP_DIST)
		local backDx = px - (bx + dirX * SIDE_REP_DIST)
		local backDy = py - (by + dirY * SIDE_REP_DIST)

		useFrontSide = frontDx * frontDx + frontDy * frontDy > backDx * backDx + backDy * backDy
	end

	local unitCoord = DeleikeGameMgr.instance.unitCoord

	self._shiftedUnits = useFrontSide and unitCoord:getUnitsInFrontB(bx, by, dirX, dirY) or unitCoord:getUnitsBehindB(bx, by, dirX, dirY)

	unitCoord:killTweensOf(self._shiftedUnits)

	self.dragActive = true
	self._isDragging = false
	self._dragPerpX, self._dragPerpY = perpX, perpY
	self._dragOriginX, self._dragOriginY = centerX, centerY
	self._dragDirX, self._dragDirY = dirX, dirY
	self._dragLength = 1
	self._lastShift = 0

	DeleikeController.instance:dispatchEvent(DeleikeEvent.Skill2DragStateChanged, true)
end

function DeleikeSkill2Comp:processDrag(worldX, worldY, isPressed)
	if not self.dragActive or #self._shiftedUnits == 0 then
		return
	end

	if not isPressed then
		if self._isDragging then
			self._isDragging = false
		end

		return
	end

	local rawProjection = (worldX - self._dragOriginX) * self._dragPerpX + (worldY - self._dragOriginY) * self._dragPerpY
	local maxComp = math.max(math.abs(self._dragPerpX), math.abs(self._dragPerpY))
	local effectiveMax = DeleikeEnum.Skill2MaxShift / math.max(maxComp, 0.001)

	if not self._isDragging then
		self._isDragging = true
		self._pressMouseProj = rawProjection
		self._pressDotProj = self._lastShift

		DeleikeController.instance:dispatchEvent(DeleikeEvent.Skill2FirstDrag)
		AudioMgr.instance:trigger(AudioEnum4_0.Deleike.skill2_drag_tile)

		return
	end

	local rawTotal = self._pressDotProj + (rawProjection - self._pressMouseProj)
	local clampedTotal = math.max(-effectiveMax, math.min(effectiveMax, rawTotal))
	local deltaShift = clampedTotal - self._lastShift

	self._lastShift = clampedTotal

	if math.abs(deltaShift) > 0.01 then
		DeleikeGameMgr.instance.unitCoord:dragUnitsByOffset(self._shiftedUnits, self._dragPerpX * deltaShift, self._dragPerpY * deltaShift)

		if self._goDragMask and not gohelper.isNil(self._goDragMask) then
			self._dragMaskX = self._dragMaskX + self._dragPerpX * deltaShift
			self._dragMaskY = self._dragMaskY + self._dragPerpY * deltaShift

			recthelper.setAnchor(self._trsMask, self._dragMaskX, self._dragMaskY)
		end
	end
end

function DeleikeSkill2Comp:cancelDrag(isCancle)
	if not self.dragActive then
		return
	end

	self.dragActive = false
	self._isDragging = false
	self._shiftedUnits = {}
	self._lastShift = 0

	DeleikeController.instance:dispatchEvent(DeleikeEvent.Skill2DragStateChanged, false)
	gohelper.setActive(self._goCanCut, false)

	if not isCancle then
		AudioMgr.instance:trigger(AudioEnum4_0.Deleike.skill2_drag_confirm)
		gohelper.setActive(self._goMaskEffect, true)
		TaskDispatcher.runDelay(self._hideMaskEffect, self, 1)
	end
end

function DeleikeSkill2Comp:_showDragMask(centerX, centerY, perpX, perpY)
	self._dragMaskX, self._dragMaskY = centerX, centerY

	recthelper.setAnchor(self._trsMask, centerX, centerY)
	transformhelper.setLocalRotation(self._trsMask, 0, 0, math.deg(math.atan2(perpY, perpX)) + 180)
	gohelper.setActive(self._goCanCut, true)
end

function DeleikeSkill2Comp:_hideMaskEffect()
	gohelper.setActive(self._goMaskEffect, false)
end

function DeleikeSkill2Comp:fadeIn()
	TaskDispatcher.cancelTask(self.delayHide, self)
	gohelper.setActive(self.go, true)

	if not self.status then
		return
	end

	local item = self.childItems[self.status]

	if item and item.go.activeInHierarchy then
		item.anim:Play("open", 0, 0)
	end
end

function DeleikeSkill2Comp:fadeOut()
	if self.status then
		local item = self.childItems[self.status]

		if item and item.go.activeInHierarchy then
			item.anim:Play("close", 0, 0)
			TaskDispatcher.runDelay(self.delayHide, self, 0.16)
		else
			self:delayHide()
		end
	else
		self:delayHide()
	end
end

function DeleikeSkill2Comp:delayHide()
	gohelper.setActive(self.go, false)
end

return DeleikeSkill2Comp
