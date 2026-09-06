-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenchallenge/model/LingShenChallengeModel.lua

module("logic.extensions.lingshenchallenge.model.LingShenChallengeModel", package.seeall)

local LingShenChallengeModel = class("LingShenChallengeModel", BaseModel)

LingShenChallengeModel.ReadFlag = "LingShenChallengeModel.ReadFlag"

function LingShenChallengeModel:ctor()
	LingShenChallengeModel.super.ctor(self)
end

function LingShenChallengeModel:onInit()
	self:onReset()
end

function LingShenChallengeModel:onReset()
	self._infos = {}
	self._fightInfo = nil
	self._readyMap = {}
	self._fmtMo = nil
end

function LingShenChallengeModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.LingShenChallenge)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.LingShenChallenge)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.LingShenChallenge, v.activityId) then
			local cfg = LingShenChallengeConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end

			printError("====t_ling_shen_challenge no cfg, id = " .. v, activityId)

			break
		end
	end

	return actId
end

function LingShenChallengeModel:saveInfo(msg)
	local info = GameUtil.pbToTable(msg)

	info.petFormPosPet = {}
	info.petFormPosPet[1] = info.form.pos[2]
	info.petFormPosPet[2] = info.form.pos[5]
	info.petFormPosPet[3] = info.form.pos[8]
	info.bossInfoMap = {}

	for i, v in ipairs(info.bossInfoList) do
		info.bossInfoMap[v.bossId] = v
	end

	info.daliyMaxDamage = checknumber(info.daliyMaxDamage)
	self._infos[info.activityId] = info
end

function LingShenChallengeModel:getInfo(activityId)
	return self._infos[activityId]
end

function LingShenChallengeModel:getBossInfo(activityId, bossId)
	local info = self:getInfo(activityId)

	if info then
		return info.bossInfoMap[bossId]
	end
end

function LingShenChallengeModel:getPetFormPosPet(activityId)
	local info = self:getInfo(activityId)

	return info and info.petFormPosPet
end

function LingShenChallengeModel:getFormTeamFmtMo()
	self._fmtMo = self._fmtMo or LingShenChallengeSetFmtMo.New()

	return self._fmtMo
end

function LingShenChallengeModel:getFightFmtMo()
	self._fightFmtMo = self._fightFmtMo or LingShenChallengeFmtMo.New()

	return self._fightFmtMo
end

function LingShenChallengeModel:saveFightInfo(msg)
	self._fightInfo = msg
	self._fightActivityId = msg.activityId
	self._fightBossId = msg.bossId
	self._fightPlayerList = msg.playerList
	self._fightForm = msg.form
end

function LingShenChallengeModel:resetFightInfo()
	self._fightInfo = nil
	self._readyMap = {}
end

function LingShenChallengeModel:saveFightInfoFrom(msg)
	if self._fightForm.formVersion < msg.form.formVersion then
		self._fightForm = msg.form
	end
end

function LingShenChallengeModel:setReadyStatus(playerId)
	self._readyMap[playerId] = true
end

function LingShenChallengeModel:getReadyStatus()
	return self._readyMap
end

function LingShenChallengeModel:getFightInfo()
	return self._fightInfo
end

function LingShenChallengeModel:getFightFrom()
	return self._fightForm
end

function LingShenChallengeModel:getDailyDamage(activityId)
	local info = self:getInfo(activityId)

	return (info or nil) and (info.daliyMaxDamage or 0)
end

function LingShenChallengeModel:isCanGetProgressReward(activityId, bossId, prizeId)
	return false
end

function LingShenChallengeModel:isGetedProgressReward(activityId, bossId, prizeId)
	local bossCfg = LingShenChallengeConfig.instance:getBossCfg(activityId, bossId)
	local prizeCfg = LingShenChallengeConfig.instance:getPrizeCfg(bossCfg.prizePlanId, prizeId)
	local info = self:getInfo(activityId)

	return info and info.daliyMaxDamage > prizeCfg.damage or false
end

function LingShenChallengeModel:setBossInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self:getInfo(data.activityId)
	local damage = checknumber(data.damage)

	if info and (not info.daliyMaxDamage or damage > info.daliyMaxDamage) then
		info.daliyMaxDamage = checknumber(data.damage)

		local historyDamage = checknumber(info.bossInfoMap[data.bossId].historyMaxDamge)

		if historyDamage < damage then
			info.bossInfoMap[data.bossId].historyMaxDamge = damage
		end
	end
end

LingShenChallengeModel.instance = LingShenChallengeModel.New()

return LingShenChallengeModel
