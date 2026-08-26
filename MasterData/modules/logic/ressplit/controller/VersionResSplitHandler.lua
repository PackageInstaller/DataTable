-- chunkname: @modules/logic/ressplit/controller/VersionResSplitHandler.lua

module("modules.logic.ressplit.controller.VersionResSplitHandler", package.seeall)

local VersionResType = ResSplitEnum.VersionResEnum
local VersionResSplitHandler = class("VersionResSplitHandler")
local _GameCfgResWhiteList = {
	{
		resKey = "image",
		format = "singlebg/storybg/%s",
		luaName = "lua_cg"
	}
}

function VersionResSplitHandler:generateResSplitCfg()
	self:_InitMapElementData()
	self:_InitAudioCfg()
	self:_InitAudioInfoXml()
	self:_InitGuideCfg()
	self:_InitStoryCfg()
	self:_initRunWork()
	self:_getPartyGameCfg()
	self._loadAllStoryCfg(self, self._generateResSplitCfg, self)
end

function VersionResSplitHandler:_initRunWork()
	self._auidoWhiteWork = VersionResSpiltAudioWhiteWork.New()

	local flow = FlowSequence.New()

	flow:addWork(self._auidoWhiteWork)
	flow:start(self)
end

function VersionResSplitHandler:_generateResSplitCfg()
	local configDict = lua_version_res_split.configDict
	local versionResSplitCfgs = {}

	for versionId, resSplitCfg in pairs(configDict) do
		if resSplitCfg.ignore ~= 1 then
			versionResSplitCfgs[versionId] = resSplitCfg
		end
	end

	self._resSplitResult = {}
	self._versionSplitData = {}
	self._allVersionSplitPathMap = {}

	local versionResChapters = {}
	local versionResUIPrefabs = {}
	local versionResStoryIds = {}

	for versionId, resSplitCfg in pairs(versionResSplitCfgs) do
		local chapterIdList = resSplitCfg.chapter

		for _, chapterId in ipairs(chapterIdList) do
			versionResChapters[chapterId] = true
		end

		local uiFolders = resSplitCfg.uiFolder

		for _, folder in ipairs(uiFolders) do
			local prefabs = VersionResSplitHandler._getFolderPrefabs(folder)

			for _, prefabPath in ipairs(prefabs) do
				versionResUIPrefabs[prefabPath] = true
			end
		end

		local storyList = resSplitCfg.story

		for _, storyId in ipairs(storyList) do
			versionResStoryIds[storyId] = true
		end
	end

	for chapterId, _ in pairs(versionResChapters) do
		local chapterEpisodeCfgList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

		if chapterEpisodeCfgList then
			for episodeId, episodecfg in ipairs(chapterEpisodeCfgList) do
				local beforeStoryId = episodecfg.beforeStory

				if beforeStoryId ~= 0 then
					versionResStoryIds[beforeStoryId] = true
				end

				local sp = string.split(episodecfg.story, "#")

				if #sp == 3 then
					local storyId = tonumber(sp[3])

					versionResStoryIds[storyId] = true
				end

				local afterStoryId = episodecfg.afterStory

				if afterStoryId ~= 0 then
					versionResStoryIds[afterStoryId] = true
				end
			end
		end
	end

	local baseResSplitData = VersionResSplitData.New()

	baseResSplitData:init(0)

	local chapterListCfg = lua_chapter.configList

	for chapterId, chapterCfg in ipairs(chapterListCfg) do
		if not versionResChapters[chapterId] then
			self:_fillSceneResByChatper(chapterId, baseResSplitData)
		end
	end

	local uiFolders = "ui"
	local allUIPrefabs = VersionResSplitHandler._getFolderPrefabs(uiFolders)

	for _, uiPrefabPath in ipairs(allUIPrefabs) do
		if not versionResUIPrefabs[uiPrefabPath] then
			self:_fillUIRes(uiPrefabPath, baseResSplitData)
		end
	end

	for _, storyId in ipairs(self._allStoryIds) do
		if not versionResStoryIds[storyId] then
			self:_fillStoryRes(storyId, baseResSplitData)
		end
	end

	for versionId, resSplitCfg in pairs(versionResSplitCfgs) do
		local versionResSplitData = VersionResSplitData.New()

		versionResSplitData:init(versionId)

		self._versionSplitData[versionId] = versionResSplitData

		local chapterIdList = resSplitCfg.chapter

		for _, chapterId in ipairs(chapterIdList) do
			self:_fillSceneResByChatper(chapterId, versionResSplitData)
			self:_fillStoryResByChatper(chapterId, versionResSplitData)
		end

		local audioList = resSplitCfg.audio

		for _, audioId in ipairs(audioList) do
			self:_fillAudioResByAudioId(audioId, versionResSplitData)
		end

		local guideList = resSplitCfg.guide

		for _, guideId in ipairs(guideList) do
			self:_fillResByGuideId(guideId, versionResSplitData)
		end

		local storyList = resSplitCfg.story

		for _, storyId in ipairs(storyList) do
			self:_fillStoryRes(storyId, versionResSplitData)
		end

		local uiFolders = resSplitCfg.uiFolder

		for _, folder in ipairs(uiFolders) do
			folder = string.gsub(folder, SLFramework.FrameworkSettings.ResourcesLibName .. "/", "")

			local uiPrefabPaths = VersionResSplitHandler._getFolderPrefabs(folder)

			for _, path in ipairs(uiPrefabPaths) do
				self:_fillUIRes(path, versionResSplitData)
			end
		end

		local folderList = resSplitCfg.folderPath

		for _, folderPath in ipairs(folderList) do
			versionResSplitData:addResSplitInfo(ResSplitEnum.Folder, VersionResType.SingleFolder, folderPath)
		end

		local fileList = resSplitCfg.path

		for _, filePath in ipairs(fileList) do
			versionResSplitData:addResSplitInfo(ResSplitEnum.Path, VersionResType.SingleFile, filePath)
		end

		if not resSplitCfg.videoPath then
			local fileList = {}

			for _, filePath in ipairs(fileList) do
				versionResSplitData:addResSplitInfo(ResSplitEnum.Video, VersionResType.SingleFile, filePath)
			end

			local versionAllRes = versionResSplitData:getAllResDict()

			for splitType, pathMap in pairs(versionAllRes) do
				for path, value in pairs(pathMap) do
					if baseResSplitData:checkResSplitInfo(splitType, path) then
						versionResSplitData:deleteResSplitInfo(splitType, nil, path)
					end
				end
			end

			local allTypeResDict = versionResSplitData:getAllResTypeDict()

			for resType, pathMap in pairs(allTypeResDict) do
				for path, value in pairs(pathMap) do
					if baseResSplitData:checkResTypeSplitInfo(resType, path) then
						versionResSplitData:deleteResSplitInfo(nil, resType, path)
					end
				end
			end
		end
	end

	for versionId, splitData in pairs(self._versionSplitData) do
		local allResDict = splitData:getAllResDict()

		for splitType, resPathMap in pairs(allResDict) do
			for path, value in pairs(resPathMap) do
				if value then
					if self._allVersionSplitPathMap[path] then
						logWarn("存在于多个版本分包中的资源： " .. path)
					else
						self._allVersionSplitPathMap[path] = true
					end
				end
			end
		end
	end

	self:_ExportSplitResult()
