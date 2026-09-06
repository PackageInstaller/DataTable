-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/controller/DreamTeamChapterController.lua

module("logic.extensions.dreamteamchapter.controller.DreamTeamChapterController", package.seeall)

local DreamTeamChapterController = class("DreamTeamChapterController", BaseController)

DreamTeamChapterController.progressTypeEnum = {
	BossDamage = 3,
	AlchemyMM = 1,
	HotMM = 2
}
DreamTeamChapterController.battleTypeEnum = {
	LoveMM = 3,
	darkMM = 4,
	HotMM = 1,
	KingMM = 2
}
DreamTeamChapterController.awakeMMId = {
	AlchemyMM = 5,
	DarkMM = 2,
	LoveMM = 6,
	DuoLaMM = 4,
	HotMM = 3,
	KingMM = 1
}
DreamTeamChapterController.KING_MM_DAY_KEY = "DREAM_TEAM_CHAP_KING_MM_DAY_CLICK_%s"
DreamTeamChapterController.DARK_MM_DAY_KEY = "DREAM_TEAM_CHAP_DARK_MM_DAY_CLICK%s"
DreamTeamChapterController.HOT_MM_DAY_KEY = "DREAM_TEAM_CHAP_HOT_MM_DAY_CLICK_%s"
DreamTeamChapterController.DUOLA_MM_DAY_KEY = "DREAM_TEAM_CHAP_DUOLA_MM_DAY_CLICK%s"
DreamTeamChapterController.ALCHEMY_MM_DAY_KEY = "DREAM_TEAM_CHAP_ALCHEMY_MM_DAY_CLICK%s"
DreamTeamChapterController.LOVE_MM_DAY_KEY = "DREAM_TEAM_CHAP_LOVE_MM_DAY_CLICK%s"

function DreamTeamChapterController:onInit()
	return
end

function DreamTeamChapterController:sendPM_DreamTeamChapterGetInfoReq(activityId)
	DreamTeamChapterAgent.instance:sendPM_DreamTeamChapterGetInfoReq(activityId)
end

function DreamTeamChapterController:handlePM_DreamTeamChapterGetInfoRes(msg)
	DreamTeamChapterModel.instance:handlePM_DreamTeamChapterGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DreamTeamChapterGetInfoRes)
end

function DreamTeamChapterController:sendPM_DreamTeamChapterSmeltReq(activityId, alchemyMaterialId)
	DreamTeamChapterAgent.instance:sendPM_DreamTeamChapterSmeltReq(activityId, alchemyMaterialId)
end

function DreamTeamChapterController:handlePM_DreamTeamChapterSmeltRes(msg)
	DreamTeamChapterModel.instance:handlePM_DreamTeamChapterSmeltRes(msg, msg.smeltPotion ~= 0)

	local tipStr = ""
	local activityId = msg.activityId

	if msg.smeltPotion == 0 then
		local actCfg = DreamTeamChapterConfig.instance:getActivityCfg(activityId)

		if actCfg then
			if not actCfg.smeltPotionFailScore then
				local smeltPotionFailScore = 0

				tipStr = string.format(lang("非常遗憾，冶炼失败了但是仍可以获得%s积分作为鼓励！"), smeltPotionFailScore)
			end
		end
	else
		local potionCfg = DreamTeamChapterConfig.instance:getAlchemyPotionCfg(activityId, msg.smeltPotion)

		if potionCfg then
			local materialStr = potionCfg.materialStr
			local matName = MaterialMgr.getMaterialsNameByCfg(materialStr)

			tipStr = string.format(lang("恭喜你，成功冶炼出了【%s】获得%s积分！"), matName, potionCfg.successScore)
		end
	end

	TipsFacade.instance:openTipWindowNoX("提示", tipStr)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DreamTeamChapterSmeltRes)
end

function DreamTeamChapterController:sendPM_DreamTeamChapterChallengeReq(activityId, challengeId, stageId, form)
	DreamTeamChapterAgent.instance:sendPM_DreamTeamChapterChallengeReq(activityId, challengeId, stageId, form)
end

function DreamTeamChapterController:handlePM_DreamTeamChapterChallengeRes(msg)
	DreamTeamChapterModel.instance:handlePM_DreamTeamChapterChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DreamTeamChapterChallengeRes, msg)
end

function DreamTeamChapterController:handlePM_DreamTeamChapterNotifyClgRes(msg)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEnd, self, msg))
	DreamTeamChapterModel.instance:handlePM_DreamTeamChapterNotifyClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DreamTeamChapterNotifyClgRes, msg)
