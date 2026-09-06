-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/facade/StoryFacade.lua

module("logic.extensions.story.facade.StoryFacade", package.seeall)

local StoryFacade = class("StoryFacade", BaseFacade)

StoryFacade.battleCgStoryId = 3030001
StoryFacade.battleCgStartStoryId = 3010927

function StoryFacade:parseGenderStory(storyId)
	local gender = RoleModel.instance:getGender()

	if storyId == 3000014 or storyId == 3000015 then
		if gender == GameEnum.Gender.Female then
			return 3000014
		end

		return 3000015
	end

	return storyId
end

function StoryFacade:getBattleStoryConfig(eveA, eveB)
	if BattleModel.instance.isPlayingCgBattle then
		return {
			round = 1,
			storyId = StoryFacade.battleCgStartStoryId,
			mode = TaskConst.BattleStoryTrigger_Round
		}
	end

	local battleStoryStory = StoryModel.instance:getBattleStory()

	if not battleStoryStory then
		return
	end

	local battleStory = battleStoryStory:getCurrStory()

	if not battleStory then
		return
	end

	if (eveA == battleStory.battle[1] and eveB == battleStory.battle[2] or eveB == battleStory.battle[2] and eveA == battleStory.battle[1]) and battleStory.battleStoryId and battleStory.battleStoryId > 0 then
		return {
			round = 1,
			storyId = battleStory.battleStoryId,
			mode = TaskConst.BattleStoryTrigger_Round
		}
	end
end

function StoryFacade:getBattleRoundConfig(round)
	if round == 2 and BattleModel.instance.isPlayingCgBattle then
		return StoryFacade.battleCgStoryId
	end
end

function StoryFacade:getBattleResultStoryConfig(eveA, eveB)
	if BattleModel.instance.isPlayingCgBattle then
		-- block empty
	end

	local battleStoryStory = StoryModel.instance:getBattleStory()

	if not battleStoryStory then
		return
	end

	local battleStory = battleStoryStory:getCurrStory()

	if not battleStory then
		return
	end

	if (eveA == battleStory.battle[1] and eveB == battleStory.battle[2] or eveB == battleStory.battle[2] and eveA == battleStory.battle[1]) and battleStory.battleResStoryId and battleStory.battleResStoryId > 0 then
		return {
			storyId = battleStory.battleResStoryId,
			mode = TaskConst.BattleStoryTrigger_End
		}
	end
end

StoryFacade.instance = StoryFacade.New()

return StoryFacade