end

function VersionResSplitHandler:_mergeSplitResult()
	local versionResSplitCfgs = lua_version_res_split.configDict
	local mergeResult = {}

	for versionId, splitData in pairs(self._versionSplitData) do
		if not versionResSplitCfgs[versionId] then
			local resCfg = versionResSplitCfgs[tonumber(versionId)]

			if versionResSplitCfgs[versionId] then
				if not versionResSplitCfgs[versionId].packName then
					local packName = "opveract"

					mergeResult[packName] = mergeResult[packName] or {}

					local resPackMap = mergeResult[packName]
					local vrsDataMap = splitData:getResSplitMap()

					for key, list in pairs(vrsDataMap) do
						resPackMap[key] = resPackMap[key] or {}

						tabletool.addValues(resPackMap[key], list)
					end
				end
			end
		end
	end

	local resWhiteDict = self:_getResWhiteListDict()
	local bankNameWhiteDic = self._auidoWhiteWork.bankNameWhiteDic
	local wenNameWhiteDic = self._auidoWhiteWork.wenNameWhiteDic

	for packName, packageMap in pairs(mergeResult) do
		for resType, resPathList in pairs(packageMap) do
			self:_checkResWhiteList(resPathList, resWhiteDict)
		end

		if packageMap.audioBank then
			self:_checkResWhiteList(packageMap.audioBank, bankNameWhiteDic)
		end

		if packageMap.audioWem then
			self:_checkResWhiteList(packageMap.audioWem, wenNameWhiteDic)
		end
	end

	for packName, packageMap in pairs(mergeResult) do
		for resType, resPathList in pairs(packageMap) do
			self:_removeSameResPathList(resPathList)
		end
	end

	return mergeResult
