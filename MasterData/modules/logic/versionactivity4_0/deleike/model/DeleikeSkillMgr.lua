-- chunkname: @modules/logic/versionactivity4_0/deleike/model/DeleikeSkillMgr.lua

module("modules.logic.versionactivity4_0.deleike.model.DeleikeSkillMgr", package.seeall)

local DeleikeSkillMgr = class("DeleikeSkillMgr")
local Input = UnityEngine.Input
local Time = UnityEngine.Time
local SKILL2_THICK = 10
local SIDE_EXTENT = DeleikeEnum.SkillWidth
local SKILL1_RELEASE_SHRINK_TIME = 0.3

function DeleikeSkillMgr:init(goLine1, goLine2)
	self.skill1 = MonoHelper.addNoUpdateLuaComOnceToGo(goLine1, DeleikeSkill1Comp)
	self.skill2 = MonoHelper.addNoUpdateLuaComOnceToGo(goLine2, DeleikeSkill2Comp)

	self.skill2:resetForReuse()

	self.curSkill = nil
	self._sideLeft = nil
	self._sideRight = nil

	gohelper.setActive(self.skill1.go, false)
	gohelper.setActive(self.skill2.go, false)
	self.skill1:cancelReleaseVisual()

	self.isCharging = false
	self.activeSkillId = 1
	self._chargeCenterX, self._chargeCenterY = 0, 0
	self._chargeDirX, self._chargeDirY = 1, 0
	self._chargeHeight = 0
	self._chargeWidth = 0
	self._chargeStartTime = 0
	self._dragPressed = false
	self._relShrinkActive = false
	self._relShrinkCenterX, self._relShrinkCenterY = 0, 0
	self._relShrinkDirX, self._relShrinkDirY = 1, 0
	self._relShrinkHeight = 0
	self._relShrinkStartTime = 0

	UpdateBeat:Add(self.onUpdate, self)
end

function DeleikeSkillMgr:dispose()
	UpdateBeat:Remove(self.onUpdate, self)
	self:_hideSkillLine()

	if self.player then
		self.player:setCharging(false)
	end

	TaskDispatcher.cancelTask(self._showSkillLine, self)
end

function DeleikeSkillMgr:onUpdate()
	if self.isCharging then
		self:_refreshChargeCenter()
		self:updateCharge()
	end

	self:updateChargeVisual()
	self:_updateScreenDrag()
	self:_updateSkill1ReleaseAnim()
end

function DeleikeSkillMgr:_updateScreenDrag()
	local skill2 = self.skill2

	if not skill2 or not skill2.dragActive then
		return
	end

	local mgr = DeleikeGameMgr.instance

	if not mgr.sceneRootRt then
		return
	end

	if Input.GetMouseButton(0) then
		local pos = recthelper.screenPosToAnchorPos(Input.mousePosition, mgr.sceneRootRt)

		skill2:processDrag(pos.x, pos.y, true)

		self._dragPressed = true
	elseif self._dragPressed then
		skill2:processDrag(0, 0, false)

		self._dragPressed = false
	end
end

function DeleikeSkillMgr:_isSkillBlocked()
	return self.skill2 ~= nil and self.skill2.dragActive
end

function DeleikeSkillMgr:onSkillBtnDragBegin(skillId)
	if self:_isSkillBlocked() then
		return
	end

	self.activeSkillId = skillId

	if self:_canCharge() then
		self:startCharge()
	end
end

function DeleikeSkillMgr:onSkillBtnDragMove(dx, dy)
	if self:_isSkillBlocked() then
		return
	end

	if not self.isCharging then
		return
	end

	local lenSq = dx * dx + dy * dy

	if lenSq < 0.0001 then
		return
	end

	local len = math.sqrt(lenSq)

	self:_refreshChargeDir(dx / len, dy / len)
end

function DeleikeSkillMgr:onSkillBtnDragEnd(cancelled)
	if self:_isSkillBlocked() then
		return
	end

	if not self.isCharging then
		return
	end

	if cancelled then
		self:cancelCharge()
		AudioMgr.instance:trigger(AudioEnum4_0.Deleike.skill_cancel)
	else
		self:releaseSkill()
	end
end

function DeleikeSkillMgr:cancelCharge()
	if not self.isCharging then
		return
	end

	self.isCharging = false

	self.player:setCharging(false)
	self:_hideSkillLine()
end

function DeleikeSkillMgr:cancelDrag(isCancle)
	self._dragPressed = false

	if self.skill2 and self.skill2.dragActive then
		self.skill2:cancelDrag(isCancle)
	end
