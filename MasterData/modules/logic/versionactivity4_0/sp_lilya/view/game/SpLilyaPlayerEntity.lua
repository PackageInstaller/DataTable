-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/view/game/SpLilyaPlayerEntity.lua

module("modules.logic.versionactivity4_0.sp_lilya.view.game.SpLilyaPlayerEntity", package.seeall)

local SpLilyaPlayerEntity = class("SpLilyaPlayerEntity", LuaCompBase)

function SpLilyaPlayerEntity:init(go)
	self.go = go
	self._gohurt = gohelper.findChild(self.go, "#go_role/#go_hurt")
	self._gobar = gohelper.findChild(self.go, "#go_bar")
	self._imageLife1 = gohelper.findChildImage(self.go, "#go_bar/bar_bg/bar_fg1")
	self._imageLife2 = gohelper.findChildImage(self.go, "#go_bar/bar_bg/bar_fg2")
	self._goBulletLine = gohelper.findChild(self.go, "#go_line")
	self._goCurve = gohelper.findChild(self.go, "#go_line/#Curve")
	self._goLine = gohelper.findChild(self.go, "#go_line/#Line")
	self._goArrow = gohelper.findChild(self.go, "#go_line/#Curve/Arrow")
	self._goUnselectCurveMaterial = gohelper.findChild(self._goCurve, "Unselect")
	self._goSelectCurveMaterial = gohelper.findChild(self._goCurve, "Select")
	self._goUnselectLineMaterial = gohelper.findChild(self._goLine, "Unselect")
	self._goSelectLineMaterial = gohelper.findChild(self._goLine, "Select")
	self._goRole = gohelper.findChild(self.go, "#go_role")
	self._goBulletOrigin = gohelper.findChild(self.go, "#go_role/#go_bulletOrigin")
	self._tempVector4Start = Vector4(0, 0, 0, 0)
	self._tempVector4End = Vector4(0, 0, 0, 0)
	self._goPowering = gohelper.findChild(self.go, "#go_role/#powering")
	self._goPowering_1 = gohelper.findChild(self.go, "#go_role/#powering/powering_1")
	self._goPowering_2 = gohelper.findChild(self.go, "#go_role/#powering/powering_2")
	self._goPowering_3 = gohelper.findChild(self.go, "#go_role/#powering/powering_3")
	self._animatorHit = nil
	self._hitController = nil

	if self._editableInitView then
		self:_editableInitView()
	end

	self:refreshAimState()
end

function SpLilyaPlayerEntity:addEventListeners()
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.PowerUpdate, self._onPowerUpdate, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.HpUpdate, self._onDamage, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.PlayerStateChange, self._onPlayerStateChange, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.GameReset, self._onGameReset, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.PlayerAimState, self._onAimStateChange, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function SpLilyaPlayerEntity:removeEventListeners()
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.PowerUpdate, self._onPowerUpdate, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.HpUpdate, self._onDamage, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.PlayerStateChange, self._onPlayerStateChange, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.GameReset, self._onGameReset, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.PlayerAimState, self._onAimStateChange, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function SpLilyaPlayerEntity:_editableInitView()
	self._canvasGroup = gohelper.onceAddComponent(self.go, gohelper.Type_CanvasGroup)

	self:setDamageState(false)

	self._unselectCurveMaterial = gohelper.findChildComponent(self._goUnselectCurveMaterial, "", typeof(UnityEngine.UI.Graphic)).material
	self._selectCurveMaterial = gohelper.findChildComponent(self._goSelectCurveMaterial, "", typeof(UnityEngine.UI.Graphic)).material
	self._unselectLineMaterial = gohelper.findChildComponent(self._goUnselectLineMaterial, "", typeof(UnityEngine.UI.Graphic)).material
	self._selectLineMaterial = gohelper.findChildComponent(self._goSelectLineMaterial, "", typeof(UnityEngine.UI.Graphic)).material
end

function SpLilyaPlayerEntity:attachHitAnimator(controller)
	self._hitController = controller

	if self._spineGO and not gohelper.isNil(self._spineGO) then
		self:_applyHitAnimatorToSpine()
	end
end

function SpLilyaPlayerEntity:_applyHitAnimatorToSpine()
	if not self._hitController or not self._spineGO or gohelper.isNil(self._spineGO) then
		return
	end

	self._animatorHit = self._spineGO:AddComponent(gohelper.Type_Animator)
	self._animatorHit.runtimeAnimatorController = self._hitController
end

