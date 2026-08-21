-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/StoryAssetBuilder.lua

module("logic.extensions.story.core.StoryAssetBuilder", package.seeall)

function CreateArgInfo(argStr)
	local argInfo = StoryArgInfo.New()
	local argArr = string.split(argStr, ":")

	argInfo.GUID = argArr[1]
	argInfo.key = argArr[2]

	if #argArr > 3 then
		local valueStr = ""

		for i = 3, #argArr do
			valueStr = valueStr .. argArr[i]
		end

		argInfo.value = valueStr
	else
		argInfo.value = argArr[3]
	end

	return argInfo
end

function CreateGraphAssetNode(tbdata)
	local data = StoryGraphAssetNode.New()

	data.GUID = tbdata.GUID
	data.actionType = tbdata.actionType
	data.startTimeMs = tbdata.startTimeMs
	data.endTimeMs = tbdata.endTimeMs
	data.startTime = tbdata.startTimeMs * 0.001
	data.endTime = tbdata.endTimeMs * 0.001

	for index, argStr in ipairs(tbdata.args) do
		table.insert(data.args, CreateArgInfo(argStr))
	end

	return data
end

function BuildAsset(jsonStr)
	local _tb, result = GameUtils.json.decode(jsonStr)

	if not result then
		printError("StoryAssetBuilder", "json decode error")

		return {}
	end

	local graphAsset = StoryGraphAsset.New()
	local setting = StorySettingData.New()

	graphAsset.settingData = setting
	setting.skip = _tb.settingData.skip
	setting.auto = _tb.settingData.auto
	setting.rogue = _tb.settingData.rogue
	setting.fadeIn = _tb.settingData.fadeIn
	setting.fadeOut = _tb.settingData.fadeOut

	if setting.fadeIn then
		local fadeInColor = _tb.settingData.fadeInColor or Color.New(1, 1, 1, 1)

		setting.fadeInColor = Color.New(fadeInColor.r, fadeInColor.g, fadeInColor.b, fadeInColor.a)
	end

	if setting.fadeOut then
		local fadeOutColor = _tb.settingData.fadeOutColor or Color.New(1, 1, 1, 1)

		setting.fadeOutColor = Color.New(fadeOutColor.r, fadeOutColor.g, fadeOutColor.b, fadeOutColor.a)
	end

	setting.skipTitle = _tb.settingData.skipTitle
	setting.skipDes = _tb.settingData.skipDes
	setting.sceneType = _tb.settingData.sceneType
	setting.sce3D = _tb.settingData.sce3D
	setting.sce2D = _tb.settingData.sce2D
	setting.sce2DTex = _tb.settingData.sce2DTex
	setting.sce2DScale = _tb.settingData.sce2DScale
	setting.sce2DPos = _tb.settingData.sce2DPos
	setting.sce2DRot = _tb.settingData.sce2DRot
	setting.stageTpl = _tb.settingData.stageTpl
	setting.stagePos = _tb.settingData.stagePos
	setting.stageRotation = _tb.settingData.stageRotation

	for _, jsonEle in ipairs(_tb.containerNodes) do
		local container = StoryGraphContainerAsset.New()

		table.insert(graphAsset.containerNodes, container)

		container.GUID = jsonEle.GUID
		container.ShotID = jsonEle.shotId
		container.isEnd = jsonEle.isEnd
		container.isAutoNext = jsonEle.isAutoNext
		container.needFade = jsonEle.needFade

		if container.needFade then
			container.fadeTime = jsonEle.fadeTime
			container.fadeColor = Color.New(jsonEle.fadeColor.r, jsonEle.fadeColor.g, jsonEle.fadeColor.b, jsonEle.fadeColor.a)
		end

		for k4, trackEle in ipairs(jsonEle.tracksAssets) do
			local track = StoryTrackAsset.New()

			track.GUID = trackEle.GUID
			track.actionType = trackEle.actionType

			for k5, argStr in ipairs(trackEle.args) do
				table.insert(track.args, CreateArgInfo(argStr))
			end

			for k5, sectionEle in ipairs(trackEle.sections) do
				table.insert(track.sections, CreateGraphAssetNode(sectionEle))
			end

			table.insert(container.tracksAssets, track)
		end
	end

	for _, edgeEle in ipairs(_tb.containerEdges) do
		local storyEdge = StoryContainerEdge.New()

		storyEdge.GUID = edgeEle.GUID
		storyEdge.containerLinkType = edgeEle.containerLinkType
		storyEdge.baseNodeGuid = edgeEle.baseNodeGuid
		storyEdge.targetNodeGuid = edgeEle.targetNodeGuid

		for index, argStr in ipairs(edgeEle.args) do
			table.insert(storyEdge.args, CreateArgInfo(argStr))
		end

		table.insert(graphAsset.containerEdges, storyEdge)
	end

	return graphAsset
end
