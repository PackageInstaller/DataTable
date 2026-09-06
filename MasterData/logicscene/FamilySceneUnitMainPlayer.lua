-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/family/FamilySceneUnitMainPlayer.lua

module("logicscene.scene.unit.component.family.FamilySceneUnitMainPlayer", package.seeall)

local FamilySceneUnitMainPlayer = class("FamilySceneUnitMainPlayer")

function FamilySceneUnitMainPlayer:ctor(luaComponentContainer)
	self._go = luaComponentContainer.gameObject
	self._moveSpeed = -1
	self._moveDir = Vector3.New(0, 0, 0)
	self._rigidbody = nil
	self._radius = 0
	self._posChangeTarget = nil
	self._posChangeHandler = nil
	self._isDirty = false
	self._currMoveSpeed = 0
	self._speedAccDuration = -1
	self._moveSpdAccTimeCount = 0
	self._isMainPlayer = false
	self._transform = nil
	self._wholeScene = nil
	self._startPos = FamilyScene.PlayerLimitStartPos
	self._endPos = FamilyScene.PlayerLimitEndPos
	self._saveScreenPos = Vector2.New(0, 0)
	self._timeOnTouchDown = 0
	self._isTouchDown = false
	self._findWayLayer = 0
	self._quaryLayerMask = 0
	self._hasInvokeNone = false
	self._hitObject = nil
	self._hitPoint = Vector3.New(0, 0, 0)
	self._mainCamera = nil
	self._clickUISoundEvent = ""
end

function FamilySceneUnitMainPlayer:Awake()
	GlobalDispatcher:addListener(SceneNotify.StageLoaded, self._onStageLoaded, self)
	FixedUpdateBeat:Add(self.fixUpdate, self)

	self._isMainPlayer = true
	self._transform = self._go.transform
	self._isDirty = false
	self._rigidbody = self._go:GetComponent(typeof(UnityEngine.Rigidbody))

	if self._rigidbody == nil then
		self._rigidbody = self._go:AddComponent(typeof(UnityEngine.Rigidbody))
	end

	self._radius = 0.1
	self._rigidbody.angularVelocity = Vector3.New(0, 0, 0)
	self._rigidbody.useGravity = false
	self._rigidbody.velocity = Vector3.New(0, 0, 0)
	self._rigidbody.angularDrag = 0

	self:_setRigidbodyParams()

	local sphere = self._go:GetComponent(typeof(UnityEngine.SphereCollider))

	if sphere ~= nil then
		self._radius = sphere.radius
	else
		printError("test FamilySceneUnitMainPlayer:Awake")
	end

	self._findWayLayer = LayerMask.NameToLayer("FindWay")

	local interactiveObjectLayer = bit.lshift(1, LayerMask.NameToLayer("InteractiveObject"))
	local findWayLayer = bit.lshift(1, self._findWayLayer)
	local unitLayer = bit.lshift(1, LayerMask.NameToLayer("Unit"))

	self._quaryLayerMask = bit.bor(interactiveObjectLayer, findWayLayer, unitLayer)
end

function FamilySceneUnitMainPlayer:_setRigidbodyParams()
	local scene = SceneMgr.instance:getCurScene()

	if scene:getSceneType() == SceneType.Family then
		local go = scene.stage:getStageIns()

		if go then
			local rbs = goutil.findChild(go, "rigidbodysetting")
			local rigidbody = rbs:GetComponent(typeof(UnityEngine.Rigidbody))

			self._rigidbody.constraints = rigidbody.constraints
			self._rigidbody.interpolation = rigidbody.interpolation
			self._rigidbody.collisionDetectionMode = rigidbody.collisionDetectionMode
		end
	end
end

function FamilySceneUnitMainPlayer:_onStageLoaded()
	self:_setRigidbodyParams()
end

function FamilySceneUnitMainPlayer:OnDestroy()
	GlobalDispatcher:removeListener(SceneNotify.StageLoaded, self._onStageLoaded, self)
	FixedUpdateBeat:Remove(self.fixUpdate, self)
end

function FamilySceneUnitMainPlayer:setWholeScene(wholeScene)
	self._wholeScene = wholeScene
end

