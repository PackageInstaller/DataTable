-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/effect/BattleLinkEffect.lua

module("logic.battle.battleflow.component.effect.BattleLinkEffect", package.seeall)

local M = class("BattleLinkEffect", IBattleReusable)
local kShowAnimationName = "_start"
local kHideAnimationName = "_end"

function M:ctor()
	self._fromPosition = Vector3.New()
	self._toPosition = Vector3.New()
	self._lineHideHandler = Handler.New()
	self._fromEntityId = false
	self._toEntityId = false
	self.mainGO = false
	self._animation = false
	self._line = false
end

function M:reset()
	if self.mainGO then
		self._lineHideHandler:clear()
		removetimer(self._onLineHideFinish, self)
		goutil.destroy(self.mainGO)

		self.mainGO = false
		self._animation = false
		self._line = false
	end
end

function M:destroy()
	self:reset()
end

function M:setGameObject(mainGO)
	if not mainGO then
		return
	end

	goutil.addChildToParent(mainGO, BattleGameObjectRootUtil.effectsRoot)

	self.mainGO = mainGO
	self._line = SpaceX.CurveLine.Get(mainGO)
	self._animation = mainGO:GetComponent(ComponentType.Animation)

	self:_updateLink(true, true)
end

function M:setLinkEntitys(fromEntityId, toEntityId)
	self._fromEntityId = fromEntityId
	self._toEntityId = toEntityId
end

function M:isTargetLink(fromEntityId, toEntityId)
	return self._fromEntityId == fromEntityId and self._toEntityId == toEntityId
end

function M:isFromEntityId(entityId)
	return self._fromEntityId == entityId
end

function M:isToEntityId(entityId)
	return self._toEntityId == entityId
end

function M:constainsEntityId(entityId)
	return self._fromEntityId == entityId or self._toEntityId == entityId
end

function M:showLink()
	if self._animation then
		AnimationUtils.PlayAnimationContainsKey(self._animation, kShowAnimationName)
		AnimationUtils.SetPlaySpeed(self._animation, BattleTime.timeScale)
	end
end

function M:hideLink(callback, callbackSelf)
	self._lineHideHandler:setListener(callback, callbackSelf)

	if self._animation then
		settimer(2, self._onLineHideFinish, self)
		AnimationUtils.PlayAnimationContainsKey(self._animation, kHideAnimationName)
		AnimationUtils.SetPlaySpeed(self._animation, BattleTime.timeScale)
	else
		self:_onLineHideFinish()
	end
end

function M:_onLineHideFinish()
	self._lineHideHandler:callAndClear(self)
end

function M:setFromPositionXYZ(x, y, z)
	self._fromPosition:Set(x, y, z)
	self:_updateLink(true, false)
end

function M:setToPositionXYZ(x, y, z)
	self._toPosition:Set(x, y, z)
	self:_updateLink(false, true)
end

function M:_updateLink(updateFrom, updateTo)
	if not self._line then
		return
	end

	if updateFrom then
		self._line:SetStartPoint(self._fromPosition:Get())
	end

	if updateTo then
		self._line:SetEndPoint(self._toPosition:Get())
	end

	self._line:Rebuild()
end

return M
