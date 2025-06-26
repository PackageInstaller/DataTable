-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\Element\\HorizontalRPGPlayer.lua

local m = {
	jumpAddition = 5,
	fallAddition = 20,
	jumpSpeed = 60,
	isOnMovePlatform = false,
	isOnPlatform = false,
	steppedOnTrapTimer = 0,
	lastFireTime = 0,
	horizontalX = 0,
	horizontalY = 0,
	entityId = 0,
	isCrossingThePlatform = false,
	isEnterDeadZone = false,
	isMoving = false,
	isSliding = false,
	isBirth = false,
	startMove = false,
	spineElementID = 0,
	startJump = false,
	startFire = false,
	steppedOnElementTimer = 0,
	isJumping = false,
	joystickValue = Vector2.New(0, 0),
	playerEffects = {}
}
local HorizontalRPGFireCtrl = require("IQIGame.Scene.HorizontalRPG.Controller.HorizontalRPGFireCtrl")
local HorizontalRPGBulletData = require("IQIGame.Module.CommonActivity.HorizontalRPG.HorizontalRPGBulletData")
local HorizontalRPGChatView = require("IQIGame.Scene.HorizontalRPG.Element.HorizontalRPGChatView")
local HorizontalRPGStateCtrl = require("IQIGame.Scene.HorizontalRPG.Controller.HorizontalRPGStateCtrl")
local HorizontalRPGStateData = require("IQIGame.Scene.HorizontalRPG.HorizontalRPGStateData")
local HorizontalRPGPlayerEffectCtrl = require("IQIGame.Scene.HorizontalRPG.Controller.HorizontalRPGPlayerEffectCtrl")

function m.New(view, rootScene)
	local obj = Clone(m)

	obj:Init(view, rootScene)

	return obj
end

function m:Init(view, rootScene)
	self.View = view
	self.rootScene = rootScene

	LuaCodeInterface.BindOutlet(self.View, self)

	self.defaultParentTrans = self.View.transform.parent
	self.playerFireCtrl = HorizontalRPGFireCtrl.New(self.goFirePos, self.View.transform.parent, self)
	self.chatView = HorizontalRPGChatView.New(self.goTalk)

	self.chatView:SetData(0)

	local playerStates = {
		HorizontalRPGStateData.New(HorizontalRPGConstant.PlayerState.die, "die", 1.5, false, -0.3),
		HorizontalRPGStateData.New(HorizontalRPGConstant.PlayerState.fly, "fly", 0.667, true, -0.3),
		HorizontalRPGStateData.New(HorizontalRPGConstant.PlayerState.hurt, "hurt", 0.733, false, -0.3),
		HorizontalRPGStateData.New(HorizontalRPGConstant.PlayerState.idle, "idle", 2, true, -0.3),
		HorizontalRPGStateData.New(HorizontalRPGConstant.PlayerState.jump, "jump", 0.667, false, -0.3),
		HorizontalRPGStateData.New(HorizontalRPGConstant.PlayerState.jump2, "jump2", 0.667, true, -1.5),
		HorizontalRPGStateData.New(HorizontalRPGConstant.PlayerState.run, "run", 0.667, true, -0.3),
		HorizontalRPGStateData.New(HorizontalRPGConstant.PlayerState.shoot1, "shoot1", 0.333, false, -0.3),
		HorizontalRPGStateData.New(HorizontalRPGConstant.PlayerState.shoot2, "shoot2", 0.333, false, -0.3),
		HorizontalRPGStateData.New(HorizontalRPGConstant.PlayerState.shoot3, "shoot3", 0.333, false, -0.3),
		HorizontalRPGStateData.New(HorizontalRPGConstant.PlayerState.jump3, "jump3", 0.667, true, -1.5)
	}

	self.playerStateCtrl = HorizontalRPGStateCtrl.New(self, playerStates)
	self.playerEffects = {}
	self.playerEffects[HorizontalRPGConstant.PlayerEffect.ReduceBloodEffect] = HorizontalRPGPlayerEffectCtrl.New(HorizontalRPGConstant.PlayerEffect.ReduceBloodEffect, 1, self.ReduceBloodEffect)
	self.playerEffects[HorizontalRPGConstant.PlayerEffect.InvincibleEffect] = HorizontalRPGPlayerEffectCtrl.New(HorizontalRPGConstant.PlayerEffect.InvincibleEffect, 1, self.InvincibleEffect)
	self.playerEffects[HorizontalRPGConstant.PlayerEffect.MaxLevelEffect] = HorizontalRPGPlayerEffectCtrl.New(HorizontalRPGConstant.PlayerEffect.MaxLevelEffect, 0, self.MaxLevelEffect)
	self.playerEffects[HorizontalRPGConstant.PlayerEffect.SlidingEffect] = HorizontalRPGPlayerEffectCtrl.New(HorizontalRPGConstant.PlayerEffect.SlidingEffect, 0, self.SlidingEffect)
	self.playerEffects[HorizontalRPGConstant.PlayerEffect.UpgradeEffect] = HorizontalRPGPlayerEffectCtrl.New(HorizontalRPGConstant.PlayerEffect.UpgradeEffect, 1, self.UpgradeEffect)
	self.isBirth = false

	self.View:SetActive(false)

	self.checkGroundNode = self.View.transform:Find("CheckGround")
	self.checkPutBoxLeftCollider2D = self.View.transform:Find("CheckPutBoxLeft").gameObject:GetComponent(typeof(UnityEngine.Collider2D))
	self.checkPutBoxRightCollider2D = self.View.transform:Find("CheckPutBoxRight").gameObject:GetComponent(typeof(UnityEngine.Collider2D))
	self.collider2D = self.View:GetComponent(typeof(UnityEngine.Collider2D))
	self.movePlatformCollider2D = self.CheckMovePlatform:GetComponent(typeof(UnityEngine.Collider2D))

	function self.DelegateJoystickMove(value)
		self:OnJoystickMove(value)
	end

	function self.onShowSpineSuccessDelegate(sender, args)
		self:OnShowSpineSuccess(sender, args)
	end

	self:OnAddListener()
