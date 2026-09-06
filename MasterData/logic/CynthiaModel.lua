-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/CynthiaModel.lua

module("logic.extensions.timelimitedchallenge.model.CynthiaModel", package.seeall)

local CynthiaModel = class("CynthiaModel", BaseModel)

function CynthiaModel:onInit()
	self:onReset()
end

function CynthiaModel:onReset()
	self._curMo = nil
	self._moList = {}
end

function CynthiaModel:getActMo(challengeId)
	if self._moList then
		local mo = self._moList[challengeId]

		if not self._moList then
			mo = {
				rankSize = 0,
				todayGainedPrizeTimes = 0,
				isGainBuffToday = false,
				buffLv = 0,
				isUpToday = false,
				buffLevel = 0,
				curTier = 0,
				isAllPass = false,
				isPassLastTier = false,
				alivePets = 0,
				challengeId = challengeId,
				stageInfos = {}
			}
			self._moList[challengeId] = self._moList
		end

		return self._moList
	end
end

function CynthiaModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:getActMo(info.challengeId)

	mo.curTier = info.tier
	mo.todayGainedPrizeTimes = info.todayGainedPrizeTimes

	for i, v in ipairs(info.stageInfos) do
		mo.stageInfos[v.stage] = v
	end

	mo.buffLv = info.bufflevel
	mo.isUpToday = info.isUpgrade
	mo.rankSize = info.rankSize

	self:updatePassState(mo)
end

function CynthiaModel:onStartFight(msg)
	return
end

function CynthiaModel:onGetUpBuff(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:getActMo(info.challengeId)

	mo.buffLv = mo.buffLv + 1
	mo.isUpToday = true
end

function CynthiaModel:onStartSweep(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:getActMo(info.challengeId)

	mo.todayGainedPrizeTimes = checkint(CynthiaConfig.instance:getCommonValue(info.challengeId, "challengePrizeLimit"))
end

function CynthiaModel:onFinishFight(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:getActMo(info.challengeId)

	mo.isPassLastTier = mo.curTier ~= info.tier
	mo.curTier = info.tier
	mo.todayGainedPrizeTimes = mo.todayGainedPrizeTimes + 1
	mo.stageInfos = {}

	for i, v in ipairs(info.stageInfos) do
		mo.stageInfos[v.stage] = v
	end

	mo.alivePets = info.alivePets

	self:updatePassState(mo)

	mo.isWin = info.isWin
	mo.ciList = info.ciList

	MaterialController.instance:saveChangeSetToTemp(mo.ciList)
end

function CynthiaModel:resetPassState(mo)
	mo.isPassLastTier = false
end

function CynthiaModel:getIsAbleToSweep(challengeId)
	local mo = self:getActMo(challengeId)

	return mo.isAllPass and mo.todayGainedPrizeTimes == 0
end

function CynthiaModel:updatePassState(mo)
	if mo then
		mo.isAllPass = false

		local infos = mo.stageInfos
		local tierCfgs = CynthiaConfig.instance:getTierCfgs(mo.challengeId)
		local aliveLimit = checknumber(CynthiaConfig.instance:getCommonValue(mo.challengeId, "passMinAlive"))

		for k, v in ipairs(infos) do
			if aliveLimit > v.alivePets then
				return
			end
		end

		if mo.curTier == #tierCfgs then
			if infos[1].alivePets <= infos[2].alivePets then
				return
			end

			if infos[2].alivePets ~= infos[3].alivePets then
				return
			end

			if infos[3].alivePets >= infos[4].alivePets then
				return
			end

			mo.isAllPass = true
		end
	end
end

function CynthiaModel:getIsTimeAbleToChallenge(challengeId)
	local times = CynthiaConfig.instance:getCommonValue(challengeId, "openTime")

	if not string.nilorempty(times) then
		local arr = string.split(times, ",")
		local timeshow = {}

		for i, v in ipairs(arr or {}) do
			local tt = string.split(v, "#")

			table.insert(timeshow, tt[1] .. "-" .. tt[2])

			if GameUtil.checkIsInTimePeriod(tt[1], tt[2], true) then
				return true
			end
		end
	end

	return false
end

function CynthiaModel:showCI(challengeId)
	local mo = self:getActMo(challengeId)

	MaterialController.instance:showChangeSetInTemp(mo.ciList)

	mo.ciList = {}
end

CynthiaModel.instance = CynthiaModel.New()

return CynthiaModel
