-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/model/MahjongBattleModel.lua

module("logic.extensions.mahjongbattle.model.MahjongBattleModel", package.seeall)

local MahjongBattleModel = class("MahjongBattleModel", BaseModel)

MahjongBattleModel.PLAYER_STATE = {
	WAITING_DRAW_MAHJONG = "waiting_draw_mahjong",
	WAITING_SELECT_MAHJONG = "waiting_select_mahjong",
	MATCHED_OPPONENT = "matched_opponent",
	WAITING_SELECT_SUMMON_PET = "waiting_select_summon_pet",
	WAITING_MATCH_OPPONENT = "waiting_match_opponent",
	WAITING_DROP_MAHJONG = "waiting_drop_mahjong",
	WAITING_OPERATION = "waiting_operation",
	WAITING_SELECT_TEAM = "waiting_select_team",
	WAITING_SELECT_SUMMON_BUFF = "waiting_select_summon_buff",
	NONE = "none"
}
MahjongBattleModel.SUMMON_TYPE = {
	GANGZI = 3,
	SANLIANGGANG = 8,
	ERLIANGGANG = 7,
	DIHU = 6,
	SILIANGGANG = 9,
	QINGYISE = 4,
	PINGHU = 5,
	SHUNZI = 1,
	KEZI = 2,
	NONE = 0
}

function MahjongBattleModel:onInit()
	self:onReset()
end

function MahjongBattleModel:onReset()
	self._curStateMap = {}
	self._baseInfoMap = {}
	self._rankInfoMap = {}
	self._reportInfoMap = {}
	self._lastFightResult = nil
	self._petMap = {}
end

function MahjongBattleModel:getBaseInfoByActId(activityId)
	local info = self._baseInfoMap[activityId]

	if not info then
		printInfo("麻将对战数据不存在，activityId=%d", activityId)
	end

	return self._baseInfoMap[activityId]
end

function MahjongBattleModel:getCurGenreIdsByActId(activityId)
	local curGenreIds = {}
	local isTeachMode = MahjongBattleController.instance:getIsTeachMode()

	if isTeachMode then
		local teachCfg = MahjongBattleController.instance:getCurTeachFakeDataCfg(activityId)

		if teachCfg then
			curGenreIds = teachCfg.randomGenre or {}
		else
			printInfo("麻将对战教学配置不存在，activityId=%d", activityId)
		end
	else
		local challengeInfo = self:getCurChallengeInfoByActId(activityId)

		if challengeInfo then
			curGenreIds = challengeInfo.drawGenreIds or {}
		end
	end

	local copyIds = {}

	for i, v in ipairs(curGenreIds) do
		table.insert(copyIds, v)
	end

	return copyIds
end

function MahjongBattleModel:getCurChallengeInfoByActId(activityId)
	local baseInfo = self._baseInfoMap[activityId]

	if not baseInfo then
		printInfo("麻将对战游戏数据不存在，activityId=%d", activityId)

		return nil
	end

	return baseInfo.challengeInfo
end

function MahjongBattleModel:getCurDrawnMahjongByActId(activityId)
	local drawnMahjongs = {}
	local isTeachMode = MahjongBattleController.instance:getIsTeachMode()

	if isTeachMode then
		local teachCfg = MahjongBattleController.instance:getCurTeachFakeDataCfg(activityId)

		if teachCfg then
			if not teachCfg.stystemMJIds then
				local tempDrawnMahjongs = {}

				for i, v in ipairs(tempDrawnMahjongs) do
					table.insert(drawnMahjongs, v)
				end
			end
		else
			printInfo("麻将对战教学配置不存在，activityId=%d", activityId)
		end
	else
		local challengeInfo = self:getCurChallengeInfoByActId(activityId)

		if challengeInfo then
			if not challengeInfo.curRoundDrawMahjong then
				local curRoundDrawMahjong = {}

				for k, v in pairs(curRoundDrawMahjong) do
					table.insert(drawnMahjongs, v)
				end
			end
		end
	end

	return drawnMahjongs
end

