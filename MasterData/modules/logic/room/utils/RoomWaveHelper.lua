-- chunkname: @modules/logic/room/utils/RoomWaveHelper.lua

module("modules.logic.room.utils.RoomWaveHelper", package.seeall)

local RoomWaveHelper = {}

function RoomWaveHelper.getWaveList(nearWaveList, nearRiverList)
	local offset = 0
	local fullFlag = true

	for i, nearWave in ipairs(nearWaveList) do
		if not nearWave then
			fullFlag = false
			offset = i

			break
		end
	end

	if fullFlag then
		return {
			RoomScenePreloader.ResEffectWaveList[6]
		}, {
			0
		}, {
			RoomScenePreloader.ResEffectWaveList[6]
		}
	end

	local resList = {}
	local directionList = {}
	local abPathList = {}
	local count = 0
	local nearRiver = false
	local start = offset

	for point = offset, offset + 5 do
		local fixedPoint = (point - 1) % 6 + 1
		local nearWave = nearWaveList[fixedPoint]

		nearRiver = nearRiver or nearRiverList[fixedPoint]

		if nearWave then
			count = count + 1
		end

		if (not nearWave or point == offset + 5) and count > 0 then
			if nearRiver then
				table.insert(resList, RoomScenePreloader.ResEffectWaveWithRiverList[count])
				table.insert(abPathList, RoomScenePreloader.ResEffectWaveWithRiverList[count])
			else
				table.insert(resList, RoomScenePreloader.ResEffectWaveList[count])
				table.insert(abPathList, RoomScenePreloader.ResEffectWaveList[count])
			end

			table.insert(directionList, start)
		end

		if not nearWave then
			start = fixedPoint % 6 + 1
			count = 0
			nearRiver = false
		end
	end

	return resList, directionList, resList
end

return RoomWaveHelper
