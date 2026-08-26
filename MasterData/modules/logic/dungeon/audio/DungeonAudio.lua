-- chunkname: @modules/logic/dungeon/audio/DungeonAudio.lua

module("modules.logic.dungeon.audio.DungeonAudio", package.seeall)

local DungeonAudio = class("DungeonAudio")
local audioConfig = {
	[DungeonEnum.ChapterListType.Story] = {
		changeCategory = AudioEnum.UI.UI_checkpoint_story_Click,
		openChapter = AudioEnum.UI.UI_checkpoint_story_open,
		closeChapter = AudioEnum.UI.UI_checkpoint_story_close,
		chapterListBoundary = AudioEnum.UI.UI_checkpoint_story_rebound,
		cardPass = AudioEnum2_8.MainStory.play_ui_checkpoint_chain
	},
	[DungeonEnum.ChapterListType.Resource] = {
		changeCategory = AudioEnum.UI.UI_checkpoint_resources_Click,
		openChapter = AudioEnum.UI.UI_checkpoint_resources_open,
		closeChapter = AudioEnum.UI.UI_checkpoint_resources_close,
		chapterListBoundary = AudioEnum.UI.UI_checkpoint_resources_rebound,
		cardPass = AudioEnum.UI.UI_checkpoint_resources_cardpass
	},
	[DungeonEnum.ChapterListType.Insight] = {
		changeCategory = AudioEnum.UI.UI_checkpoint_Insight_Click,
		openChapter = AudioEnum.UI.UI_checkpoint_Insight_open,
		closeChapter = AudioEnum.UI.UI_checkpoint_Insight_close,
		chapterListBoundary = AudioEnum.UI.UI_checkpoint_Insight_rebound,
		cardPass = AudioEnum.UI.UI_checkpoint_Insight_cardpass
	},
	[DungeonEnum.ChapterListType.WeekWalk] = {
		changeCategory = AudioEnum.UI.UI_checkpoint_Insight_Click,
		openChapter = AudioEnum.UI.UI_checkpoint_Insight_open,
		closeChapter = AudioEnum.UI.UI_checkpoint_Insight_close,
		chapterListBoundary = AudioEnum.UI.UI_checkpoint_Insight_rebound,
		cardPass = AudioEnum.UI.UI_checkpoint_Insight_cardpass
	}
}

function DungeonAudio:_trigger(key)
	local type = self:getChapterListType()

	if audioConfig[type] then
		if audioConfig[type] then
			AudioMgr.instance:trigger(audioConfig[type])
		end
	end
end

function DungeonAudio:changeCategory()
	self:_trigger("changeCategory")
end

function DungeonAudio:openChapter()
	self:_trigger("openChapter")
end

function DungeonAudio:closeChapter()
	self:_trigger("closeChapter")
end

function DungeonAudio:openChapterAmbientSound()
	local id = self:getChapterAmbientMusic()

	if id <= 0 then
		return
	end

	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.DungeonAmbientSound, id, AudioEnum.UI.stop_ui_noise_allarea)
	AudioMgr.instance:trigger(id)
end

function DungeonAudio:closeChapterAmbientSound(chapterId)
	local id = self:getChapterAmbientMusic(chapterId)

	if id <= 0 then
		return
	end

	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.DungeonAmbientSound, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
end

function DungeonAudio:chapterListBoundary()
	self:_trigger("chapterListBoundary")
end

function DungeonAudio:cardPass()
	self:_trigger("cardPass")
end

function DungeonAudio:getChapterListType()
	local isNormalType, isResourceType, isBreakType, isWeekWalkType = DungeonModel.instance:getChapterListTypes()

	if isNormalType then
		return DungeonEnum.ChapterListType.Story
	end

	if isResourceType then
		return DungeonEnum.ChapterListType.Resource
	end

	if isBreakType then
		return DungeonEnum.ChapterListType.Insight
	end

	if isWeekWalkType then
		return DungeonEnum.ChapterListType.WeekWalk
	end
end

function DungeonAudio:getChapterAmbientMusic(chapterId)
	local co = DungeonConfig.instance:getChapterCO(chapterId or DungeonModel.instance.curLookChapterId)

	return (co or nil) and (co.ambientMusic or 0)
end

DungeonAudio.instance = DungeonAudio.New()

return DungeonAudio
