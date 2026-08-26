-- chunkname: @modules/logic/jump/config/JumpConfig.lua

module("modules.logic.jump.config.JumpConfig", package.seeall)

local JumpConfig = class("JumpConfig", BaseConfig)

function JumpConfig:ctor()
	self._jumpConfig = nil
end

function JumpConfig:reqConfigNames()
	return {
		"jump"
	}
end

function JumpConfig:onConfigLoaded(configName, configTable)
	if configName == "jump" then
		self._jumpConfig = configTable
	end
end

function JumpConfig:getJumpConfig(jumpId)
	jumpId = tonumber(jumpId)

	if not jumpId or jumpId == 0 then
		logError("jumpId为空")

		return nil
	end

	local config = self._jumpConfig.configDict[jumpId]

	if not config then
		logError("没有找到跳转配置, jumpId: " .. tostring(jumpId))
	end

	return config
end

function JumpConfig:getJumpName(jumpId, replaceColor)
	local config = self:getJumpConfig(jumpId)

	if config then
		local jumpParam = config.param

		if string.nilorempty(jumpParam) then
			logError("跳转参数为空")

			return ""
		end

		local color = replaceColor or "#3f485f"
		local jumps = string.split(jumpParam, "#")
		local jumpView = tonumber(jumps[1])

		if jumpView == JumpEnum.JumpView.DungeonViewWithEpisode then
			local episodeId = tonumber(jumps[2])

			return self:getEpisodeNameAndIndex(episodeId)
		elseif jumpView == JumpEnum.JumpView.DungeonViewWithChapter then
			local chapterId = tonumber(jumps[2])
			local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

			if chapterConfig then
				return string.format("<color=%s><size=32>%s</size></color>", color, config.name), ""
			end
		else
			return string.format("<color=%s><size=32>%s</size></color>", color, config.name) or ""
		end

		logError("跳转参数错误: " .. jumpParam)

		return ""
	end

	return ""
end

function JumpConfig:getEpisodeNameAndIndex(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	if chapterConfig and chapterConfig.type == DungeonEnum.ChapterType.Hard then
		episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
		chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
	end

	if episodeConfig and chapterConfig then
		local episodeIndex, type = DungeonConfig.instance:getChapterEpisodeIndexWithSP(chapterConfig.id, episodeConfig.id)

		return string.format("<color=#3f485f><size=32>%s</size></color>", episodeConfig.name), string.format("%s-%s", (type == DungeonEnum.EpisodeType.Sp or nil) and "SP", episodeIndex)
	end
end

function JumpConfig:getJumpEpisodeId(jumpId)
	local jumpConfig = self:getJumpConfig(jumpId)
	local jumpParam = jumpConfig.param
	local jumps = string.split(jumpParam, "#")
	local jumpView = tonumber(jumps[1])

	if jumpView == JumpEnum.JumpView.DungeonViewWithEpisode then
		return tonumber(jumps[2])
	end
end

function JumpConfig:getJumpView(jumpId)
	if not jumpId then
		return nil
	end

	local jumpConfig = self:getJumpConfig(jumpId)
	local jumpParam = jumpConfig.param
	local jumps = string.split(jumpParam, "#")

	return tonumber(jumps[1])
end

function JumpConfig:isJumpHardDungeon(episodeId)
	if episodeId then
		::label_9_0::

		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

		if episodeConfig then
			::label_9_1::

			local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

			return chapterConfig and chapterConfig.type == DungeonEnum.ChapterType.Hard
		end
	end
end

function JumpConfig:isOpenJumpId(jumpId)
	if VersionValidator.instance:isInReviewing() ~= true then
		return true
	end

	local jumpConfig = self:getJumpConfig(jumpId)
	local jumpParam = jumpConfig.param
	local jumps = string.split(jumpParam, "#")
	local jumpView = tonumber(jumps[1])

	if jumpView == JumpEnum.JumpView.DungeonViewWithEpisode then
		local episodeId = tonumber(jumps[2])

		if episodeId then
			::label_10_0::

			local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

			if episodeConfig then
				return ResSplitConfig.instance:isSaveChapter(episodeConfig.chapterId)
			end
		end
	elseif jumpView == JumpEnum.JumpView.NoticeView then
		return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Notice)
	end

	return true
end

JumpConfig.instance = JumpConfig.New()

return JumpConfig
