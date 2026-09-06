-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/model/FamilyHoudingClgModel.lua

module("logic.extensions.familyhoundingclg.model.FamilyHoudingClgModel", package.seeall)

local FamilyHoudingClgModel = class("FamilyHoudingClgModel", BaseModel)

function FamilyHoudingClgModel:ctor()
	return
end

function FamilyHoudingClgModel:onInit()
	self:onReset()
end

function FamilyHoudingClgModel:onReset()
	self._customFmtMo = nil
	self._curPlanId = 0
	self._curDayIndex = 0
	self._curBuffId = 0
	self._leftChallengeTimes = 0
	self._familyTopN = {}
	self._personTopN = {}
	self._rankMsgOfFamily = {}
	self._rankMsgOfPerson = {}
	self._fightResult = nil
	self._practiceResult = nil
end

function FamilyHoudingClgModel:handlePM_FamilyHounding_GetInfoRes(msg)
	self._curPlanId = msg.planId
	self._curDayIndex = msg.dayIndex
	self._curBuffId = msg.buffId
	self._leftChallengeTimes = msg.leftChallengeTimes
	self._familyTopN = msg.familyTopN
	self._personTopN = msg.personTopN
end

function FamilyHoudingClgModel:handlePM_FamilyHounding_ViewFamilyRankRes(msg)
	self._rankMsgOfFamily = msg
end

function FamilyHoudingClgModel:handlePM_FamilyHounding_ViewPersonRankRes(msg)
	self._rankMsgOfPerson = msg
end

function FamilyHoudingClgModel:handlePM_FamilyHounding_FightRes(msg)
	return
end

function FamilyHoudingClgModel:handlePM_FamilyHounding_PracticeRes(msg)
	return
end

function FamilyHoudingClgModel:handlePM_FamilyHounding_NotifyFightResultRes(msg)
	self._fightResult = msg
end

function FamilyHoudingClgModel:handlePM_FamilyHounding_NotifyPracticeResultRes(msg)
	self._practiceResult = msg
end

function FamilyHoudingClgModel:getFhcCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = FamilyHoudingClgCustomFmtMo.New()
	end

	return self._customFmtMo
end

function FamilyHoudingClgModel:getCurPlanId()
	return self._curPlanId
end

function FamilyHoudingClgModel:getCurDayIndex()
	return self._curDayIndex
end

function FamilyHoudingClgModel:getCurBuffId()
	return self._curBuffId
end

function FamilyHoudingClgModel:getLeftChallengeTimes()
	return self._leftChallengeTimes
end

function FamilyHoudingClgModel:getFamilyTopN()
	return self._familyTopN
end

function FamilyHoudingClgModel:getPersonTopN()
	return self._personTopN
end

function FamilyHoudingClgModel:getRankInfoListOfFamily()
	return self._rankMsgOfFamily.rankInfo or {}
end

function FamilyHoudingClgModel:getMyFamilyScoreOfFamily()
	return checknumber(self._rankMsgOfFamily.myFamilyScore)
end

function FamilyHoudingClgModel:getMyFamilyRankOfFamily()
	return checknumber(self._rankMsgOfFamily.myFamilyRank)
end

function FamilyHoudingClgModel:getRankInfoListOfPerson()
	return self._rankMsgOfPerson.rankInfo or {}
end

function FamilyHoudingClgModel:getMyFamilyScoreOfPerson()
	return checknumber(self._rankMsgOfPerson.myScore)
end

function FamilyHoudingClgModel:getMyFamilyRankOfPerson()
	return checknumber(self._rankMsgOfPerson.myRank)
end

function FamilyHoudingClgModel:getFightResult()
	return self._fightResult
end

function FamilyHoudingClgModel:getPracticeResult()
	return self._fightResult
end

FamilyHoudingClgModel.instance = FamilyHoudingClgModel.New()

return FamilyHoudingClgModel
