-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightrui/model/SaintKnightRuiModel.lua

module("logic.extensions.saintknightrui.model.SaintKnightRuiModel", package.seeall)

local SaintKnightRuiModel = class("SaintKnightRuiModel", BaseModel)

SaintKnightRuiModel.KeyAnim1 = "saintknightrui_animpath"
SaintKnightRuiModel.KeyStory1 = "saintknightrui_story1"
SaintKnightRuiModel.KeyStory2 = "saintknightrui_story2"

function SaintKnightRuiModel:ctor()
	return
end

function SaintKnightRuiModel:onInit()
	self:onReset()
end

function SaintKnightRuiModel:onReset()
	self._activityId = 172001
	self._customFmtMo = nil
	self._playCountToday = 0
	self._stageInfo = {}
	self._totalGameTime = 0
end

function SaintKnightRuiModel:onGetInfoRes(msg)
	self._playCountToday = msg.playCount
	self._totalGameTime = msg.totalGameTime
	self._stageInfo = GameUtil.pbToTable(msg.stageInfo)
end

function SaintKnightRuiModel:onPlayStageRes(msg)
	self._playCountToday = msg.playCount

	for i, v in ipairs(self._stageInfo) do
		if msg.stageInfo.stageId == v.stageId then
			v.passCreepsMasterId = msg.stageInfo.passCreepsMasterId
		end
	end
end

function SaintKnightRuiModel:getPlayCount()
	return self._playCountToday
end

function SaintKnightRuiModel:isCreepsPass(stageId, creepsMasterId)
	for i, v in ipairs(self._stageInfo) do
		if v.stageId == stageId and creepsMasterId <= v.passCreepsMasterId then
			return true
		end
	end
end

function SaintKnightRuiModel:getPassCreepsMasterId(stageId)
	for i, v in ipairs(self._stageInfo) do
		if v.stageId == stageId then
			return v.passCreepsMasterId
		end
	end

	return 0
end

function SaintKnightRuiModel:getActivityId()
	return self._activityId
end

function SaintKnightRuiModel:getChallengePlanId()
	local cfg = SaintKnightRuiConfig.instance:getActivityCfg(self._activityId)

	return (cfg or nil) and (cfg.challengePlanId or 0)
end

function SaintKnightRuiModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = SaintKnightRuiCustomFmtMo.New()
	end

	return self._customFmtMo
end

function SaintKnightRuiModel:setWinId(winId)
	self._winId = winId
end

function SaintKnightRuiModel:getWinId()
	self._winId = nil

	return self._winId
end

SaintKnightRuiModel.instance = SaintKnightRuiModel.New()

return SaintKnightRuiModel
