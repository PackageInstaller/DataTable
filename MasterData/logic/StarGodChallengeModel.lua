-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodchallenge/model/StarGodChallengeModel.lua

module("logic.extensions.stargodchallenge.model.StarGodChallengeModel", package.seeall)

local StarGodChallengeModel = class("StarGodChallengeModel", BaseModel)

StarGodChallengeModel.RuleDescKey = "stargodchallengeruledesc"

function StarGodChallengeModel:ctor()
	self._chapterId = 3
end

function StarGodChallengeModel:onInit()
	self:onReset()
end

function StarGodChallengeModel:onReset()
	self._curTier = 1
	self._maxTier = #StarGodChallengeConfig.instance:getChallengeCfgList()
	self._todayHelpPrizeTimes = 0
	self._todayGameTimes = 0
	self._isSingleWin = false
	self._form = nil
	self._isTeamWin = false
	self._failReason = 0
	self._customFmtMo = nil
	self._teamCustomFmtMo = nil
	self._saveCustomFmtMo = nil
end

function StarGodChallengeModel:getChapterId()
	return self._chapterId
end

function StarGodChallengeModel:resetGameTimes()
	self._todayGameTimes = 0
	self._todayHelpPrizeTimes = 0
end

function StarGodChallengeModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = StarGodChaCustomFmtMo.New()
	end

	return self._customFmtMo
end

function StarGodChallengeModel:getTeamCustomFmtMo()
	self._teamCustomFmtMo = self._teamCustomFmtMo or StarGodChaTeamFmtMo.New()

	return self._teamCustomFmtMo
end

function StarGodChallengeModel:getSaveCustomFmtMo()
	self._saveCustomFmtMo = self._saveCustomFmtMo or StarGodChaSaveFmtMo.New()

	return self._saveCustomFmtMo
end

function StarGodChallengeModel:onStarGodChallengeGetInfoRes(msg)
	self._curTier = msg.curTier
	self._todayGameTimes = msg.todayGameTimes
	self._todayHelpPrizeTimes = msg.todayHelpPrizeTimes
end

function StarGodChallengeModel:onStarGodChallengeSingleFightResultRes(msg)
	self._isSingleWin = msg.win
end

function StarGodChallengeModel:onStarGodChallengeGetFormRes(msg)
	self._form = GameUtil.pbToTable(msg.form)
end

function StarGodChallengeModel:onStarGodChallengeSetFormRes(msg)
	self._form = GameUtil.pbToTable(msg.form)
end

function StarGodChallengeModel:onStarGodChallengeNotifyEndRes(msg)
	self._failReason = msg.reason
end

function StarGodChallengeModel:isLevelPass(level)
	return level < self._curTier
end

function StarGodChallengeModel:isCurLevel(level)
	return self._curTier == level
end

function StarGodChallengeModel:isLevelLock(level)
	return level > self._curTier
end

function StarGodChallengeModel:getCurLevel()
	return (self._curTier <= self._maxTier or nil) and (self._curTier or self._maxTier)
end

function StarGodChallengeModel:getMaxLevel()
	return self._maxTier
end

function StarGodChallengeModel:addTodayGameTimes(times)
	self._todayGameTimes = self._todayGameTimes + times
end

function StarGodChallengeModel:addTodayGameTime()
	self._todayGameTimes = self._todayGameTimes + 1
end

function StarGodChallengeModel:getTodayGameTimes()
	return self._todayGameTimes
end

function StarGodChallengeModel:getTeamForm()
	return self._form
end

function StarGodChallengeModel:setChangeSetId(changeSetId)
	self._changeSetId = changeSetId
end

function StarGodChallengeModel:getChangeSetId()
	self._changeSetId = nil

	return self._changeSetId
end

StarGodChallengeModel.instance = StarGodChallengeModel.New()

return StarGodChallengeModel