end

function DreamTeamChapterController:sendPM_DreamTeamChapterChallengeBossReq(activityId, form)
	DreamTeamChapterAgent.instance:sendPM_DreamTeamChapterChallengeBossReq(activityId, form)
end

function DreamTeamChapterController:handlePM_DreamTeamChapterChallengeBossRes(msg)
	DreamTeamChapterModel.instance:handlePM_DreamTeamChapterChallengeBossRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DreamTeamChapterChallengeBossRes, msg)
end

function DreamTeamChapterController:handlePM_DreamTeamChapterNotifyBossClgRes(msg)
	DreamTeamChapterModel.instance:handlePM_DreamTeamChapterNotifyBossClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DreamTeamChapterNotifyBossClgRes, msg)
end

function DreamTeamChapterController:sendPM_DreamTeamChapterOneClickGainProgressPrizeReq(activityId, progressType)
	DreamTeamChapterAgent.instance:sendPM_DreamTeamChapterOneClickGainProgressPrizeReq(activityId, progressType)
end

function DreamTeamChapterController:handlePM_DreamTeamChapterOneClickGainProgressPrizeRes(msg)
	DreamTeamChapterModel.instance:handlePM_DreamTeamChapterOneClickGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DreamTeamChapterOneClickGainProgressPrizeRes, msg)
end

function DreamTeamChapterController:sendPM_DreamTeamChapterRankViewReq(activityId)
	DreamTeamChapterAgent.instance:sendPM_DreamTeamChapterRankViewReq(activityId)
end

function DreamTeamChapterController:handlePM_DreamTeamChapterRankViewRes(msg)
	DreamTeamChapterModel.instance:handlePM_DreamTeamChapterRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DreamTeamChapterRankViewRes, msg)
end

function DreamTeamChapterController:sendPM_DreamTeamChapterFirstClickReq(activityId, chapterId)
	DreamTeamChapterAgent.instance:sendPM_DreamTeamChapterFirstClickReq(activityId, chapterId)
end

function DreamTeamChapterController:handlePM_DreamTeamChapterFirstClickRes(msg)
	DreamTeamChapterModel.instance:handlePM_DreamTeamChapterFirstClickRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DreamTeamChapterFirstClickRes, msg.chapterId)
end

function DreamTeamChapterController:sendPM_DreamTeamChapterAwakenMengMengReq(activityId)
	DreamTeamChapterAgent.instance:sendPM_DreamTeamChapterAwakenMengMengReq(activityId)
end

function DreamTeamChapterController:handlePM_DreamTeamChapterAwakenMengMengRes(msg)
	if checknumber(msg.changeSetId) > 0 then
		DreamTeamChapterModel.instance:pushChangeSetList(msg.changeSetId)
	end

	DreamTeamChapterModel.instance:handlePM_DreamTeamChapterAwakenMengMengRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DreamTeamChapterAwakenMengMengRes)
end

function DreamTeamChapterController:hasSmeltPotionCurDrug(activityId, matList)
	local hasChooseMatMap = self:translateMatMap(matList)
	local info = DreamTeamChapterModel.instance:getInfo(activityId)

	if info then
		if not info.hasSmeltPotion then
			local hasSmeltPotion = {}

			if #hasSmeltPotion > 0 then
				for i, potionId in ipairs(hasSmeltPotion) do
					local potionCfg = DreamTeamChapterConfig.instance:getAlchemyPotionCfg(activityId, potionId)

					if potionCfg then
						if not potionCfg.needMaterial then
							local needMatarial = {}
							local needMatarialMap = self:translateMatMap(needMatarial)
							local hasProduct = true
							local hasExSelect = false

							for matId, needNum in pairs(needMatarialMap) do
								local chooseMatNum = checknumber(hasChooseMatMap[matId])

								if chooseMatNum ~= needNum then
									hasProduct = false
								end
							end

							for matId, v in pairs(hasChooseMatMap) do
								if not needMatarialMap[matId] then
									hasExSelect = true
								end
							end

							if (hasExSelect or nil) and false then
								return true
							end
						end
					end
				end
			end

			return false
		end
	end
end

function DreamTeamChapterController:translateMatMap(matList)
	local matMap = {}

	for i, matId in ipairs(matList) do
		matMap[matId] = checknumber(matMap[matId]) + 1
	end

	return matMap
end

