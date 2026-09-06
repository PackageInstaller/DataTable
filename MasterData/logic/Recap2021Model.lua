-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/model/Recap2021Model.lua

module("logic.extensions.recap2021.view.Recap2021Model", package.seeall)

local Recap2021Model = class("Recap2021Model", BaseModel)

function Recap2021Model:ctor()
	return
end

function Recap2021Model:onInit()
	self:onReset()
end

function Recap2021Model:onReset()
	self._letterPrizeIds = {}
	self._editionPrizeIds = {}
	self._recap21Datas = {}
	self._recap21Editions = {}
	self._tagCache = {}
	self._share10_gainTime = 0
end

function Recap2021Model:setInfo(msg)
	self._letterPrizeIds = msg.letterPrizeIds
	self._editionPrizeIds = msg.editionPrizeIds
	self._recap21Datas = msg.items
	self._recap21Editions = msg.editions
end

function Recap2021Model:gainLetterPrizeRes(letterPrizeId)
	self._letterPrizeIds:append(letterPrizeId)
end

function Recap2021Model:gainEditionPrizeRes(editionId)
	self._editionPrizeIds:append(editionId)
end

function Recap2021Model:getPersonLookBackViewDatas()
	if not self._cachePersonLookbackViewDatas then
		local mos = {}
		local PERSON_EVENT_ID = Recap2021Config.instance:getCommonValue("PERSON_EVENT_ID", true)
		local cfgs = Recap2021Config.instance:getPersonLookBackCfgs(PERSON_EVENT_ID)

		for i, viewCfg in ipairs(cfgs) do
			local dCfgs = Recap2021Config.instance:getPersonDetailCfgs(viewCfg.detailPlanId)

			for page, v in ipairs(dCfgs) do
				local data = PersonLookbackMo.New()

				data.viewCfg = viewCfg
				data.tagCfgs = v
				data.page = page
				data.totalPage = #v

				table.insert(mos, data)
			end
		end

		self._cachePersonLookbackViewDatas = mos
	end

	return self._cachePersonLookbackViewDatas
end

function Recap2021Model:getVaueByDataId(dataId)
	local value = -1

	for i, v in ipairs(self._recap21Datas) do
		if v.recapType == dataId then
			value = v.value

			break
		end
	end

	return value
end

function Recap2021Model:getDescByDataId(dataId)
	local value = -1

	for i, v in ipairs(self._recap21Datas) do
		if v.recapType == dataId then
			value = v.value

			break
		end
	end

	if value == -1 or string.nilorempty(value) then
		return -1
	end

	local res = self:getDescByDataValue(dataId, value)

	if not string.nilorempty(res) then
		return res
	end

	return -1
end