end

function VersionResSplitHandler:_checkSingleBgAb(pathList, singlebgMapList)
	local singleMap = {}

	for i = #pathList, 1, -1 do
		local path = pathList[i]

		if string.find(path, "singlebg") then
			local fullPath = string.format("Assets/ZResourcesLib/%s", string.gsub(path, "\\/", "/"))

			table.remove(pathList, i)

			singleMap[fullPath] = path
		end
	end

	local insertFlag = {}

	for abName, resList in pairs(singlebgMapList) do
		local isAllIn = true

		for _, resPath in ipairs(resList) do
			if not singleMap[resPath] then
				isAllIn = false
			elseif insertFlag[resPath] == nil then
				insertFlag[resPath] = false
			end
		end

		if isAllIn then
			for _, resPath in ipairs(resList) do
				if not insertFlag[resPath] then
					insertFlag[resPath] = true

					table.insert(pathList, singleMap[resPath])
				end
			end
		end
	end

	for fullPath, path in pairs(singleMap) do
		if insertFlag[fullPath] == nil then
			insertFlag[fullPath] = true

			table.insert(pathList, path)
		end
	end
end

function VersionResSplitHandler:_getResWhiteListDict()
	local file = io.open(ResSplitEnum.VersionResWhiteListPath, "r")
	local whiteListStr = file:read("*a")

	file:close()

	whiteListStr = string.gsub(whiteListStr, "\\/", "/")

	local whiteList = cjson.decode(whiteListStr)
	local resWhiteDict = {}

	if whiteList and #whiteList > 0 then
		for _, resPath in ipairs(whiteList) do
			resWhiteDict[resPath] = true
		end
	end

	local whiteCfgList = _GameCfgResWhiteList

	for i = 1, #whiteCfgList do
		local whiteCfg = whiteCfgList[i]
		local tempLua = _G[whiteCfg.luaName]

		if tempLua and tempLua.configList then
			local cfgList = tempLua.configList

			for _, cfg in ipairs(cfgList) do
				local res = cfg[whiteCfg.resKey]

				if not string.nilorempty(res) then
					local resPath = string.format(whiteCfg.format, cfg[whiteCfg.resKey])

					resWhiteDict[resPath] = true
				end
			end
		end
	end

	for i = 0, self._partyGameAssets.Length - 1 do
		local filePath = self._partyGameAssets[i]

		resWhiteDict[filePath] = true
	end

	return resWhiteDict
end

function VersionResSplitHandler:_checkResWhiteList(pathList, resWhiteDict)
	if pathList and #pathList > 0 and resWhiteDict then
		for i = #pathList, 1, -1 do
			if resWhiteDict[pathList[i]] then
				table.remove(pathList, i)
			end
		end
	end
end

function VersionResSplitHandler:_removeSameResPathList(resPathList)
	if resPathList and #resPathList > 0 then
		local reaPathMap = {}
		local count = #resPathList

		for i = count, 1, -1 do
			local resPath = resPathList[i]

			if reaPathMap[resPath] then
				table.remove(resPathList, i)
			else
				reaPathMap[resPath] = true
			end
		end
	end
end

