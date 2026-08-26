-- chunkname: @modules/logic/ressplit/controller/ResSplitSaveHelper.lua

module("modules.logic.ressplit.controller.ResSplitSaveHelper", package.seeall)

local ResSplitSaveHelper = _M

function ResSplitSaveHelper.init()
	return
end

function ResSplitSaveHelper.createExcludeConfig()
	local dic = ResSplitConfig.instance:getAppIncludeConfig()
	local characterIdDic = {}
	local chapterIdDic = {}
	local storyIdDic = {}
	local guideIdDic = {}
	local videoDic = {}
	local pathDic = {}
	local seasonDic = {}

	for i, v in pairs(dic) do
		for n, m in pairs(v.character) do
			characterIdDic[m] = true
		end

		for n, m in pairs(v.chapter) do
			chapterIdDic[m] = true
		end

		for n, m in pairs(v.story) do
			storyIdDic[m] = true
		end

		for n, m in pairs(v.guide) do
			guideIdDic[m] = true
		end

		for n, m in pairs(v.video) do
			videoDic[m] = true
		end

		for n, m in pairs(v.path) do
			pathDic[m] = true
		end

		for n, m in pairs(v.seasonIds) do
			seasonDic[m] = true
		end
	end

	local allAudioDic = AudioConfig.instance:getAudioCO()

	ResSplitHelper._buildMapData()
	ResSplitModel.instance:init(characterIdDic, chapterIdDic, allAudioDic, storyIdDic, guideIdDic, videoDic, pathDic, seasonDic)

	local flow = FlowSequence.New()

	flow:addWork(ResSplitSaveUIWork.New())
	flow:addWork(ResSplitSaveChapterWork.New())
	flow:addWork(ResSplitSaveCharacterWork.New())
	flow:addWork(ResSplitSaveSceneWork.New())
	flow:addWork(ResSplitSaveSkillWork.New())
	flow:addWork(ResSplitSaveAudioWemWork.New())
	flow:addWork(ResSplitSaveExportWork.New())
	flow:start()
end

function ResSplitSaveHelper.checkConfigEmpty(mainKey, configKey, config)
	if string.nilorempty(config) then
		logError("config Empty", mainKey, configKey)
	end
end

function ResSplitSaveHelper.addSceneRes(levelId)
	local levelCO = lua_scene_level.configDict[levelId]

	ResSplitHelper.checkConfigEmpty(string.format("levelId:%d", levelId), "resName", levelCO.resName)

	local path = ResUrl.getSceneRes(levelCO.resName)

	ResSplitModel.instance:setInclude(ResSplitEnum.InnerSceneAB, path, true)

	local bgm = levelCO.bgm
	local audioInfo = ResSplitModel.instance.audioDic[bgm]

	if audioInfo then
		ResSplitModel.instance:setInclude(ResSplitEnum.CommonAudioBank, audioInfo.bankName)
	end
end

return ResSplitSaveHelper