function DreamTeamChapterController:enterHotMMBattleClg(activityId, challengeId, stageId)
	local customFmtMo = DreamTeamChapterModel.instance:getHotMMFmtMo(activityId)

	customFmtMo:updateCfg(activityId, challengeId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DreamTeamChapterController:enterMultMMBattleClg(activityId, challengeId, stageId)
	local customFmtMo = DreamTeamChapterModel.instance:getMultMMFmtMo(activityId)

	customFmtMo:updateCfg(activityId, challengeId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DreamTeamChapterController:enterChap3BattleClg(activityId)
	local customFmtMo = DreamTeamChapterModel.instance:getChap3FmtMo(activityId)

	customFmtMo:updateCfg(activityId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DreamTeamChapterController:enterBattleClg(activityId, challengeId, stageId)
	if DreamTeamChapterConfig.instance:isMultBattleStage(activityId, challengeId, stageId) then
		self:enterMultMMBattleClg(activityId, challengeId, stageId)
	else
		self:enterHotMMBattleClg(activityId, challengeId, stageId)
	end
end

function DreamTeamChapterController:canAwakeAllMM(activityId)
	local mmCfgs = DreamTeamChapterConfig.instance:getAwakeMMCfgs(activityId)
	local canAllAwake = true

	for i, v in ipairs(mmCfgs) do
		if not self:_canAwakeMM(activityId, v.mengMengId) then
			canAllAwake = false
		end
	end

	return canAllAwake
end

function DreamTeamChapterController:_canAwakeMM(activityId, mmId)
	local awakeMMCfg = DreamTeamChapterConfig.instance:getAwakeMMCfgById(activityId, mmId)

	if awakeMMCfg then
		local awakenCost = awakeMMCfg.awakenCost
		local matType, matId, matNum = MaterialMgr.getMatParams(awakenCost)
		local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

		return matNum <= hasNum
	end

	return false
end

function DreamTeamChapterController:_chap2CanPlay(activityId)
	local chapterCfg = DreamTeamChapterConfig.instance:getChapterCfg(activityId, 2)
	local openTime = chapterCfg and chapterCfg.openTime

	if openTime then
		local openTimeStamp = GameUtil.string2time(openTime)

		return openTimeStamp < ServerTime.now()
	end

	return false
end

function DreamTeamChapterController:progressCanGetPrize(activityId, progressType)
	local info = DreamTeamChapterModel.instance:getInfo(activityId) or {}
	local progressMap = DreamTeamChapterModel.instance:getProgressInfoMap(activityId) or {}
	local maxGetProgressId = checknumber(progressMap[progressType])
	local score = 0

	if progressType == DreamTeamChapterController.progressTypeEnum.AlchemyMM then
		score = checknumber(info.alchemyScore)
	elseif progressType == DreamTeamChapterController.progressTypeEnum.BossDamage then
		score = checknumber(info.totalBossDamage)
	end

	local progressPlanCfgs = DreamTeamChapterConfig.instance:getProgressPlanCfgs(activityId, progressType)
	local canGetProgressId = 0

	for i, cfg in ipairs(progressPlanCfgs) do
		if score >= checknumber(cfg.progress) then
			canGetProgressId = cfg.progressId
		end
	end

	return maxGetProgressId < canGetProgressId
end

function DreamTeamChapterController:_chapIsInOpenTime(activityId, chapId)
	local chapterCfg = DreamTeamChapterConfig.instance:getChapterCfg(activityId, chapId)

	if chapterCfg then
		local openTimeStamp = GameUtil.string2time(chapterCfg.openTime)

		return openTimeStamp <= ServerTime.now()
	end

	return false
end

function DreamTeamChapterController:checkRedPointActive(activityId, redId)
	local info = DreamTeamChapterModel.instance:getInfo(activityId) or {}
	local hasClickChapter = checktable(info.hasClickChapter)
	local chap2CanPlay = self:_chap2CanPlay(activityId)
	local hasAwakenMengMeng = checkbool(info.hasAwakenMengMeng)

	if redId == RedPointModel.ID_DREAM_TEAM_CHAP_ONE_OPEN then
		return not table.indexof(hasClickChapter, 1) and self:_chapIsInOpenTime(activityId, 1)
	elseif redId == RedPointModel.ID_DREAM_TEAM_CHAP_TWO_OPEN then
		return not table.indexof(hasClickChapter, 2) and self:_chapIsInOpenTime(activityId, 2)
	elseif redId == RedPointModel.ID_DREAM_TEAM_CHAP_THREE_OPEN then
		return not table.indexof(hasClickChapter, 3) and self:_chapIsInOpenTime(activityId, 3)
	elseif redId == RedPointModel.ID_DREAM_TEAM_CHAP_KING_MM_DAY_CLICK then
		local hasAwakeKingMM = self:_canAwakeMM(activityId, DreamTeamChapterController.awakeMMId.KingMM)
		local key = string.format(DreamTeamChapterController.KING_MM_DAY_KEY, activityId)
		local data = GameUtil.getUserDayData(key)

		return not data and not hasAwakeKingMM and chap2CanPlay and not hasAwakenMengMeng and self:_chapIsInOpenTime(activityId, 2)
	elseif redId == RedPointModel.ID_DREAM_TEAM_CHAP_DARK_MM_DAY_CLICK then
		local hasAwakeKingMM = self:_canAwakeMM(activityId, DreamTeamChapterController.awakeMMId.DarkMM)
		local key = string.format(DreamTeamChapterController.DARK_MM_DAY_KEY, activityId)
		local data = GameUtil.getUserDayData(key)

		return not data and not hasAwakeKingMM and chap2CanPlay and not hasAwakenMengMeng and self:_chapIsInOpenTime(activityId, 2)
	elseif redId == RedPointModel.ID_DREAM_TEAM_CHAP_HOT_MM_DAY_CLICK then
		local hasAwakeKingMM = self:_canAwakeMM(activityId, DreamTeamChapterController.awakeMMId.HotMM)
		local key = string.format(DreamTeamChapterController.HOT_MM_DAY_KEY, activityId)
		local data = GameUtil.getUserDayData(key)

		return not data and not hasAwakeKingMM and chap2CanPlay and not hasAwakenMengMeng and self:_chapIsInOpenTime(activityId, 2)
	elseif redId == RedPointModel.ID_DREAM_TEAM_CHAP_DUOLA_MM_DAY_CLICK then
		local hasAwakeKingMM = self:_canAwakeMM(activityId, DreamTeamChapterController.awakeMMId.DuoLaMM)
		local key = string.format(DreamTeamChapterController.DUOLA_MM_DAY_KEY, activityId)
		local data = GameUtil.getUserDayData(key)

		return not data and not hasAwakeKingMM and chap2CanPlay and not hasAwakenMengMeng and self:_chapIsInOpenTime(activityId, 2)
	elseif redId == RedPointModel.ID_DREAM_TEAM_CHAP_ALCHEMY_MM_DAY_CLICK then
		local hasAwakeKingMM = self:_canAwakeMM(activityId, DreamTeamChapterController.awakeMMId.AlchemyMM)
		local key = string.format(DreamTeamChapterController.ALCHEMY_MM_DAY_KEY, activityId)
		local data = GameUtil.getUserDayData(key)

		return not data and not hasAwakeKingMM and chap2CanPlay and not hasAwakenMengMeng and self:_chapIsInOpenTime(activityId, 2)
	elseif redId == RedPointModel.ID_DREAM_TEAM_CHAP_LOVE_MM_DAY_CLICK then
		local hasAwakeKingMM = self:_canAwakeMM(activityId, DreamTeamChapterController.awakeMMId.LoveMM)
		local key = string.format(DreamTeamChapterController.LOVE_MM_DAY_KEY, activityId)
		local data = GameUtil.getUserDayData(key)

		return not data and not hasAwakeKingMM and chap2CanPlay and not hasAwakenMengMeng and self:_chapIsInOpenTime(activityId, 2)
	elseif redId == RedPointModel.ID_DREAM_TEAM_CHAP_ALCHEMY_MM_CAN_GET_PRIZE then
		return self:progressCanGetPrize(activityId, DreamTeamChapterController.progressTypeEnum.AlchemyMM)
	elseif redId == RedPointModel.ID_DREAM_TEAM_CHAP_THREE_CAN_REWARD then
		return self:progressCanGetPrize(activityId, DreamTeamChapterController.progressTypeEnum.BossDamage)
	elseif redId == RedPointModel.ID_DREAM_TEAM_CHAP_AWAKE_ALL_MM then
		return self:canAwakeAllMM(activityId) and not checkbool(info.hasAwakenMengMeng)
	end
end

function DreamTeamChapterController:_onResFightEnd(msg)
	if msg.isPass then
		UIStateManager.instance:open(ViewName.BattleSettlementSuccess)
	else
		UIStateManager.instance:open(ViewName.BattleSettlementFailSimple)
	end

	return true
end

DreamTeamChapterController.instance = DreamTeamChapterController.New()

return DreamTeamChapterController
