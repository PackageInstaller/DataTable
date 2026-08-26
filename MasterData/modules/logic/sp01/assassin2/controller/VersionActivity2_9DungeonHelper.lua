-- chunkname: @modules/logic/sp01/assassin2/controller/VersionActivity2_9DungeonHelper.lua

module("modules.logic.sp01.assassin2.controller.VersionActivity2_9DungeonHelper", package.seeall)

local VersionActivity2_9DungeonHelper = _M

function VersionActivity2_9DungeonHelper.setEpisodeProgressIcon(episodeId, imageComp)
	local mode = VersionActivity2_9DungeonHelper.getEpisodeMode(episodeId)
	local imageName = VersionActivity2_9DungeonEnum.EpisodeMode2Icon[mode]

	UISpriteSetMgr.instance:setV2a9DungeonSprite(imageComp, imageName, true)
end

function VersionActivity2_9DungeonHelper.setEpisodeProgressBg(episodeId, imageComp)
	local mode = VersionActivity2_9DungeonHelper.getEpisodeMode(episodeId)
	local imageName = VersionActivity2_9DungeonEnum.EpisodeMode2Bg[mode]

	UISpriteSetMgr.instance:setV2a9DungeonSprite(imageComp, imageName)
end

function VersionActivity2_9DungeonHelper.getEpisodeMode(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	return (ActivityConfig.instance:getChapterIdMode(episodeCo.chapterId))
end

function VersionActivity2_9DungeonHelper.formatEpisodeProgress(progressVal)
	return string.format("%s%%", progressVal * 100)
end

function VersionActivity2_9DungeonHelper.setEpisodeTargetProgress(episodeId, starType, txtComp)
	local conditionCount = VersionActivity2_9DungeonHelper.getEpisodeConditionCount(episodeId)
	local perProgress = VersionActivity2_9DungeonEnum.EpisodeMaxProgress / conditionCount
	local progress = perProgress * starType

	txtComp.text = VersionActivity2_9DungeonHelper.formatEpisodeProgress(progress)
end

function VersionActivity2_9DungeonHelper.calcEpisodeProgress(episodeId)
	local episodeMo = DungeonModel.instance:getEpisodeInfo(episodeId)

	if episodeMo then
		if not episodeMo.star then
			local star = 0
			local conditionCount = VersionActivity2_9DungeonHelper.getEpisodeConditionCount(episodeId)
			local perProgress = VersionActivity2_9DungeonEnum.EpisodeMaxProgress / conditionCount

			return perProgress * star
		end
	end
end

function VersionActivity2_9DungeonHelper.getEpisodeConditionCount(episodeId)
	local count = 0
	local firstConditionList = DungeonConfig.instance:getEpisodeWinConditionTextList(episodeId)
	local advanceCondition1 = DungeonConfig.instance:getEpisodeAdvancedConditionText(episodeId)
	local advanceCondition2 = DungeonConfig.instance:getEpisodeAdvancedCondition2Text(episodeId)

	if not string.nilorempty(advanceCondition1) then
		count = count + 1
	end

	if not string.nilorempty(advanceCondition2) then
		count = count + 1
	end

	if firstConditionList then
		if not #firstConditionList then
			local firstConditionCount = 0

			count = count + firstConditionCount

			return count
		end
	end
end

function VersionActivity2_9DungeonHelper.getEpisdoeLittleGameType(episodeId)
	VersionActivity2_9DungeonHelper._buildLittleGameEpisodeMap()

	return VersionActivity2_9DungeonHelper._initLittleGameMap and VersionActivity2_9DungeonHelper._initLittleGameMap[episodeId]
end

function VersionActivity2_9DungeonHelper._buildLittleGameEpisodeMap()
	if not VersionActivity2_9DungeonHelper._initLittleGameMap then
		local function initFunc(littleGameType)
			local constId = VersionActivity2_9DungeonEnum.LittleGameType2EpisdoeConstId[littleGameType]
			local episdoeId = AssassinConfig.instance:getAssassinConst(constId, true)

			VersionActivity2_9DungeonHelper._initLittleGameMap = VersionActivity2_9DungeonHelper._initLittleGameMap or {}
			VersionActivity2_9DungeonHelper._initLittleGameMap[episdoeId] = littleGameType
		end

		initFunc(VersionActivity2_9DungeonEnum.LittleGameType.Eye)
		initFunc(VersionActivity2_9DungeonEnum.LittleGameType.Line)
		initFunc(VersionActivity2_9DungeonEnum.LittleGameType.Point)
	end
end

function VersionActivity2_9DungeonHelper.getLittleGameDialogIds(constId)
	local dialogIdStr = AssassinConfig.instance:getAssassinConst(constId)

	return string.splitToNumber(dialogIdStr, "#")
end

function VersionActivity2_9DungeonHelper.loadFightCondition(viewInst, episodeId, goroot)
	local isUseCustomFunc = VersionActivity2_9DungeonHelper._checkIsUseCustomFunc2LoadCondition(episodeId)

	if not isUseCustomFunc then
		return
	end

	VersionActivity2_9DungeonHelper._startLoadFightCondition(viewInst, episodeId, goroot)

	return isUseCustomFunc
end

function VersionActivity2_9DungeonHelper._checkIsUseCustomFunc2LoadCondition(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterCo = DungeonConfig.instance:getChapterCO(episodeCo.chapterId)

	return chapterCo and chapterCo.actId == VersionActivity2_9Enum.ActivityId.Dungeon
end

function VersionActivity2_9DungeonHelper._startLoadFightCondition(viewInst, episodeId, goroot)
	gohelper.setActive(viewInst._goconditionitem, false)

	viewInst._v2a9ConditionList = viewInst._v2a9ConditionList or viewInst:getUserDataTb_()

	local loader = PrefabInstantiate.Create(goroot)
	local resUrl = loader:getPath()

	if string.nilorempty(resUrl) then
		loader:startLoad(VersionActivity2_9DungeonEnum.FightGoalItemResUrl, VersionActivity2_9DungeonHelper._onLoadFightGoalItemDone, viewInst)

		return
	end

	local gotemplate = loader:getInstGO()

	if gohelper.isNil(gotemplate) then
		return
	end

	VersionActivity2_9DungeonHelper._refreshFightConditionList(viewInst, gotemplate)
end

function VersionActivity2_9DungeonHelper._onLoadFightGoalItemDone(viewInst, loader)
	local gotemplate = loader:getInstGO()

	gohelper.setActive(gotemplate, false)
	VersionActivity2_9DungeonHelper._refreshFightConditionList(viewInst, gotemplate)
end

function VersionActivity2_9DungeonHelper._refreshFightConditionList(viewInst, gotemplate)
	local conditionGoList = viewInst and viewInst._v2a9ConditionList
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local allConditionTxtList = {}
	local winConditionTxtList = DungeonConfig.instance:getEpisodeWinConditionTextList(episodeId)

	tabletool.addValues(allConditionTxtList, winConditionTxtList)
	table.insert(allConditionTxtList, DungeonConfig.instance:getEpisodeAdvancedConditionText(episodeId))
	table.insert(allConditionTxtList, DungeonConfig.instance:getEpisodeAdvancedCondition2Text(episodeId))

	if winConditionTxtList then
		if not #winConditionTxtList then
			local winConditionNum = 0
			local index = 0

			for _, conditionTxt in ipairs(allConditionTxtList) do
				if not string.nilorempty(conditionTxt) then
					index = index + 1

					local gocondition = conditionGoList[index]

					if not gocondition then
						gocondition = gohelper.cloneInPlace(gotemplate, "condition_" .. index)
						conditionGoList[index] = gocondition
					end

					local light = false
					local starType = DungeonEnum.StarType.Normal
					local isAdvanceCondition = winConditionNum < index

					if isAdvanceCondition then
						local conditionId = DungeonConfig.instance:getEpisodeAdvancedCondition2(episodeId, index - winConditionNum)

						light = viewInst:checkPlatCondition(conditionId)
						starType = DungeonEnum.StarType.Advanced
					end

					VersionActivity2_9DungeonHelper._refreshSingleFightCondition(episodeId, starType, gocondition, conditionTxt, light)
				end
			end

			for i = index + 1, #conditionGoList do
				gohelper.setActive(conditionGoList[i], false)
			end
		end
	end
end

function VersionActivity2_9DungeonHelper._refreshSingleFightCondition(episdoeId, starType, gocondition, conditionTxt, light)
	gohelper.setActive(gocondition, true)

	local imagestar = gohelper.findChildImage(gocondition, "star")
	local txtcondition = gohelper.findChildText(gocondition, "condition")
	local txtprogress = gohelper.findChildText(gocondition, "progress")
	local gofinish = gohelper.findChild(gocondition, "condition/image_gou")

	txtcondition.text = conditionTxt

	gohelper.setActive(gofinish, light)
	VersionActivity2_9DungeonHelper.setEpisodeProgressIcon(episdoeId, imagestar)
	VersionActivity2_9DungeonHelper.setEpisodeTargetProgress(episdoeId, starType, txtprogress)
end

function VersionActivity2_9DungeonHelper.isTargetActEpisode(episodeId, actId)
	if not episodeId or not actId then
		return
	end

	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCO then
		return
	end

	local chapterId = episodeCO.chapterId
	local chapterCO = DungeonConfig.instance:getChapterCO(chapterId)

	if not chapterCO then
		return
	end

	return chapterCO.actId == actId
end

function VersionActivity2_9DungeonHelper.getEpisodeAfterStoryId(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		return
	end

	if episodeCo.afterStory ~= 0 then
		return episodeCo.afterStory
	end

	local littleGameType = VersionActivity2_9DungeonHelper.getEpisdoeLittleGameType(episodeId)

	if not littleGameType then
		return
	end

	local storyConstId = VersionActivity2_9DungeonEnum.LittleGameType2AfterStoryConstId[littleGameType]

	if not storyConstId then
		return
	end

	return AssassinConfig.instance:getAssassinConst(storyConstId, true)
end

function VersionActivity2_9DungeonHelper.isAttachedEpisode(episdoeId)
	if not episdoeId then
		return
	end

	if not VersionActivity2_9DungeonHelper._attachedEpisodeIdMap then
		local attachedEpisodeIdStr = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.AttachedEpisodeIds)
		local attachedEpisodeIdList = string.splitToNumber(attachedEpisodeIdStr, "#")

		VersionActivity2_9DungeonHelper._attachedEpisodeIdMap = {}

		for _, attachedEpisodeId in ipairs(attachedEpisodeIdList or {}) do
			VersionActivity2_9DungeonHelper._attachedEpisodeIdMap[attachedEpisodeId] = true
		end
	end

	return VersionActivity2_9DungeonHelper._attachedEpisodeIdMap and VersionActivity2_9DungeonHelper._attachedEpisodeIdMap[episdoeId]
end

function VersionActivity2_9DungeonHelper.isAllEpisodeAdvacePass(chapterId)
	local episodeCoList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	for _, episodeCo in ipairs(episodeCoList) do
		local episodeId = episodeCo.id

		if not DungeonModel.instance:hasPassLevelAndStory(episodeId) then
			return
		end

		local advanceConditionStr = DungeonConfig.instance:getEpisodeAdvancedCondition(episodeId)

		if not string.nilorempty(advanceConditionStr) then
			local episodeMo = DungeonModel.instance:getEpisodeInfo(episodeId)

			if not episodeMo or episodeMo.star < DungeonEnum.StarType.Advanced then
				return
			end
		end
	end

	return true
end

return VersionActivity2_9DungeonHelper
