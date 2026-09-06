-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/game/FlynuoPlayer.lua

module("logic.extensions.flyingnuo.view.game.FlynuoPlayer", package.seeall)

local FlynuoPlayer = class("FlynuoPlayer", BaseLuaOnce)
local force = FlyNuoConfig.instance:getJumpForce()

function FlynuoPlayer:ctor(go)
	self.mainGO = go
	self.transform = go.transform

	self:buildUI()
end

function FlynuoPlayer:buildUI()
	self._rigidbody = self.mainGO:GetComponent(typeof(UnityEngine.Rigidbody2D))
	self._cornors = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	self._roleConTr = goutil.findChild(self.mainGO, "roleCon").transform
	self._rectTr = self:getGo("playerRaycastBouns"):GetComponent(goutil.Type_RectTransform)
	self._flyEffectGo = goutil.findChild(self.mainGO, "flyEffect")
	self._shieldEffectGo = goutil.findChild(self.mainGO, "shieldEffect")
	self._followEffectGo = goutil.findChild(self.mainGO, "followEffect")

	self:_setFloat(true)
end

function FlynuoPlayer:onEnter(playView)
	GlobalDispatcher:addListener(FlyNuoGameController.ShieldChange, self._shiledChange, self)

	self._isFirstEnter = true
	self._playView = playView
	self._isDied = false
	self._isWudi = false
	self._isWudiFly = false
	self._getShield = false
	self._jumpTag = false

	self:_setFloat(true)
	self:_setRole()
	self:_idleAnim()
end

function FlynuoPlayer:onExit()
	self:stopFlyEffect()

	if self._roleSkeletonGo then
		goutil.destroy(self._roleSkeletonGo, false)

		self._roleSkeletonGo = nil
	end

	self._roleSkeletonGraphic = nil

	removetimer(self._setFlyEffect3, self)
	UIEffectManager.instance:stopEffect(self._flyEffctHandler3)
	UIEffectManager.instance:stopEffect(self._shieldEffectHandler)
	UIEffectManager.instance:stopEffect(self._diedEffectHandler)
	GlobalDispatcher:removeListener(FlyNuoGameController.ShieldChange, self._shiledChange, self)
	removetimer(self._beginOrStopPosTween, self)
	removetimer(self._doDiedFinish, self)
	removetimer(self._updateHit, self)
	self:_cancelLittleWudi()

	if self._resLoader then
		GameUtil.unloadMultiResLoaderResource(self._resLoader)

		self._resLoader = nil
	end
end

function FlynuoPlayer:startFly(flyTime)
	self._isWudiFly = true

	self:setWudiState(true)
	self:_setFloat(true)
	self:_setFlyEffect(flyTime)
end

function FlynuoPlayer:endFly()
	self._isWudiFly = false

	self:setWudiState(false)
	self:_prepareJump()
	self:stopFlyEffect()
end

function FlynuoPlayer:pause()
	self:setWudiState(false)
	self:_setFloat(false)

	self._jumpTag = false

	GoUtil.SetRigidbody2DBodyType(self._rigidbody, GameEnum.Rigidbody2DBodyType.Static)
end

function FlynuoPlayer:relive()
	self:_prepareJump(true)
end

function FlynuoPlayer:_prepareJump(notAutoJump)
	self._isDown = false

	self:_setFloat(true)
	self:littleWudi()

	if not notAutoJump then
		settimer(2, self._setFloat, self)
	end
end

function FlynuoPlayer:jump()
	if self._isDied or self:isWudiFly() then
		return
	end

	self._isDown = false

	self:_setFloat(false)
	self:_addForce()
	self:_upAnim()

	self._jumpTag = true
	self._currJumpTime = ServerTime.nowMs()
end

function FlynuoPlayer:down()
	self._isDown = true
end

function FlynuoPlayer:_upAnim()
	AudioPlayerEx.instance:playEffect(30303)
end

function FlynuoPlayer:_idleAnim(callBack)
	self:_rolePlayAnim("idle", true, false)
end

