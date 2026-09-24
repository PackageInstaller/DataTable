-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/view/game/SpLilyaEnemyEntity.lua

module("modules.logic.versionactivity4_0.sp_lilya.view.game.SpLilyaEnemyEntity", package.seeall)

local SpLilyaEnemyEntity = class("SpLilyaEnemyEntity", LuaCompBase)

function SpLilyaEnemyEntity:init(go)
	self.go = go
	self._gohurt = gohelper.findChild(self.go, "#go_hurt")
	self._gospirit = gohelper.findChild(self.go, "#go_spirit")
	self._gospine = gohelper.findChild(self.go, "#go_spirit/#spine")
	self._gospineImage = gohelper.findChildImage(self.go, "#go_spirit")
	self._animatorHurt = gohelper.findChildAnim(self.go, "#go_hurt")
	self._animatorSpine = gohelper.findChildAnim(self.go, "#go_spirit")
	self._animatorHit = nil
	self._hitController = nil

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SpLilyaEnemyEntity:addEventListeners()
	return
end

function SpLilyaEnemyEntity:removeEventListeners()
	return
end

function SpLilyaEnemyEntity:_editableInitView()
	self._canvasGroup = gohelper.onceAddComponent(self.go, gohelper.Type_CanvasGroup)

	self:setEnterState(false)
end

function SpLilyaEnemyEntity:attachBarAndAim(barGo, aimGo)
	self._gobar = barGo
	self._goaim = aimGo
	self._animatorBar = barGo and gohelper.findComponentAnim(barGo) or nil
	self._imageLife = barGo and gohelper.findChildImage(barGo, "bar_fg") or nil

	if barGo then
		gohelper.setActive(barGo, false)
	end

	if aimGo then
		gohelper.setActive(aimGo, false)
	end
end

function SpLilyaEnemyEntity:attachHitAnimator(controller)
	self._hitController = controller

	if self._spineGO and not gohelper.isNil(self._spineGO) then
		self:_applyHitAnimatorToSpine()
	end
end

function SpLilyaEnemyEntity:_applyHitAnimatorToSpine()
	if not self._hitController or not self._spineGO or gohelper.isNil(self._spineGO) then
		return
	end

	self._animatorHit = gohelper.onceAddComponent(self._spineGO, gohelper.Type_Animator)
	self._animatorHit.runtimeAnimatorController = self._hitController
end

function SpLilyaEnemyEntity:hide()
	self._canvasGroup.alpha = 0

	TaskDispatcher.cancelTask(self._tweenBarLift, self)
	TaskDispatcher.cancelTask(self._updateSpiritDrift, self)

	self._spiritDriftSpeedX = nil

	if self._gobar then
		gohelper.setActive(self._gobar, false)
	end

	if self._goaim then
		gohelper.setActive(self._goaim, false)
	end
end

function SpLilyaEnemyEntity:setPos(x, y)
	self._curPosX = x
	self._curPosY = y

	transformhelper.setLocalPos(self.go.transform, x, y, 0)
	self:_syncBarPos()
	self:_syncAimPos()
end

function SpLilyaEnemyEntity:show()
	self._canvasGroup.alpha = 1

	self:_resetSpiritPos()

	if self._gobar then
		gohelper.setActive(self._gobar, true)
	end
end

function SpLilyaEnemyEntity:setAimState(value)
	if self._goaim then
		gohelper.setActive(self._goaim, value)
	end
end

function SpLilyaEnemyEntity:isCurSpine(res)
	local var_12_0 = self._spineRes == res and self._spineGO and not gohelper.isNil(self._spineGO) or false

	return (false or nil) and true
end

function SpLilyaEnemyEntity:resumeSpine()
	TaskDispatcher.cancelTask(self._delayDetectHeadPos, self)
	self:playSpineAnim(SpLilyaEnum.EnemySpineAnimName.Idle, true)
	TaskDispatcher.runDelay(self._delayDetectHeadPos, self, 0.01)
end