end

function DeleikeSkillMgr:resetState()
	self:_cancelSkill1ReleaseAnim()
	self:cancelDrag(true)

	if self.isCharging then
		self:cancelCharge()
	end
end

function DeleikeSkillMgr:_canCharge()
	if not self.player then
		return false
	end

	local skillCount = self.player:getSkillCount(self.activeSkillId)

	return skillCount ~= nil and skillCount > 0
end

function DeleikeSkillMgr:_refreshChargeCenter()
	if not self.player then
		return
	end

	local px, py = self.player:getLogicPos()

	self._chargeCenterX = px + self._chargeDirX * DeleikeEnum.PlayerRadius
	self._chargeCenterY = py + self._chargeDirY * DeleikeEnum.PlayerRadius
end

function DeleikeSkillMgr:_refreshChargeDir(dirX, dirY)
	self._chargeDirX, self._chargeDirY = dirX, dirY

	self:_refreshChargeCenter()
end

function DeleikeSkillMgr:startCharge()
	self:_cancelSkill1ReleaseAnim()

	self.isCharging = true
	self._chargeStartTime = Time.time
	self._chargeHeight = 0
	self._chargeWidth = 0

	local target, audioId

	if self.activeSkillId == 1 then
		target = self.skill1
		audioId = AudioEnum4_0.Deleike.skill1_start_charge
	else
		target = self.skill2
		audioId = AudioEnum4_0.Deleike.skill2_start_charge
	end

	AudioMgr.instance:trigger(audioId)

	if self.curSkill ~= target then
		self.curSkill = target
	end

	self:_refreshChargeDir(1, 0)
	self.player:setCharging(true)
	AudioMgr.instance:trigger(AudioEnum4_0.Deleike.skill_charging)
	TaskDispatcher.runDelay(self._showSkillLine, self, 0.05)
end

function DeleikeSkillMgr:_buildBlockQuad()
	local centerX, centerY = self._chargeCenterX, self._chargeCenterY
	local dirX, dirY = self._chargeDirX, self._chargeDirY
	local perpX, perpY = -dirY, dirX
	local hw, len

	if self.activeSkillId == 1 then
		hw = DeleikeEnum.SkillWidth * 0.5
		len = self._chargeHeight
	else
		hw = self._chargeWidth * 0.5
		len = SKILL2_THICK
	end

	local endX = centerX + dirX * len
	local endY = centerY + dirY * len

	return {
		{
			x = centerX - perpX * hw,
			y = centerY - perpY * hw
		},
		{
			x = endX - perpX * hw,
			y = endY - perpY * hw
		},
		{
			x = endX + perpX * hw,
			y = endY + perpY * hw
		},
		{
			x = centerX + perpX * hw,
			y = centerY + perpY * hw
		}
	}
end

function DeleikeSkillMgr:refreshUncutMarks()
	local blockQuad = self:_buildBlockQuad()
	local blocked = false
	local unitCoord = DeleikeGameMgr.instance.unitCoord

	if unitCoord then
		if not unitCoord.unitList then
			local unitList = {}

			for i = 1, #unitList do
				local comp = unitList[i]
				local mo = comp.mo

				if mo and mo.tileType == DeleikeEnum.TileType.Anchor and not gohelper.isNil(comp.go) then
					local hit = DeleikeCollision.convexPolysOverlap(blockQuad, comp:getWorldPolygon())

					if hit then
						blocked = true
					end

					gohelper.setActive(comp.goUncut, hit)
				end
			end

			local half = DeleikeEnum.GridUnit * 0.5

			if unitCoord then
				if not unitCoord.triggerList then
					local triggers = {}

					for i = 1, #triggers do
						local comp = triggers[i]

						if comp.isDoor and not comp.isCollected and not gohelper.isNil(comp.go) then
							local wx, wy = comp.worldPos.x, comp.worldPos.y
							local doorQuad = {
								{
									x = wx - half,
									y = wy - half
								},
								{
									x = wx - half,
									y = wy + half
								},
								{
									x = wx + half,
									y = wy + half
								},
								{
									x = wx + half,
									y = wy - half
								}
							}
							local hit = DeleikeCollision.convexPolysOverlap(blockQuad, doorQuad)

							if hit then
								blocked = true
							end

							if comp.goUncut then
								gohelper.setActive(comp.goUncut, hit)
							end
						end
					end

					return blocked
				end
			end
		end
	end
end

