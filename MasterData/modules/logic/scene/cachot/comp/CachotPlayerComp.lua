-- chunkname: @modules/logic/scene/cachot/comp/CachotPlayerComp.lua

module("modules.logic.scene.cachot.comp.CachotPlayerComp", package.seeall)

local CachotPlayerComp = class("CachotPlayerComp", BaseSceneComp)
local camera_follow_speed = 0.05
local camera_move_max = 0.1
local camera_follow_min = 0.02
local move_to_event_dis = 0.3
local near_event_dis = 1

function CachotPlayerComp:init()
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayerMove, self.onPlayerMove, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayerStopMove, self.onStopMove, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayerMoveTo, self.moveToPos, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangeAnimEnd, self._resetPlayerPos, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangeBegin, self._clearAsset, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.BeginTriggerEvent, self._beginTriggerEvent, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self._levelComp:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self.onSceneLevelLoaded, self)

	if self._levelComp:getSceneGo() then
		self:onSceneLevelLoaded()
	end
end

function CachotPlayerComp:onSceneStart(sceneId, levelId)
	self._scene = self:getCurScene()
	self._roomComp = self._scene.room
	self._levelComp = self._scene.level
	self._preloadComp = self._scene.preloader
end

function CachotPlayerComp:onSceneLevelLoaded()
	local levelId = self:getCurScene():getCurLevelId()
	local levelCo = lua_scene_level.configDict[levelId]

	self._sceneGo = self._levelComp:getSceneGo()

	local animator = self._sceneGo:GetComponent(typeof(UnityEngine.Animator))

	animator.enabled = false

	local clips = animator.runtimeAnimatorController.animationClips

	for i = 0, clips.Length - 1 do
		local name = clips[i].name

		if name:find("_role_middle$") then
			self._playerAnim = clips[i]
		elseif name:find("_role_left$") then
			self._playerAnimLeft = clips[i]
		elseif name:find("_role_right$") then
			self._playerAnimRight = clips[i]
		else
			self._sceneAnim = clips[i]
		end
	end

	self._playerSpeed = tonumber(V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.MoveSpeed).value) or 3
	self._animLen = self._playerAnim.length
	self._animLeftLen = self._playerAnimLeft.length
	self._animRightLen = self._playerAnimRight.length

	local defaultVal = self:_getDefaultVal(levelCo)

	defaultVal = defaultVal - self._animLeftLen

	self:_setAnimValForce(defaultVal)

	self._playerGo = gohelper.findChild(self._sceneGo, "Obj-Plant/role/body")
	self._player = CachotPlayer.Create(self._playerGo)

	self._player:setDir(false)

	if ViewMgr.instance:isOpen(ViewName.LoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLayerChangeView) then
		self._player:setActive(false)
	else
		self._player:setActive(true)
		self._player:playEnterAnim(not V1a6_CachotModel.instance:isInRogue())
	end

	if not V1a6_CachotModel.instance:isInRogue() then
		local doorgo = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/near_b/effects/trigger/effect_door")

		self._doorEffect = CachotDoorEffect.Create(self._preloadComp:getResInst(CachotScenePreloader.DoorEffectPath, doorgo))
	end

	TaskDispatcher.runRepeat(self._cameraFollow, self, 0, -1)
end

function CachotPlayerComp:_getDefaultVal(levelCo)
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if rogueInfo and lua_rogue_room.configDict[rogueInfo.room].type == 0 then
		return tonumber(lua_rogue_const.configDict[V1a6_CachotEnum.Const.FirstRoomValue].value)
	end

	return tonumber(levelCo.cardCamera) or 0
end

function CachotPlayerComp:_clearAsset()
	self._sceneAnim = nil
	self._playerAnim = nil
	self._playerAnimLeft = nil
	self._playerAnimRight = nil
	self._sceneGo = nil

	TaskDispatcher.cancelTask(self._cameraFollow, self)

	self._targetTr = nil

	TaskDispatcher.cancelTask(self._everyFrameMove, self)
	V1a6_CachotRoomModel.instance:setNearEventMo(nil)
