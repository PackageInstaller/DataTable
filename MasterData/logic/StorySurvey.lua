-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/model/StorySurvey.lua

module("logic.extensions.story.model.StorySurvey", package.seeall)

local StorySurvey = class("StorySurvey")
local surveyMap = {
	[3000013] = {
		start = SurveyBehaviorID.STORY_ID_3000013_START,
		finished = SurveyBehaviorID.STORY_ID_3000013_FINISHED
	},
	[3000019] = {
		start = SurveyBehaviorID.STORY_ID_3000019_START,
		finished = SurveyBehaviorID.STORY_ID_3000019_FINISHED
	},
	[3000021] = {
		start = SurveyBehaviorID.STORY_ID_3000021_START,
		finished = SurveyBehaviorID.STORY_ID_3000021_FINISHED
	},
	[3000028] = {
		start = SurveyBehaviorID.STORY_ID_3000028_START,
		finished = SurveyBehaviorID.STORY_ID_3000028_FINISHED
	},
	[3000033] = {
		start = SurveyBehaviorID.STORY_ID_3000033_START,
		finished = SurveyBehaviorID.STORY_ID_3000033_FINISHED
	},
	[3000014] = {
		start = SurveyBehaviorID.STORY_ID_3000014_START,
		finished = SurveyBehaviorID.STORY_ID_3000014_FINISHED
	},
	[3000015] = {
		start = SurveyBehaviorID.STORY_ID_3000014_START,
		finished = SurveyBehaviorID.STORY_ID_3000014_FINISHED
	}
}

function StorySurvey:ctor()
	return
end

function StorySurvey:onStoryPlayStart(storyId)
	local config = surveyMap[storyId]

	if config then
		SurveyController.instance:reportBehavior(config.start)
	end
end

function StorySurvey:onStoryPlayFinished(storyId)
	local config = surveyMap[storyId]

	if config then
		SurveyController.instance:reportBehavior(config.finished)
	end
end

StorySurvey.instance = StorySurvey.New()

return StorySurvey