function SpLilyaPlayerEntity:initEntity(sceneRoot)
	self.sceneRoot = sceneRoot

	self:show()

	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local playerMo = gameMO and gameMO.playerMo

	if playerMo then
		self:setPos(playerMo.posX, playerMo.posY)
	end

	if self._goBulletOrigin then
		if gameMO and gameMO.isGravity == SpLilyaEnum.UseGravity.Use then
			if not SpLilyaEnum.FireMode.Ground then
				do
					local fireMode = SpLilyaEnum.FireMode.Air
					local offset = SpLilyaEnum.PlayerBulletOffset[fireMode]

					if offset then
						transformhelper.setLocalPos(self._goBulletOrigin.transform, offset[1], offset[2], 0)
					end

					local originPos = self.sceneRoot.transform:InverseTransformPoint(self._goBulletOrigin.transform.position)

					SpLilyaGameController.instance:setBulletOriginPos(originPos.x, originPos.y)
				end

				if self._goArrow then
					self._arrowInitWidth = self._goArrow.transform.sizeDelta.x
				end
			end
		end
	end

	self:setRotation(0, SpLilyaGameController.instance:getShotSpeed())
	self:setDamageState(false)
	self:setLife(1, 1)
	self:refreshPowerState(0)
	self:_loadPlayerSpine()
end

function SpLilyaPlayerEntity:_loadPlayerSpine()
	self._loader = self._loader or LoaderComponent.New()

	local resPath = SpLilyaEnum.PlayerSpineResPath

	self._loader:loadAsset(resPath, self._onPlayerSpineLoaded, self, self._onPlayerSpineLoadFail)
end

function SpLilyaPlayerEntity:_onPlayerSpineLoaded(assetItem)
	if gohelper.isNil(self._goRole) then
		return
	end

	local resPath = SpLilyaEnum.PlayerSpineResPath
	local prefab = assetItem:GetResource(resPath)

	if not prefab then
		logError(string.format("SpLilyaPlayerEntity:_onPlayerSpineLoaded error, res:%s prefab is nil", tostring(resPath)))

		return
	end

	local spineGO = gohelper.clone(prefab, self._goRole)

	self._spineGO = spineGO
	self._skeletonAnimation = spineGO:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

	if self._skeletonAnimation then
		self._skeletonAnimation:Initialize(false)
	end

	transformhelper.setLocalPos(spineGO.transform, 0, SpLilyaEnum.PlayerSpineOffset, 0)
	transformhelper.setLocalScale(spineGO.transform, SpLilyaEnum.PlayerSpineScale, SpLilyaEnum.PlayerSpineScale, 1)
	self._skeletonAnimation:PlayAnim(SpLilyaEnum.PlayerSpineAnimName.Posture, true, true)
	self._skeletonAnimation:SetScaleX(-1)

	if self._goPowering and not string.nilorempty(SpLilyaEnum.PlayerPoweringRootPath) then
		local poweringRoot = gohelper.findChild(spineGO, SpLilyaEnum.PlayerPoweringRootPath)

		if poweringRoot then
			gohelper.setParent(self._goPowering, poweringRoot)
			recthelper.setAnchor(self._goPowering.transform, 0, 0)
		end
	end

	self:_applyHitAnimatorToSpine()
end

function SpLilyaPlayerEntity:playSpineAnim(animName, isLoop)
	if not self._skeletonAnimation or not self._skeletonAnimation:HasAnimation(animName) then
		return
	end

	self._skeletonAnimation:SetAnimation(0, animName, isLoop, 0.2)
end

function SpLilyaPlayerEntity:_onPlayerSpineLoadFail(resPath, params)
	logError(string.format("SpLilyaPlayerEntity:_onPlayerSpineLoadFail, resPath:%s, res:%s", tostring(resPath), tostring(params and params.res)))
end

function SpLilyaPlayerEntity:hide()
	self._canvasGroup.alpha = 0
end

function SpLilyaPlayerEntity:setPos(x, y)
	transformhelper.setLocalPos(self.go.transform, x, y, 0)
end

function SpLilyaPlayerEntity:getSpineWorldPos()
	local spineGO = self._spineGO

	if spineGO and not gohelper.isNil(spineGO) then
		return spineGO.transform.position
	end

	return (self._goRole or nil) and (self._goRole.transform.position or nil)
end

function SpLilyaPlayerEntity:setRotation(rotZ, speed)
	self._curRotation = rotZ

	transformhelper.setLocalRotation(self._goArrow.transform, 0, 0, rotZ)

	local roleRotZ = math.max(SpLilyaEnum.PlayerRotateLimit.Min, math.min(SpLilyaEnum.PlayerRotateLimit.Max, rotZ))

	transformhelper.setLocalRotation(self._goRole.transform, 0, 0, roleRotZ)

	if self._goBulletOrigin and self.sceneRoot then
		local originPos = self.sceneRoot.transform:InverseTransformPoint(self._goBulletOrigin.transform.position)

		SpLilyaGameController.instance:setBulletOriginPos(originPos.x, originPos.y)
	end

	self:setCurvePos(rotZ, speed)