function FlynuoPlayer:_rolePlayAnim(name, loop, restart, callBack)
	if self._roleSkeletonGo then
		RoleObjectPool.instance:playAnimation(self._roleSkeletonGo, name, loop, callBack, restart)
	end
end

function FlynuoPlayer:_addForce()
	self._rigidbody.velocity = Vector2.zero

	self._rigidbody:AddForce(Vector2.up * force)
end

function FlynuoPlayer:doDied(finishCallBack)
	self._isDown = true
	self._isDied = true
	self._jumpTag = false
	self._diedfinishCallBack = finishCallBack

	GoUtil.SetRigidbody2DBodyType(self._rigidbody, GameEnum.Rigidbody2DBodyType.Static)
	UIEffectManager.instance:stopEffect(self._shieldEffectHandler)
	self:stopFlyEffect()
	self:_stopHitEffect()
	self:_diedEffect()
	self:_diedAnim()
end

function FlynuoPlayer:_diedAnim()
	AudioPlayerEx.instance:playEffect(30305)
	self:_rolePlayAnim("die", false)
	settimer(0.8, self._doDiedFinish, self, false)
end

function FlynuoPlayer:_doDiedFinish()
	if self._diedfinishCallBack then
		self:_diedfinishCallBack()
	end
end

function FlynuoPlayer:_diedEffect()
	self._diedEffectHandler = UIEffectManager.instance:playEffect(self._playView, "fx_ui_shijianzhuisu/fx_siwang_shijianzhuisu.prefab")

	self._diedEffectHandler:setParent(self._flyEffectGo.transform)
	self._diedEffectHandler:setScale(1)
	self._diedEffectHandler:setLocalPos(0, 0, 0)
end

function FlynuoPlayer:isWudi()
	return self._isWudi
end

function FlynuoPlayer:setWudiState(bool)
	self._isWudi = bool
end

function FlynuoPlayer:getBound()
	self.transform:GetWorldCorners(self._cornors)

	return self._cornors
end

function FlynuoPlayer:getPos()
	return self.transform.position
end

function FlynuoPlayer:_setFloat(bool)
	removetimer(self._setFloat, self)

	bool = checkbool(bool)

	if self._floatState == bool then
		return
	end

	self._floatState = bool

	if not bool then
		GoUtil.SetRigidbody2DBodyType(self._rigidbody, GameEnum.Rigidbody2DBodyType.Dynamic)

		self._rigidbody.gravityScale = FlyNuoConfig.instance:getGravity()
		self._rigidbody.mass = 0.1
		self._rigidbody.drag = 3
	else
		GameUtil.setAnchoredPos(self.mainGO, 0, 0)
		GoUtil.SetRigidbody2DBodyType(self._rigidbody, GameEnum.Rigidbody2DBodyType.Static)
		self:_idleAnim()
	end
end

function FlynuoPlayer:isWudiFly()
	return self._isWudiFly
end

function FlynuoPlayer:littleWudi()
	self:setWudiState(true)
	settimer(0.5, self._cancelLittleWudi, self)
end

function FlynuoPlayer:_cancelLittleWudi()
	removetimer(self._cancelLittleWudi, self)
	self:setWudiState(false)
end

function FlynuoPlayer:isGetShield()
	return self._getShield == FlyNuoGameController.ShieldState.Add
end

function FlynuoPlayer:update()
	if self._jumpTag and ServerTime.nowMs() - self._currJumpTime >= 20 and self._rigidbody.velocity.y <= -0.1 and not self._isDown then
		self:down()
	end
end

function FlynuoPlayer:_setRole()
	if not self._resLoader then
		local _, path = CharacterConfig.instance:GetCharacterResIdx(50142, nil)

		self._resLoader = MultiResLoader.New()

		self._resLoader:addResPath(path)
		self._resLoader:load(function()
			local res = self._resLoader:getResource(path)

			if res then
				local main_asset = res:GetMainAsset()

				if main_asset then
					self._roleSkeletonGo = goutil.cloneAndSetParent(main_asset, self._roleConTr)
					self._roleSkeletonGraphic = self._roleSkeletonGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

					GameUtil.setLocalScale(self._roleSkeletonGo, 1.4, 1.4, 1.4)
				end
			end
		end)
	end
