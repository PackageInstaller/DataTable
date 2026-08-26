-- chunkname: @modules/logic/playercard/view/comp/PlayerCardChapter.lua

module("modules.logic.playercard.view.comp.PlayerCardChapter", package.seeall)

local PlayerCardChapter = class("PlayerCardChapter", BasePlayerCardComp)

function PlayerCardChapter:onInitView()
	self.txtChapter = gohelper.findChildTextMesh(self.viewGO, "#txt_chapter")
end

function PlayerCardChapter:addEventListeners()
	return
end

function PlayerCardChapter:removeEventListeners()
	return
end

function PlayerCardChapter:onRefreshView()
	local info = self:getPlayerInfo()
	local episodeId = info.lastEpisodeId
	local episodeConfig = episodeId and lua_episode.configDict[episodeId]

	if episodeConfig then
		local chapterCO = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

		if chapterCO.type == DungeonEnum.ChapterType.Simple then
			episodeConfig = lua_episode.configDict[episodeConfig.normalEpisodeId]
		end

		if episodeConfig then
			self.txtChapter.text = string.format("《%s %s》", DungeonController.getEpisodeName(episodeConfig), episodeConfig.name)
		end
	end
end

function PlayerCardChapter:onDestroy()
	return
end

return PlayerCardChapter
