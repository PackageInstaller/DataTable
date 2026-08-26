-- chunkname: @modules/logic/scene/room/compwork/FlowParallelRoom.lua

module("modules.logic.scene.room.compwork.FlowParallelRoom", package.seeall)

local FlowParallelRoom = class("FlowParallelRoom", FlowParallel)

function FlowParallelRoom:onStartInternal(context)
	if #self._workList == 0 then
		self:onDone(true)

		return
	end

	self._doneCount = 0
	self._succCount = 0

	for _, work in ipairs(self._workList) do
		if isTypeOf(work, RoomSceneCommonCompWork) then
			RoomHelper.logElapse("++++++ " .. work.__cname .. " " .. work._comp.__cname, 0.001)
		elseif isTypeOf(work, RoomSceneWaitEventCompWork) then
			RoomHelper.logElapse("++++++ " .. work.__cname .. " " .. work._comp.__cname, 0.001)
		else
			RoomHelper.logElapse("++++++ " .. work.__cname, 0.001)
		end

		work:onStartInternal(context)
	end
end

function FlowParallelRoom:onWorkDone(work)
	if isTypeOf(work, RoomSceneCommonCompWork) then
		RoomHelper.logElapse("-------- " .. work.__cname .. " " .. work._comp.__cname, 0.001)
	elseif isTypeOf(work, RoomSceneWaitEventCompWork) then
		RoomHelper.logElapse("-------- " .. work.__cname .. " " .. work._comp.__cname, 0.001)
	else
		RoomHelper.logElapse("-------- " .. work.__cname, 0.001)
	end

	FlowParallelRoom.super.onWorkDone(self, work)
end

return FlowParallelRoom
