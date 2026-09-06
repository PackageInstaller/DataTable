-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/knowledgeanswer/model/KnowledgeAnswerModel.lua

module("logic.extensions.knowledgeanswer.model.KnowledgeAnswerModel", package.seeall)

local KnowledgeAnswerModel = class("KnowledgeAnswerModel", BaseModel)

function KnowledgeAnswerModel:ctor()
	return
end

function KnowledgeAnswerModel:onInit()
	self:onReset()
end

function KnowledgeAnswerModel:onReset()
	self._baseInfoList = {}
end

function KnowledgeAnswerModel:getBaseInfoByActId(actId)
	return self._baseInfoList[actId]
end

function KnowledgeAnswerModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoList[info.activityId] = info
end

function KnowledgeAnswerModel:onGainPrize(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self._baseInfoList[info.activityId]

	baseInfo.gainedPrizeIds = baseInfo.gainedPrizeIds or {}

	table.insert(baseInfo.gainedPrizeIds, info.prizeId)
end

function KnowledgeAnswerModel:onSeekHelp(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self._baseInfoList[info.activityId]
	local helpType = info.type

	if not baseInfo.times then
		local data

		for i, timeInfo in ipairs(baseInfo.times) do
			if timeInfo.type == helpType then
				data = timeInfo
			end
		end

		if not data then
			data = {
				usedTimes = 0,
				type = helpType
			}

			table.insert(baseInfo.times, data)
		end

		data.usedTimes = data.usedTimes + 1
		baseInfo.times = baseInfo.times
	end
end

function KnowledgeAnswerModel:getRemainingHelpTimes(activityId, helpType)
	local baseInfo = self._baseInfoList[activityId]
	local helpCfg = KnowledgeAnswerConfig.instance:getHelpCfgByType(activityId, helpType)

	if baseInfo and helpCfg then
		if not baseInfo.times then
			for i, timeInfo in ipairs(baseInfo.times) do
				if timeInfo.type == helpType then
					return helpCfg.times - timeInfo.usedTimes
				end
			end
		end
	end

	return 0
end

KnowledgeAnswerModel.instance = KnowledgeAnswerModel.New()

return KnowledgeAnswerModel
