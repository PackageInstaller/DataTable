-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleGOInstProxyDelete.lua

module("logic.extensions.story.core.logic.handles.StoryHandleGOInstProxyDelete", package.seeall)

local M = class("StoryHandleGOInstProxyDelete")

function M:Handle(assetUID, instUID, binder)
	if not binder then
		return
	end

	local ptrInfo = binder:FindIDPtr(instUID)

	if not ptrInfo then
		local _shotId = StoryController.instance:getCurStoryEntry():_GetCurrShotId()
		local index = StoryController.instance:getCurStoryEntry():_GetShotIndex(_shotId)

		printWarn("StoryHandleGOInstProxyDelete 无法找到ptr==》", instUID, "index=", index)

		return
	end

	if ptrInfo.type ~= StoryResIDPtrType.GameObject then
		local _shotId = StoryController.instance:getCurStoryEntry():_GetCurrShotId()
		local index = StoryController.instance:getCurStoryEntry():_GetShotIndex(_shotId)

		printWarn("StoryHandleGOInstProxyDelete 企图删除非GameObject类型指针。==》", assetUID, instUID, "index=", index)

		return
	end

	local info = binder:RemovePtr(instUID)

	if info then
		local proxyInst = info.targetObj

		if proxyInst then
			if proxyInst.target then
				goutil.destroy(proxyInst.target)
			end

			if proxyInst.proxyTarget then
				goutil.destroy(proxyInst.proxyTarget)
			end
		end
	end
end

return M