function FamilySceneUnitMainPlayer:Update()
	if UGUIToolHelper.IsTouchDown() then
		local hitUI = UGUIToolHelper.IsHitVisibleUI()

		if goutil.isNil(hitUI) then
			self:_onTouchDown()
		else
			self:_invokeTouchNone()

			self._hasInvokeNone = false
		end
	elseif self._isTouchDown and UGUIToolHelper.IsTouchUp() then
		self:_onTouchUp()
	end
end

function FamilySceneUnitMainPlayer:fixUpdate()
	if self._transform == nil then
		return
	end

	if self._isDirty then
		self._isDirty = false

		if self._posChangeHandler ~= nil then
			local currPos = self._rigidbody.position

			if self._posChangeTarget ~= nil then
				self._posChangeHandler(self._posChangeTarget, self._moveDir.x, self._moveDir.z, currPos.x, currPos.z)
			else
				self._posChangeHandler(self._moveDir.x, self._moveDir.z, currPos.x, currPos.z)
			end
		end
	end

	self._rigidbody.velocity = Vector3.zero

	if self._moveSpeed > 0 then
		self:UpdateMoveSpd()

		local pos = self._transform.position + self._moveDir * Time.fixedDeltaTime * self._currMoveSpeed
		local posDiff = self:MovePosDiff(self._rigidbody.position, pos, self._radius)

		self._rigidbody:MovePosition(posDiff)

		self._isDirty = true
	end
end

function FamilySceneUnitMainPlayer:UpdateMoveSpd()
	if self._speedAccDuration > 0 and self._currMoveSpeed < self._moveSpeed then
		self._moveSpdAccTimeCount = self._moveSpdAccTimeCount + Time.deltaTime

		local percent = self._moveSpdAccTimeCount / self._speedAccDuration

		if percent > 1 then
			percent = 1
		end

		self._currMoveSpeed = self._moveSpeed * percent
	end
end

function FamilySceneUnitMainPlayer:AddPosChangedListener(handler, handlerObj)
	self._posChangeTarget = handlerObj
	self._posChangeHandler = handler
end

function FamilySceneUnitMainPlayer:RemovePosChangedListener()
	self._posChangeTarget = nil
	self._posChangeHandler = nil
end

function FamilySceneUnitMainPlayer:SetSpeed(speed)
	self._moveSpeed = speed

	if self._speedAccDuration <= 0 then
		self._currMoveSpeed = self._moveSpeed
	elseif self._moveSpeed > 0 then
		if self._moveSpdAccTimeCount <= 0 then
			self._currMoveSpeed = 0
			self._moveSpdAccTimeCount = 0
		end
	else
		self._currMoveSpeed = 0
		self._moveSpdAccTimeCount = 0
	end
end

function FamilySceneUnitMainPlayer:SetMoveDir(dx, dy, dz)
	self._moveDir.x = dx
	self._moveDir.y = 0
	self._moveDir.z = dz

	self._moveDir:Normalize()
end

function FamilySceneUnitMainPlayer:MovePosDiff(pos, dest, r)
	pos.y = 0
	dest.y = 0
	dest.x = Mathf.Min(dest.x, Mathf.Max(0, dest.x))
	dest.z = Mathf.Min(dest.z, Mathf.Max(0, dest.z))

	if self:isPositionReachable(dest) then
		return dest
	end

	local diff = dest - pos
	local len = diff:Magnitude()
	local dir = diff:Normalize()
	local x = pos.x + dir.x * r
	local z = pos.z + dir.z * r
	local dt = 0.01
	local drx = 0
	local drz = 0
	local isXDirty = false
	local isZDirty = false
	local l = 0

	while l < len do
		l = l + dt
		isXDirty = true
		x = x + dt * dir.x
	end

	x = isXDirty and self:clampPos(x - dir.x * (drx + r), pos.x, dir.x) or pos.x

	local m = 0

	while m < len do
		m = m + dt
		isZDirty = true
		z = z + dt * dir.z
	end

	z = isZDirty and self:clampPos(z - dir.z * (drz + r), pos.z, dir.z) or pos.z

	local newPos = Vector3.New(x, dest.y, z)

	newPos = self:_limitMovePos(newPos)

	return newPos