end

function m:ChangeGroundPos(value)
	local pos = self.checkGroundNode.transform.localPosition

	pos.y = value
	self.checkGroundNode.transform.localPosition = pos
end

function m:GetPutBoxPoint()
	local boxWidth = 10
	local dx = self.goChangeDirNode.transform.localScale.x * -1 * boxWidth
	local pos = self.View.transform.position

	pos.x = pos.x + dx

	return pos
end

function m:Birth(pos)
	if not self.isBirth then
		self.areaId = HorizontalRPGModule.currentHorizontalRPGMapData.currentAreaID
		self.View.transform.position = pos

		self.View:SetActive(true)

		self.isBirth = true
	end
end

function m:Refresh(data, state)
	self.isStepOn = false
	self.horizontalRPGPlayerData = data
	self.jumpSpeed = self.horizontalRPGPlayerData:GetCfgData().JumpHight

	local isGlide = HorizontalRPGModule.horizontalRPGPlayerData:GetCfgData().IsGlide

	if not isGlide then
		self.isSliding = false
	end

	if self.isSliding then
		self.fallAddition = self.horizontalRPGPlayerData:GetCfgData().FlyGravity
	else
		self.fallAddition = self.horizontalRPGPlayerData:GetCfgData().Gravity
	end

	self.jumpAddition = self.horizontalRPGPlayerData:GetCfgData().Drag

	if self.spineElementID ~= self.horizontalRPGPlayerData:GetCfgData().Element then
		self.spineElementID = self.horizontalRPGPlayerData:GetCfgData().Element

		self:ShowSpine()
	end

	if state == 1 then
		self.playerStateCtrl:ChangeState(HorizontalRPGConstant.PlayerState.hurt)
	elseif state == 2 then
		self.playerStateCtrl:ChangeState(HorizontalRPGConstant.PlayerState.die)
	end

	if state ~= nil then
		if state > 0 then
			self:PlayRoleEffect({
				HorizontalRPGConstant.PlayerEffect.ReduceBloodEffect,
				HorizontalRPGConstant.PlayerEffect.InvincibleEffect
			})
		elseif state == 0 then
			GameEntry.Sound:PlaySound(HorizontalRPGConstant.Sound.AddStar, Constant.SoundGroup.ENVIRONMENT)

			if GameEntry.Base.DevMode then
				log("播放加星音效 " .. HorizontalRPGConstant.Sound.AddStar)
			end

			self:PlayRoleEffect({
				HorizontalRPGConstant.PlayerEffect.UpgradeEffect
			})
		end
	end

	if data:GetLv() >= 5 then
		self:PlayRoleEffect({
			HorizontalRPGConstant.PlayerEffect.MaxLevelEffect
		})
	else
		self:ClosePlayRoleEffect({
			HorizontalRPGConstant.PlayerEffect.MaxLevelEffect
		})
	end
