-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventSceneMove.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventSceneMove", package.seeall)

local FightTLEventSceneMove = class("FightTLEventSceneMove", FightTimelineTrackItem)

FightTLEventSceneMove.MoveType = {
	Revert = 2,
	Move = 1
}

function FightTLEventSceneMove:onTrackStart(fightStepData, duration, paramsArr)
	self.moveType = tonumber(paramsArr[1])
	self.easeType = tonumber(paramsArr[3])

	if self.moveType == FightTLEventSceneMove.MoveType.Move then
		self:handleMove(fightStepData, duration, paramsArr)
	else
		self:handleRevert(fightStepData, duration, paramsArr)
	end
end

function FightTLEventSceneMove:handleMove(fightStepData, duration, paramsArr)
	self.targetPos = FightStrUtil.instance:getSplitToNumberCache(paramsArr[2], ",")

	local entity = FightHelper.getEntity(fightStepData.fromId)
	local entityMo = entity and entity:getMO()

	if not entityMo then
		logError("not found entity mo : " .. tostring(fightStepData.fromId))

		return
	end

	local x, y, z = FightHelper.getEntityStandPos(entityMo)
	local targetX, targetY, targetZ = self.targetPos[1], self.targetPos[2], self.targetPos[3]

	targetX = entityMo.side == FightEnum.EntitySide.MySide and targetX or -targetX

	local offsetX, offsetY, offsetZ = targetX - x, targetY - y, targetZ - z
	local tr = self:getSceneTr()

	if tr then
		self:clearTween()

		local curX, curY, curZ = transformhelper.getLocalPos(tr)

		FightModel.instance:setCurSceneOriginPos(curX, curY, curZ)

		self.tweenId = ZProj.TweenHelper.DOMove(tr, curX + offsetX, curY + offsetY, curZ + offsetZ, duration, nil, nil, nil, self.easeType)
	end
end

function FightTLEventSceneMove:handleRevert(fightStepData, duration, paramsArr)
	local originX, originY, originZ = FightModel.instance:getCurSceneOriginPos()
	local tr = self:getSceneTr()

	if tr then
		self:clearTween()

		self.tweenId = ZProj.TweenHelper.DOMove(tr, originX, originY, originZ, duration, self.onRevertCallback, self, nil, self.easeType)
	end
end

function FightTLEventSceneMove:getSceneTr()
	local curScene = GameSceneMgr.instance:getCurScene()
	local sceneGo = curScene and curScene:getSceneContainerGO()

	return sceneGo and sceneGo.transform
end

function FightTLEventSceneMove:onRevertCallback()
	local originX, originY, originZ = FightModel.instance:getCurSceneOriginPos()

	FightModel.instance:setCurSceneOriginPos(nil, nil, nil)

	local tr = self:getSceneTr()

	if tr then
		transformhelper.setLocalPos(tr, originX, originY, originZ)
	end
end

function FightTLEventSceneMove:onTrackEnd()
	return
end

function FightTLEventSceneMove:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function FightTLEventSceneMove:clearData()
	self.moveType = nil
	self.targetPos = nil
	self.easeType = nil
end

function FightTLEventSceneMove:onDestructor()
	self:clearTween()
	self:clearData()
end

return FightTLEventSceneMove
