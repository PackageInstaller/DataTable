-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyao/model/FuYaoModel.lua

module("logic.extensions.fuyao.model.FuYaoModel", package.seeall)

local FuYaoModel = class("FuYaoModel", BaseModel)

function FuYaoModel:ctor()
	return
end

function FuYaoModel:onInit()
	self:onReset()
end

function FuYaoModel:onReset()
	self.fuyaoInfo = {}
	self.activityId = 0
	self.fuyaoCommonChallengeFmtMo = nil
	self.extremeSelectId = 1
end

function FuYaoModel:setFuyaoInfo(msg)
	table.clear(self.fuyaoInfo)
	GameUtil.pbToTable(msg, self.fuyaoInfo)
end

function FuYaoModel:getFuyaoInfo()
	return self.fuyaoInfo
end

function FuYaoModel:setActivityId(actId)
	self.activityId = actId
end

function FuYaoModel:getActivityId()
	return self.activityId
end

function FuYaoModel:getPassPuzzles()
	return self.fuyaoInfo.passPuzzles or {}
end

function FuYaoModel:getExtremeSelectId()
	return self.extremeSelectId
end

function FuYaoModel:setExtremeSelectId(stageId)
	self.extremeSelectId = stageId
end

function FuYaoModel:getExtremeScores()
	return self.fuyaoInfo.extremeScores or {}
end

function FuYaoModel:getCurScore()
	local score = 0

	for _, v in pairs(self:getExtremeScores()) do
		if v > 0 then
			score = score + checknumber(v)
		end
	end

	return score
end

function FuYaoModel:getChallengeFmtMo(activityId, challengeId, creepsMasterId, isExtreme)
	if self.fuyaoCommonChallengeFmtMo == nil then
		self.fuyaoCommonChallengeFmtMo = FuyaoChallengeFmtMo.New()
	end

	self.fuyaoCommonChallengeFmtMo:initParams(activityId, challengeId, creepsMasterId, isExtreme)

	return self.fuyaoCommonChallengeFmtMo
end

FuYaoModel.instance = FuYaoModel.New()

return FuYaoModel