function Recap2021Model:getDescByDataValue(dataId, value)
	local desc = -1

	if string.nilorempty(value) then
		return desc
	end

	if dataId == GameEnum.Recap21Type.GOOD_FEELING_MAX_RACE or dataId == GameEnum.Recap21Type.MAX_ZDL_RACE or dataId == GameEnum.Recap21Type.MAX_SSR_RACE or dataId == GameEnum.Recap21Type.FIRST_AWAKEN_RACE then
		local petCo = CharacterConfig.instance:getPetCo(checkint(value))

		if petCo then
			desc = petCo.name
		end
	elseif dataId == GameEnum.Recap21Type.DECOMPOSE_PET or dataId == GameEnum.Recap21Type.FULL_LEVEL_PETS or dataId == GameEnum.Recap21Type.PET_HISTORY_COUNT then
		desc = value
	elseif dataId == GameEnum.Recap21Type.MAX_ZDL_SIX_PETS then
		return value
	elseif dataId == GameEnum.Recap21Type.ARENA_BEST_POSITION then
		local tcfgs = ArenaConfig.instance:getArenaTopGroupCfgs()
		local lastPosition = 0

		value = checkint(value)

		local hit = false

		for i, v in ipairs(tcfgs) do
			if lastPosition < value and value <= v.numOrPercent then
				desc = v.topGroupName
				hit = true

				break
			end

			lastPosition = v.numOrPercent
		end
	elseif dataId == GameEnum.Recap21Type.ARENA_3V3_GAIN_PRIZE then
		local rank = checknumber(value)

		if rank > 0 then
			local rcfg = SeniorArenaConfig.instance:getRankCfgByRank(rank)

			if rcfg then
				desc = rcfg.rankName
			end
		end
	elseif dataId == GameEnum.Recap21Type.RANKING_MATCH_CLASSIC_BEST_TOP_GROUP then
		local rankId = checknumber(value)

		if rankId > 0 then
			local cfgs = RankRaceConfig.instance:getRankLevelConfig()

			if cfgs[rankId] then
				desc = cfgs[rankId].levelName
			end
		end
	elseif dataId == GameEnum.Recap21Type.RANKING_MATCH_EXTREME_BEST_TOP_GROUP then
		local rankId = checknumber(value)

		if rankId > 0 then
			local cfgs = RankRaceConfig.instance:getRankLevelConfig()

			if cfgs[rankId] then
				desc = cfgs[rankId].levelName
			end
		end
	else
		desc = dataId == GameEnum.Recap21Type.BATTLE_COUNT and value or (dataId == GameEnum.Recap21Type.TOTAL_MOUNT or dataId == GameEnum.Recap21Type.EVER_HEAD_ICON or dataId == GameEnum.Recap21Type.EVER_TITLE or dataId == GameEnum.Recap21Type.EVER_HEAD_FRAME or dataId == GameEnum.Recap21Type.SKINS or dataId == GameEnum.Recap21Type.CLOTHES) and value or dataId == GameEnum.Recap21Type.TOTAL_ONLINE and math.floor(checkint(value) / 60) or (dataId == GameEnum.Recap21Type.USE_STRENGTH or dataId == GameEnum.Recap21Type.TOTAL_GAIN_DIAMOND or dataId == GameEnum.Recap21Type.TOTAL_LOTTERY_PET or dataId == GameEnum.Recap21Type.TOTAL_LOTTERY_EQM) and value or (dataId == GameEnum.Recap21Type.DAYS_IN_0_TO_5 or dataId == GameEnum.Recap21Type.TOTAL_ONLINE_DAYS or dataId == GameEnum.Recap21Type.LATEST_LOG_OUT) and value or value
	end

	return desc
end

function Recap2021Model:isNumberValueByDataId(dataId)
	local flag = false

	if dataId == GameEnum.Recap21Type.DECOMPOSE_PET or dataId == GameEnum.Recap21Type.FULL_LEVEL_PETS or dataId == GameEnum.Recap21Type.PET_HISTORY_COUNT then
		flag = true
	elseif dataId == GameEnum.Recap21Type.BATTLE_COUNT then
		flag = true
	elseif dataId == GameEnum.Recap21Type.TOTAL_MOUNT or dataId == GameEnum.Recap21Type.EVER_HEAD_ICON or dataId == GameEnum.Recap21Type.EVER_TITLE or dataId == GameEnum.Recap21Type.EVER_HEAD_FRAME or dataId == GameEnum.Recap21Type.SKINS or dataId == GameEnum.Recap21Type.CLOTHES then
		flag = true
	elseif dataId == GameEnum.Recap21Type.TOTAL_ONLINE or dataId == GameEnum.Recap21Type.USE_STRENGTH or dataId == GameEnum.Recap21Type.TOTAL_GAIN_DIAMOND or dataId == GameEnum.Recap21Type.TOTAL_LOTTERY_PET or dataId == GameEnum.Recap21Type.TOTAL_LOTTERY_EQM then
		flag = true
	elseif dataId == GameEnum.Recap21Type.DAYS_IN_0_TO_5 or dataId == GameEnum.Recap21Type.TOTAL_ONLINE_DAYS or dataId == GameEnum.Recap21Type.LATEST_LOG_OUT then
		flag = true
	elseif dataId == GameEnum.Recap21Type.ARENA_BEST_POSITION then
		flag = true
	elseif dataId == GameEnum.Recap21Type.ARENA_3V3_GAIN_PRIZE then
		flag = true
	elseif dataId == GameEnum.Recap21Type.RANKING_MATCH_CLASSIC_BEST_TOP_GROUP then
		flag = true
	elseif dataId == GameEnum.Recap21Type.RANKING_MATCH_EXTREME_BEST_TOP_GROUP then
		flag = true
	elseif dataId == GameEnum.Recap21Type.MAX_ZDL_RACE then
		flag = true
	elseif dataId == GameEnum.Recap21Type.MAX_SSR_RACE then
		flag = true
	elseif dataId == GameEnum.Recap21Type.FIRST_AWAKEN_RACE then
		flag = true
	elseif dataId == GameEnum.Recap21Type.DECOMPOSE_PET then
		flag = true
	elseif dataId == GameEnum.Recap21Type.PEAK_TOURNAMENT_WIN_TIMES then
		flag = true
	elseif dataId == GameEnum.Recap21Type.SEASON_MODE_PARTICIPATION_TIMES then
		flag = true
	elseif dataId == GameEnum.Recap21Type.SEASON_MODE_OCCUPIED_NUM then
		flag = true
	end

	return flag
