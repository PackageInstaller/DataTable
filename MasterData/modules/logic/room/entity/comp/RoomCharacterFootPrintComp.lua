-- chunkname: @modules/logic/room/entity/comp/RoomCharacterFootPrintComp.lua

module("modules.logic.room.entity.comp.RoomCharacterFootPrintComp", package.seeall)

local RoomCharacterFootPrintComp = class("RoomCharacterFootPrintComp", LuaCompBase)

function RoomCharacterFootPrintComp:ctor(entity)
	self.entity = entity
end

function RoomCharacterFootPrintComp:init(go)
	self.go = go
	self.goTrs = go.transform

	local x, y, z = transformhelper.getPos(self.goTrs)

	self._lastPosition = Vector3(x, y, z)
	self._scene = GameSceneMgr.instance:getCurScene()
	self._footDistance = 0.05
end

function RoomCharacterFootPrintComp:addEventListeners()
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, self._updateCharacterMove, self)
end

function RoomCharacterFootPrintComp:removeEventListeners()
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, self._updateCharacterMove, self)
end

function RoomCharacterFootPrintComp:_updateCharacterMove()
	self:_updateMovingLookDir()
end

function RoomCharacterFootPrintComp:_updateMovingLookDir()
	if self.entity.isPressing then
		return
	end

	local mo = self.entity:getMO()

	if not mo then
		return
	end

	if self._scene.character:isLock() then
		return
	end

	if mo.roomCharacterConfig.hideFootprint ~= 0 then
		return
	end

	if mo:getMoveState() ~= RoomCharacterEnum.CharacterMoveState.Move then
		self._needFootPrint = true

		return
	end

	local moveDir = mo:getMovingDir()
	local moveX = moveDir.x
	local moveY = moveDir.y

	if moveX == 0 and moveY == 0 then
		return
	end

	local x, y, z = transformhelper.getPos(self.goTrs)
	local position = Vector3(x, y, z)

	if self._needFootPrint or Vector3.Distance(self._lastPosition, position) >= self._footDistance then
		local hexX, hexY = HexMath.posXYToRoundHexYX(x, z, RoomBlockEnum.BlockSize)
		local blockMO = RoomMapBlockModel.instance:getBlockMO(hexX, hexY)

		if blockMO and blockMO:isInMapBlock() and RoomBlockEnum.FootPrintDict[blockMO:getDefineBlockType()] then
			self._needFootPrint = false
			self._lastPosition = position

			local targetDir = Vector3(moveX, 0, moveY)
			local toRotation = Quaternion.LookRotation(targetDir, Vector3.up)
			local rotationV3 = toRotation.eulerAngles

			self._isLeftFoot = self._isLeftFoot == false

			RoomMapController.instance:dispatchEvent(RoomEvent.AddCharacterFootPrint, rotationV3, position, self._isLeftFoot)
		end
	end
end

function RoomCharacterFootPrintComp:beforeDestroy()
	self:removeEventListeners()
end

return RoomCharacterFootPrintComp