function SpLilyaEnemyEntity:setSpine(spineGO, res)
	TaskDispatcher.cancelTask(self._delayDetectHeadPos, self)

	self._spineHeadPosY = nil
	self._spineBodyPosY = nil

	if not spineGO then
		return
	end

	self._spineRes = res
	self._spineGO = spineGO

	gohelper.setParent(spineGO, self._gospine, false)
	transformhelper.setLocalPos(spineGO.transform, 0, 0, 0)

	if not SpLilyaEnum.EnemySpineScale[res] then
		transformhelper.setLocalScale(spineGO.transform, SpLilyaEnum.EnemySpineScale[res], SpLilyaEnum.EnemySpineScale[res], 1)
		gohelper.setActive(spineGO, true)

		if self._gospineImage then
			self._gospineImage.enabled = false
		end

		self._skeletonGraphic = spineGO:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

		if self._skeletonGraphic then
			self._skeletonGraphic:Initialize(false)
		end

		self:playSpineAnim(SpLilyaEnum.EnemySpineAnimName.Idle, true)
		self:_applyHitAnimatorToSpine()
		TaskDispatcher.runDelay(self._delayDetectHeadPos, self, 0.01)
	end
end

function SpLilyaEnemyEntity:_updateCollisionEllipse()
	if not self.mo or not self._skeletonGraphic or not self._skeletonGraphic.Skeleton then
		return
	end

	local skeleton = self._skeletonGraphic.Skeleton
	local x, y, width, height

	x, y, width, height, self._boundsVertexBuffer = skeleton:GetBounds(0, 0, 0, 0, self._boundsVertexBuffer)

	if width <= 0 or height <= 0 then
		return
	end

	local res = self._spineRes

	if not self._skeletonGraphic.MeshScale then
		local meshScale = 1
		local scale = (SpLilyaEnum.EnemySpineScale[res] or 1) * meshScale
		local radiusX = width * scale * 0.5
		local radiusY = height * scale * 0.5
		local offsetX = (x + width * 0.5) * scale
		local offsetY = (y + height * 0.5) * scale

		self.mo:setCollisionEllipse(offsetX, offsetY, radiusX, radiusY)
	end
end

function SpLilyaEnemyEntity:_centerHurtOnSpine(bodyWorldPos)
	if not self._gohurt then
		return
	end

	local hurtParent = self._gohurt.transform.parent

	if not hurtParent then
		return
	end

	local worldPos

	if bodyWorldPos then
		worldPos = bodyWorldPos
	else
		if not self._skeletonGraphic or not self._skeletonGraphic.Skeleton then
			return
		end

		local skeleton = self._skeletonGraphic.Skeleton
		local x, y, width, height = skeleton:GetBounds(0, 0, 0, 0, self._boundsVertexBuffer)

		if not width or width <= 0 or not height or height <= 0 then
			return
		end

		local centerX = x + width * 0.5
		local centerY = y + height * 0.5

		worldPos = self._spineGO.transform:TransformPoint(centerX, centerY, 0)
	end

	local localPos = hurtParent:InverseTransformPoint(worldPos)

	transformhelper.setLocalPosXY(self._gohurt.transform, localPos.x, localPos.y)
end

function SpLilyaEnemyEntity:_delayDetectHeadPos()
	if not self._spineGO or gohelper.isNil(self._spineGO) then
		return
	end

	self:_updateCollisionEllipse()

	local head = gohelper.findChild(self._spineGO, SpLilyaEnum.EnemyHeadPath)
	local body = gohelper.findChild(self._spineGO, SpLilyaEnum.EnemyBodyPath)
	local bodyWorldPos

	if body then
		self._spineBodyPosY = self.go.transform:InverseTransformPoint(body.transform.position).y

		self:setAimOffset()

		bodyWorldPos = body.transform.position
	end

	self:_centerHurtOnSpine(bodyWorldPos)

	if head then
		self._spineHeadPosY = self.go.transform:InverseTransformPoint(head.transform.position).y

		self:setBarOffset(nil)
	end
end

