-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9HeroGroupFightViewLevel.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9HeroGroupFightViewLevel", package.seeall)

local VersionActivity2_9HeroGroupFightViewLevel = class("VersionActivity2_9HeroGroupFightViewLevel", HeroGroupFightViewLevel)

function VersionActivity2_9HeroGroupFightViewLevel:onInitView()
	VersionActivity2_9HeroGroupFightViewLevel.super.onInitView(self)

	self._gostarcontainer = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer")

	gohelper.setActive(self._gostarcontainer, false)

	self._conditionItemTab = self:getUserDataTb_()
end

function VersionActivity2_9HeroGroupFightViewLevel:_refreshTarget()
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	gohelper.setActive(self._gotargetlist, true)

	local isHardMode = chapterConfig.type == DungeonEnum.ChapterType.Hard

	gohelper.setActive(self._gohardEffect, isHardMode)
	gohelper.setActive(self._gobalanceEffect, HeroGroupBalanceHelper.getIsBalanceMode())

	self._isHardMode = isHardMode

	local allConditionList = {}
	local firstPassConditions = DungeonConfig.instance:getEpisodeWinConditionTextList(self._episodeId)
	local advancePassCondition1 = DungeonConfig.instance:getEpisodeAdvancedConditionText(self._episodeId)
	local advancePassCondition2 = DungeonConfig.instance:getEpisodeAdvancedCondition2Text(self._episodeId)

	tabletool.addValues(allConditionList, firstPassConditions)
	table.insert(allConditionList, advancePassCondition1)
	table.insert(allConditionList, advancePassCondition2)

	if firstPassConditions then
		if not #firstPassConditions then
			local maxFirstConditionIndex = 0

			for index, conditionDesc in ipairs(allConditionList) do
				if not string.nilorempty(conditionDesc) then
					local conditionItem = self:_getOrCreateConditionItem(index)

					conditionItem.txtcondition.text = conditionDesc

					if index <= maxFirstConditionIndex then
						if not DungeonEnum.StarType.Normal then
							local starType = DungeonEnum.StarType.Advanced

							VersionActivity2_9DungeonHelper.setEpisodeTargetProgress(self._episodeId, starType, conditionItem.txtprogress)
							VersionActivity2_9DungeonHelper.setEpisodeProgressIcon(self._episodeId, conditionItem.imageprogress)
							gohelper.setActive(conditionItem.go, true)
						end
					end
				end
			end

			if allConditionList then
				if not #allConditionList then
					local allConditionNum = 0

					if self._conditionItemTab then
						if not #self._conditionItemTab then
							local conditionItemNum = 0

							for i = allConditionNum + 1, conditionItemNum do
								gohelper.setActive(self._conditionItemTab[i].go, false)
							end

							gohelper.setActive(self._gonormalcondition, false)

							local isOnlyShowOneTarget = allConditionNum <= 1

							gohelper.setActive(self._goplace, isOnlyShowOneTarget)
						end
					end
				end
			end
		end
	end
end

function VersionActivity2_9HeroGroupFightViewLevel:_getOrCreateConditionItem(index)
	local conditionItem = self._conditionItemTab[index]

	if not conditionItem then
		conditionItem = self:getUserDataTb_()
		conditionItem.go = gohelper.cloneInPlace(self._gonormalcondition, "condition_" .. index)
		conditionItem.txtcondition = gohelper.findChildText(conditionItem.go, "#txt_normalcondition")
		conditionItem.txtprogress = gohelper.findChildText(conditionItem.go, "star/condition")
		conditionItem.imageprogress = gohelper.findChildImage(conditionItem.go, "star")
		self._conditionItemTab[index] = conditionItem
	end

	return conditionItem
end

return VersionActivity2_9HeroGroupFightViewLevel
