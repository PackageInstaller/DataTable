-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleSoundPlay.lua

module("logic.extensions.story.core.logic.handles.StoryHandleSoundPlay", package.seeall)

local M = class("StoryHandleSoundPlay")

function M:Handle(config, shotId)
	if not config or not config:HasAnyArg() then
		return false
	end

	local voiceRes = config:GetArgValue(StoryArgKeyConst.AudioEvent)

	if string.nilorempty(voiceRes) then
		return false
	end

	local index = shotId
	local historyData = StoryModel.instance:getHistoryByIndex(index)

	if historyData then
		historyData.voice = voiceRes
	else
		historyData = {
			index = index,
			voice = voiceRes
		}

		StoryModel.instance:addHistory(historyData)
	end

	return CriwareAudioFacade.instance:playVoiceByName(voiceRes)
end

return M