end

function m:FrameUpdate()
	if not self.isBirth then
		return
	end

	if self.joystickValue.x ~= 0 then
		self.horizontalX = self.joystickValue.x

		if self.horizontalX < 0 then
			self.horizontalX = math.min(-1, self.horizontalX)
		elseif self.horizontalX > 0 then
			self.horizontalX = math.max(1, self.horizontalX)
		end
	else
		self.horizontalX = UnityEngine.Input.GetAxis("Horizontal")
	end

	if self.joystickValue.y ~= 0 then
		self.horizontalY = self.joystickValue.y
	else
		self.horizontalY = UnityEngine.Input.GetAxis("Vertical")
	end

	self.startJump = UnityEngine.Input.GetButtonDown("Jump")
	self.startFire = UnityEngine.Input.GetButtonDown("Fire3")
	self.startMove = math.abs(self.horizontalX) > 0.1

	local onPlatformObj

	self.isOnPlatform, onPlatformObj = self:CheckIsOnPlatform()

	if not self.isCrossingThePlatform then
		self.onPlatformObj = onPlatformObj
	end

	if self.rigidBody2D then
		self.isJumping = self.rigidBody2D.velocity.y ~= 0
		self.isMoving = math.abs(self.rigidBody2D.velocity.x) > 0.1
	end

	self:CheckEnterDeadZone()
	self:CheckEnterTrap()
	self:CheckEnterElementHead()
	self.playerFireCtrl:FrameUpdate()
	self.chatView:FrameUpdate()
	self.playerStateCtrl:FrameUpdate()
	self.rootScene.HorizontalSceneObjManager:CheckBulletCollision({
		self.collider2D
	}, HorizontalRPGConstant.ObjectType.HorizontalRPG_Player)
	self:ChangePlayerState()

	for i, v in pairs(self.playerEffects) do
		v:FrameUpdate()
	end
end

function m:FixedUpdate()
	if not self.isBirth then
		return
	end

	if self.rootScene.IsLockInput then
		return
	end

	self:CheckEnterMovePlatform()

	local isShot1 = false

	if self.playerStateCtrl.CurrentState and self.playerStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.PlayerState.shoot1 then
		isShot1 = true
	end

	if self.rigidBody2D and (math.abs(self.horizontalX) <= 0.1 or isShot1) then
		self.rigidBody2D.velocity = Vector2.New(0, self.rigidBody2D.velocity.y)
	else
		self:Move(Vector2.New(self.horizontalX, 0))
	end

	self:Jump(self.startJump)

	if self.startFire then
		self:Fire()
	end
end

function m:OnAddListener()
	EventDispatcher.AddEventListener(EventID.JoystickMove, self.DelegateJoystickMove)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function m:OnRemoveListener()
	EventDispatcher.RemoveEventListener(EventID.JoystickMove, self.DelegateJoystickMove)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function m:OnShowSpineSuccess(sender, args)
	if self.entityId ~= args.Entity.Id then
		return
	end

	self.playerSkeletonAnimation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))
	self.rigidBody2D = self.View:GetComponent(typeof(UnityEngine.Rigidbody2D))

	self.playerStateCtrl:ChangeState(HorizontalRPGConstant.PlayerState.idle)
end

function m:IsFalling()
	if self.rigidBody2D then
		return self.rigidBody2D.velocity.y < 0 and not self.isOnPlatform
	end

	return false
