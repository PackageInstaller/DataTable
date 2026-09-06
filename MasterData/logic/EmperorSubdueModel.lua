-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emperorsubdue/model/EmperorSubdueModel.lua

module("logic.extensions.emperorsubdue.model.EmperorSubdueModel", package.seeall)

local EmperorSubdueModel = class("EmperorSubdueModel", BaseModel)

function EmperorSubdueModel:onInit()
	self:onReset()
end

function EmperorSubdueModel:onReset()
	self._infoMap = {}
	self._rankInfoMap = {}
end

function EmperorSubdueModel:getInfoByActId(activityId)
	local info = self._infoMap[activityId]

	if not info then
		printInfo("帝王降魔基础数据不存在，activityId=%d", activityId)
	end

	return self._infoMap[activityId]
end

function EmperorSubdueModel:getRankInfoByActId(activityId)
	local rankInfo = self._rankInfoMap[activityId]

	if not rankInfo then
		printInfo("帝王降魔排行榜数据不存在，activityId=%d", activityId)
	end

	return self._rankInfoMap[activityId]
end

function EmperorSubdueModel:handlePM_EmperorSubdueInfoRes(msg)
	self._infoMap[msg.activityId] = GameUtil.pbToTable(msg)
end

function EmperorSubdueModel:handleNotifyStageChallenge(msg)
	return
end

function EmperorSubdueModel:handleNotifyBossChallenge(msg)
	return
end

function EmperorSubdueModel:handleResetStage(msg)
	local activityId = msg.activityId
	local info = self._infoMap[activityId]

	if info then
		info.hasPassStageIds = {}
	end
end

function EmperorSubdueModel:handlePM_EmperorSubdueRankViewRes(msg)
	self._rankInfoMap[msg.activityId] = GameUtil.pbToTable(msg)
end

EmperorSubdueModel.instance = EmperorSubdueModel.New()

return EmperorSubdueModel