function DeleikeSkillMgr:clearUncutMarks()
	local unitCoord = DeleikeGameMgr.instance.unitCoord

	if unitCoord then
		if not unitCoord.unitList then
			local unitList = {}

			for i = 1, #unitList do
				local comp = unitList[i]
				local mo = comp.mo

				if mo and mo.tileType == DeleikeEnum.TileType.Anchor and comp.goUncut then
					gohelper.setActive(comp.goUncut, false)
				end
			end

			if unitCoord then
				if not unitCoord.triggerList then
					local triggers = {}

					for i = 1, #triggers do
						local comp = triggers[i]

						if comp.isDoor and comp.goUncut then
							gohelper.setActive(comp.goUncut, false)
						end
					end
				end
			end
		end
	end
end

function DeleikeSkillMgr:getLineStatus()
	local blocked = self:refreshUncutMarks()

	if blocked then
		return DeleikeEnum.LineStatus.UnCut
	end

	if self.activeSkillId == 1 then
		if self._chargeHeight >= DeleikeEnum.SkilllHeight then
			return DeleikeEnum.LineStatus.CanCut
		end

		return DeleikeEnum.LineStatus.PreCut
	else
		if self.isCharging then
			return DeleikeEnum.LineStatus.PreCut
		end

		return DeleikeEnum.LineStatus.CanCut
	end
end

function DeleikeSkillMgr:updateCharge()
	local elapsed = Time.time - self._chargeStartTime

	if self.activeSkillId == 1 then
		self._chargeHeight = math.min(elapsed * DeleikeEnum.SkilllHeight, DeleikeEnum.SkilllHeight)
	else
		self._chargeWidth = math.min(elapsed * DeleikeEnum.SkillWidth, DeleikeEnum.SkillWidth)
		self._chargeHeight = 1
	end
end

function DeleikeSkillMgr:updateChargeVisual()
	if not self.isCharging then
		return
	end

	local status = self:getLineStatus()

	if self.activeSkillId == 1 then
		self.skill1:setLineStatus(status)
	else
		self.skill2:setLineStatus(status)
	end

	if self.activeSkillId == 2 then
		self:_updateVisual(self._chargeCenterX, self._chargeCenterY, self._chargeDirX, self._chargeDirY, self._chargeHeight, self._chargeWidth * 0.5)
	else
		self:_updateVisual(self._chargeCenterX, self._chargeCenterY, self._chargeDirX, self._chargeDirY, self._chargeHeight)
	end
end

function DeleikeSkillMgr:releaseSkill()
	if not self.isCharging then
		return
	end

	self.isCharging = false

	self.player:setCharging(false)

	local blocked = self:getLineStatus() == DeleikeEnum.LineStatus.UnCut
	local skillCount = self.player:getSkillCount(self.activeSkillId)

	if self.activeSkillId == 1 then
		if self._chargeHeight >= DeleikeEnum.SkilllHeight and not blocked and skillCount > 0 then
			DeleikeGameMgr.instance:snapshotForUndo()
			self.player:setSkillCount(self.activeSkillId, skillCount - 1)
			self:_updateVisual(self._chargeCenterX, self._chargeCenterY, self._chargeDirX, self._chargeDirY, self._chargeHeight)
			self.skill1:onTrigger(self._sideLeft, self._sideRight, self._chargeCenterX, self._chargeCenterY, self._chargeDirX, self._chargeDirY, self._chargeHeight)
			AudioMgr.instance:trigger(AudioEnum4_0.Deleike.skill1_use)
			self:_startSkill1ReleaseAnim()

			return
		else
			AudioMgr.instance:trigger(AudioEnum4_0.Deleike.skill_cancel)
		end
	elseif self._chargeWidth >= DeleikeEnum.SkillWidth and not blocked and skillCount > 0 then
		DeleikeGameMgr.instance:snapshotForUndo()
		self.player:setSkillCount(self.activeSkillId, skillCount - 1)
		self:_updateVisual(self._chargeCenterX, self._chargeCenterY, self._chargeDirX, self._chargeDirY, self._chargeHeight, self._chargeWidth * 0.5)
		self.skill2:onTrigger(self._sideLeft, self._sideRight, self._chargeCenterX, self._chargeCenterY, self._chargeDirX, self._chargeDirY, self._chargeHeight)
		AudioMgr.instance:trigger(AudioEnum4_0.Deleike.skill2_use)
	else
		AudioMgr.instance:trigger(AudioEnum4_0.Deleike.skill_cancel)
	end

	self:_hideSkillLine()