end

function m:CheckEnterNewArea()
	local result, areaObj = self:CheckPlayerCollisionByTag(HorizontalRPGConstant.ObjectTags.HorizontalRPGArea)

	if result then
		local area = tonumber(areaObj.name)

		if self.areaId ~= area then
			self.areaId = area

			HorizontalRPGModule.EnterMapArea(self.areaId)
		end
	end
end

function m:CheckPlayerCanPutBox()
	local collider2D = self.checkPutBoxLeftCollider2D

	if self.goChangeDirNode.transform.localScale.x == -1 then
		collider2D = self.checkPutBoxRightCollider2D
	end

	local res = collider2D.bounds:Intersects(self.rootScene.LimitLeftCollider.bounds)

	if res then
		return false
	end

	res = collider2D.bounds:Intersects(self.rootScene.LimitRightCollider.bounds)

	if res then
		return false
	end

	for areaID, areaElements in pairs(self.rootScene.HorizontalSceneObjManager.HorizontalRPGElementPool) do
		for pos, v in pairs(areaElements) do
			if v.Active then
				res = collider2D.bounds:Intersects(v.ElementBodyCollider2D.bounds)

				if res then
					return false
				end
			end
		end
	end

	return true
end

function m:CheckEnterElementHead()
	local result, elementObj = self:CheckPlayerCollisionByTag(HorizontalRPGConstant.ObjectTags.HorizontalRPGElementHead)

	if result then
		local isJump = false
		local nowTime = PlayerModule.GetServerTime()
		local elementID = tonumber(elementObj.name)
		local element = self.rootScene.HorizontalSceneObjManager:GetElementByID(elementID)

		if element and element.IsStepOn then
			return
		end

		if self.steppedOnElementID ~= elementID then
			self.steppedOnElementID = elementID
			self.steppedOnElementTimer = nowTime

			HorizontalRPGModule.TriggerElementService(HorizontalRPGConstant.ElementTriggerType.CollisionElementHead, self.steppedOnElementID)

			isJump = true
		elseif self.steppedOnElementID == elementID and self.steppedOnElementID ~= nil and nowTime - self.steppedOnElementTimer >= HorizontalRPGModule.continuedTriggerCD then
			self.steppedOnElementTimer = nowTime

			HorizontalRPGModule.TriggerElementService(HorizontalRPGConstant.ElementTriggerType.CollisionElementHead, self.steppedOnElementID)

			isJump = true
		end

		if element and element.ElementData:GetCfgData().ElementType == HorizontalRPGConstant.ElementType.HorizontalRPG_Line_Move_Element then
			self:AddForce()
			GameEntry.Sound:PlaySound(HorizontalRPGConstant.Sound.StepOnMonster, Constant.SoundGroup.CHARACTER)

			if GameEntry.Base.DevMode then
				log("播放放踩怪音效 " .. HorizontalRPGConstant.Sound.StepOnMonster)
			end

			element.IsStepOn = true
		end
	else
		self.steppedOnElementID = nil
	end
end

function m:CheckEnterTrap()
	local result, areaObj = self:CheckPlayerCollisionByTag(HorizontalRPGConstant.ObjectTags.HorizontalRPGTrap)

	if result then
		local nowTime = PlayerModule.GetServerTime()

		if nowTime - self.steppedOnTrapTimer >= HorizontalRPGModule.continuedTriggerCD then
			self.steppedOnTrapTimer = nowTime

			logDebug("触发陷阱扣血")
			HorizontalRPGModule.ElementExecutionElse({
				90006
			})
		end
	end
end

function m:CheckEnterDeadZone()
	local result, areaObj = self:CheckPlayerCollisionByTag(HorizontalRPGConstant.ObjectTags.HorizontalRPGDeadZone)

	if result then
		if self.isEnterDeadZone then
			return
		end

		self.isEnterDeadZone = true

		log("进入了死亡区域")
		HorizontalRPGModule.ElementExecutionElse({
			90007
		})
	else
		self.isEnterDeadZone = false
	end
end

