-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/entity/comp/ArcadeEntityBezierComp.lua

module("modules.logic.versionactivity3_3.arcade.view.game.entity.comp.ArcadeEntityBezierComp", package.seeall)

local ArcadeEntityBezierComp = class("ArcadeEntityBezierComp", LuaCompBase)

function ArcadeEntityBezierComp:ctor(param)
	self._entity = param.entity
	self._compName = param.compName
	self._initialized = true
end

function ArcadeEntityBezierComp:init(go)
	self.go = go
	self.trans = go.transform
	self._bezierY = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.FlyingEffectOffsetY, true) or 2
	self._bezierTime = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.FlyingEffectTime, true) or 0.3
end

function ArcadeEntityBezierComp:beginGridXY(gridX, gridY)
	if not self._initialized then
		return
	end

	self._beginX, self._beginY = ArcadeGameHelper.getGridPos(gridX, gridY)
	self._fUnitMO = self._entity:getMO()

	self:_killTween()
	transformhelper.setLocalPos(self.trans, self._beginX, self._beginY, 0)

	self._bezierTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, self._bezierTime, self._frameBeginCallback, nil, self)
end

function ArcadeEntityBezierComp:endGridXY(gridX, gridY)
	if not self._initialized then
		return
	end

	local unitMO = self._entity:getMO()
	local curGridX, curGridY = unitMO:getGridPos()

	unitMO:setGridPos(gridX, gridY)
	self:beginGridXY(curGridX, curGridY)
end

function ArcadeEntityBezierComp:begin2EndGridXY(gridX, gridY, endGridX, endGridY)
	if not self._initialized then
		return
	end

	local unitMO = self._entity:getMO()

	unitMO:setGridPos(endGridX, endGridY)
	self:beginGridXY(gridX, gridY)
end

function ArcadeEntityBezierComp:_frameBeginCallback(t)
	local gridX, gridY = self._fUnitMO:getGridPos()
	local endX, endY = ArcadeGameHelper.getGridPos(gridX, gridY)
	local x = self:getBezierValue(t, self._beginX, endX, (self._beginX + endX) * 0.5)
	local y = self:getBezierValue(t, self._beginY, endY, self._bezierY)

	transformhelper.setLocalPos(self.trans, x, y, 0)
	ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnEntityMove, self._fUnitMO)
end

function ArcadeEntityBezierComp:getBezierValue(t, beginValue, endValue, bezier)
	return (1 - t) * (1 - t) * beginValue + 2 * t * (1 - t) * bezier + t * t * endValue
end

function ArcadeEntityBezierComp:_killTween()
	if self._bezierTweenId then
		ZProj.TweenHelper.KillById(self._bezierTweenId)

		self._bezierTweenId = nil
	end
end

function ArcadeEntityBezierComp:getCompName()
	return self._compName
end

function ArcadeEntityBezierComp:clear()
	if not self._initialized then
		return
	end

	self:_killTween()
end

function ArcadeEntityBezierComp:onDestroy()
	self:clear()

	self._initialized = false
end

return ArcadeEntityBezierComp
