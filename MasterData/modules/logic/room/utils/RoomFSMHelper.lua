-- chunkname: @modules/logic/room/utils/RoomFSMHelper.lua

module("modules.logic.room.utils.RoomFSMHelper", package.seeall)

local RoomFSMHelper = {}

function RoomFSMHelper.isCanJompTo(state)
	if state == RoomEnum.FSMEditState.PlaceConfirm then
		local blockMO = RoomMapBlockModel.instance:getTempBlockMO()

		if blockMO then
			return true
		end
	elseif state == RoomEnum.FSMEditState.BackConfirm then
		local backBlockModel = RoomMapBlockModel.instance:getBackBlockModel()

		if backBlockModel and backBlockModel:getCount() > 0 then
			return true
		end
	end

	return false
end

return RoomFSMHelper
