-- chunkname: @modules/logic/room/utils/RoomRotateHelper.lua

module("modules.logic.room.utils.RoomRotateHelper", package.seeall)

local RoomRotateHelper = {}

function RoomRotateHelper.getMod(num, mod)
	if num > 0 then
		num = num % mod
	else
		local count = math.ceil(math.abs(num / mod))

		num = num + count * mod
	end

	return num
end

function RoomRotateHelper.rotateRotate(originalRotate, rotate)
	rotate = originalRotate + rotate
	rotate = RoomRotateHelper.getMod(rotate, 6)

	return rotate
end

function RoomRotateHelper.rotateDirection(direction, rotate)
	if direction == 0 then
		return direction
	end

	direction = RoomRotateHelper.rotateRotate(direction - 1, rotate)

	return direction + 1
end

function RoomRotateHelper.rotateDirectionWithCenter(direction, rotate)
	return RoomRotateHelper.getMod(direction + rotate, 7)
end

function RoomRotateHelper.oppositeDirection(direction)
	if direction == 0 then
		return direction
	end

	return RoomRotateHelper.rotateDirection(direction, 3)
end

function RoomRotateHelper.simpleRotate(lerp, rotateA, rotateB)
	rotateA = RoomRotateHelper.getMod(rotateA, Mathf.PI * 2)
	rotateB = RoomRotateHelper.getMod(rotateB, Mathf.PI * 2)

	if Mathf.Abs(rotateA - rotateB) > Mathf.PI then
		if rotateA > Mathf.PI then
			rotateA = rotateA - Mathf.PI * 2
		elseif rotateB > Mathf.PI then
			rotateB = rotateB - Mathf.PI * 2
		end
	end

	return RoomRotateHelper.getMod((1 - lerp) * rotateA + lerp * rotateB, Mathf.PI * 2)
end

function RoomRotateHelper.getCameraNearRotate(rotation)
	rotation = RoomRotateHelper.getMod(Mathf.Round((rotation - 30) / 60), 6)

	return rotation
end

return RoomRotateHelper