function MahjongBattleModel:getCurHandMahjongByActId(activityId)
	local handMahjongs = {}
	local isTeachMode = MahjongBattleController.instance:getIsTeachMode()

	if isTeachMode then
		local teachCfg = MahjongBattleController.instance:getCurTeachFakeDataCfg(activityId)

		if teachCfg then
			if not teachCfg.handMJIds then
				local tempHandMahjongs = {}

				for i, v in ipairs(tempHandMahjongs) do
					table.insert(handMahjongs, v)
				end
			end
		else
			printInfo("麻将对战教学配置不存在，activityId=%d", activityId)
		end
	else
		local challengeInfo = self:getCurChallengeInfoByActId(activityId)

		if challengeInfo then
			if not challengeInfo.handMahjong then
				local handMahjong = {}

				for k, v in pairs(handMahjong) do
					table.insert(handMahjongs, v)
				end
			end
		end
	end

	return handMahjongs
end

function MahjongBattleModel:getCurSummonMahjongInfoByActId(activityId)
	local summonMahjongInfos = {}
	local isTeachMode = MahjongBattleController.instance:getIsTeachMode()

	if isTeachMode then
		-- block empty
	else
		local challengeInfo = self:getCurChallengeInfoByActId(activityId)

		if challengeInfo then
			if not challengeInfo.hasSummonMahjongInfo then
				for k, v in pairs(challengeInfo.hasSummonMahjongInfo) do
					table.insert(summonMahjongInfos, v)
				end
			end
		end
	end

	return summonMahjongInfos
end

function MahjongBattleModel:getCurSummonChiPengMJInfoByActId(activityId)
	local chiPengMJInfos = {}
	local isTeachMode = MahjongBattleController.instance:getIsTeachMode()

	if isTeachMode then
		-- block empty
	else
		local challengeInfo = self:getCurChallengeInfoByActId(activityId)

		if challengeInfo then
			if not challengeInfo.hasSummonMahjongInfo then
				for k, v in pairs(challengeInfo.hasSummonMahjongInfo) do
					if v.summonType == MahjongBattleModel.SUMMON_TYPE.KEZI or v.summonType == MahjongBattleModel.SUMMON_TYPE.SHUNZI then
						table.insert(chiPengMJInfos, v)
					end
				end
			end
		end
	end

	return chiPengMJInfos
end

function MahjongBattleModel:getCurSummonGangMJInfoByActId(activityId)
	local gangMJInfos = {}
	local isTeachMode = MahjongBattleController.instance:getIsTeachMode()

	if isTeachMode then
		-- block empty
	else
		local challengeInfo = self:getCurChallengeInfoByActId(activityId)

		if challengeInfo then
			if not challengeInfo.hasSummonMahjongInfo then
				for k, v in pairs(challengeInfo.hasSummonMahjongInfo) do
					if v.summonType == MahjongBattleModel.SUMMON_TYPE.GANGZI or v.summonType == MahjongBattleModel.SUMMON_TYPE.ERLIANGGANG or v.summonType == MahjongBattleModel.SUMMON_TYPE.SANLIANGGANG or v.summonType == MahjongBattleModel.SUMMON_TYPE.SILIANGGANG then
						table.insert(gangMJInfos, v)
					end
				end
			end
		end
	end

	return gangMJInfos
end

function MahjongBattleModel:getCurSummonTypeByActId(activityId)
	local isTeachMode = MahjongBattleController.instance:getIsTeachMode()

	if isTeachMode then
		local teachCfg = MahjongBattleController.instance:getCurTeachFakeDataCfg(activityId)

		if teachCfg then
			return teachCfg.summonType or MahjongBattleModel.SUMMON_TYPE.NONE
		else
			printInfo("麻将对战教学配置不存在，activityId=%d", activityId)

			return MahjongBattleModel.SUMMON_TYPE.NONE
		end
	else
		local challengeInfo = self:getCurChallengeInfoByActId(activityId)

		if challengeInfo then
			return challengeInfo.summonType or MahjongBattleModel.SUMMON_TYPE.NONE
		end
	end

	return MahjongBattleModel.SUMMON_TYPE.NONE
end