function m:CheckEnterMovePlatform()
	local result, trans = self:CheckIsOnMovePlatform()

	self.isOnMovePlatform = result

	if result then
		local pos = trans:InverseTransformPoint(self.View.transform.position)

		self.View.transform.localPosition = pos

		self.View.transform:SetParent(trans, false)
	else
		local defaultPos = self.defaultParentTrans:InverseTransformPoint(self.View.transform.position)

		self.View.transform.localPosition = defaultPos

		self.View.transform:SetParent(self.defaultParentTrans, false)
	end
end

function m:CheckIsOnPlatform()
	local tags = {
		HorizontalRPGConstant.ObjectTags.HorizontalRPGPlatform,
		HorizontalRPGConstant.ObjectTags.HorizontalRPGElementHead,
		HorizontalRPGConstant.ObjectTags.HorizontalRPGTrap
	}
	local result, platObj

	for i, v in pairs(tags) do
		result, platObj = self:CheckPlayerCollisionByTag(v)

		if result then
			return result, platObj
		end
	end

	return result, platObj
end

function m:CheckIsOnMovePlatform()
	for areaKey, sceneAreaCell in pairs(self.rootScene.SceneAreaCells) do
		for platformKey, movePlatform in pairs(sceneAreaCell.MovePlatform) do
			local res = self.movePlatformCollider2D.bounds:Intersects(movePlatform.TriggerCollider2D.bounds)

			if res then
				return true, movePlatform.View.transform
			end
		end
	end

	return false, nil
end

function m:CheckPlayerCollisionByTag(tag)
	local wordPoint = self.checkGroundNode.transform.position
	local leftPos = Vector3.New(wordPoint.x - 3, wordPoint.y, wordPoint.z)
	local rightPos = Vector3.New(wordPoint.x + 3, wordPoint.y, wordPoint.z)
	local points = {
		leftPos,
		wordPoint,
		rightPos
	}

	for i, v in pairs(points) do
		local hits = LuaCodeInterface.RaycastAll(v, Vector2.zero)

		for i = 0, hits.Length - 1 do
			local hit = hits[i]

			if hit and hit.collider.gameObject.tag == tag then
				if tag == HorizontalRPGConstant.ObjectTags.HorizontalRPGElementHead then
					return true, hit.collider.transform.parent.gameObject
				end

				return true, hit.collider.gameObject
			end
		end
	end

	return false, nil
end

function m:OnJoystickMove(moveDir)
	self.joystickValue = moveDir
end

function m:PlayAction(actionName, top)
	if self.playerSkeletonAnimation then
		self.playerSkeletonAnimation.state:SetEmptyAnimation(0, 0)
		self.playerSkeletonAnimation.state:SetAnimation(0, actionName, top)
	end
end

function m:CrossingThePlatform()
	if self.onPlatformObj then
		local platformEffector2D = self.onPlatformObj:GetComponent(typeof(UnityEngine.PlatformEffector2D))

		if platformEffector2D then
			self.isCrossingThePlatform = true
			platformEffector2D.rotationalOffset = 180

			self.rootScene.HorizontalSceneObjManager:ChangeElementsRigidBodySimulated(false)

			local timer = Timer.New(function()
				platformEffector2D.rotationalOffset = 0
				self.isCrossingThePlatform = false
				self.onPlatformObj = nil

				self.rootScene.HorizontalSceneObjManager:ChangeElementsRigidBodySimulated(true)
			end, 2)

			timer:Start()
		end
	end
end

function m:Move()
	if self.rootScene.IsLockInput then
		return
	end

	if self.startMove then
		if self.rigidBody2D and math.abs(self.horizontalX) > 0.1 then
			self.rigidBody2D.velocity = Vector2.New(self.horizontalRPGPlayerData:GetCfgData().MoveDistance * self.horizontalX * 0.3, self.rigidBody2D.velocity.y)
		end

		local localScale = self.goChangeDirNode.transform.localScale

		if self.horizontalX > 0 then
			localScale.x = -math.abs(localScale.x)
		elseif self.horizontalX < 0 then
			localScale.x = math.abs(localScale.x)
		end

		self.goChangeDirNode.transform.localScale = localScale

		self:CheckEnterNewArea()
	end
