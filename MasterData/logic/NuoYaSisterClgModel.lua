-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/model/NuoYaSisterClgModel.lua

module("logic.extensions.nuoyasisterclg.model.NuoYaSisterClgModel", package.seeall)

local NuoYaSisterClgModel = class("NuoYaSisterClgModel", BaseModel)

NuoYaSisterClgModel.BOSSA_ID = 0
NuoYaSisterClgModel.BOSSB_ID = 1

function NuoYaSisterClgModel:ctor()
	return
end

function NuoYaSisterClgModel:onInit()
	NuoYaSisterClgModel.super.onInit(self)
	self:onReset()
end

function NuoYaSisterClgModel:onReset()
	self._info = {}
	self._comFmtMo = nil
	self._extFmtMo = nil
end

function NuoYaSisterClgModel:saveExtremeClgInfo(msg)
	self._info[msg.activityId] = self._info[msg.activityId] or {}

	local info = self._info[msg.activityId]

	info.extremeInfo = GameUtil.pbToTable(msg)

	local extremeInfo = info.extremeInfo
	local teamInfoMap = {}
	local petInfos = {}

	if extremeInfo.types then
		for i, v in ipairs(extremeInfo.types) do
			teamInfoMap[v.typeId] = {}

			if v.pets then
				teamInfoMap[v.typeId].pets = {}

				for j, petInfo in ipairs(v.pets) do
					petInfos[petInfo.petId] = petInfo

					table.insert(teamInfoMap[v.typeId].pets, petInfo.petId)
				end
			end

			teamInfoMap[v.typeId].stageNum = v.stageNum
		end
	end

	extremeInfo.teamInfoMap = teamInfoMap
	extremeInfo.petInfos = petInfos
end

function NuoYaSisterClgModel:saveExtremeClgTeamInfo(msg)
	local data = GameUtil.pbToTable(msg)

	if not self._info[data.activityId] then
		local info = {}

		info.extremeInfo = info.extremeInfo or {}

		local extremeInfo = info.extremeInfo
		local teamInfoMap = {}
		local petInfos = {}

		for i, v in ipairs(data.selects) do
			teamInfoMap[v.typeId] = {}
			teamInfoMap[v.typeId].pets = v.petIds
			teamInfoMap[v.typeId].stageNum = 0
		end

		extremeInfo.teamInfoMap = teamInfoMap
		extremeInfo.petInfos = petInfos
		extremeInfo.types = {}
		extremeInfo.curStageId = 0
	end
end

function NuoYaSisterClgModel:saveExtremeClgResetInfo(msg)
	local info = self._info[msg.activityId]

	if info then
		local extremeInfo = info.extremeInfo

		extremeInfo.types = nil
		extremeInfo.curStageId = 0
		extremeInfo.petInfos = nil
	end
end

function NuoYaSisterClgModel:resetTeamInfoMap(activityId)
	local info = self._info[activityId]

	if info then
		local extremeInfo = info.extremeInfo

		extremeInfo.teamInfoMap = nil
	end
end

function NuoYaSisterClgModel:saveExtremeClgBattle(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._info[data.activityId]
	local extremeInfo = info.extremeInfo

	extremeInfo.curStageId = data.stageId

	if extremeInfo.maxStageId < data.stageId then
		extremeInfo.maxStageId = data.stageId
	end

	local teamInfoMap = extremeInfo.teamInfoMap

	teamInfoMap[data.type.typeId] = {}

	if data.type.pets then
		teamInfoMap[data.type.typeId].pets = {}

		for j, petInfo in ipairs(data.type.pets) do
			extremeInfo.petInfos[petInfo.petId] = petInfo

			table.insert(teamInfoMap[data.type.typeId].pets, petInfo.petId)
		end
	end

	teamInfoMap[data.type.typeId].stageNum = data.type.stageNum
end

function NuoYaSisterClgModel:saveCommonClgInfo(msg)
	self._info[msg.activityId] = self._info[msg.activityId] or {}

	local info = self._info[msg.activityId]

	info.commonInfo = GameUtil.pbToTable(msg)

	local commonInfo = info.commonInfo
	local originTime, _ = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.NuoYaSisterClg, msg.activityId)
	local day = GameUtil.getDaysByTimestamp(originTime, ServerTime.now())
	local bossCfgs = NuoYaSisterClgConfig.instance:getCommonBossCfgs(msg.activityId)

	day = day % #bossCfgs

	if day == 0 then
		day = #bossCfgs
	end

	commonInfo.day = day

	local gainPrizeMap = {}

	if commonInfo.gainedPrizeIds then
		for i, v in ipairs(commonInfo.gainedPrizeIds) do
			gainPrizeMap[v] = true
		end
	end

	commonInfo.gainPrizeMap = gainPrizeMap
	commonInfo.todayGainedScoreIds = commonInfo.todayGainedScoreIds or {}