function VersionResSplitHandler:_ExportSplitResult()
	local resultJson = cjson.encode(self:_mergeSplitResult())

	resultJson = string.gsub(resultJson, "\\/", "/")

	local file = io.open(ResSplitEnum.VersionResSplitCfgPath, "w")

	file:write(tostring(resultJson))
	file:close()

	local resSplitDebugResult = {}

	for versionId, resSplitData in pairs(self._versionSplitData) do
		resSplitDebugResult[tostring(versionId)] = self._versionSplitData[versionId]:getResTypeSplitMap()
	end

	local debugResultJson = cjson.encode(resSplitDebugResult)

	debugResultJson = string.gsub(debugResultJson, "\\/", "/")

	local fullPath = string.format("%s/../versionressplitdebug.json", UnityEngine.Application.dataPath)
	local file = io.open(fullPath, "w")

	file:write(tostring(debugResultJson))
	file:close()
end

function VersionResSplitHandler:_InitMapElementData()
	local allMapElement = lua_chapter_map_element.configDict

	self._mapElementResDic = {}

	for id, config in pairs(allMapElement) do
		self._mapElementResDic[config.mapId] = self._mapElementResDic[config.mapId] or {}

		if not string.nilorempty(config.res) then
			table.insert(self._mapElementResDic[config.mapId], config.res)
		end

		if not string.nilorempty(config.effect) then
			table.insert(self._mapElementResDic[config.mapId], config.effect)
		end
	end
end

