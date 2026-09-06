-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingisaacclg/data/KingIsaacClgData.lua

module("logic.extensions.kingisaacclg.data.KingIsaacClgData", package.seeall)

local KingIsaacClgData = class("KingIsaacClgData")

function KingIsaacClgData:ctor(activityId)
	self._activityId = activityId
	self._stageIdOfMaxPass = 0
	self._clgResMsg = nil
end

function KingIsaacClgData:getActivityId()
	return self._activityId
end

function KingIsaacClgData:handlePM_KingIsaacClgInfoRes(msg)
	self._stageIdOfMaxPass = msg.stageId
end

function KingIsaacClgData:handlePM_KingIsaacClgChallengeRes(msg)
	return
end

function KingIsaacClgData:handlePM_NotifyKingIsaacClgChallengeEndRes(msg)
	self._clgResMsg = msg

	if msg.isWin then
		self._stageIdOfMaxPass = msg.stageId
	end
end

function KingIsaacClgData:getStageIdOfMaxPass()
	return self._stageIdOfMaxPass
end

function KingIsaacClgData:getClgResMsg()
	return self._clgResMsg
end

return KingIsaacClgData
