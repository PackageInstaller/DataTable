-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/PlotChapterViewPresentor.lua

module("logic.extensions.plotcopy.view.PlotChapterViewPresentor", package.seeall)

local PlotChapterViewPresentor = class("PlotChapterViewPresentor", ViewWithGuidePresentor)

function PlotChapterViewPresentor:ctor()
	PlotChapterViewPresentor.super.ctor(self)
end

function PlotChapterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlotChapterViewPresentor:dependWhatResources()
	return {
		"ui/views/plotcopy/chapterview.prefab",
		"ui/views/plotcopy/chapterreward.prefab"
	}
end

function PlotChapterViewPresentor:getTempResources()
	local resultPath = {}

	self._chapterId = self:getFirstParam()

	local cfg = CopyConfig.instance:getChapter(self._chapterId)

	if not cfg then
		return resultPath
	end

	table.insert(resultPath, string.format("ui/bigbg/copychapter/chapterbg/%s.png", cfg.nearBg))
	table.insert(resultPath, string.format("ui/bigbg/copychapter/chapterbg/%s.png", cfg.middleBg))
	table.insert(resultPath, string.format("ui/bigbg/copychapter/chapterbg/%s.png", cfg.farBg))

	local resMap = self:_prepareSpineModelsPath()

	if not resMap then
		return resultPath
	end

	for k, v in pairs(resMap) do
		table.insert(resultPath, k)
	end

	local effPath = self:_prepareEffsPath()

	if effPath then
		table.insert(resultPath, effPath)
	end

	return resultPath
end

function PlotChapterViewPresentor:_prepareEffsPath()
	local stageId = PlotCopyModel.instance:curOpenStageNum(self._chapterId)

	if not stageId or stageId <= 0 then
		return
	end

	local openStageNum = PlotCopyModel.instance:curOpenStageNum(self._chapterId)
	local stageCfgs = CopyConfig.instance:getStages(self._chapterId)

	for i = 1, #stageCfgs do
		local unlockState = PlotCopyModel.instance:getUnlockState(stageCfgs[i].chapterId, stageCfgs[i].stageId)
		local isLock = openStageNum < i or unlockState ~= 0
		local key = RoleModel.instance:getUserId() .. CopyConst.isNewStage .. stageCfgs[i].chapterId .. stageCfgs[i].stageId
		local nameValue = UnityEngine.PlayerPrefs.GetInt(key)
		local isPass = PlotCopyModel.instance:isStagePassed(stageCfgs[i].chapterId, stageCfgs[i].stageId)

		if openStageNum == i and not isLock then
			if nameValue == 0 and not isPass then
				return UIEffectManager.instance:getEffectPath(PlotStageItem.arrowEffectPath)
			end
		end
	end
end

function PlotChapterViewPresentor:_prepareSpineModelsPath()
	local stageId = PlotCopyModel.instance:curOpenStageNum(self._chapterId)

	if not stageId or stageId <= 0 then
		return
	end

	local stageCfgs = CopyConfig.instance:getStages(self._chapterId)
	local num = 4
	local inSightStages = {}

	if num >= #stageCfgs then
		table.merge(inSightStages, stageCfgs)
	else
		table.insert(inSightStages, stageCfgs[stageId])

		local sign = 1

		while num > #inSightStages do
			local preStage = stageId - sign
			local nextStage = stageId + sign

			sign = sign + 1

			if stageCfgs[preStage] then
				table.insert(inSightStages, stageCfgs[preStage])

				if num <= #inSightStages then
					break
				end
			end

			if stageCfgs[nextStage] then
				table.insert(inSightStages, stageCfgs[nextStage])

				if num <= #inSightStages then
					break
				end
			end
		end
	end

	local resMap = {}

	for i = 1, #inSightStages do
		local raceId = inSightStages[i].stageCardRaceId

		if raceId ~= 0 then
			local petCo = CharacterConfig.instance:getPetCo(raceId)

			if petCo then
				local idx, spineUrl = CharacterConfig.instance:GetCharacterResIdx(checknumber(petCo.faceIds), false)

				resMap[spineUrl] = true
			end
		end
	end

	return resMap
end

function PlotChapterViewPresentor:buildViews()
	return {
		PlotChapterView.New(),
		ChapterRewardView.New()
	}
end

return PlotChapterViewPresentor
