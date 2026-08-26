-- chunkname: @modules/logic/room/entity/comp/RoomCritterFollowerComp.lua

module("modules.logic.room.entity.comp.RoomCritterFollowerComp", package.seeall)

local RoomCritterFollowerComp = class("RoomCritterFollowerComp", RoomBaseFollowerComp)

function RoomCritterFollowerComp:ctor(entity)
	RoomCritterFollowerComp.super.ctor(self, entity)

	self._followDis = 0.15
end

function RoomCritterFollowerComp:init(go)
	RoomCritterFollowerComp.super.init(go)
	self:delaySetFollow(0.5)
end

function RoomCritterFollowerComp:addPathPos(pos)
	local pathData = self:getFollowPathData()

	if pathData:getPosCount() == 1 then
		local dis = Vector3.Distance(pathData:getFirstPos(), pos)

		if not self._followDis then
			if self._followDis > dis + pathData:getPathDistance() then
				return
			end
		end
	end

	RoomCritterFollowerComp.super.addPathPos(self, pos)
end

function RoomCritterFollowerComp:onMoveByPathData(pathData)
	if pathData:getPosCount() < 1 then
		return
	end

	local pathDis = pathData:getPathDistance()
	local followDis = self._followDis

	if followDis < pathDis then
		local targetPos = pathData:getPosByDistance(followDis)

		self.entity:setLocalPos(targetPos.x, targetPos.y, targetPos.z)
	elseif pathDis < followDis then
		-- block empty
	end

	local critterspine = self.entity.critterspine

	if critterspine then
		local characterEntity = self:_findCharacterEntity()

		if characterEntity and characterEntity.characterspine then
			critterspine:setLookDir(characterEntity.characterspine:getLookDir())
		end
	end
end

function RoomCritterFollowerComp:onStopMove()
	self:_playAnimState(RoomCharacterEnum.CharacterMoveState.Idle, true)

	local ex, ey, ez = transformhelper.getPos(self.entity.goTrs)
	local pathData = self:getFollowPathData()

	pathData:clear()
	pathData:addPathPos(Vector3(ex, ey, ez))
end

function RoomCritterFollowerComp:onStartMove()
	self:_playAnimState(RoomCharacterEnum.CharacterMoveState.Move, true)
end

function RoomCritterFollowerComp:_playAnimState(moveState, isLoop)
	local critterspine = self.entity.critterspine

	if critterspine then
		critterspine:changeMoveState(moveState)
		critterspine:play(RoomCharacterHelper.getAnimStateName(moveState, self.entity.id), isLoop, true)
	end
end

function RoomCritterFollowerComp:_findCharacterEntity()
	local critterMO = self.entity:getMO()

	if not critterMO then
		return
	end

	local characterMO = RoomCharacterModel.instance:getCharacterMOById(critterMO.heroId)
	local scene = GameSceneMgr.instance:getCurScene()

	if scene and characterMO then
		return (scene.charactermgr:getCharacterEntity(characterMO.id, SceneTag.RoomCharacter))
	end
end

function RoomCritterFollowerComp:delaySetFollow(delay)
	TaskDispatcher.cancelTask(self._delaySetFollow, self)
	TaskDispatcher.runDelay(self._delaySetFollow, self, delay or 0.5)
end

function RoomCritterFollowerComp:_delaySetFollow()
	local roomScene = RoomCameraController.instance:getRoomScene()
	local roomCritterMO = self.entity:getMO()

	if not roomCritterMO or not roomScene then
		return
	end

	local characterEntity = self:_findCharacterEntity()

	if characterEntity then
		self:followCharacter(characterEntity)

		return
	end
end

function RoomCritterFollowerComp:followCharacter(characterEntity)
	self:setFollowPath(characterEntity.followPathComp)

	local pathData = self:getFollowPathData()

	if pathData:getPosCount() <= 1 then
		local ex, ey, ez = transformhelper.getPos(self.entity.goTrs)

		pathData:addPathPos(Vector3(ex, ey, ez))

		local px, py, pz = transformhelper.getPos(characterEntity.goTrs)

		pathData:addPathPos(Vector3(px, py, pz))
	end

	self:onMoveByPathData(pathData)
end

function RoomCritterFollowerComp:beforeDestroy()
	RoomCritterFollowerComp.super.beforeDestroy(self)
	TaskDispatcher.cancelTask(self._delaySetFollow, self)
end

return RoomCritterFollowerComp
