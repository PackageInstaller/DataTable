-- chunkname: @modules/logic/versionactivity1_4/act131/model/Activity131LogListModel.lua

module("modules.logic.versionactivity1_4.act131.model.Activity131LogListModel", package.seeall)

local Activity131LogListModel = class("Activity131LogListModel", MixScrollModel)

function Activity131LogListModel:ctor()
	Activity131LogListModel.super.ctor(self)

	self._infos = nil
end

function Activity131LogListModel:setLogList(infos)
	self._infos = {}

	local moList = {}

	if infos then
		self._infos = infos

		for _, info in ipairs(infos) do
			local logMo = Activity131LogMo.New()
			local params = string.split(info.param, "#")
			local audioId = tonumber(params[2])

			logMo:init(info.speaker, info.content, audioId)
			table.insert(moList, logMo)
		end
	end

	self:setList(moList)
end

function Activity131LogListModel:getInfoList(scrollGO)
	local mixCellInfos = {}

	if not self._infos or #self._infos <= 0 then
		return mixCellInfos
	end

	local textComp = gohelper.findChildText(scrollGO, "Viewport/logcontent/storylogitem/go_normal/txt_content")
	local mixType = 0
	local lastInfo

	for i, info in ipairs(self._infos) do
		local lineWidth = 0
		local text = GameUtil.filterRichText(info.content)

		lineWidth = SLFramework.UGUI.GuiHelper.GetPreferredHeight(textComp, text)
		lineWidth = lineWidth + 13.96

		if lastInfo and info.speaker == lastInfo.speaker then
			mixType = 1
		else
			if i > 1 then
				mixCellInfos[i - 1].lineLength = mixCellInfos[i - 1].lineLength + 40
			end

			mixType = 0
		end

		table.insert(mixCellInfos, SLFramework.UGUI.MixCellInfo.New(mixType, lineWidth, nil))

		lastInfo = info
	end

	return mixCellInfos
end

function Activity131LogListModel:clearData()
	self._infos = nil
end

function Activity131LogListModel:setPlayingLogAudio(audioId)
	self._playingId = audioId
end

function Activity131LogListModel:setPlayingLogAudioFinished(audioId)
	if self._playingId == audioId then
		self._playingId = 0
	end
end

function Activity131LogListModel:getPlayingLogAudioId()
	return self._playingId
end

Activity131LogListModel.instance = Activity131LogListModel.New()

return Activity131LogListModel