end

function CachotPlayerComp:onPlayerMove(val)
	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	if not self._player or not self._player:isCanMove() then
		return
	end

	if not self._sceneAnim then
		return
	end

	if self._targetTr then
		self._targetTr = nil

		TaskDispatcher.cancelTask(self._everyFrameMove, self)
	end

	self._playerVal = self._playerVal + val * UnityEngine.Time.deltaTime * self._playerSpeed
	self._playerVal = Mathf.Clamp(self._playerVal, -self._animLeftLen, self._animLen + self._animRightLen)

	self:_setPlayerDir(val > 0)
	self._player:setIsMove(true)
	self:_movePlayer()
end

function CachotPlayerComp:_movePlayer()
	if self._playerVal < 0 then
		self._playerAnimLeft:SampleAnimation(self._sceneGo, self._animLeftLen + self._playerVal)
	elseif self._playerVal > self._animLen then
		self._playerAnimRight:SampleAnimation(self._sceneGo, self._playerVal - self._animLen)
		self:_checkStartGame()
	else
		self._playerAnim:SampleAnimation(self._sceneGo, self._playerVal)
	end

	if V1a6_CachotModel.instance:isInRogue() then
		self:_checkNearEvent()
	elseif self._doorEffect then
		self._doorEffect:setIsInDoor(self._playerVal > self._animLen + 0.5 * self._animRightLen)
	end
end

function CachotPlayerComp:_checkStartGame()
	if V1a6_CachotModel.instance:isInRogue() then
		return
	end

	if self._playerVal == self._animLen + self._animRightLen then
		ViewMgr.instance:closeView(ViewName.V1a6_CachotMainView)
		self._player:showEffect(V1a6_CachotEnum.PlayerEffect.RoleTransEffect)
		self._player:setActive(false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_entrance_teleport)
		TaskDispatcher.runDelay(self._onEffectFinish, self, 0.6)
	end
end

function CachotPlayerComp:_onEffectFinish()
	TaskDispatcher.cancelTask(self._onEffectFinish, self)
	V1a6_CachotController.instance:openV1a6_CachotDifficultyView()
	self._doorEffect:hideEffect()
	self._player:hideEffect(V1a6_CachotEnum.PlayerEffect.RoleTransEffect)
end

function CachotPlayerComp:moveToPos(targetTr)
	if not self._player or not self._player:isCanMove() then
		return
	end

	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	local playerPos = self._player:getPos()
	local targetPos = targetTr.position

	if math.abs(targetPos.x - playerPos.x) < move_to_event_dis then
		return
	end

	self._targetTr = targetTr

	self:_setPlayerDir(targetPos.x > playerPos.x)
	self._player:setIsMove(true)
	TaskDispatcher.runRepeat(self._everyFrameMove, self, 0, -1)
end

function CachotPlayerComp:_cameraFollow()
	if not self._sceneAnim then
		return
	end

	local offset = math.abs(self._playerVal - self._cameraVal)

	if offset < camera_follow_min then
		return
	end

	local sign = self._playerVal >= self._cameraVal and 1 or -1
	local moveVal = offset * camera_follow_speed

	if moveVal > camera_move_max then
		moveVal = camera_move_max
	end

	self._cameraVal = moveVal * sign + self._cameraVal
	self._cameraVal = Mathf.Clamp(self._cameraVal, 0, self._animLen)

	self._sceneAnim:SampleAnimation(self._sceneGo, self._cameraVal)
end

function CachotPlayerComp:_everyFrameMove()
	local playerPos = self._player:getPos()
	local targetPos = self._targetTr.position

	if math.abs(targetPos.x - playerPos.x) < move_to_event_dis then
		self._targetTr = nil

		TaskDispatcher.cancelTask(self._everyFrameMove, self)
		self:onStopMove()

		return
	end

	self._playerVal = self._playerVal + UnityEngine.Time.deltaTime * self._playerSpeed * (targetPos.x > playerPos.x and 1 or -1)
	self._playerVal = Mathf.Clamp(self._playerVal, -self._animLeftLen, self._animLen + self._animRightLen)

	self:_movePlayer()