function VersionResSplitHandler:_InitGuideCfg()
	local helpPageCfgList = lua_helppage.configList

	self._guideId2HelpPageDict = {}

	for _, cfg in ipairs(helpPageCfgList) do
		if cfg.type == 2 then
			local unLockGuideId = cfg.unlockGuideId

			self._guideId2HelpPageDict[unLockGuideId] = self._guideId2HelpPageDict[unLockGuideId] or {}

			local helpPageList = self._guideId2HelpPageDict[unLockGuideId]

			helpPageList[#helpPageList + 1] = cfg
		end
	end
end

function VersionResSplitHandler:_InitAudioCfg()
	self._allAudioDic = AudioConfig.instance:getAudioCO()
end

function VersionResSplitHandler:_InitAudioInfoXml()
	local xmlPath = "../audios/Android/SoundbanksInfo.xml"
	local file = io.open(xmlPath, "r")
	local xml = file:read("*a")

	file:close()

	local soundInfoXmlTree = ResSplitXmlTree:new()
	local parser = ResSplitXml2lua.parser(soundInfoXmlTree)

	parser:parse(xml)

	self._bnk2wenDic = {}
	self.bankEvent2wenDic = {}
	self.wen2BankDic = {}

	for i, p in pairs(soundInfoXmlTree.root.SoundBanksInfo.SoundBanks.SoundBank) do
		self:_dealSingleSoundBank(p)
	end
end

function VersionResSplitHandler:_dealSingleSoundBank(soundBank)
	local bankName = soundBank.ShortName

	if soundBank._attr.Language == "SFX" and soundBank.Media then
		for i, mediaFile in pairs(soundBank.Media.File) do
			if mediaFile.Path then
				self:_addWenInfo(bankName, "", mediaFile.Path)
			end
		end
	end
end

function VersionResSplitHandler:_addWenInfo(bankName, eventName, fileId)
	if self._bnk2wenDic[bankName] == nil then
		self._bnk2wenDic[bankName] = {}
	end

	table.insert(self._bnk2wenDic[bankName], fileId)

	local eventKey = bankName .. "#" .. eventName

	if self.bankEvent2wenDic[eventKey] == nil then
		self.bankEvent2wenDic[eventKey] = {}
	end

	table.insert(self.bankEvent2wenDic[eventKey], fileId)

	if self.wen2BankDic[fileId] == nil then
		self.wen2BankDic[fileId] = {}
	end

	self.wen2BankDic[fileId][bankName] = true
end

function VersionResSplitHandler:_InitStoryCfg()
	local storyCfgFolder = "Assets/ZResourcesLib/configs/story/groups"
	local allFilePaths = SLFramework.FileHelper.GetDirFilePaths(storyCfgFolder)

	self._allStoryIds = {}

	for i = 0, allFilePaths.Length - 1 do
		local path = allFilePaths[i]

		if path:match("%.json$") then
			local storyCfgName = SLFramework.FileHelper.GetFileName(path, false)
			local storyIdStr = string.gsub(storyCfgName, "json_story_group_", "")
			local storyId = tonumber(storyIdStr)

			if storyId > 999 then
				self._allStoryIds[#self._allStoryIds + 1] = storyId
			end
		end
	end
end

function VersionResSplitHandler:_loadAllStoryCfg(callback, callbackObj)
	if self._loadStroyFinishCount and self._loadStroyFinishCount > 0 then
		return
	end

	self._loadFinishCallblock = callback
	self._loadFinishCallblockObj = callbackObj
	self._loadStroyFinishCount = #self._allStoryIds * 2

	for i, storyId in ipairs(self._allStoryIds) do
		local stepPath = string.format("configs/story/steps/json_story_step_%s.json", storyId)
		local groupPath = string.format("configs/story/groups/json_story_group_%s.json", storyId)

		loadNonAbAsset(stepPath, SLFramework.AssetType.TEXT, self._loadStoryCfgCallBack, self)
		loadNonAbAsset(groupPath, SLFramework.AssetType.TEXT, self._loadStoryCfgCallBack, self)
	end
end

function VersionResSplitHandler:_loadStoryCfgCallBack(assetItem)
	if not assetItem.IsLoadSuccess then
		logError("config load fail: " .. assetItem.ResPath)

		return
	end

	self._loadStroyFinishCount = self._loadStroyFinishCount - 1
	self._storyCfgMap = self._storyCfgMap or {}
	self._storyCfgMap[assetItem.ResPath] = cjson.decode(assetItem.TextAsset)

	if self._loadStroyFinishCount <= 0 and self._loadFinishCallblock then
		if self._loadFinishCallblockObj then
			self._loadFinishCallblock(self._loadFinishCallblockObj)
		else
			self._loadFinishCallblock()
		end
	end
end

function VersionResSplitHandler:_fillSceneResByChatper(chapterId, versionResSplitData)
	for i, chapterMapCfg in ipairs(lua_chapter_map.configList) do
		if chapterMapCfg.chapterId == chapterId then
			local sceneRes = chapterMapCfg.res
			local path = ResUrl.getDungeonMapRes(sceneRes)

			versionResSplitData:addResSplitInfo(ResSplitEnum.Path, VersionResType.ChapterScene, path)
			self:_fillSceneDependRes(path, versionResSplitData)

			local elementResList = self._mapElementResDic[chapterMapCfg.id]

			if elementResList then
				for j, v in ipairs(elementResList) do
					self:_fillSceneDependRes(v, versionResSplitData)
				end
			end
		end
	end
end

local _DependResExtDic = {
	tga = true,
	prefab = true,
	controller = true,
	asset = true,
	png = true,
	anim = true,
	mat = true
}
local _ExcludeResFolder = {
	["font/"] = true
}

function VersionResSplitHandler:_fillSceneDependRes(path, resSplitData)
	path = SLFramework.FrameworkSettings.GetEditorResPath(path)

	local dependencies = ZProj.AssetDatabaseHelper.GetDependencies(path, true)

	for i = 0, dependencies.Length - 1 do
		local dependPath = dependencies[i]
		local extension = string.match(dependPath, ".+%.(%w+)$")
		local containExcludeFolder = false

		for _excludefolder, _ in pairs(_ExcludeResFolder) do
			if string.match(dependPath, "font/") then
				containExcludeFolder = true

				break
			end
		end

		if not containExcludeFolder then
			local extension = string.match(dependPath, ".+%.(%w+)$")

			if _DependResExtDic[extension] then
				dependPath = string.gsub(dependPath, SLFramework.FrameworkSettings.AssetRootDir .. "/", "")

				resSplitData:addResSplitInfo(ResSplitEnum.Path, VersionResType.ChapterSceneDepand, dependPath)
			end
		end
	end
end

function VersionResSplitHandler:_fillStoryResByChatper(chapterId, versionResSplitData)
	local chapterEpisodeCfgList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	if not chapterEpisodeCfgList then
		return
	end

	for episodeId, episodecfg in ipairs(chapterEpisodeCfgList) do
		local beforeStoryId = episodecfg.beforeStory

		if beforeStoryId ~= 0 then
			self:_fillStoryRes(beforeStoryId, versionResSplitData)
		end

		local sp = string.split(episodecfg.story, "#")

		if #sp == 3 then
			local storyId = tonumber(sp[3])

			self:_fillStoryRes(storyId, versionResSplitData)
		end

		local afterStoryId = episodecfg.afterStory

		if afterStoryId ~= 0 then
			self:_fillStoryRes(afterStoryId, versionResSplitData)
		end
	end
end

function VersionResSplitHandler:_fillStoryRes(storyId, versionResSplitData)
	local stepPath = string.format("configs/story/steps/json_story_step_%s.json", storyId)
	local groupPath = string.format("configs/story/groups/json_story_group_%s.json", storyId)
	local stepInfo = self._storyCfgMap[stepPath]
	local groupInfo = self._storyCfgMap[groupPath]

	if not stepInfo then
		logNormal(string.format("找不到剧情配置Id:%s", storyId))

		return
	end

	StoryModel.instance:clearData()
	StoryStepModel.instance:setStepList(stepInfo[3])
	StoryGroupModel.instance:setGroupList(groupInfo)

	local stepList = StoryStepModel.instance:getStepList()

	for i, storyStepMo in ipairs(stepList) do
		if not string.nilorempty(storyStepMo.bg.bgImg) then
			local path = ResUrl.getStoryBg(storyStepMo.bg.bgImg)

			versionResSplitData:addResSplitInfo(ResSplitEnum.Path, VersionResType.StoryBg, path)

			local zoneMo = StoryBgZoneModel.instance:getBgZoneByPath(storyStepMo.bg.bgImg)

			if zoneMo then
				local zonePath = ResUrl.getStoryRes(zoneMo.sourcePath)

				versionResSplitData:addResSplitInfo(ResSplitEnum.Path, VersionResType.StoryBg, zonePath)
			end
		end

		for _, StoryStepVideoMo in pairs(storyStepMo.videoList) do
			local videoArgs = string.split(StoryStepVideoMo.video, ".")
			local _videoName = videoArgs[1]

			versionResSplitData:addResSplitInfo(ResSplitEnum.Video, VersionResType.StoryVideo, _videoName)
		end

		for _, audio in pairs(storyStepMo.conversation.audios) do
			local audioInfo = self._allAudioDic[audio]

			if audioInfo then
				versionResSplitData:addResSplitInfo(ResSplitEnum.AudioBank, VersionResType.StoryAudio, audioInfo.bankName)
				self:_fillAudioResByAudioBnkName(audioInfo.bankName, versionResSplitData)
			end
		end

		for _, audio in pairs(storyStepMo.audioList) do
			local audioInfo = self._allAudioDic[audio.audio]

			if audioInfo then
				versionResSplitData:addResSplitInfo(ResSplitEnum.AudioBank, VersionResType.StoryAudio, audioInfo.bankName)
				self:_fillAudioResByAudioBnkName(audioInfo.bankName, versionResSplitData)
			end
		end

		for _, storyStepPictureMo in pairs(storyStepMo.picList) do
			if not string.nilorempty(storyStepPictureMo.picture) then
				local path = ResUrl.getStoryItem(storyStepPictureMo.picture)

				versionResSplitData:addResSplitInfo(ResSplitEnum.Path, VersionResType.StoryBgItem, path)
			end
		end
	end
end

function VersionResSplitHandler:_fillAudioResByAudioId(audioId, versionResSplitData)
	local audioInfo = self._allAudioDic[audioId]

	if audioInfo then
		versionResSplitData:addResSplitInfo(ResSplitEnum.AudioBank, VersionResType.VersionAudio, audioInfo.bankName)
		self:_fillAudioResByAudioBnkName(audioInfo.bankName, versionResSplitData)
	end
end

function VersionResSplitHandler:_fillAudioResByAudioBnkName(bankName, versionResSplitData)
	local wenList = self._bnk2wenDic[bankName]

	if wenList then
		for i, wenId in ipairs(wenList) do
			versionResSplitData:addResSplitInfo(ResSplitEnum.AudioWem, VersionResType.VersionAudio, wenId)
		end
	end
end

function VersionResSplitHandler:_fillResByGuideId(guideId, versionResSplitData)
	local helpPageList = self._guideId2HelpPageDict[guideId]

	if helpPageList then
		for _, cfg in ipairs(helpPageList) do
			local path = ResUrl.getVersionActivityHelpItem(cfg.icon, cfg.isCn)

			versionResSplitData:addResSplitInfo(ResSplitEnum.Path, VersionResType.GuideHalpPage, path)
		end
	end
end

function VersionResSplitHandler:_fillUIResByFolder(folder, resSplitData)
	folder = SLFramework.FrameworkSettings.GetEditorResPath(folder)

	local allFilePaths = SLFramework.FileHelper.GetDirFilePaths(folder)

	for i = 0, allFilePaths.Length - 1 do
		local path = allFilePaths[i]

		if path:match("%.prefab$") then
			self:_fillUIRes(path, resSplitData)
		end
	end
end

function VersionResSplitHandler:_fillUIRes(prefabPath, resSplitData)
	local index = string.find(prefabPath, "Assets")
	local unityPrefabPath = string.sub(prefabPath, index, string.len(prefabPath))
	local reslibPath = string.gsub(unityPrefabPath, SLFramework.FrameworkSettings.AssetRootDir .. "/", "")
	local dependencies = ZProj.AssetDatabaseHelper.GetDependencies(unityPrefabPath, true)

	resSplitData:addResSplitInfo(ResSplitEnum.Path, VersionResType.UIPrefab, reslibPath)

	for i = 0, dependencies.Length - 1 do
		local dependPath = dependencies[i]
		local containExcludeFolder = false

		for _excludefolder, _ in pairs(_ExcludeResFolder) do
			if string.match(dependPath, "font/") then
				containExcludeFolder = true

				break
			end
		end

		if not containExcludeFolder then
			local extension = string.match(dependPath, ".+%.(%w+)$")

			if _DependResExtDic[extension] then
				dependPath = string.gsub(dependPath, SLFramework.FrameworkSettings.AssetRootDir .. "/", "")

				resSplitData:addResSplitInfo(ResSplitEnum.Path, VersionResType.UIPrefabDepand, dependPath)
			end
		end
	end
end

function VersionResSplitHandler._getFolderPrefabs(folder)
	local files = {}

	folder = SLFramework.FrameworkSettings.GetEditorResPath(folder)

	if not SLFramework.FileHelper.IsDirExists(folder) then
		logError("文件夹" .. folder .. "不存在，请检查")
	else
		local allFilePaths = SLFramework.FileHelper.GetDirFilePaths(folder)

		for i = 0, allFilePaths.Length - 1 do
			local path = allFilePaths[i]

			if path:match("%.prefab$") then
				files[#files + 1] = path
			end
		end
	end

	return files
end

function VersionResSplitHandler._getResFolderFiles(folder, extension)
	local files = {}

	folder = SLFramework.FrameworkSettings.GetEditorResPath(folder)

	if not SLFramework.FileHelper.IsDirExists(folder) then
		logError("文件夹" .. folder .. " 不存在，请检查")
	else
		local allFilePaths = SLFramework.FileHelper.GetDirFilePaths(folder)

		for i = 0, allFilePaths.Length - 1 do
			local path = allFilePaths[i]

			if path:match("%." .. extension .. "$") then
				files[#files + 1] = path
			end
		end
	end

	return files
end

function VersionResSplitHandler:_getPartyGameCfg()
	local partyGameMgrCs = PartyGame.Runtime.GameLogic.GameMgr

	self._partyGameAssets = partyGameMgrCs.Instance.GetPartyGamePreLoaderAllAssetAllDeps()
end

return VersionResSplitHandler