end

function Recap2021Model:getVaueByEditionDataId(editionId, dataId)
	for i, v1 in ipairs(self._recap21Editions) do
		if editionId == v1.editionId then
			for _, v in ipairs(v1.editionData) do
				if v.recapType == dataId then
					return v.value
				end
			end
		end
	end

	return -1
end

function Recap2021Model:isJudgePass(judgePlanId)
	local pass = false
	local jcfg = Recap2021Config.instance:getJudgeCfg(judgePlanId)

	if jcfg.judgeType == "TOTAL_ADD_PERCENT" then
		local totalPercent = 0

		for i, id in ipairs(jcfg.dataIds) do
			local value = self:getVaueByDataId(id)

			value = checkint(value)
			totalPercent = totalPercent + value / self:_getTotalValueByDataId(id)
		end

		local nums = string.split(jcfg.judgeValue, ",")
		local num1 = checknumber(nums[1])
		local num2 = checknumber(nums[2])

		pass = num1 < totalPercent and totalPercent <= num2
	elseif jcfg.judgeType == "MORE_THEN" then
		local totalSce = self:getVaueByDataId(jcfg.dataIds[1])

		totalSce = checkint(totalSce)

		local totalDay = self:getVaueByDataId(jcfg.dataIds[2])

		totalDay = checkint(totalDay)

		local num1 = checknumber(jcfg.judgeValue)

		pass = num1 <= ((totalDay > 0 and totalSce > 0 or nil) and totalSce / 60 / totalDay)
	end

	return pass
end

function Recap2021Model:_getTotalValueByDataId(dataId)
	local value = 0

	if dataId == GameEnum.Recap21Type.TOTAL_MOUNT then
		value = #MountConfig.instance:getAllMounts()
	elseif dataId == GameEnum.Recap21Type.EVER_HEAD_ICON then
		value = #HeadItemConfig.instance:getAllHeadIconList()
	elseif dataId == GameEnum.Recap21Type.EVER_TITLE then
		value = #TitleConfig.instance:getCfg().dataList
	elseif dataId == GameEnum.Recap21Type.EVER_HEAD_FRAME then
		value = #HeadItemConfig.instance:getAllHeadFrameList()
	elseif dataId == GameEnum.Recap21Type.SKINS then
		value = 0

		local list = PetSkinConfig.instance:getPetSkinCfgList()

		for i, v in ipairs(list) do
			if v.skinId ~= v.raceId then
				value = value + 1
			end
		end
	elseif dataId == GameEnum.Recap21Type.CLOTHES then
		value = #DressConfig.instance:getAllConfig().dataList
	end

	return value
end

function Recap2021Model:getJudgeBestCfgId(judgeCfgIds)
	local finalId = -1
	local first_judgePlanId = judgeCfgIds and judgeCfgIds[1]

	if not first_judgePlanId then
		return finalId
	end

	local jcfg = Recap2021Config.instance:getJudgeCfg(first_judgePlanId)

	if jcfg.judgeType == "TOTAL_ADD_PERCENT" then
		local maxNum = -1

		for i, v in ipairs(judgeCfgIds) do
			local s_jcfg = Recap2021Config.instance:getJudgeCfg(v)
			local nums = string.split(jcfg.judgeValue, ",")
			local num2 = checknumber(nums[2])

			if maxNum < num2 then
				maxNum = num2
				finalId = s_jcfg.judgePlanId
			end
		end
	elseif jcfg.judgeType == "MORE_THEN" then
		local maxNum = -1

		for i, v in ipairs(judgeCfgIds) do
			local s_jcfg = Recap2021Config.instance:getJudgeCfg(v)
			local num2 = checknumber(jcfg.judgeValue)

			if maxNum < num2 then
				maxNum = num2
				finalId = s_jcfg.judgePlanId
			end
		end
	end

	return finalId
end

