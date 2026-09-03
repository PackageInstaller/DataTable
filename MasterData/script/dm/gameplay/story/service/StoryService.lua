-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/service/StoryService.lua

StoryService = class("StoryService", Service, _M)

local opType = {
	OPCODE_STORY_MAZECLUE = 33333,
	OPCODE_STORY_LOVE = 27008
}

function StoryService:initialize()
	super.initialize(self)
end

function StoryService:dispose()
	super.dispose(self)
end

function StoryService:requestStoryLove(params, blockUI, callback)
	local request = self:newRequest(opType.OPCODE_STORY_LOVE, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end

function StoryService:requestMazeClue(params, blockUI, callback)
	local request = self:newRequest(opType.OPCODE_STORY_MAZECLUE, params, function(response)
		if callback ~= nil then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end