end

function NuoYaSisterClgModel:saveCommonPrize(msg)
	local info = self._info[msg.activityId]
	local commonInfo = info.commonInfo

	commonInfo.gainPrizeMap[msg.prizeId] = true
end

function NuoYaSisterClgModel:saveCommonClgBattle(msg)
	local info = self._info[msg.activityId]

	if info and info.commonInfo then
		if msg.bossId == NuoYaSisterClgModel.BOSSA_ID then
			info.commonInfo.bossADamage = msg.maxDamage
		else
			info.commonInfo.bossBDamage = msg.maxDamage
		end
	end

	local commonInfo = info.commonInfo

	if checknumber(msg.gainedScoreId) > 0 then
		table.insert(commonInfo.todayGainedScoreIds, msg.gainedScoreId)

		local totalScore = 0
		local damageCfg = NuoYaSisterClgConfig.instance:getCommonDamageCfgByIndex(msg.activityId, commonInfo.day, msg.gainedScoreId)

		commonInfo.totalScore = totalScore + damageCfg.addScore
	end
end

function NuoYaSisterClgModel:getExtFmtMo()
	self._extFmtMo = self._extFmtMo or NuoYaSisterClgExtFmtMo.New()

	return self._extFmtMo
end

function NuoYaSisterClgModel:getComFmtMo()
	self._comFmtMo = self._comFmtMo or NuoYaSisterClgComFmtMo.New()

	return self._comFmtMo
end

function NuoYaSisterClgModel:IsInitTeam(activityId)
	local info = self._info[activityId]

	if info and info.extremeInfo and info.extremeInfo.types then
		return true
	end

	return false
end

function NuoYaSisterClgModel:getTeamInfo(activityId, teamId)
	local info = self._info[activityId]

	if info and info.extremeInfo and info.extremeInfo.teamInfoMap then
		return info.extremeInfo.teamInfoMap[teamId] or {}
	end

	return {}
end

function NuoYaSisterClgModel:getPetInfo(activityId, petId)
	local info = self._info[activityId]

	if info and info.extremeInfo and info.extremeInfo.petInfos then
		return info.extremeInfo.petInfos[petId]
	end

	return nil
end

function NuoYaSisterClgModel:getCurStageId(activityId)
	local info = self._info[activityId]

	if info and info.extremeInfo then
		return info.extremeInfo.curStageId or 0
	end

	return 0
end

function NuoYaSisterClgModel:getMaxStageId(activityId)
	local info = self._info[activityId]

	if info and info.extremeInfo then
		return info.extremeInfo.maxStageId or 0
	end

	return 0
end

function NuoYaSisterClgModel:getBossADamage(activityId)
	local info = self._info[activityId]

	if info and info.commonInfo then
		return info.commonInfo.bossADamage or 0
	end

	return 0
end

function NuoYaSisterClgModel:getBossBDamage(activityId)
	local info = self._info[activityId]

	if info and info.commonInfo then
		return info.commonInfo.bossBDamage or 0
	end

	return 0
end

function NuoYaSisterClgModel:getCommonScore(activityId)
	local info = self._info[activityId]

	if info and info.commonInfo then
		return info.commonInfo.totalScore or 0
	end

	return 0
end

function NuoYaSisterClgModel:getCommonDay(activityId)
	local info = self._info[activityId]

	if info and info.commonInfo then
		return info.commonInfo.day or 1
	end

	return 1
end

function NuoYaSisterClgModel:isCanGetProgressReward(activityId, prizeId)
	local cfg = NuoYaSisterClgConfig.instance:getProgressRewardCfg(activityId, prizeId)
	local score = self:getCommonScore(activityId)

	return score >= cfg.needScore and not self:isGetedProgressReward(activityId, prizeId)
end

function NuoYaSisterClgModel:isGetedProgressReward(activityId, prizeId)
	local info = self._info[activityId]

	if info and info.commonInfo and info.commonInfo.gainPrizeMap then
		return info.commonInfo.gainPrizeMap[prizeId] or false
	end

	return false
end

function NuoYaSisterClgModel:saveTempSelectTeam(tableMap)
	self._tempSelectTeam = tableMap
end

function NuoYaSisterClgModel:getTempSelectTeam()
	return self._tempSelectTeam
end

NuoYaSisterClgModel.instance = NuoYaSisterClgModel.New()

return NuoYaSisterClgModel