function Recap2021Model:getBestTagDesc(tagPlanId, index)
	local tagCfgs = Recap2021Config.instance:getPersonLookBackTagCfgs(tagPlanId)
	local passList = {}
	local judgePlanIdKey_list = {}

	for i, v in ipairs(tagCfgs) do
		local isPass = Recap2021Model.instance:isJudgePass(v.judgePlanId)

		if isPass then
			table.insert(passList, v.judgePlanId)

			judgePlanIdKey_list[v.judgePlanId] = v
		end
	end

	local judgePlanId = self:getJudgeBestCfgId(passList)

	if judgePlanId <= 0 then
		return ""
	end

	local tagCfg = judgePlanIdKey_list[judgePlanId]

	self:setTagCache(index, tagCfg.tagDesc)

	return string.format(tagCfg.desc, tagCfg.tagDesc)
end

function Recap2021Model:getBattleTagDesc(tagPlanId)
	local tagCfgs = Recap2021Config.instance:getPersonLookBackTagCfgs(tagPlanId)
	local tagDesc = ""
	local battJudgeCfgs = Recap2021Config.instance:getBattleJudgeCfgs()
	local arenaRankStage = -1
	local battleTimeStage = -1

	for i, v in ipairs(battJudgeCfgs) do
		local value = self:getVaueByDataId(v.dataId1)

		value = math.max(0, checkint(value))

		if arenaRankStage == -1 and value >= v.ranks[1] and value <= v.ranks[2] then
			arenaRankStage = v.stage
		end

		value = self:getVaueByDataId(v.dataId2)
		value = math.max(0, checkint(value))

		if battleTimeStage == -1 and value >= v.battleTime then
			battleTimeStage = v.stage
		end
	end

	local descStr = ""

	if arenaRankStage == -1 and battleTimeStage == -1 then
		tagDesc = "初级训练师"

		self:setTagCache(1, "初级训练师")

		return tagDesc
	end

	if battleTimeStage == -1 or arenaRankStage > 0 and arenaRankStage < battleTimeStage then
		tagDesc = battJudgeCfgs[arenaRankStage].tag1
		descStr = battJudgeCfgs[arenaRankStage].desc1
	elseif arenaRankStage == -1 or battleTimeStage > 0 and battleTimeStage < arenaRankStage then
		tagDesc = battJudgeCfgs[battleTimeStage].tag2
		descStr = battJudgeCfgs[battleTimeStage].desc2
	else
		tagDesc = battJudgeCfgs[arenaRankStage].tag1
		descStr = battJudgeCfgs[arenaRankStage].desc1
	end

	self:setTagCache(1, tagDesc)

	return string.format(descStr, tagDesc)
end

function Recap2021Model:setTagCache(index, desc)
	self._tagCache[index] = desc
end

function Recap2021Model:getCacheTag(index)
	return self._tagCache[index] or "无"
end

function Recap2021Model:setShare10GainTime(gainTime)
	self._share10_gainTime = gainTime
end

function Recap2021Model:isGainLetterPrize(letterPrizeId)
	for i, v in ipairs(self._letterPrizeIds) do
		if v == letterPrizeId then
			return true
		end
	end

	return false
end

function Recap2021Model:isCanGainLetterPrize(letterPrizeId)
	if not self:isGainLetterPrize(letterPrizeId) then
		return true
	end

	return false
end

function Recap2021Model:isGainEditionIdPrize(editionId)
	for i, v in ipairs(self._editionPrizeIds) do
		if v == editionId then
			return true
		end
	end

	return false
end

function Recap2021Model:isCanGainEditionIdPrize(editionId)
	if not self:isGainEditionIdPrize(editionId) then
		local ecfg = Recap2021Config.instance:getEditionCfg(editionId)

		return not string.nilorempty(ecfg.prize)
	end

	return false
end

function Recap2021Model:checkMsgPrizeRed()
	local list = Recap2021Config.instance:getLetterPrizeCfgs()

	for i, v in ipairs(list) do
		if self:isCanGainLetterPrize(v.letterPrizeId) then
			return true
		end
	end

	return false
end

function Recap2021Model:checkGameEventPrizeRed()
	local list = Recap2021Config.instance:getEditionCfgs()

	for i, v in ipairs(list) do
		if self:isCanGainEditionIdPrize(v.editionId) then
			return true
		end
	end

	return false
end

function Recap2021Model:checkPersonEventPrizeRed()
	local cfg = ShareConfig.instance:getShareById(10)

	return self._share10_gainTime < cfg.limitTimes
end

Recap2021Model.instance = Recap2021Model.New()

return Recap2021Model
