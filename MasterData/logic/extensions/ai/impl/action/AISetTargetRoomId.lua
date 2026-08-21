-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AISetTargetRoomId.lua

module("logic.extensions.ai.impl.action.AISetTargetRoomId", package.seeall)

local M = class("AISetTargetRoomId", AINode)

function M:ctor(context)
	M.super.ctor(self, context)

	self._roomId = 0
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._roomId = aiConfigData.roomId
end

function M:onStart()
	M.super.onStart(self)

	if self._roomId > 0 then
		local mo = HouseNavigationModel.instance:getMOByZoneId(self._roomId)

		if mo then
			self:getContext():setTargetPos(mo:getRandomPoint(), self._roomId)
			self:getContext():setUseRandomPos(true)

			return self:onEnd(AIConst.AIStatus.SUCCESS)
		end
	end

	return self:onEnd(AIConst.AIStatus.FAILD)
end

function M:handleEnd()
	return
end

function M:onReset()
	M.super.onReset(self)
end

function M:onRecycle()
	M.super.onRecycle(self)

	self._roomId = 0
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._roomId = 0
end

return M
