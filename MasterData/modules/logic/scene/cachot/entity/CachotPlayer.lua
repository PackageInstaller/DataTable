-- chunkname: @modules/logic/scene/cachot/entity/CachotPlayer.lua

module("modules.logic.scene.cachot.entity.CachotPlayer", package.seeall)

local CachotPlayer = class("CachotPlayer", BaseUnitSpawn)
local AnimName = {
	IdleToMove = "move2",
	MoveToIdle = "move2_2",
	Idle = "idle",
	MainSceneBorn = "born",
	RogueSceneBorn = "born2",
	TriggerIdle = "idle2",
	Move = "move2_1"
}
local LoopAnim = {
	[AnimName.Idle] = true,
	[AnimName.Move] = true
}

function CachotPlayer.Create(containerGO)
	return MonoHelper.addNoUpdateLuaComOnceToGo(containerGO, CachotPlayer)
end

function CachotPlayer:init(go)
	CachotPlayer.super.init(self, go)

	self.trans = go.transform
	self._effectDict = {}
	self._effectContainer = gohelper.create3d(self.go, "Effect")

	self:loadSpine("roles/dilaoxiaoren/dilaoxiaoren.prefab")
end

function CachotPlayer:initComponents()
	self:addComp("spine", UnitSpine)
	self:addComp("spineRenderer", UnitSpineRenderer)
	self.spine:setLayer(UnityLayer.Scene)
end

function CachotPlayer:loadSpine(spinePath)
	if self.spine then
		self.spine:setResPath(spinePath, self._onSpineLoaded, self)
	end
end

function CachotPlayer:_onSpineLoaded(spine)
	if self.spineRenderer then
		self.spineRenderer:setSpine(spine)
	end

	self.spine:addAnimEventCallback(self._onAnimEvent, self)
	self:playAnim(self._cacheAnimName or AnimName.Idle)
	transformhelper.setLocalScale(spine:getSpineTr(), 0.435, 0.435, 0.435)
	gohelper.setActive(self.spine:getSpineGO(), self._isActive)
end

function CachotPlayer:playAnim(animName)
	self._cacheAnimName = animName

	if self.spine:getSpineGO() then
		self.spine:play(animName, LoopAnim[animName], not LoopAnim[animName])
	end
end

function CachotPlayer:playEnterAnim(isMainScene)
	if isMainScene then
		self:playAnim(AnimName.MainSceneBorn)
	else
		self:playAnim(AnimName.RogueSceneBorn)
		self:showEffect(V1a6_CachotEnum.PlayerEffect.RoleBornEffect)
		TaskDispatcher.cancelTask(self._delayHideEffect, self)
		TaskDispatcher.runDelay(self._delayHideEffect, self, 1.5)
	end
end

function CachotPlayer:_delayHideEffect()
	self:hideEffect(V1a6_CachotEnum.PlayerEffect.RoleBornEffect)
end

function CachotPlayer:_onAnimEvent(actionName, eventName, eventArgs)
	if eventName == SpineAnimEvent.ActionComplete then
		if actionName == AnimName.IdleToMove then
			self:playAnim(AnimName.Move)
		else
			self:playAnim(AnimName.Idle)
		end

		if actionName == AnimName.RogueSceneBorn then
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.CheckPlayStory)
		end
	end
end

function CachotPlayer:setIsMove(isMoving, isForce)
	if not isForce and self._isMoving == isMoving then
		return
	end

	self._isMoving = isMoving

	if not self:isCanMove() then
		return
	end

	if self._cacheAnimName == AnimName.Move and not self._isMoving then
		self:playAnim(AnimName.MoveToIdle)
	elseif self._cacheAnimName == AnimName.Idle and self._isMoving then
		self:playAnim(AnimName.IdleToMove)
	else
		self:playAnim((self._isMoving or nil) and (AnimName.Move or AnimName.Idle))
	end
end

function CachotPlayer:playTriggerAnim()
	self:playAnim(AnimName.TriggerIdle)
end

function CachotPlayer:isCanMove()
	if not self.spine:getSpineGO() or not self.spine:getSpineGO().activeSelf then
		return
	end

	return self._cacheAnimName == AnimName.Idle or self._cacheAnimName == AnimName.Move or self._cacheAnimName == AnimName.MoveToIdle or self._cacheAnimName == AnimName.IdleToMove or not self._cacheAnimName
end

function CachotPlayer:setDir(isLeft, isForce)
	if not isForce and self._isLeft == isLeft then
		return
	end

	self._isLeft = isLeft

	transformhelper.setLocalScale(self.trans, isLeft and 1 or -1, 1, 1)
end

function CachotPlayer:showEffect(effectName)
	if self._effectDict[effectName] then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()

	self._effectDict[effectName] = scene.preloader:getResInst(CachotScenePreloader[effectName], self._effectContainer)
end

function CachotPlayer:hideEffect(effectName)
	if self._effectDict[effectName] then
		gohelper.destroy(self._effectDict[effectName])

		self._effectDict[effectName] = nil
	end
end

function CachotPlayer:setActive(isShow)
	self._isActive = isShow

	gohelper.setActive(self.spine:getSpineGO(), isShow)
end

function CachotPlayer:getPos()
	return self.trans.position
end

function CachotPlayer:dispose()
	TaskDispatcher.cancelTask(self._delayHideEffect, self)
	gohelper.destroy(self._effectContainer)

	self._effectContainer = nil
	self._effectDict = {}
end

return CachotPlayer