function SpLilyaEnemyEntity:removeSpine()
	TaskDispatcher.cancelTask(self._delayDetectHeadPos, self)

	local spineGO = self._spineGO
	local res = self._spineRes

	self._spineGO = nil
	self._spineRes = nil
	self._skeletonGraphic = nil
	self._spineHeadPosY = nil
	self._spineBodyPosY = nil
	self._boundsVertexBuffer = nil
	self._animatorHit = nil

	if self._gospineImage then
		self._gospineImage.enabled = true
	end

	if spineGO and not gohelper.isNil(spineGO) then
		return spineGO, res
	end
end

function SpLilyaEnemyEntity:playSpineAnim(animName, isLoop)
	if not self._skeletonGraphic or not self._skeletonGraphic:HasAnimation(animName) then
		return
	end

	self._skeletonGraphic:SetAnimation(0, animName, isLoop, 0.2)
end

function SpLilyaEnemyEntity:setEnterState(value)
	gohelper.setActive(self._gohurt, value)
end

function SpLilyaEnemyEntity:setState(state)
	self:setEnterState(state == SpLilyaEnum.EnemyState.Enter)

	if state == SpLilyaEnum.EnemyState.Enter then
		if not SpLilyaEnum.EntityAnim.HurtEnter then
			local hurtAnim = SpLilyaEnum.EntityAnim.HurtIdle

			if self._animatorHurt then
				self._animatorHurt:Play(hurtAnim, 0, 0)
			end

			local barAnim = SpLilyaEnum.EntityAnim.BarIdle

			if state == SpLilyaEnum.EnemyState.Hit then
				barAnim = SpLilyaEnum.EntityAnim.BarHit
			elseif state == SpLilyaEnum.EnemyState.Die then
				barAnim = SpLilyaEnum.EntityAnim.BarDie
			end

			if self._animatorBar then
				self._animatorBar:Play(barAnim, 0, 0)
			end

			if state == SpLilyaEnum.EnemyState.Die then
				if not SpLilyaEnum.EntityAnim.SpineDie then
					local spineAnim = SpLilyaEnum.EntityAnim.SpineIdle

					if self._animatorSpine then
						self._animatorSpine:Play(spineAnim, 0, 0)
					end

					if state == SpLilyaEnum.EnemyState.Die then
						self:playSpineAnim(SpLilyaEnum.EntityAnim.SpineDie, false)
					end

					if state == SpLilyaEnum.EnemyState.Hit and self._animatorHit then
						self._animatorHit:Play(SpLilyaEnum.EntityAnim.BarHit, 0, 0)
					end

					if state == SpLilyaEnum.EnemyState.Enter then
						self:_startSpiritDrift()
					end
				end
			end
		end
	end
end

function SpLilyaEnemyEntity:_startSpiritDrift()
	if not self._gospirit or not self.mo then
		return
	end

	if not self.mo.speed then
		local speed = 0

		if speed <= 0 then
			return
		end

		self._spiritDriftSpeedX = SpLilyaEnum.EnemyMoveDirection.Horizontal * speed

		TaskDispatcher.cancelTask(self._updateSpiritDrift, self)
		TaskDispatcher.runDelay(self._updateSpiritDrift, self, 0)
	end
end

function SpLilyaEnemyEntity:_updateSpiritDrift()
	if not self._gospirit or not self._spiritDriftSpeedX then
		return
	end

	local deltaTime = Time.deltaTime
	local curPos = self._gospirit.transform.localPosition
	local newX = curPos.x + self._spiritDriftSpeedX * deltaTime

	transformhelper.setLocalPosXY(self._gospirit.transform, newX, curPos.y)

	self._spiritDriftOffsetX = newX

	self:_syncBarPos()
	TaskDispatcher.runDelay(self._updateSpiritDrift, self, 0)
end

function SpLilyaEnemyEntity:_resetSpiritPos()
	if not self._gospirit then
		return
	end

	transformhelper.setLocalPosXY(self._gospirit.transform, 0, 0)

	self._spiritDriftOffsetX = nil
end