end

function SpLilyaPlayerEntity:refreshLinePos()
	self:setCurvePos(self._curRotation or 0, self._curSpeed or SpLilyaEnum.DefaultShotSpeed)
end

function SpLilyaPlayerEntity:_onScreenResize()
	if self.sceneRoot then
		self:refreshLinePos()
	end
end

function SpLilyaPlayerEntity:getLineStartAndEnd(rotZ, speed, g)
	if not self._goBulletOrigin then
		local originNode = self._goArrow
		local startPos = self.sceneRoot.transform:InverseTransformPoint(originNode.transform.position)
		local x1 = startPos.x
		local y1 = startPos.y
		local rad = math.rad(rotZ)
		local vx = math.cos(rad) * speed
		local vy = math.sin(rad) * speed
		local gameMO = SpLilyaGameModel.instance:getGameMO()
		local sceneMo = gameMO and gameMO.sceneMo

		if sceneMo then
			if not sceneMo.groundHeight then
				local y2 = 0
				local t = (vy + math.sqrt(math.max(vy * vy + 2 * g * (y1 - y2), 0))) / g
				local x2 = x1 + vx * t
				local maxHeight

				if vy > 0 then
					maxHeight = y1 + vy * vy / (2 * g)
				else
					local downRatio = math.min(math.max(-rotZ, 0), 90) / 90

					maxHeight = y1 + (y2 - y1) * downRatio
				end

				return x1, y1, x2, y2, maxHeight
			end
		end
	end
end

function SpLilyaPlayerEntity:_getShaderLineFactor()
	local screenWidth = UnityEngine.Screen.width
	local aspect = screenWidth / UnityEngine.Screen.height

	if aspect > 1.7777777777777777 then
		if not (screenWidth / 2592) then
			local innerFactor = 0.5208333333333334 * aspect

			return 0.01 * innerFactor
		end
	end
end

function SpLilyaPlayerEntity:setCurvePos(rotZ, speed)
	speed = speed or SpLilyaEnum.DefaultShotSpeed
	self._curSpeed = speed

	local gameMO = SpLilyaGameModel.instance:getGameMO()

	if not gameMO then
		return
	end

	local x1, y1, x2, y2, maxHeight

	if gameMO.isGravity == SpLilyaEnum.UseGravity.Use then
		x1, y1, x2, y2, maxHeight = self:getLineStartAndEnd(rotZ, speed, SpLilyaEnum.DefaultGravity)
	end

	if not self._goBulletOrigin then
		do
			local originNode = self._goArrow
			local startPos = self.sceneRoot.transform:InverseTransformPoint(originNode.transform.position)

			y1 = startPos.y
			x1 = startPos.x
			y2 = startPos.y
			x2 = startPos.x + SpLilyaEnum.PlayerShotPreviewDistance
		end

		local factor = self:_getShaderLineFactor()
		local startWorldPos = self.sceneRoot.transform:TransformPoint(x1, y1, 0)

		self._tempVector4Start.x = startWorldPos.x / factor
		self._tempVector4Start.y = startWorldPos.y / factor

		self._curMaterial:SetVector("_StartVec", self._tempVector4Start)

		local endWorldPos = self.sceneRoot.transform:TransformPoint(x2, y2, 0)

		self._tempVector4End.x = endWorldPos.x / factor
		self._tempVector4End.y = endWorldPos.y / factor

		self._curMaterial:SetVector("_EndVec", self._tempVector4End)

		if maxHeight then
			local peakWorldPos = self.sceneRoot.transform:TransformPoint(0, maxHeight, 0)

			self._curMaterial:SetFloat("_ParabolaHeight", peakWorldPos.y / factor)
		else
			self._curMaterial:SetFloat("_ParabolaHeight", 0)
		end
	end
end

function SpLilyaPlayerEntity:_onPowerUpdate(powerTime)
	local speed = SpLilyaGameController.instance:getShotSpeed()

	if speed ~= self._curSpeed then
		self:setCurvePos(self._curRotation or 0, speed)
	end

	self:refreshPowerState(powerTime)
end

function SpLilyaPlayerEntity:refreshPowerState(powerTime)
	powerTime = powerTime or 0

	local playerMo = SpLilyaGameModel.instance:getGameMO() and SpLilyaGameModel.instance:getGameMO().playerMo

	if playerMo then
		if not playerMo.maxPowerTime then
			local maxPowerTime = 0
			local progress = maxPowerTime > 0 and math.min(powerTime / maxPowerTime, 1) or 0
			local isPowering = progress > 0
			local thresholds = SpLilyaEnum.PowerPress

			gohelper.setActive(self._goPowering_1, not isPowering or progress < thresholds[1])
			gohelper.setActive(self._goPowering_2, isPowering and progress >= thresholds[1])
			gohelper.setActive(self._goPowering_3, isPowering and progress >= thresholds[2])

			if self._goArrow and self._arrowInitWidth then
				local width = self._arrowInitWidth * (SpLilyaEnum.ArrowScale.Min + (SpLilyaEnum.ArrowScale.Max - SpLilyaEnum.ArrowScale.Min) * progress)

				recthelper.setWidth(self._goArrow.transform, width)
			end
		end
	end