end

function m:Jump(startJump)
	if self.rootScene.IsLockInput then
		return
	end

	if not self.horizontalRPGPlayerData:GetCfgData().IsJump then
		return
	end

	if self.isOnPlatform and self.horizontalY < -0.5 and startJump and self.onPlatformObj then
		self:CrossingThePlatform()

		return
	end

	if self.rigidBody2D then
		if startJump then
			if self.isOnPlatform then
				self.rigidBody2D.velocity = Vector2.New(0, 1) * self.jumpSpeed

				self.playerStateCtrl:ChangeState(HorizontalRPGConstant.PlayerState.jump)
				self:PlayPlayerSceneEffect(9008033, self.View.transform.position, 0, 1, 3)
				GameEntry.Sound:PlaySound(HorizontalRPGConstant.Sound.Jump, Constant.SoundGroup.CHARACTER)

				if GameEntry.Base.DevMode then
					log("播放起跳音效 " .. HorizontalRPGConstant.Sound.Jump)
				end
			end
		else
			local dy = math.abs(self.rigidBody2D.velocity.y)

			if dy > 0.5 then
				if self.rigidBody2D.velocity.y < 0 then
					self.rigidBody2D.velocity = self.rigidBody2D.velocity + Vector2.New(0, 1) * UnityEngine.Physics.gravity.y * (self.fallAddition - 1) * UnityEngine.Time.fixedDeltaTime
				elseif self.rigidBody2D.velocity.y > 0 then
					self.playerStateCtrl:ChangeState(HorizontalRPGConstant.PlayerState.jump3)

					self.rigidBody2D.velocity = self.rigidBody2D.velocity + Vector2.New(0, 1) * UnityEngine.Physics.gravity.y * (self.jumpAddition - 1) * UnityEngine.Time.fixedDeltaTime
				end
			end
		end
	end
end

function m:Fire()
	if self.rootScene.IsLockInput then
		return
	end

	if not self.horizontalRPGPlayerData:GetCfgData().IsAttack then
		return
	end

	if self.playerStateCtrl and self.playerStateCtrl.CurrentState and (self.playerStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.PlayerState.jump or self.playerStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.PlayerState.jump3) then
		return
	end

	if self.playerFireCtrl then
		local bullet = self.horizontalRPGPlayerData:GetCfgData().Bullet

		if bullet > 0 then
			local dir = self.goChangeDirNode.transform.localScale.x * -1
			local bulletData = HorizontalRPGBulletData.New(-1, HorizontalRPGConstant.ObjectType.HorizontalRPG_Player, bullet, dir)

			if UnityEngine.Time.realtimeSinceStartup - self.lastFireTime > bulletData:GetCfgData().ShootCd then
				self.lastFireTime = UnityEngine.Time.realtimeSinceStartup

				local shootState
				local timerCD = 0

				if self.isOnPlatform then
					shootState = HorizontalRPGConstant.PlayerState.shoot1
					timerCD = 0.2
				elseif self:IsFalling() and self.isSliding then
					shootState = HorizontalRPGConstant.PlayerState.shoot2
				else
					shootState = HorizontalRPGConstant.PlayerState.shoot3
				end

				self.playerStateCtrl:ChangeState(shootState)

				local timer = Timer.New(function()
					self.playerFireCtrl:SetBulletData(bulletData)
					self.playerFireCtrl:Fire(shootState)

					local dir = 1
					local localScale = self.goChangeDirNode.transform.localScale

					if localScale.x > 0 then
						dir = -1
					end

					self:PlayPlayerSceneEffect(9008037, self.playerFireCtrl.firePos.transform.position, 0, 1, dir)
				end, timerCD)

				timer:Start()
			end
		end
	end
end

function m:Sliding()
	self.isSliding = not self.isSliding

	if self.isSliding then
		self.fallAddition = self.horizontalRPGPlayerData:GetCfgData().FlyGravity
	else
		self.fallAddition = self.horizontalRPGPlayerData:GetCfgData().Gravity
	end
end

