-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/work/MainSceneWorkAirtightTimeChange.lua

module("logic.extensions.mainui.scene.work.MainSceneWorkAirtightTimeChange", package.seeall)

local M = class("MainSceneWorkAirtightTimeChange", WorkBase)

function M:onEnter(context)
	self:_setEvent(true)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CHECK_TO_AIRTIGHT_ANI)
end

function M:onExit(isInterrupt)
	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_TO_AIRTIGHT_ANI_FINISHED, self._onToAirtightAniFinished, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_TO_AIRTIGHT_ANI_FINISHED, self._onToAirtightAniFinished, self)
	end
end

function M:_onToAirtightAniFinished(e)
	self:onDone(WorkResult.Succeed)
end

return M
