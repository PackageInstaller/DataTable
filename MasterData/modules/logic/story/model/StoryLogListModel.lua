-- chunkname: @modules/logic/story/model/StoryLogListModel.lua

module("modules.logic.story.model.StoryLogListModel", package.seeall)

local StoryLogListModel = class("StoryLogListModel", MixScrollModel)

function StoryLogListModel:ctor()
	StoryLogListModel.super.ctor(self)

	self._infos = nil
end

function StoryLogListModel:setLogList(infos)
	self._infos = infos

	local moList = {}

	for _, info in ipairs(infos) do
		local logMo = StoryLogMo.New()

		logMo:init(info)
		table.insert(moList, logMo)
	end

	self:setList(moList)
end

function StoryLogListModel:getInfoList(scrollGO)
	local mixCellInfos = {}

	if not self._infos or #self._infos <= 0 then
		return mixCellInfos
	end

	local textComp = gohelper.findChildText(scrollGO, "Viewport/logcontent/storylogitem/go_normal/txt_content")
	local mixType = 0
	local preInfo = 0

	for i, v in ipairs(self._infos) do
		local lineWidth = 0

		if type(v) == "number" then
			local curCo = StoryStepModel.instance:getStepListById(v).conversation
			local text = GameUtil.filterRichText(curCo.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

			text = text:gsub("^%d+,%d+#", "")
			lineWidth = GameUtil.getTextHeightByLine(textComp, text, 42.35294, 13.96) + 80 - 42.35294 + 31.41

			if type(preInfo) == "number" and preInfo > 0 then
				local preCo = StoryStepModel.instance:getStepListById(preInfo).conversation

				if preCo.type == curCo.type and preCo.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == curCo.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] then
					mixType = 1
					mixCellInfos[i - 1].lineLength = math.max(mixCellInfos[i - 1].lineLength - 20, 0)
				else
					mixType = 0
				end
			else
				mixType = 0
			end
		elseif type(v) == "table" then
			lineWidth = 55 * #StoryModel.instance:getShowStoryBranchOpts(v.stepId) + 25
			mixType = 0
		end

		table.insert(mixCellInfos, SLFramework.UGUI.MixCellInfo.New(mixType, lineWidth, nil))

		preInfo = v
	end

	return mixCellInfos
end

function StoryLogListModel:clearData()
	self._infos = nil
end

function StoryLogListModel:setPlayingLogAudio(audioId)
	self._playingId = audioId
end

function StoryLogListModel:setPlayingLogAudioFinished(audioId)
	if self._playingId == audioId then
		self._playingId = 0
	end
end

function StoryLogListModel:getPlayingLogAudioId()
	return self._playingId
end

StoryLogListModel.instance = StoryLogListModel.New()

return StoryLogListModel
