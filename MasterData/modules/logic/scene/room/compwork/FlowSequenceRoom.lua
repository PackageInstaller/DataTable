-- chunkname: @modules/logic/scene/room/compwork/FlowSequenceRoom.lua

module("modules.logic.scene.room.compwork.FlowSequenceRoom", package.seeall)

local FlowSequenceRoom = class("FlowSequenceRoom", FlowSequence)

function FlowSequenceRoom:_runNext()
	local work = self._workList[self._curIndex + 1]

	if work then
		if isTypeOf(work, RoomSceneCommonCompWork) then
			RoomHelper.logElapse("++++++ " .. work.__cname .. " " .. work._comp.__cname, 0.001)
		elseif isTypeOf(work, RoomSceneWaitEventCompWork) then
			RoomHelper.logElapse("++++++ " .. work.__cname .. " " .. work._comp.__cname, 0.001)
		else
			RoomHelper.logElapse("++++++ " .. work.__cname, 0.001)
		end
	end

	FlowSequenceRoom.super._runNext(self)
end

function FlowSequenceRoom:onWorkDone(work)
	if isTypeOf(work, RoomSceneCommonCompWork) then
		RoomHelper.logElapse("-------- " .. work.__cname .. " " .. work._comp.__cname, 0.001)
	elseif isTypeOf(work, RoomSceneWaitEventCompWork) then
		RoomHelper.logElapse("-------- " .. work.__cname .. " " .. work._comp.__cname, 0.001)
	else
		RoomHelper.logElapse("-------- " .. work.__cname, 0.001)
	end

	FlowSequenceRoom.super.onWorkDone(self, work)
end

return FlowSequenceRoom
