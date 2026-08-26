-- chunkname: @modules/logic/fight/controller/FightASFDFlyPathHelper.lua

module("modules.logic.fight.controller.FightASFDFlyPathHelper", package.seeall)

local FightASFDFlyPathHelper = _M

function FightASFDFlyPathHelper.getMissileMover(entity, missileCo, missileWrap, toId, asfdContext, arriveCallback, arriveCallbackObj)
	local handle = FightASFDFlyPathHelper.flyPathHandle[missileCo.flyPath]

	handle = handle or FightASFDFlyPathHelper.defaultFlyMover

	return handle(missileCo.flyPath, entity, missileCo, missileWrap, toId, asfdContext, arriveCallback, arriveCallbackObj)
end

function FightASFDFlyPathHelper.defaultFlyMover(flyPathId, entity, missileCo, missileWrap, toId, asfdContext, arriveCallback, arriveCallbackObj)
	local mover = MonoHelper.addLuaComOnceToGo(missileWrap.containerGO, UnitMoverBezier3)

	MonoHelper.addLuaComOnceToGo(missileWrap.containerGO, UnitMoverHandler)
	mover:registerCallback(UnitMoveEvent.Arrive, arriveCallback, arriveCallbackObj)
	FightASFDHelper.changeRandomArea()

	local entityMo = entity:getMO()
	local startPos = asfdContext.missilePos and asfdContext.missilePos or FightASFDHelper.getStartPos((entityMo or nil) and (entityMo.side or FightEnum.EntitySide.MySide), missileCo.sceneEmitterId)
	local endPos = FightASFDHelper.getEndPos(toId)
	local p1 = startPos
	local p2 = FightASFDHelper.getRandomPos(startPos, endPos, missileCo)
	local p3 = p2
	local p4 = endPos

	missileWrap:setWorldPos(startPos.x, startPos.y, startPos.z)

	local flyPathCo = FightASFDConfig.instance:getFlyPathCo(flyPathId)

	mover:setEaseType(flyPathCo.lineType)

	local curIndex = asfdContext.emitterAttackNum
	local flyDuration = FightASFDConfig.instance:getFlyDuration(flyPathCo.flyDuration, curIndex) / FightModel.instance:getSpeed()

	mover:simpleMove(p1, p2, p3, p4, flyDuration)

	return mover
end

function FightASFDFlyPathHelper.straightLineFlyMover(flyPathId, entity, missileCo, missileWrap, toId, asfdContext, arriveCallback, arriveCallbackObj)
	local mover = MonoHelper.addLuaComOnceToGo(missileWrap.containerGO, UnitMoverEase)

	MonoHelper.addLuaComOnceToGo(missileWrap.containerGO, UnitMoverHandler)
	mover:registerCallback(UnitMoveEvent.Arrive, arriveCallback, arriveCallbackObj)

	local entityMo = entity:getMO()
	local startPos = asfdContext.missilePos and asfdContext.missilePos or FightASFDHelper.getStartPos((entityMo or nil) and (entityMo.side or FightEnum.EntitySide.MySide), missileCo.sceneEmitterId)
	local endPos = FightASFDHelper.getEndPos(toId, ModuleEnum.SpineHangPoint.mountbody)

	missileWrap:setWorldPos(startPos.x, startPos.y, startPos.z)

	local rotationZ = FightASFDHelper.getZRotation(startPos.x, startPos.y, endPos.x, endPos.y)

	transformhelper.setLocalRotation(missileWrap.containerGO.transform, 0, 0, rotationZ)

	local flyPathCo = FightASFDConfig.instance:getFlyPathCo(flyPathId)

	mover:setEaseType(flyPathCo.lineType)

	local curIndex = asfdContext.emitterAttackNum
	local flyDuration = FightASFDConfig.instance:getFlyDuration(flyPathCo.flyDuration, curIndex) / FightModel.instance:getSpeed()

	mover:simpleMove(startPos.x, startPos.y, startPos.z, endPos.x, endPos.y, endPos.z, flyDuration)

	return mover
end

function FightASFDFlyPathHelper.straightLine_LSJFlyMover(flyPathId, entity, missileCo, missileWrap, toId, asfdContext, arriveCallback, arriveCallbackObj)
	local mover = MonoHelper.addLuaComOnceToGo(missileWrap.containerGO, UnitMoverEase)

	MonoHelper.addLuaComOnceToGo(missileWrap.containerGO, UnitMoverHandler)
	mover:registerCallback(UnitMoveEvent.Arrive, arriveCallback, arriveCallbackObj)

	local entityMo = entity:getMO()
	local startPos = asfdContext.missilePos and asfdContext.missilePos or FightASFDHelper.getStartPos((entityMo or nil) and (entityMo.side or FightEnum.EntitySide.MySide), missileCo.sceneEmitterId)
	local endPos = FightASFDHelper.getEndPos(toId, ModuleEnum.SpineHangPoint.mountbody)

	missileWrap:setWorldPos(startPos.x, startPos.y, startPos.z)

	local rotationZ = FightASFDHelper.getZRotation(startPos.x, startPos.y, endPos.x, endPos.y)

	transformhelper.setLocalRotation(missileWrap.containerGO.transform, 0, 0, rotationZ)

	local flyPathCo = FightASFDConfig.instance:getFlyPathCo(flyPathId)

	mover:setEaseType(flyPathCo.lineType)

	local flyDuration = flyPathCo.flyDuration / FightModel.instance:getSpeed()

	mover:simpleMove(startPos.x, startPos.y, startPos.z, endPos.x, endPos.y, endPos.z, flyDuration)

	return mover
end

FightASFDFlyPathHelper.flyPathHandle = {
	[FightEnum.ASFDFlyPath.Default] = FightASFDFlyPathHelper.defaultFlyMover,
	[FightEnum.ASFDFlyPath.StraightLine] = FightASFDFlyPathHelper.straightLineFlyMover,
	[FightEnum.ASFDFlyPath.StraightLine_LSJ] = FightASFDFlyPathHelper.straightLine_LSJFlyMover
}

return FightASFDFlyPathHelper
