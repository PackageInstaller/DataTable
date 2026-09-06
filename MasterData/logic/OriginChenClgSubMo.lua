-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/data/OriginChenClgSubMo.lua

module("logic.extensions.originchenclg.data.OriginChenClgSubMo", package.seeall)

local OriginChenClgSubMo = class("OriginChenClgSubMo")

function OriginChenClgSubMo:ctor(activityId)
	self._activityId = activityId

	self:_resetData()
end

function OriginChenClgSubMo:_resetData()
	self._msgInfos = {}
end

function OriginChenClgSubMo:dispose()
	self:_resetData()
end

function OriginChenClgSubMo:handlePM_OriginChenClgGetInfoRes(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._msgInfos[activityId] = info
	self._msgInfos[activityId].passedNormalStageIds = self._msgInfos[activityId].passedNormalStageIds or {}
	self._msgInfos[activityId].extremeStageInfos = self._msgInfos[activityId].extremeStageInfos or {}
end

function OriginChenClgSubMo:handlePM_OriginChenClgResetExtremeRes(msg)
	local info = self:getInfo(msg.activityId)

	info.extremeStageInfos = {}
end

function OriginChenClgSubMo:handlePM_Notify_OriginChenClgChallengeExtremeResultRes(msg)
	return
end

function OriginChenClgSubMo:handlePM_Notify_OriginChenClgChallengeNormalResultRes(msg)
	if not msg.win then
		return
	end

	local info = self:getInfo(msg.activityId)

	if not info then
		info = {
			activityId = msg.activityId,
			passedNormalStageIds = {},
			extremeStageInfos = {}
		}
		self._msgInfos[msg.activityId] = info
	end

	info.passedNormalStageIds = info.passedNormalStageIds or {}

	for _, stageId in ipairs(info.passedNormalStageIds) do
		if stageId == msg.stageId then
			return
		end
	end

	table.insert(info.passedNormalStageIds, msg.stageId)
end

function OriginChenClgSubMo:handlePM_OriginChenClgConfirmExtremeRes(msg)
	return
end

function OriginChenClgSubMo:onConfirmExtreme(activityId, stageInfo)
	local info = self:getInfo(activityId)

	table.insert(info.extremeStageInfos, stageInfo)
end

function OriginChenClgSubMo:getInfo(activityId)
	return self._msgInfos[activityId]
end

return OriginChenClgSubMo
