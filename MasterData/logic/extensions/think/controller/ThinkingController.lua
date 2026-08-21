-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/think/controller/ThinkingController.lua

module("logic.extensions.think.controller.ThinkingController", package.seeall)

local M = class("ThinkingController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()

	local code = GameEnum.SystemEnum.Thought
	local event = StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, code)

	GlobalDispatcher:addEventListener(event, self.requestThinkingData, self)
end

function M:onReset()
	self._selectedThinkingId = nil
end

function M:requestThinkingData()
	ThinkingAgent.instance:sendGetAllThinkingRequest()
	ThinkingAgent.instance:sendGetHeroThinkingRequest()
end

function M:setSelectedThinkingId(thinkingId)
	self._selectedThinkingId = thinkingId
end

function M:getSelectedThinkingId()
	return self._selectedThinkingId
end

M.instance = M.New()

return M