function MahjongBattleModel:getCurPetMoListByActId(activityId)
	local creepMoList = {}
	local isTeachMode = MahjongBattleController.instance:getIsTeachMode()

	if isTeachMode then
		local teachCfg = MahjongBattleController.instance:getCurTeachFakeDataCfg(activityId)

		if teachCfg then
			if not teachCfg.creepsIds then
				local creepsIds = {}

				for i, v in ipairs(creepsIds) do
					local petMo = self:getPetMo(activityId, v, 0)

					if petMo then
						table.insert(creepMoList, petMo)
					end
				end
			end
		else
			printInfo("麻将对战教学配置不存在，activityId=%d", activityId)
		end
	else
		local challengeInfo = self:getCurChallengeInfoByActId(activityId)

		if challengeInfo then
			if not challengeInfo.creepsInfos then
				local creepsInfos = {}

				for k, v in pairs(creepsInfos) do
					local petMo = self:getPetMo(activityId, v.creepsId, v.awakenLevel)

					if petMo then
						table.insert(creepMoList, petMo)
					end
				end
			end
		end
	end

	return creepMoList
end

function MahjongBattleModel:getCurSummonCreepIdsByActId(activityId)
	local summonCreepIds = {}
	local isTeachMode = MahjongBattleController.instance:getIsTeachMode()

	if isTeachMode then
		local teachCfg = MahjongBattleController.instance:getCurTeachFakeDataCfg(activityId)

		if teachCfg then
			if not teachCfg.summonCreepsIds then
				local summonCreepsIds = {}

				for i, v in ipairs(summonCreepsIds) do
					table.insert(summonCreepIds, v)
				end
			end
		else
			printInfo("麻将对战教学配置不存在，activityId=%d", activityId)
		end
	else
		local challengeInfo = self:getCurChallengeInfoByActId(activityId)

		if challengeInfo then
			if not challengeInfo.summonPet then
				local summonCreepsIds = {}

				for k, v in pairs(summonCreepsIds) do
					table.insert(summonCreepIds, v)
				end
			end
		end
	end

	return summonCreepIds
end

function MahjongBattleModel:getRankInfoByActId(activityId)
	local info = self._rankInfoMap[activityId]

	if not info then
		printInfo("麻将对战排行数据不存在，activityId=%d", activityId)
	end

	return self._rankInfoMap[activityId]
end

function MahjongBattleModel:getCurStateByActId(activityId)
	local isTeachMode = MahjongBattleController.instance:getIsTeachMode()

	if isTeachMode then
		return MahjongBattleController.instance:getCurTeachPlayerState(activityId)
	end

	local state = self._curStateMap[activityId]

	state = state or MahjongBattleModel.PLAYER_STATE.NONE

	return state
end

function MahjongBattleModel:getPetMo(activityId, creepId, awakeLevel)
	local key = string.format("%d_%d_%d", activityId, creepId, awakeLevel or 0)
	local petMo = self._petMap[key]

	if not petMo then
		local addzdlRatio = MahjongBattleConfig.instance:getCommonValueToNumber("AWAKEN_LEVEL_PROPERTY_WAN_PERCENT") / 10000
		local sysCfg = MahjongBattleConfig.instance:getSystemPetByCreepsId(activityId, creepId)

		if sysCfg then
			local fPowerPet = FightingPowerPetMo.New()

			fPowerPet:fromChallengeCreepCo(sysCfg)

			petMo = fPowerPet:toBaseBagPetMo()

			if awakeLevel and awakeLevel > 0 then
				petMo.awakeLevel = awakeLevel
				petMo.awakenLv = awakeLevel
				petMo.allPropertyExtZdlRate = addzdlRatio * awakeLevel or 0
			end

			petMo.isMyPackPet = false
			petMo.attrMo.isCalcPower = false

			petMo:refreshAllAttr()

			self._petMap[key] = petMo
		end
	end

	return petMo
end

function MahjongBattleModel:getReportInfo(activityId)
	local info = self._reportInfoMap[activityId]

	if not info then
		printInfo("麻将对战战报数据不存在，activityId=%d", activityId)
	end

	return self._reportInfoMap[activityId]
end

function MahjongBattleModel:getLastFightResult()
	return self._lastFightResult
end

function MahjongBattleModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._baseInfoMap[activityId] = info

	self:_updatePlayerState(activityId)
end