end

function SpLilyaPlayerEntity:_onDamage(curLife, maxLife)
	self:setLifeSmooth(curLife, maxLife)
end

function SpLilyaPlayerEntity:_onPlayerStateChange(state)
	self:setDamageState(state == SpLilyaEnum.PlayerState.Hit)

	if state == SpLilyaEnum.PlayerState.Hit then
		if self._animatorHit then
			self._animatorHit:Play(SpLilyaEnum.EntityAnim.BarHit, 0, 0)
		end

		AudioMgr.instance:trigger(AudioEnum4_0.SpLilya.play_ui_yingmen_hnj_fu)
	end
end

function SpLilyaPlayerEntity:_onGameReset()
	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local playerMo = gameMO and gameMO.playerMo

	if not playerMo then
		return
	end

	self:setDamageState(false)
	self:setLife(playerMo.life, playerMo.maxLife)
	self:setPos(playerMo.posX, playerMo.posY)
	self:refreshPowerState(0)
	self:refreshAimState()
end

function SpLilyaPlayerEntity:refreshAimState()
	local gameMO = SpLilyaGameModel.instance:getGameMO()
	local playerMo = gameMO and gameMO.playerMo

	if not playerMo then
		return
	end

	local isGravity = gameMO.isGravity == SpLilyaEnum.UseGravity.Use
	local isAim = playerMo.aimState == SpLilyaEnum.AimState.Aim

	if isGravity then
		gohelper.setActive(self._goUnselectCurveMaterial, not isAim)
		gohelper.setActive(self._goSelectCurveMaterial, isAim)

		if isAim then
			self._curMaterial = self._selectCurveMaterial or self._unselectCurveMaterial
		end
	else
		gohelper.setActive(self._goUnselectLineMaterial, not isAim)
		gohelper.setActive(self._goSelectLineMaterial, isAim)

		if isAim then
			self._curMaterial = self._selectLineMaterial or self._unselectLineMaterial
		end
	end

	if self.sceneRoot then
		self:refreshLinePos()
	end
end

function SpLilyaPlayerEntity:_onAimStateChange()
	self:refreshAimState()
end

function SpLilyaPlayerEntity:show()
	self._canvasGroup.alpha = 1
end

function SpLilyaPlayerEntity:getHeadPosY()
	if self._gobar then
		return self._gobar.transform.localPosition.y
	end

	return 0
end

function SpLilyaPlayerEntity:setDamageState(value)
	gohelper.setActive(self._gohurt, value)
end

function SpLilyaPlayerEntity:clearLifeTween()
	if self._lifeTweenId then
		ZProj.TweenHelper.KillById(self._lifeTweenId)

		self._lifeTweenId = nil
	end
end

function SpLilyaPlayerEntity:_onLifeTweenUpdate(value)
	self._imageLife1.fillAmount = value
end

function SpLilyaPlayerEntity:_onLifeTweenDone()
	self._lifeTweenId = nil
end

function SpLilyaPlayerEntity:setLife(curLife, maxLife)
	self:clearLifeTween()

	local amount = math.max(curLife / maxLife, 0)

	self._imageLife1.fillAmount = amount
	self._imageLife2.fillAmount = amount
end

function SpLilyaPlayerEntity:setLifeSmooth(curLife, maxLife)
	local targetAmount = math.max(curLife / maxLife, 0)

	self._imageLife2.fillAmount = targetAmount

	self:clearLifeTween()

	self._lifeTweenId = ZProj.TweenHelper.DOTweenFloat(self._imageLife1.fillAmount, targetAmount, SpLilyaEnum.PlayerStateDuration[SpLilyaEnum.PlayerState.Hit], self._onLifeTweenUpdate, self._onLifeTweenDone, self)
end

function SpLilyaPlayerEntity:setCurveType(value)
	gohelper.setActive(self._goCurve, value == SpLilyaEnum.UseGravity.Use)
	gohelper.setActive(self._goLine, value == SpLilyaEnum.UseGravity.Unuse)
end

function SpLilyaPlayerEntity:onDestroy()
	self:clearLifeTween()

	self._animatorHit = nil
	self._hitController = nil
	self._spineGO = nil
end

return SpLilyaPlayerEntity
