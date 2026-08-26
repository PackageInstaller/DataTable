-- chunkname: @modules/logic/ressplit/work/ResSplitStoryWork.lua

module("modules.logic.ressplit.work.ResSplitStoryWork", package.seeall)

local ResSplitStoryWork = class("ResSplitStoryWork", BaseWork)

function ResSplitStoryWork:onStart(context)
	self._arr = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.AssetRootDir .. "/configs/story/steps/")

	self:_buildGuideStory()

	self._storyIndex = -1
	self._storyCount = self._arr.Length

	self:_dealStory()
end

function ResSplitStoryWork:_test()
	local excludeSinglebgDicList = {}
	local allUISinglebgDic = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.AssetRootDir .. "/singlebg/storybg/")
	local excludeDic = ResSplitModel.instance:getExcludeDic(ResSplitEnum.Path)
	local gcList = HandbookConfig.instance:getCGList()

	for i, cgConfig in pairs(gcList) do
		local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

		if bgZoneMo ~= nil then
			ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getStoryRes(bgZoneMo.path), true)
			ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getStoryRes(bgZoneMo.sourcePath), true)
		end
	end

	local storyGroupList = HandbookConfig.instance:getStoryGroupList()

	for i, config in pairs(storyGroupList) do
		local path = ResUrl.getStorySmallBg(config.image)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, path, true)
	end

	for i = 0, allUISinglebgDic.Length - 1 do
		local path = allUISinglebgDic[i]

		if not string.find(path, ".meta") then
			path = SLFramework.FileHelper.GetUnityPath(path)

			local p = string.gsub(path, "D:/work/projm%-client/Unity/Assets/ZResourcesLib/", "")

			if not excludeDic[p] then
				table.insert(excludeSinglebgDicList, p)
			end
		end
	end

	local resultJson = cjson.encode(excludeSinglebgDicList)

	resultJson = string.gsub(resultJson, "\\/", "/")

	local file = io.open("Assets/ZResourcesLib/configs/ressplit2.json", "w")

	file:write(tostring(resultJson))
	file:close()
	self:onDone(true)
end

function ResSplitStoryWork:_dealStory()
	self._storyIndex = self._storyIndex + 1

	if self._storyIndex >= self._storyCount then
		self:onDone(true)

		return
	end

	local path = self._arr[self._storyIndex]

	if not string.find(path, ".meta") then
		local fileName = SLFramework.FileHelper.GetFileName(path, false)

		self._storyId = string.gsub(fileName, "json_story_step_", "")
		self._storyId = tonumber(self._storyId)

		if self._storyId ~= nil and self._storyId > 1000 then
			StoryController.instance:initStoryData(self._storyId, self._addStoryRes, self)
		else
			self:_dealStory()
		end
	else
		self:_dealStory()
	end
end

function ResSplitStoryWork:_buildGuideStory()
	local guideList = ResSplitModel.instance:getIncludeGuide()

	if tabletool.len(guideList) > 0 then
		for id, _ in pairs(guideList) do
			local stepList = GuideConfig.instance:getStepList(id)

			self:_buildGuideStory2(stepList)
		end
	else
		guideList = GuideConfig.instance:getGuideList()

		for _, guideCO in pairs(guideList) do
			local stepList = GuideConfig.instance:getStepList(guideCO.id)

			self:_buildGuideStory2(stepList)
		end
	end
end

function ResSplitStoryWork:_buildGuideStory2(stepList)
	for stepId, stepCO in pairs(stepList) do
		if not string.nilorempty(stepCO.action) then
			local actionStrs = string.split(stepCO.action, "|")

			for i = 1, #actionStrs do
				local index, _ = string.find(actionStrs[i], "#")
				local actionType, actionParam

				if index then
					actionType = tonumber(string.sub(actionStrs[i], 1, index - 1))
					actionParam = string.sub(actionStrs[i], index + 1)
				else
					actionType = tonumber(actionStrs[i]) or actionStrs[i]
				end

				if actionType == 101 then
					local storyIds = string.splitToNumber(actionParam, "#")

					for _, storyId in ipairs(storyIds) do
						ResSplitModel.instance:addIncludeStory(storyId)
					end
				end
			end
		end
	end
end

function ResSplitStoryWork:_addStoryRes()
	local storyId = self._storyId
	local exclude = not not ResSplitModel.instance:isExcludeStoryId(storyId)
	local path
	local stepList = StoryStepModel.instance:getStepList()

	for i, storyStepMo in ipairs(stepList) do
		path = ResUrl.getStoryBg(storyStepMo.bg.bgImg)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, path, exclude)

		local zoneMo = StoryBgZoneModel.instance:getBgZoneByPath(storyStepMo.bg.bgImg)

		if zoneMo then
			path = ResUrl.getStoryRes(zoneMo.sourcePath)

			ResSplitModel.instance:setExclude(ResSplitEnum.Path, path, exclude)
		end

		for _, StoryStepVideoMo in pairs(storyStepMo.videoList) do
			local videoArgs = string.split(StoryStepVideoMo.video, ".")
			local _videoName = videoArgs[1]

			ResSplitModel.instance:setExclude(ResSplitEnum.Video, _videoName, exclude)
		end

		for _, audio in pairs(storyStepMo.conversation.audios) do
			local audioInfo = ResSplitModel.instance.audioDic[audio]

			if audioInfo then
				ResSplitModel.instance:setExclude(ResSplitEnum.AudioBank, audioInfo.bankName, exclude)
			end
		end

		for _, audio in pairs(storyStepMo.audioList) do
			local audioInfo = ResSplitModel.instance.audioDic[audio.audio]

			if audioInfo then
				ResSplitModel.instance:setExclude(ResSplitEnum.AudioBank, audioInfo.bankName, exclude)
			end
		end

		path = string.format("singlebg/headicon_small/%s", storyStepMo.conversation.heroIcon)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, path, exclude)

		for _, storyStepPictureMo in pairs(storyStepMo.picList) do
			path = ResUrl.getStoryItem(storyStepPictureMo.picture)

			ResSplitModel.instance:setExclude(ResSplitEnum.Path, path, exclude)
		end

		for _, storyStepHeroMo in pairs(storyStepMo.heroList) do
			local heroCo = StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(storyStepHeroMo.heroIndex)

			if heroCo then
				path = heroCo.type == 0 and string.format("rolesstory/%s", heroCo.prefab) or string.format("live2d/roles/%s", heroCo.live2dPrefab)

				if heroCo.type == 0 and heroCo.prefab == "" then
					logError("rolesstory is nil", storyId, storyStepHeroMo.heroIndex)
				elseif heroCo.type ~= 0 and heroCo.live2dPrefab == "" then
					logError("live2dPrefab is nil", storyId, storyStepHeroMo.heroIndex)
				else
					local fileName = SLFramework.FileHelper.GetFileName(path, true)

					if heroCo.type == 0 then
						path = string.gsub(path, "/" .. fileName, "")

						ResSplitModel.instance:setExclude(ResSplitEnum.Path, path, exclude)
					else
						path = string.gsub(path, fileName, "")

						ResSplitModel.instance:setExclude(ResSplitEnum.Folder, path, exclude)
					end
				end
			end
		end
	end

	self:_dealStory()
end

return ResSplitStoryWork
