-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petsearch/model/PetsearchModel.lua

module("logic.extensions.petsearch.model.PetsearchModel", package.seeall)

local PetsearchModel = class("PetsearchModel", BaseModel)

function PetsearchModel:ctor()
	self:onReset()
end

function PetsearchModel:onReset()
	self._curBossId = nil
	self._curCyCleId = nil
	self._curChallengeTimes = 0
	self._curRefreshTimes = 0
	self._curZDL = 0
end

function PetsearchModel:setCurBossId(bossInfo)
	self._curBossId = checkint((bossInfo or nil) and (bossInfo.bossId or nil))
	self._curZDL = checkint((bossInfo or nil) and (bossInfo.zdl or nil))
end

function PetsearchModel:getCurBossId()
	return self._curBossId
end

function PetsearchModel:getCurZDL()
	return self._curZDL
end

function PetsearchModel:addCurRefreshTimes()
	self._curRefreshTimes = self._curRefreshTimes + 1
end

function PetsearchModel:getCurChallengeTimes()
	local totaltimes = checkint(PetsearchConfig.instance:getParamValueByKey("CHALLENGE_TIMES"))

	return totaltimes - self._curChallengeTimes
end

function PetsearchModel:getCurRreshCost()
	return PetsearchConfig.instance:getRefreshCostByTimes(self._curRefreshTimes + 1)
end

function PetsearchModel:updateAfterGetInfo(msg)
	self:setCurBossId(msg.boss)

	self._curChallengeTimes = checkint(msg.challengeTimes)
	self._curRefreshTimes = checkint(msg.refreshTimes)
end

PetsearchModel.instance = PetsearchModel.New()

return PetsearchModel