end

function FamilySceneUnitMainPlayer:isPositionReachable(dest)
	return false
end

function FamilySceneUnitMainPlayer:isPositionBarrier()
	return
end

function FamilySceneUnitMainPlayer:clampPos(pos, curPos, dir)
	if dir < 0 then
		if curPos < pos then
			return curPos
		end
	elseif pos < curPos then
		return curPos
	end

	return pos
end

function FamilySceneUnitMainPlayer:_limitMovePos(newPos)
	if newPos.x < self._startPos.x then
		newPos.x = self._startPos.x
	elseif newPos.x > self._endPos.x then
		newPos.x = self._endPos.x
	end

	if newPos.y < self._startPos.y then
		newPos.y = self._startPos.y
	elseif newPos.y > self._endPos.y then
		newPos.y = self._endPos.y
	end

	if newPos.z < self._startPos.z then
		newPos.z = self._startPos.z
	elseif newPos.z > self._endPos.z then
		newPos.z = self._endPos.z
	end

	return newPos
end

function FamilySceneUnitMainPlayer:_onTouchDown()
	local cameraTarget = CameraTargetMgr.instance:getMainCameraTarget()

	if cameraTarget == nil then
		return
	end

	self._isTouchDown = true
	self._hasInvokeNone = false
	self._saveScreenPos = UGUIToolHelper.GetTouchPosition()
	self._timeOnTouchDown = Time.unscaledTime
	self._hitObject = nil

	local mousePos = UGUIToolHelper.GetTouchPosition()
	local ray = cameraTarget:getCamera():ScreenPointToRay(mousePos)
	local isHit, hitResult = UnityEngine.Physics.Raycast(ray, nil, Mathf.Infinity, self._quaryLayerMask)

	if isHit then
		self._hitObject = hitResult.collider.gameObject
		self._hitPoint = hitResult.point

		if hitResult.collider.gameObject.layer == self._findWayLayer then
			if self:HasPathTo(self._hitPoint.x, self._hitPoint.z) then
				return
			else
				self._hitObject = nil
			end
		end
	end

	self:_invokeTouchNone()
end

function FamilySceneUnitMainPlayer:_onTouchUp()
	self._isTouchDown = false

	local mousePos = UGUIToolHelper.GetTouchPosition()

	if Vector2.Distance(mousePos, self._saveScreenPos) >= UGUIToolHelper.touchDragThreshold then
		self._hitObject = nil

		return
	end

	if Time.unscaledTime - self._timeOnTouchDown >= 0.2 then
		self._hitObject = nil

		return
	end

	if UGUIToolHelper.IsOverUI() then
		self._hitObject = null

		self:_invokeTouchNone()

		return
	end

	if self._hitObject ~= nil then
		if self._hitObject.layer == self._findWayLayer then
			self:OnFindWay(self._hitPoint.x, self._hitPoint.z)
		else
			self:_invokeTouchNone()
			self:OnSelectObject(self._hitObject)
		end
	else
		self:_invokeTouchNone()
	end
end

function FamilySceneUnitMainPlayer:_invokeTouchNone()
	if self._hasInvokeNone == false then
		self._hasInvokeNone = true

		self:OnTouchNone(UGUIToolHelper.GetTouchPosition())
	end
end

function FamilySceneUnitMainPlayer:HasPathTo(x, z)
	return true
end

function FamilySceneUnitMainPlayer:OnFindWay(x, z)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.picker then
		x = Mathf.Clamp(x, self._startPos.x, self._endPos.x)
		z = Mathf.Clamp(z, self._startPos.z, self._endPos.z)

		scene.picker:onQueryFindWayXZ(x, z)
	end
end

function FamilySceneUnitMainPlayer:OnSelectObject(go)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.picker then
		scene.picker:onQueryObject(go)
	end
end

function FamilySceneUnitMainPlayer:OnTouchNone(screenPos)
	local eff = UIEffectManager.instance:playScreenEffect("fx_ui_dianji.prefab", screenPos)

	eff:setScale(0.6)

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.picker and scene.picker.onQueryNoneObject then
		scene.picker:onQueryNoneObject(screenPos)
	end
end

return FamilySceneUnitMainPlayer