end

function CachotPlayerComp:_checkNearEvent()
	local playerPos = self._player:getPos()
	local preNearEventMo = V1a6_CachotRoomModel.instance:getNearEventMo()
	local nowNearEventMo

	if preNearEventMo then
		local trans = self._levelComp:getEventTr(preNearEventMo.index)

		if math.abs(trans.position.x - playerPos.x) <= near_event_dis then
			return
		end
	end

	local events = V1a6_CachotRoomModel.instance:getRoomEventMos()

	for _, mo in pairs(events) do
		local trans = self._levelComp:getEventTr(mo.index)

		if math.abs(trans.position.x - playerPos.x) <= near_event_dis then
			nowNearEventMo = mo

			break
		end
	end

	V1a6_CachotRoomModel.instance:setNearEventMo(nowNearEventMo)
end

function CachotPlayerComp:_setPlayerDir(isRight)
	self._player:setDir(not isRight)
end

function CachotPlayerComp:_beginTriggerEvent()
	self:onStopMove()

	self._targetTr = nil

	TaskDispatcher.cancelTask(self._everyFrameMove, self)
	self._player:playTriggerAnim()
end

function CachotPlayerComp:onStopMove()
	self._player:setIsMove(false)
end

function CachotPlayerComp:_onCloseViewFinish(viewName)
	if viewName == ViewName.V1a6_CachotDifficultyView then
		if self._player then
			self._player:setActive(true)
		end

		self:_resetPlayerPos()
	elseif (viewName == ViewName.LoadingView or viewName == ViewName.V1a6_CachotLoadingView or viewName == ViewName.V1a6_CachotLayerChangeView) and self._player then
		self._player:setActive(true)
		self._player:playEnterAnim(not V1a6_CachotModel.instance:isInRogue())
	end
end

function CachotPlayerComp:_resetPlayerPos()
	local levelId = self:getCurScene():getCurLevelId()
	local levelCo = lua_scene_level.configDict[levelId]
	local defaultVal = self:_getDefaultVal(levelCo)

	defaultVal = defaultVal - self._animLeftLen

	self:_setAnimValForce(defaultVal)
	self._player:hideEffect(V1a6_CachotEnum.PlayerEffect.RoleTransEffect)
	self:_movePlayer()
end

function CachotPlayerComp:_setAnimValForce(value)
	self._playerVal = value
	self._cameraVal = Mathf.Clamp(value, 0, self._animLen)

	if value < 0 then
		self._sceneAnim:SampleAnimation(self._sceneGo, 0)
		self._playerAnimLeft:SampleAnimation(self._sceneGo, self._animLeftLen + value)
	elseif value > self._animLen then
		self._sceneAnim:SampleAnimation(self._sceneGo, 1)
		self._playerAnimRight:SampleAnimation(self._sceneGo, value - self._animLen)
	else
		self._playerAnim:SampleAnimation(self._sceneGo, value)
		self._sceneAnim:SampleAnimation(self._sceneGo, value)
	end
end

function CachotPlayerComp:onSceneClose()
	V1a6_CachotRoomModel.instance:setNearEventMo(nil)
	TaskDispatcher.cancelTask(self._everyFrameMove, self)
	TaskDispatcher.cancelTask(self._cameraFollow, self)
	TaskDispatcher.cancelTask(self._onEffectFinish, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.PlayerMove, self.onPlayerMove, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.PlayerStopMove, self.onStopMove, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.PlayerMoveTo, self.moveToPos, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangeAnimEnd, self._resetPlayerPos, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangeBegin, self._clearAsset, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.BeginTriggerEvent, self._beginTriggerEvent, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self._levelComp:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self.onSceneLevelLoaded, self)

	if self._player then
		self._player:dispose()

		self._player = nil
	end

	if self._doorEffect then
		self._doorEffect:dispose()

		self._doorEffect = nil
	end

	gohelper.destroy(self._playerGo)

	self._playerGo = nil
	self._targetTr = nil
	self._scene = nil
end

return CachotPlayerComp
