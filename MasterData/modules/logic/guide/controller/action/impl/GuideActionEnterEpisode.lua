-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionEnterEpisode.lua

module("modules.logic.guide.controller.action.impl.GuideActionEnterEpisode", package.seeall)

local GuideActionEnterEpisode = class("GuideActionEnterEpisode", BaseGuideAction)

function GuideActionEnterEpisode:onStart(context)
	GuideActionEnterEpisode.super.onStart(self, context)

	local temp = string.splitToNumber(self.actionParam, "#")
	local episodeId = temp[1]
	local showSettlement = temp[2]
	local episodeCO = episodeId and lua_episode.configDict[episodeId]

	if episodeCO then
		local chapterCO = DungeonConfig.instance:getChapterCO(episodeCO.chapterId)

		if chapterCO.type == DungeonEnum.ChapterType.Newbie then
			DungeonFightController.instance:enterNewbieFight(episodeCO.chapterId, episodeId)
		else
			DungeonFightController.instance:enterFight(episodeCO.chapterId, episodeId, nil)
		end

		local fightParam = FightModel.instance:getFightParam()

		if showSettlement == 0 then
			fightParam:setShowSettlement(false)
		end

		self:onDone(true)
	else
		logError("Guide episode id nil, guide_" .. self.guideId .. "_" .. self.stepId)
		self:onDone(false)
	end
end

return GuideActionEnterEpisode