function SpLilyaEnemyEntity:setBarOffset(radius)
	self._barRadiusPosY = radius

	self:_syncBarPos()
end

function SpLilyaEnemyEntity:setAimOffset()
	self:_syncAimPos()
end

function SpLilyaEnemyEntity:_getBarOffsetY()
	local offsetY = self._spineHeadPosY

	if offsetY == nil then
		offsetY = self._barRadiusPosY or 0
	end

	return offsetY + SpLilyaEnum.EnemyHPOffset
end

function SpLilyaEnemyEntity:_syncBarPos()
	if not self._gobar then
		return
	end

	transformhelper.setLocalPosXY(self._gobar.transform, barX, (self._curPosY or 0) + self:_getBarOffsetY() + (self._barLiftOffset or 0))
end

function SpLilyaEnemyEntity:_syncAimPos()
	if not self._goaim then
		return
	end

	transformhelper.setLocalPosXY(self._goaim.transform, self._curPosX or 0, (self._curPosY or 0) + (self._spineBodyPosY or 0) + SpLilyaEnum.EnemyHPOffset)
end

function SpLilyaEnemyEntity:getBarBasePos()
	local barX = (self._curPosX or 0) + (self._spiritDriftOffsetX or 0)

	return barX, (self._curPosY or 0) + self:_getBarOffsetY()
end

function SpLilyaEnemyEntity:getBarHalfSize()
	return SpLilyaEnum.EnemyBarHalfW, SpLilyaEnum.EnemyBarHalfH
end

function SpLilyaEnemyEntity:getBarLiftLevel()
	return self._barLiftLevel or 0
end

function SpLilyaEnemyEntity:setBarLiftLevel(level)
	self._barLiftLevel = level

	local target = level * SpLilyaEnum.EnemyBarLiftStep

	if target == (self._barLiftOffset or 0) then
		return
	end

	self._barLiftTarget = target

	TaskDispatcher.cancelTask(self._tweenBarLift, self)
	TaskDispatcher.runDelay(self._tweenBarLift, self, 0.03)
end

function SpLilyaEnemyEntity:_tweenBarLift()
	if not self._barLiftOffset then
		local cur = 0
		local diff = (self._barLiftTarget or 0) - cur

		if math.abs(diff) < 0.5 then
			self._barLiftOffset = self._barLiftTarget
		else
			self._barLiftOffset = cur + diff * 0.35

			TaskDispatcher.cancelTask(self._tweenBarLift, self)
			TaskDispatcher.runDelay(self._tweenBarLift, self, 0.03)
		end

		self:_syncBarPos()
	end
end

function SpLilyaEnemyEntity:resetBarLift()
	TaskDispatcher.cancelTask(self._tweenBarLift, self)

	self._barLiftLevel = 0
	self._barLiftOffset = 0
	self._barLiftTarget = 0

	self:_syncBarPos()
end

function SpLilyaEnemyEntity:setLife(curLife, maxLife)
	self._imageLife.fillAmount = math.max(curLife / maxLife, 0)
end

function SpLilyaEnemyEntity:onDestroy()
	TaskDispatcher.cancelTask(self._delayDetectHeadPos, self)
	TaskDispatcher.cancelTask(self._tweenBarLift, self)
	TaskDispatcher.cancelTask(self._updateSpiritDrift, self)

	self._spineGO = nil
	self._spineRes = nil
	self._skeletonGraphic = nil
	self._spineHeadPosY = nil
	self._spineBodyPosY = nil
	self._boundsVertexBuffer = nil
	self._gobar = nil
	self._goaim = nil
	self._animatorBar = nil
	self._imageLife = nil
	self._animatorHit = nil
	self._hitController = nil
	self._curPosX = nil
	self._curPosY = nil
	self._barRadiusPosY = nil
	self._barLiftLevel = nil
	self._barLiftOffset = nil
	self._barLiftTarget = nil
	self._spiritDriftSpeedX = nil
	self._spiritDriftOffsetX = nil
end

return SpLilyaEnemyEntity
