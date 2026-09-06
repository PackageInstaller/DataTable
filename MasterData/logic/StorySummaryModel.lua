-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storysummary/model/StorySummaryModel.lua

module("logic.extensions.storysummary.model.StorySummaryModel", package.seeall)

local StorySummaryModel = class("StorySummaryModel", BaseModel)

function StorySummaryModel:ctor()
	return
end

function StorySummaryModel:onInit()
	self:onReset()
end

function StorySummaryModel:onReset()
	self._passInfo = {}
	self._curChapterId = 0
	self._curStageId = 0
	self._customFmtMo = nil
	self._isInStage = false
end

function StorySummaryModel:onHandleStorySummaryInfoRes(msg)
	self._passInfo = {}

	for _, info in ipairs(msg.infos) do
		self:handlePassInfo(info)
	end
end

function StorySummaryModel:onHandleStorySummaryFightOrViewRes(msg)
	return
end

function StorySummaryModel:onHandleNotifyStorySummaryFightEndRes(msg)
	if msg.win == true then
		local info = msg.requestParams

		self:handlePassInfo(info)
	end
end

function StorySummaryModel:handlePassInfo(info)
	local chapterId = info.chapterId

	if self._passInfo[chapterId] == nil then
		self._passInfo[chapterId] = {}
	end

	for stageId = 1, info.stageId do
		self._passInfo[chapterId][stageId] = true
	end
end

function StorySummaryModel:getStorySummaryStagePassInfo(chapterId, stageId)
	if self._passInfo[chapterId] == nil then
		return nil
	end

	return self._passInfo[chapterId][stageId]
end

function StorySummaryModel:addViewInfo(viewName, ...)
	self._viewInfo = self._viewInfo or {}

	local info = {}

	info.viewName = viewName
	info.params = {
		...
	}

	table.insert(self._viewInfo, info)
end

function StorySummaryModel:getViewInfos()
	return self._viewInfo or {}
end

function StorySummaryModel:clearViewInfos()
	self._viewInfo = {}
end

function StorySummaryModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = StorySummaryCustomFmtMo.New()
	end

	return self._customFmtMo
end

StorySummaryModel.instance = StorySummaryModel.New()

return StorySummaryModel