function MahjongBattleModel:onRandomCardLuck(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self:_updatePlayerState(activityId)

	local baseInfo = self._baseInfoMap[activityId]

	if baseInfo then
		baseInfo.todayCardLuckId = info.cardLuckId

		self:_updatePlayerState(activityId)

		local state = self:getCurStateByActId(activityId)

		if state == MahjongBattleModel.PLAYER_STATE.NONE and baseInfo.challengeInfo then
			baseInfo.challengeInfo.curCircleCardLuckId = info.cardLuckId
		end
	end
end

function MahjongBattleModel:onRankView(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._rankInfoMap[activityId] = info
end

function MahjongBattleModel:onFightReport(msg)
	local info = GameUtil.pbToTable(msg)

	self._reportInfoMap[info.activityId] = info
end

function MahjongBattleModel:onDrawGenre(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if not info.genreId then
		if baseInfo then
			baseInfo.challengeInfo.drawGenreIds = info.genreId
		end

		self:_updatePlayerState(activityId)
	end
end

function MahjongBattleModel:onSelectGenre(msg)
	return
end

function MahjongBattleModel:onGiveUp(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if baseInfo then
		baseInfo.challengeInfo = {}
		baseInfo.challengeInfo.curCircleCardLuckId = baseInfo.todayCardLuckId
		baseInfo.totalScore = info.totalScore
		baseInfo.opponent = nil
	end

	self:_updatePlayerState(activityId)
end

function MahjongBattleModel:onDrawMahjong(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if baseInfo and baseInfo.challengeInfo then
		if not info.mahjongId then
			baseInfo.challengeInfo.curRoundDrawMahjong = info.mahjongId

			local drawCountMap = {}

			for k, v in ipairs(info.mahjongId) do
				drawCountMap[v] = (drawCountMap[v] or 0) + 1
			end

			if not baseInfo.challengeInfo.mahjongPoolIdToNumMap then
				for k, mjInfo in ipairs(baseInfo.challengeInfo.mahjongPoolIdToNumMap) do
					if not drawCountMap[mjInfo.left] then
						mjInfo.right = math.max(mjInfo.right - drawCountMap[mjInfo.left], 0)
					end
				end

				baseInfo.challengeInfo.mahjongPoolIdToNumMap = baseInfo.challengeInfo.mahjongPoolIdToNumMap
			end
		end
	end

	self:_updatePlayerState(activityId)
end

function MahjongBattleModel:onSelectMahjong(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if not info.selectMahjongId then
		if baseInfo and baseInfo.challengeInfo and info.selectMahjongId > 0 then
			baseInfo.challengeInfo.isSelectMahjong = true

			if not baseInfo.challengeInfo.handMahjong then
				table.insert(baseInfo.challengeInfo.handMahjong, info.selectMahjongId)

				baseInfo.challengeInfo.handMahjong = baseInfo.challengeInfo.handMahjong
			end
		end

		self:_updatePlayerState(activityId)
	end
end

function MahjongBattleModel:onDropMahjong(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if baseInfo and baseInfo.challengeInfo then
		if not baseInfo.challengeInfo.handMahjong then
			if not info.dropMahjongId then
				local dropMahjongId = 0

				table.removebyvalue(baseInfo.challengeInfo.handMahjong, dropMahjongId)

				baseInfo.challengeInfo.handMahjong = baseInfo.challengeInfo.handMahjong
				baseInfo.challengeInfo.isDropMahjong = true
			end
		end
	end

	self:_updatePlayerState(activityId)
end

function MahjongBattleModel:onMatchOpponent(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if baseInfo then
		baseInfo.opponent = info.opponent
	end

	self:_updatePlayerState(activityId)
end

function MahjongBattleModel:onViewBtlReport(msg)
	local info = GameUtil.pbToTable(msg)

	self._reportInfoMap[info.activityId] = info
end

function MahjongBattleModel:onNotifyFightResult(msg)
	self._lastFightResult = GameUtil.pbToTable(msg)
end

function MahjongBattleModel:onSelectSummonBuff(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if baseInfo and baseInfo.challengeInfo then
		baseInfo.challengeInfo.isSelectSummonBuff = true
		baseInfo.challengeInfo.selectSummonBuff = info.summonBuffId
	end

	self:_updatePlayerState(activityId)
end

function MahjongBattleModel:onSummon(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if baseInfo and baseInfo.challengeInfo then
		baseInfo.challengeInfo.summonType = info.summonType or 0

		if info.summonType == MahjongBattleModel.SUMMON_TYPE.DIHU or info.summonType == MahjongBattleModel.SUMMON_TYPE.PINGHU or info.summonType == MahjongBattleModel.SUMMON_TYPE.QINGYISE then
			baseInfo.challengeInfo.isDropMahjong = true
		end

		baseInfo.challengeInfo.summonPet = info.petId or {}

		if not info.operaMahjongId then
			local operaMahjongIds = {}

			baseInfo.challengeInfo.summonMahjong = operaMahjongIds

			if not baseInfo.challengeInfo.handMahjong then
				local handMahjongIds = {}
				local tempHandMahjongIdMap = {}

				for _, mahjongId in ipairs(handMahjongIds) do
					tempHandMahjongIdMap[mahjongId] = (tempHandMahjongIdMap[mahjongId] or 0) + 1
				end

				for i, operaId in ipairs(operaMahjongIds) do
					tempHandMahjongIdMap[operaId] = (tempHandMahjongIdMap[operaId] or 0) - 1
				end

				local newHandMahjongIds = {}

				for mahjongId, count in pairs(tempHandMahjongIdMap) do
					for i = 1, count do
						table.insert(newHandMahjongIds, mahjongId)
					end
				end

				baseInfo.challengeInfo.handMahjong = newHandMahjongIds

				if not info.summonType then
					if info.summonType == MahjongBattleModel.SUMMON_TYPE.SHUNZI or info.summonType == MahjongBattleModel.SUMMON_TYPE.KEZI or info.summonType == MahjongBattleModel.SUMMON_TYPE.GANGZI or info.summonType == MahjongBattleModel.SUMMON_TYPE.ERLIANGGANG or info.summonType == MahjongBattleModel.SUMMON_TYPE.SANLIANGGANG or info.summonType == MahjongBattleModel.SUMMON_TYPE.SILIANGGANG then
						if not baseInfo.challengeInfo.hasSummonMahjongInfo then
							local hasSummonMahjongInfos = {}
							local summonMahjongInfo = {}

							summonMahjongInfo.summonType = info.summonType
							summonMahjongInfo.summonMahjong = operaMahjongIds

							table.insert(hasSummonMahjongInfos, summonMahjongInfo)

							baseInfo.challengeInfo.hasSummonMahjongInfo = hasSummonMahjongInfos
						end
					end
				end
			end
		end
	end

	self:_updatePlayerState(activityId)
end

function MahjongBattleModel:onSelectSummonPet(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if baseInfo and baseInfo.challengeInfo then
		if not info.selectSummonPetId then
			if not baseInfo.challengeInfo.creepsInfos then
				local creepsInfos = {}

				for _, selectId in ipairs(info.selectSummonPetId) do
					local exist = false

					for _, creepsInfo in ipairs(creepsInfos) do
						if creepsInfo.creepsId == selectId then
							exist = true
							creepsInfo.awakenLevel = (creepsInfo.awakenLevel or 0) + 1
						end
					end

					if not exist then
						table.insert(creepsInfos, {
							awakenLevel = 0,
							creepsId = selectId
						})
					end
				end

				baseInfo.challengeInfo.creepsInfos = creepsInfos
				baseInfo.challengeInfo.isSelectSummonPet = true
				baseInfo.challengeInfo.selectSummonPetId = info.selectSummonPetId or 0
			end
		end
	end

	self:_updatePlayerState(activityId)
end

function MahjongBattleModel:onDropPet(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if baseInfo and baseInfo.challengeInfo then
		if not info.dropPetId then
			if not baseInfo.challengeInfo.creepsInfos then
				local creepsInfos = {}
				local removePos = -1

				for i, creepsInfo in ipairs(creepsInfos) do
					if creepsInfo.creepsId == info.dropPetId then
						removePos = i

						break
					end
				end

				if removePos > 0 then
					table.remove(creepsInfos, removePos)
				end
			end
		end
	end
end

function MahjongBattleModel:onGmCoverHand(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if baseInfo and baseInfo.challengeInfo then
		if not info.coverMahjongId then
			baseInfo.challengeInfo.handMahjong = info.coverMahjongId
		end
	end

	self:_updatePlayerState(activityId)
end

function MahjongBattleModel:onGmCoverSystemCard(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]

	if baseInfo and baseInfo.challengeInfo then
		if not info.changeDrawMahjongId then
			baseInfo.challengeInfo.curRoundDrawMahjong = info.changeDrawMahjongId
		end
	end

	self:_updatePlayerState(activityId)
end

function MahjongBattleModel:onNotifyDrawMahjong(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self._baseInfoMap[activityId]
	local challengeInfo = baseInfo and baseInfo.challengeInfo

	if challengeInfo then
		if not info.mahjongId then
			challengeInfo.curRoundDrawMahjong = info.mahjongId
			challengeInfo.isSelectMahjong = false
			challengeInfo.isDropMahjong = false

			local drawCountMap = {}

			for k, v in ipairs(info.mahjongId) do
				drawCountMap[v] = (drawCountMap[v] or 0) + 1
			end

			if not baseInfo.challengeInfo.mahjongPoolIdToNumMap then
				for k, mjInfo in ipairs(baseInfo.challengeInfo.mahjongPoolIdToNumMap) do
					if not drawCountMap[mjInfo.left] then
						mjInfo.right = math.max(mjInfo.right - drawCountMap[mjInfo.left], 0)
					end
				end

				baseInfo.challengeInfo.mahjongPoolIdToNumMap = baseInfo.challengeInfo.mahjongPoolIdToNumMap
			end
		end
	end

	self:_updatePlayerState(activityId)
end

function MahjongBattleModel:_determineSummonState(activityId, summonType, isSelectSummonBuff, isSelectSummonPet)
	local summonTypeCfg = MahjongBattleConfig.instance:getSummonTypeCfgById(activityId, summonType)

	if not summonTypeCfg then
		return MahjongBattleModel.PLAYER_STATE.WAITING_OPERATION
	end

	if not summonTypeCfg.buffPlan then
		local buffPlan = 0
		local needSelectBuff = buffPlan > 0

		if needSelectBuff and not isSelectSummonBuff then
			return MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_SUMMON_BUFF
		end

		if not isSelectSummonPet then
			return MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_SUMMON_PET
		end

		return MahjongBattleModel.PLAYER_STATE.WAITING_MATCH_OPPONENT
	end
end

function MahjongBattleModel:_updatePlayerState(activityId)
	local state = MahjongBattleModel.PLAYER_STATE.NONE
	local baseInfo = self._baseInfoMap[activityId]

	if not baseInfo then
		self._curStateMap[activityId] = state

		return
	end

	if baseInfo.opponent then
		state = MahjongBattleModel.PLAYER_STATE.MATCHED_OPPONENT
		self._curStateMap[activityId] = MahjongBattleModel.PLAYER_STATE.MATCHED_OPPONENT

		return
	end

	local challengeInfo = baseInfo.challengeInfo

	if not challengeInfo then
		state = MahjongBattleModel.PLAYER_STATE.NONE
		self._curStateMap[activityId] = MahjongBattleModel.PLAYER_STATE.NONE

		return
	end

	if not challengeInfo.drawGenreIds then
		local drawGenreIds = {}

		if #drawGenreIds == 0 then
			state = MahjongBattleModel.PLAYER_STATE.NONE
			self._curStateMap[activityId] = MahjongBattleModel.PLAYER_STATE.NONE

			return
		end

		if not challengeInfo.genreId then
			local genreId = 0

			if genreId == 0 then
				state = MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_TEAM
				self._curStateMap[activityId] = MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_TEAM

				return
			end

			if not challengeInfo.isSelectSummonPet then
				local isSelectSummonPet = false

				state = isSelectSummonPet and MahjongBattleModel.PLAYER_STATE.WAITING_MATCH_OPPONENT or self:isDeckEnough(activityId) and self:_determineStateDeckEnough(activityId, challengeInfo) or self:_determineStateDeckNotEnough(activityId, challengeInfo)
				self._curStateMap[activityId] = state
			end
		end
	end
end

function MahjongBattleModel:_determineStateDeckEnough(activityId, challengeInfo)
	if not challengeInfo.curRoundDrawMahjong then
		if #challengeInfo.curRoundDrawMahjong == 0 then
			return MahjongBattleModel.PLAYER_STATE.WAITING_DRAW_MAHJONG
		elseif not challengeInfo.isSelectMahjong then
			local isSelectMahjong = false

			if not isSelectMahjong then
				return MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_MAHJONG
			end

			if not challengeInfo.isDropMahjong then
				local isDropMahjong = false

				if not isDropMahjong then
					return MahjongBattleModel.PLAYER_STATE.WAITING_DROP_MAHJONG
				end

				if not challengeInfo.summonType then
					local summonType = 0

					if summonType > 0 then
						if not challengeInfo.isSelectSummonBuff then
							if not challengeInfo.isSelectSummonPet then
								local isSelectSummonPet = false

								return self:_determineSummonState(activityId, summonType, challengeInfo.isSelectSummonBuff, isSelectSummonPet)
							end
						end
					end
				end
			end
		end

		return MahjongBattleModel.PLAYER_STATE.WAITING_OPERATION
	end
end

function MahjongBattleModel:_determineStateDeckNotEnough(activityId, challengeInfo)
	if not challengeInfo.summonType then
		if challengeInfo.summonType > 0 then
			if not challengeInfo.isSelectSummonBuff then
				local isSelectSummonBuff = false

				if not challengeInfo.isSelectSummonPet then
					local isSelectSummonPet = false

					if challengeInfo.summonType == MahjongBattleModel.SUMMON_TYPE.GANGZI or challengeInfo.summonType == MahjongBattleModel.SUMMON_TYPE.ERLIANGGANG or challengeInfo.summonType == MahjongBattleModel.SUMMON_TYPE.SANLIANGGANG or challengeInfo.summonType == MahjongBattleModel.SUMMON_TYPE.SILIANGGANG then
						if not challengeInfo.isSelectMahjong then
							local isSelectMahjong = false

							if not isSelectMahjong then
								return MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_MAHJONG
							end
						end
					end

					return self:_determineSummonState(activityId, challengeInfo.summonType, isSelectSummonBuff, isSelectSummonPet)
				end
			end
		end

		return MahjongBattleModel.PLAYER_STATE.WAITING_OPERATION
	end
end

function MahjongBattleModel:isDeckEnough(activityId)
	local challengeInfo = self:getCurChallengeInfoByActId(activityId)

	if not challengeInfo then
		return false
	end

	if not challengeInfo.mahjongPoolIdToNumMap then
		local mahjongPoolIdToNumMap = {}

		for _, mjInfo in ipairs(mahjongPoolIdToNumMap) do
			if mjInfo.right > 0 then
				return true
			end
		end

		return false
	end
end

function MahjongBattleModel:getDeckRemainNum(activityId)
	local challengeInfo = self:getCurChallengeInfoByActId(activityId)

	if not challengeInfo then
		return 0
	end

	if not challengeInfo.mahjongPoolIdToNumMap then
		local mahjongPoolIdToNumMap = {}
		local remainNum = 0

		for _, mjInfo in ipairs(mahjongPoolIdToNumMap) do
			remainNum = remainNum + (mjInfo.right or 0)
		end

		return remainNum
	end
end

function MahjongBattleModel:isDiHu(activityId)
	local challengeInfo = self:getCurChallengeInfoByActId(activityId)

	if not challengeInfo then
		return false
	end

	if not challengeInfo.handMahjong then
		local handMahjongs = {}

		if #handMahjongs ~= 14 then
			return false
		end

		if not challengeInfo.isHasOperaMahjongAfterRefresh then
			local isHasOperaMahjongAfterRefresh = false

			return not isHasOperaMahjongAfterRefresh
		end
	end
end

function MahjongBattleModel:isQingYiSe(activityId)
	local challengeInfo = self:getCurChallengeInfoByActId(activityId)

	if not challengeInfo then
		return false
	end

	if not challengeInfo.handMahjong then
		local handMahjongs = {}
		local allMahjongs = {}

		for _, v in pairs(handMahjongs) do
			table.insert(allMahjongs, v)
		end

		if not challengeInfo.hasSummonMahjongInfo then
			for _, summonInfo in pairs(challengeInfo.hasSummonMahjongInfo) do
				if not summonInfo.summonMahjong then
					local summonMahjong = {}

					for _, v in pairs(summonMahjong) do
						table.insert(allMahjongs, v)
					end
				end
			end

			if #allMahjongs == 0 then
				return false
			end

			local firstType

			for _, mahjongId in pairs(allMahjongs) do
				local cfg = MahjongBattleConfig.instance:getMahjongCfg(activityId, mahjongId)

				if cfg then
					firstType = firstType or cfg.type

					if firstType and cfg.type ~= firstType then
						return false
					end
				end
			end

			return true
		end
	end
end

function MahjongBattleModel:getCurHandMahjongIdsDesc(activityId)
	local handMahjongs = self:getCurHandMahjongByActId(activityId)
	local handMahjongIds = {}

	for _, v in pairs(handMahjongs) do
		table.insert(handMahjongIds, v)
	end

	table.sort(handMahjongIds, function(a, b)
		return b < a
	end)

	return handMahjongIds
end

function MahjongBattleModel:getCurSummonOperaMahjongIds(activityId)
	local operaMahjongIds = {}
	local isTeachMode = MahjongBattleController.instance:getIsTeachMode()

	if isTeachMode then
		local teachCfg = MahjongBattleController.instance:getCurTeachFakeDataCfg(activityId)

		if teachCfg then
			if not teachCfg.handMJIds then
				local tempIdList = {}
				local sortIdList = {}

				for _, v in pairs(tempIdList) do
					table.insert(sortIdList, v)
				end

				table.sort(sortIdList, function(a, b)
					return b < a
				end)

				for _, v in ipairs(sortIdList) do
					table.insert(operaMahjongIds, v)
				end
			end
		else
			printInfo("麻将对战教学配置不存在，activityId=%d", activityId)
		end

		return operaMahjongIds
	end

	local challengeInfo = self:getCurChallengeInfoByActId(activityId)

	if challengeInfo then
		if not challengeInfo.summonType then
			local summonType = 0

			if summonType > 0 then
				if summonType == MahjongBattleModel.SUMMON_TYPE.PINGHU or summonType == MahjongBattleModel.SUMMON_TYPE.DIHU or summonType == MahjongBattleModel.SUMMON_TYPE.QINGYISE then
					if not challengeInfo.hasSummonMahjongInfo then
						local hasSummonMahjongInfo = {}

						for _, summonInfo in pairs(hasSummonMahjongInfo) do
							if not summonInfo.summonMahjong then
								local summonMahjong = {}
								local tempOperaMahjongIds = {}

								for _, v in pairs(summonMahjong) do
									table.insert(tempOperaMahjongIds, v)
								end

								table.sort(tempOperaMahjongIds, function(a, b)
									return b < a
								end)

								for _, v in ipairs(tempOperaMahjongIds) do
									table.insert(operaMahjongIds, v)
								end
							end
						end
					end
				elseif summonType == MahjongBattleModel.SUMMON_TYPE.ERLIANGGANG or summonType == MahjongBattleModel.SUMMON_TYPE.SANLIANGGANG or summonType == MahjongBattleModel.SUMMON_TYPE.SILIANGGANG then
					if not challengeInfo.hasSummonMahjongInfo then
						local hasSummonMahjongInfo = {}
						local hasSummonCount = #hasSummonMahjongInfo
						local addSummonSortStartId = hasSummonCount

						if summonType == MahjongBattleModel.SUMMON_TYPE.ERLIANGGANG then
							addSummonSortStartId = hasSummonCount - 1
						elseif summonType == MahjongBattleModel.SUMMON_TYPE.SANLIANGGANG then
							addSummonSortStartId = hasSummonCount - 2
						elseif summonType == MahjongBattleModel.SUMMON_TYPE.SILIANGGANG then
							addSummonSortStartId = hasSummonCount - 3
						end

						local addSortIdMap = {}

						for i = addSummonSortStartId, hasSummonCount - 1 do
							addSortIdMap[i] = true
						end

						for index, summonInfo in pairs(hasSummonMahjongInfo) do
							if not summonInfo.sortId then
								if addSortIdMap[summonInfo.sortId] then
									if not summonInfo.summonMahjong then
										local tempOperaMahjongIds = {}

										for _, v in pairs(summonInfo.summonMahjong) do
											table.insert(tempOperaMahjongIds, v)
										end

										table.sort(tempOperaMahjongIds, function(a, b)
											return b < a
										end)

										for _, v in ipairs(tempOperaMahjongIds) do
											table.insert(operaMahjongIds, v)
										end
									end
								end
							end
						end
					end
				end

				if not challengeInfo.summonMahjong then
					local tempIdList = {}
					local sortIdList = {}

					for _, v in pairs(tempIdList) do
						table.insert(sortIdList, v)
					end

					table.sort(sortIdList, function(a, b)
						return b < a
					end)

					for _, v in ipairs(sortIdList) do
						table.insert(operaMahjongIds, v)
					end
				end
			end
		end
	end

	return operaMahjongIds
end

MahjongBattleModel.instance = MahjongBattleModel.New()

return MahjongBattleModel