end

function DeleikeSkillMgr:_startSkill1ReleaseAnim()
	self:clearUncutMarks()

	self._sideLeft = nil
	self._sideRight = nil
	self._relShrinkActive = true
	self._relShrinkCenterX = self._chargeCenterX
	self._relShrinkCenterY = self._chargeCenterY
	self._relShrinkDirX, self._relShrinkDirY = self._chargeDirX, self._chargeDirY
	self._relShrinkHeight = self._chargeHeight
	self._relShrinkStartTime = Time.time
end

function DeleikeSkillMgr:_updateSkill1ReleaseAnim()
	if not self._relShrinkActive then
		return
	end

	local t = (Time.time - self._relShrinkStartTime) / SKILL1_RELEASE_SHRINK_TIME

	if t > 1 then
		t = 1
	end

	local eased = t * t * (3 - 2 * t)
	local height = self._relShrinkHeight * (1 - eased)
	local dirX, dirY = self._relShrinkDirX, self._relShrinkDirY

	self:_updateLine(self.skill1.transform, self._relShrinkCenterX + dirX * height * 0.5, self._relShrinkCenterY + dirY * height * 0.5, -dirY, dirX, DeleikeEnum.SkillWidth, height)

	if t >= 1 then
		self._relShrinkActive = false
		self.skill1.status = nil

		self.skill1:showReleaseLight()
	end
end

function DeleikeSkillMgr:_cancelSkill1ReleaseAnim()
	if not self._relShrinkActive and not self.skill1:isReleaseVisualActive() then
		return
	end

	self._relShrinkActive = false

	self.skill1:cancelReleaseVisual()
end

function DeleikeSkillMgr:_updateVisual(centerX, centerY, dirX, dirY, length, halfWidth)
	halfWidth = halfWidth or DeleikeEnum.SkillWidth * 0.5

	if dirX == 0 and dirY == 0 or length < 1 then
		return
	end

	local perpX, perpY = -dirY, dirX
	local hw = halfWidth
	local endX = centerX + dirX * length
	local endY = centerY + dirY * length
	local ext = SIDE_EXTENT

	self._sideLeft = {
		{
			x = centerX - perpX * hw - dirX * ext,
			y = centerY - perpY * hw - dirY * ext
		},
		{
			x = centerX + perpX * hw - dirX * ext,
			y = centerY + perpY * hw - dirY * ext
		},
		{
			x = centerX + perpX * hw,
			y = centerY + perpY * hw
		},
		{
			x = centerX - perpX * hw,
			y = centerY - perpY * hw
		}
	}
	self._sideRight = {
		{
			x = endX - perpX * hw,
			y = endY - perpY * hw
		},
		{
			x = endX + perpX * hw,
			y = endY + perpY * hw
		},
		{
			x = endX + perpX * hw + dirX * ext,
			y = endY + perpY * hw + dirY * ext
		},
		{
			x = endX - perpX * hw + dirX * ext,
			y = endY - perpY * hw + dirY * ext
		}
	}

	if self.activeSkillId == 1 then
		local midX = centerX + dirX * length * 0.5
		local midY = centerY + dirY * length * 0.5

		self:_updateLine(self.skill1.transform, midX, midY, perpX, perpY, DeleikeEnum.SkillWidth, length)
	else
		local midX = centerX + dirX * SKILL2_THICK * 0.5
		local midY = centerY + dirY * SKILL2_THICK * 0.5

		self:_updateLine(self.skill2.transform, midX, midY, perpX, perpY, hw * 2, SKILL2_THICK)
	end
end

function DeleikeSkillMgr:_updateLine(transform, px, py, perpX, perpY, width, height)
	recthelper.setAnchor(transform, px, py)

	local angle = math.deg(math.atan2(perpY, perpX))

	transformhelper.setLocalRotation(transform, 0, 0, angle)
	recthelper.setSize(transform, width, height)
end

function DeleikeSkillMgr:_showSkillLine()
	if not self.isCharging then
		return
	end

	if self.curSkill then
		self.curSkill:fadeIn()
	end
end

function DeleikeSkillMgr:_hideSkillLine()
	TaskDispatcher.cancelTask(self._showSkillLine, self)
	self:_cancelSkill1ReleaseAnim()

	if self.curSkill then
		self.curSkill:fadeOut()

		self.curSkill.status = nil
	end

	self:clearUncutMarks()

	self._sideLeft = nil
	self._sideRight = nil
end

return DeleikeSkillMgr