end

function FlynuoPlayer:_shiledChange(state)
	if self._getShield == state then
		return
	end

	self._getShield = state

	if state == FlyNuoGameController.ShieldState.Add then
		self._shieldEffectHandler = UIEffectManager.instance:playEffect(self._playView, "fx_ui_shijianzhuisu/fx_hudun_shijianzhuisu.prefab", self._shieldEffectGo, 0, 0, true)

		self._shieldEffectHandler:setParent(self._shieldEffectGo.transform)
		self._shieldEffectHandler:setScale(0.7)
		self._shieldEffectHandler:setLocalPos(0, 0, 0)
	else
		UIEffectManager.instance:stopEffect(self._shieldEffectHandler)
	end
end

function FlynuoPlayer:_setFlyEffect(flyTime)
	local duration = flyTime - 0.2

	self:_setFlyEffect1()
	self:_setFlyEffect2(flyTime)
	settimer(duration, self._setFlyEffect3, self, false)
end

function FlynuoPlayer:_setFlyEffect1()
	self._flyEffctHandler1 = UIEffectManager.instance:playEffect(self._playView, "fx_ui_shijianzhuisu/fx_wudi01_shijianzhuisu.prefab", nil, 0, 0, true)

	self._flyEffctHandler1:setParent(self._flyEffectGo.transform)
	self._flyEffctHandler1:setScale(1)
	self._flyEffctHandler1:setLocalPos(0, 0, 0)
end

function FlynuoPlayer:_setFlyEffect2(flyTime)
	self._flyEffctHandler2 = UIEffectManager.instance:playEffect(self._playView, "fx_ui_shijianzhuisu/fx_wudi_sj_shijianzhuisu.prefab", nil, 0, 0, true)

	self._flyEffctHandler2:setParent(self._followEffectGo.transform)
	self._flyEffctHandler2:setScale(0.5)
	self._flyEffctHandler2:setLocalPos(0, 0, 0)
end

function FlynuoPlayer:_setFlyEffect3(flyTime)
	local function finishCallBack()
		UIEffectManager.instance:stopEffect(self._flyEffctHandler3)
	end

	removetimer(self._setFlyEffect3, self)
	UIEffectManager.instance:stopEffect(self._flyEffctHandler1)

	self._flyEffctHandler3 = UIEffectManager.instance:playEffect(self._playView, "fx_ui_shijianzhuisu/fx_wudi02_shijianzhuisu.prefab", nil, 0, 0, false, nil, finishCallBack)

	self._flyEffctHandler3:setParent(self._flyEffectGo.transform)
	self._flyEffctHandler3:setScale(1)
	self._flyEffctHandler3:setLocalPos(0, 0, 0)
end

function FlynuoPlayer:stopFlyEffect()
	removetimer(self._setFlyEffect2, self)
	UIEffectManager.instance:stopEffect(self._flyEffctHandler1)
	UIEffectManager.instance:stopEffect(self._flyEffctHandler2)
end

function FlynuoPlayer:isHit()
	self:littleWudi()

	self._updateHitTime = 0
	self._updateHitCount = 0

	settimer(0.04, self._updateHit, self, true)
end

function FlynuoPlayer:_updateHit()
	self._updateHitTime = self._updateHitTime + Time.deltaTime

	if self._updateHitTime >= 0.3 then
		removetimer(self._updateHit, self)
		self:_stopHitEffect()

		return
	end

	if self._roleSkeletonGraphic then
		local temp = self._roleSkeletonGraphic.color

		temp.a = self._updateHitCount % 2 == 0 and 0.5 or 1
		self._roleSkeletonGraphic.color = temp
	end

	self._updateHitCount = self._updateHitCount + 1
end

function FlynuoPlayer:_stopHitEffect()
	removetimer(self._updateHitTime, self)

	if self._roleSkeletonGraphic then
		local temp = self._roleSkeletonGraphic.color

		temp.a = 1
		self._roleSkeletonGraphic.color = temp
	end
end

function FlynuoPlayer:getRectTr()
	return self._rectTr
end

return FlynuoPlayer