function m:AddForce()
	if self.rigidBody2D then
		self.rigidBody2D.velocity = Vector2.New(0, 1) * self.horizontalRPGPlayerData:GetCfgData().JumpMonster
	end
end

function m:ChangePlayerState()
	if self.playerStateCtrl and self.playerStateCtrl.CurrentState then
		local isFalling = self:IsFalling()
		local isEnter = self.playerStateCtrl.CurrentState.isEnter
		local isShooting = isEnter and (self.playerStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.PlayerState.shoot1 or self.playerStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.PlayerState.shoot2 or self.playerStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.PlayerState.shoot3)
		local isDeath = self:PlayerIsDie()
		local isJump = isEnter and (self.playerStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.PlayerState.jump or self.playerStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.PlayerState.jum3)
		local isHurt = isEnter and self.playerStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.PlayerState.hurt

		if isFalling and self.isSliding and not isShooting and not isDeath then
			self.playerStateCtrl:ChangeState(HorizontalRPGConstant.PlayerState.fly)
			self:PlayRoleEffect({
				HorizontalRPGConstant.PlayerEffect.SlidingEffect
			})
			GameEntry.Sound:PlaySound(HorizontalRPGConstant.Sound.Sliding, Constant.SoundGroup.ENVIRONMENT)

			if GameEntry.Base.DevMode then
				log("播放滑行音效 " .. HorizontalRPGConstant.Sound.Sliding)
			end

			return
		end

		self:ClosePlayRoleEffect({
			HorizontalRPGConstant.PlayerEffect.SlidingEffect
		})

		if isFalling and not isShooting and not isDeath then
			self.playerStateCtrl:ChangeState(HorizontalRPGConstant.PlayerState.jump2)

			return
		end

		if (self.isMoving or math.abs(self.horizontalX) > 0.1) and not isHurt and self.isOnPlatform and not isShooting and not isDeath and not isJump then
			self.playerStateCtrl:ChangeState(HorizontalRPGConstant.PlayerState.run)
			GameEntry.Sound:PlaySound(HorizontalRPGConstant.Sound.Run, Constant.SoundGroup.ENVIRONMENT)

			return
		end

		if not self.isMoving and not isJump and not isShooting and not isDeath and not isHurt and self.isOnPlatform then
			self.playerStateCtrl:ChangeState(HorizontalRPGConstant.PlayerState.idle)
		end
	end
end

function m:PlayRoleEffect(effects)
	for i, v in pairs(effects) do
		local effectData = self.playerEffects[v]

		if effectData then
			effectData:StartPlay()
		end
	end
end

function m:ClosePlayRoleEffect(effects)
	for i, v in pairs(effects) do
		local effectData = self.playerEffects[v]

		if effectData then
			effectData:PlayEnd()
		end
	end
end

function m:PlayPlayerSceneEffect(effectID, position, delayPlayTime, playTime, scale)
	local renderer = self.View:GetComponentInChildren(typeof(UnityEngine.Renderer))

	GameEntry.Effect:PlayNormalEffect(effectID, position, delayPlayTime, playTime, 0, renderer.sortingLayerID, renderer.sortingOrder + 1, scale, true)
end

function m:PlayerIsDie()
	if self.playerStateCtrl and self.playerStateCtrl.CurrentState then
		local isEnter = self.playerStateCtrl.CurrentState.isEnter
		local isDeath = isEnter and self.playerStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.PlayerState.die

		return isDeath
	end

	return false
end

function m:ShowSpine()
	self:OnHideEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, self.horizontalRPGPlayerData:GetCfgData().Element, 0, self.goSpineRoot.transform, Vector3.zero, nil, false)
end

function m:OnHideEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function m:Dispose()
	self:OnRemoveListener()
	self.playerStateCtrl:Dispose()

	self.playerStateCtrl = nil

	self.playerFireCtrl:Dispose()

	self.playerFireCtrl = nil

	self.chatView:Dispose()

	self.chatView = nil
	self.horizontalRPGPlayerData = nil
	self.rigidBody2D = nil
	self.rootScene = nil

	self:OnHideEntity()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
