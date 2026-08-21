-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/viewextension/MaterialBattleIncrEffect.lua

module("logic.extensions.dungeon.battleflow.viewextension.MaterialBattleIncrEffect", package.seeall)

local MaterialBattleIncrEffect = class("MaterialBattleIncrEffect", IReusable)
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kUICamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
local kMainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
local kDistance = 10

function MaterialBattleIncrEffect:ctor(effectPrefab)
	self._goEffect = goutil.clone(effectPrefab)
	self._movingTrack = EffectMovingTrack.Get(self._goEffect)

	self._movingTrack:SetDefaultTemplate()
	self._movingTrack:SetCount(4)
	self._movingTrack:SetDuration(0.5, 1)
	self._movingTrack:SetShiftStrength(0.2)
	self._movingTrack:Build()

	self._timeline = TimelineTask.New()
	self._finishHandler = Handler.New()
	self._moveToDestinationHandler = Handler.New()

	goutil.addChildToParent(self._goEffect, kSceneRoot)
end

function MaterialBattleIncrEffect:destroy()
	goutil.destroy(self._goEffect)

	self._goEffect = nil
	self._movingTrack = nil
end

function MaterialBattleIncrEffect:reuse()
	goutil.setActive(self._goEffect, true)
end

function MaterialBattleIncrEffect:reset()
	self:stop()
	self._finishHandler:clear()
	self._moveToDestinationHandler:clear()
	goutil.setActive(self._goEffect, false)
end

function MaterialBattleIncrEffect:setMoveToDestinationListener(callback, callbackSelf)
	self._moveToDestinationHandler:setListener(callback, callbackSelf)
end

function MaterialBattleIncrEffect:setFinishListener(callback, callbackSelf)
	self._finishHandler:setListener(callback, callbackSelf)
end

function MaterialBattleIncrEffect:play(fromX, fromY, fromZ, toX, toY, toZ)
	local screenX, screenY = RaycastUtils.WorldToScreenPoint(kMainCamera, fromX, fromY, fromZ, 0, 0, 0)
	local fx, fy, fz = RaycastUtils.ScreenToWorldPoint(kUICamera, screenX, screenY, kDistance, 0, 0, 0)

	self._movingTrack:SetFromPosition(fx, fy, fz)

	screenX, screenY = RaycastUtils.WorldToScreenPoint(kUICamera, toX, toY, toZ, 0, 0, 0)

	local tx, ty, tz = RaycastUtils.ScreenToWorldPoint(kUICamera, screenX, screenY, kDistance, 0, 0, 0)

	self._movingTrack:SetToPosition(tx, ty, tz)
	self._movingTrack:SetPlaySpeed(BattleTime.timeScale)
	self._movingTrack:Play()
	self._timeline:clear()
	self._timeline:addTask(0.6, self._tMoveToDestination, self)
	self._timeline:addTask(0.4)
	self._timeline:addFinishListener(self._onTaskFinish, self)
	self._timeline:setTimeScale(BattleTime.timeScale)
	self._timeline:start()
end

function MaterialBattleIncrEffect:stop()
	self._timeline:clear()
	self._movingTrack:Stop()
end

function MaterialBattleIncrEffect:_tMoveToDestination()
	self._moveToDestinationHandler:call()
end

function MaterialBattleIncrEffect:_onTaskFinish()
	self._finishHandler:call(self)
end

return MaterialBattleIncrEffect
