-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/controller/IslandStationController.lua

module("logic.extensions.islandstation.controller.IslandStationController", package.seeall)

local IslandStationController = class("IslandStationController", BaseController)

function IslandStationController:onInit()
	return
end

function IslandStationController:getUnlockFoodBookNum(activityId, shopId)
	local curFoodBookCfgs = IslandStationConfig.instance:getFoodCfgByShopId(activityId, shopId)
	local shopInfo = IslandStationModel.instance:getShopInfoByShopId(activityId, shopId)
	local grilsInfo = IslandStationModel.instance:getGrilInfo(activityId)
	local profit = shopInfo.profit
	local shopLevel = IslandStationConfig.instance:getShopLevel(activityId, shopId, profit)
	local unlockNum = 0

	for i, cfg in pairs(curFoodBookCfgs) do
		local shopLvEnough = shopLevel >= cfg.shopLvUnlock
		local fetterEnough = false
		local girlId = cfg.girlId

		if girlId == 0 then
			fetterEnough = true
		else
			local curGrilInfo = grilsInfo[girlId]

			if curGrilInfo then
				fetterEnough = curGrilInfo.fetter >= cfg.fetterUnlock
			end
		end

		if fetterEnough and shopLvEnough then
			unlockNum = unlockNum + 1
		end
	end

	return unlockNum
end

function IslandStationController:getUnLockShelfNum(activityId, shopId, curShopLv)
	local shopCfg = IslandStationConfig.instance:getShopCfgByShopId(activityId, shopId)
	local shopLvPlanId = shopCfg.shopLvPlanId
	local shopLevelCfg = IslandStationConfig.instance:getShopLevelCfg(shopLvPlanId)
	local shelfNum = 0

	for i, cfg in ipairs(shopLevelCfg) do
		if curShopLv >= cfg.level then
			shelfNum = cfg.unlockPosCount
		end
	end

	return shelfNum
end

function IslandStationController:getUnLockFoodList(activityId, shopId)
	local curFoodBookCfgs = IslandStationConfig.instance:getFoodCfgByShopId(activityId, shopId)
	local shopInfo = IslandStationModel.instance:getShopInfoByShopId(activityId, shopId)
	local grilsInfo = IslandStationModel.instance:getGrilInfo(activityId)

	if shopInfo then
		if not shopInfo.profit then
			local profit = 0
			local shopLevel = IslandStationConfig.instance:getShopLevel(activityId, shopId, profit)
			local localFoodList = {}
			local grilFoodList = {}

			for i, cfg in ipairs(curFoodBookCfgs) do
				local shopLvEnough = shopLevel >= cfg.shopLvUnlock
				local fetterEnough = false
				local grilId = cfg.girlId

				if grilId == 0 then
					fetterEnough = true
				end

				if not grilsInfo[grilId] then
					do
						local curGrilInfo = {}

						fetterEnough = checknumber(curGrilInfo.fetter) >= cfg.fetterUnlock
					end

					if fetterEnough and shopLvEnough then
						if cfg.shopLvUnlock == 0 then
							table.insert(grilFoodList, cfg)
						else
							table.insert(localFoodList, cfg)
						end
					end
				end
			end

			return localFoodList, grilFoodList
		end
	end
end

function IslandStationController:getSmallGameRewardList(activityId, stageId)
	local smallGameCfg = IslandStationConfig.instance:getSmallGameCfgById(activityId, stageId)
	local rewardList = {}

	if smallGameCfg then
		local stuffProduceUnit = smallGameCfg and smallGameCfg.stuffProduceUnit
		local rewardArr = string.split(stuffProduceUnit, "#")

		for i, reward in ipairs(rewardArr) do
			local curReward = {}
			local arr = string.split(reward, "=")
			local foodStuffCfg = IslandStationConfig.instance:getFoodStuffCfgById(activityId, checknumber(arr[1]))

			curReward.materialStr = foodStuffCfg.materialStr
			curReward.count = checknumber(arr[2])

			table.insert(rewardList, curReward)
		end
	end

	return rewardList
end

function IslandStationController:getShopLvList(activityId)
	local info = IslandStationModel.instance:getInfo(activityId)
	local shopInfos = IslandStationModel.instance:getShopInfo(activityId)
	local shopCfgs = IslandStationConfig.instance:getShopCfg(activityId)
	local shopLvList = {}

	for i, cfg in ipairs(shopCfgs) do
		local shopId = cfg.shopId
		local curShopInfo = shopInfos[shopId]
		local shopLv = IslandStationConfig.instance:getShopLevel(activityId, shopId, curShopInfo.profit)

		table.insert(shopLvList, shopLv)
	end

	return shopLvList
end

function IslandStationController:sendPM_IslandStationInfoReq(activityId)
	IslandStationAgent.instance:sendPM_IslandStationInfoReq(activityId)
end

function IslandStationController:handlePM_IslandStationInfoRes(msg)
	IslandStationModel.instance:handlePM_IslandStationInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IslandStationInfoRes, msg)
end

function IslandStationController:sendPM_IslandStationRefreshShelfReq(activityId)
	IslandStationAgent.instance:sendPM_IslandStationRefreshShelfReq(activityId)
end

function IslandStationController:handlePM_IslandStationRefreshShelfRes(msg)
	IslandStationModel.instance:handlePM_IslandStationRefreshShelfRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IslandStationRefreshShelfRes)
end

function IslandStationController:sendPM_IslandStationOneKeyFullFillReq(activityId, shopId)
	IslandStationAgent.instance:sendPM_IslandStationOneKeyFullFillReq(activityId, shopId)
end

function IslandStationController:handlePM_IslandStationOneKeyFullFillRes(msg)
	IslandStationModel.instance:handlePM_IslandStationOneKeyFullFillRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IslandStationOneKeyFullFillRes)
end

function IslandStationController:sendPM_IslandStationPutOrChangeFoodReq(activityId, shopId, posId, foodId, foodNum)
	IslandStationAgent.instance:sendPM_IslandStationPutOrChangeFoodReq(activityId, shopId, posId, foodId, foodNum)
end

function IslandStationController:handlePM_IslandStationPutOrChangeFoodRes(msg)
	IslandStationModel.instance:handlePM_IslandStationPutOrChangeFoodRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IslandStationPutOrChangeFoodRes)
end

function IslandStationController:sendPM_IslandStationMakeFoodReq(activityId, foodId, makeCount)
	IslandStationAgent.instance:sendPM_IslandStationMakeFoodReq(activityId, foodId, makeCount)
end

function IslandStationController:handlePM_IslandStationMakeFoodRes(msg)
	IslandStationModel.instance:handlePM_IslandStationMakeFoodRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IslandStationMakeFoodRes)
end

function IslandStationController:sendPM_IslandStationStartGameReq(activityId, stageId)
	local clientKey = IslandStationModel.instance:getClientKey(activityId)

	IslandStationAgent.instance:sendPM_IslandStationStartGameReq(activityId, stageId, clientKey)
end

function IslandStationController:handlePM_IslandStationStartGameRes(msg)
	IslandStationModel.instance:handlePM_IslandStationStartGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IslandStationStartGameRes)
end

function IslandStationController:sendPM_IslandStationGetBossInfoReq(activityId)
	IslandStationAgent.instance:sendPM_IslandStationGetBossInfoReq(activityId)
end

function IslandStationController:handlePM_IslandStationGetBossInfoRes(msg)
	IslandStationModel.instance:handlePM_IslandStationGetBossInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IslandStationGetBossInfoRes)
end

function IslandStationController:sendPM_IslandStationEndGameReq(activityId, stageId, score)
	local encryptedKey = IslandStationModel.instance:getEncryptedKey(activityId, stageId, score)

	IslandStationAgent.instance:sendPM_IslandStationEndGameReq(activityId, stageId, score, encryptedKey)
end

function IslandStationController:handlePM_IslandStationEndGameRes(msg)
	IslandStationModel.instance:handlePM_IslandStationEndGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IslandStationEndGameRes)
end

function IslandStationController:sendPM_IslandStationChallengeBossReq(activityId, form)
	IslandStationAgent.instance:sendPM_IslandStationChallengeBossReq(activityId, form)
end

function IslandStationController:handlePM_IslandStationChallengeBossRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IslandStationChallengeBossRes)
end

function IslandStationController:sendPM_IslandStationResetChatReq(activityId, girlId, dialogueId)
	IslandStationAgent.instance:sendPM_IslandStationResetChatReq(activityId, girlId, dialogueId)
end

function IslandStationController:handlePM_IslandStationResetChatRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IslandStationResetChatRes, msg)
end

function IslandStationController:sendPM_IslandStationSelectAnswerReq(activityId, girlId, dialogueId, answer)
	IslandStationAgent.instance:sendPM_IslandStationSelectAnswerReq(activityId, girlId, dialogueId, answer)
end

function IslandStationController:handlePM_IslandStationSelectAnswerRes(msg)
	IslandStationModel.instance:handlePM_IslandStationSelectAnswerRes(msg)

	if msg.curFetter and msg.curFetter > 0 then
		GlobalDispatcher:dispatch(GlobalNotify.IslandStationGirlAddFetter)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_IslandStationSelectAnswerRes, msg)
end

function IslandStationController:handlePM_Notify_IslandStationChallengeResult(msg)
	IslandStationModel.instance:handlePM_Notify_IslandStationChallengeResult(msg)
end

function IslandStationController:sendPM_IslandStationGainCollectSkinPrizeReq(activityId)
	IslandStationAgent.instance:sendPM_IslandStationGainCollectSkinPrizeReq(activityId)
end

function IslandStationController:handlePM_IslandStationGainCollectSkinPrizeRes(msg)
	IslandStationModel.instance:handlePM_IslandStationGainCollectSkinPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IslandStationGainCollectSkinPrizeRes)
end

function IslandStationController:enterBattleClg(activityId)
	local customFmtMo = IslandStationModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function IslandStationController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function IslandStationController:getRandomPictureCfg(difficult)
	local findDifferenceCfg = IslandStationConfig.instance:getFindDifferenceCfg()
	local difficultIdCfgList = {}

	for i, cfg in ipairs(findDifferenceCfg) do
		if cfg.difficulty == difficult then
			table.insert(difficultIdCfgList, cfg)
		end
	end

	local randomGameIdx = math.random(1, #difficultIdCfgList)

	return difficultIdCfgList[randomGameIdx]
end

function IslandStationController:getGoddessShopMo(activityId)
	return IslandStationModel.instance:getGoddessShopMo(activityId)
end

function IslandStationController:getNextUnLockFoodCfg(activityId, girlId)
	local girlFoodDic = IslandStationConfig.instance:getGirlFoodDic(activityId)
	local girlFetter = IslandStationModel.instance:getGirlFetter(activityId, girlId)
	local girlFoodList = girlFoodDic[girlId]

	table.sort(girlFoodList, function(a, b)
		return a.fetterUnlock < b.fetterUnlock
	end)

	for i, foodCfg in ipairs(girlFoodList) do
		if girlFetter < foodCfg.fetterUnlock then
			return foodCfg
		end
	end
end

function IslandStationController:getTotalFetter(activityId)
	local girlCfgs = IslandStationConfig.instance:getGirlCfg(activityId)
	local totalFetter = 0

	for i, cfg in ipairs(girlCfgs) do
		local curGirlId = cfg.girlId
		local curFetter = IslandStationModel.instance:getGirlFetter(activityId, curGirlId)

		totalFetter = totalFetter + curFetter
	end

	return totalFetter
end

function IslandStationController:tryPlayFetter(activityId, girlId, oldFetter)
	local curGirlFetter = IslandStationModel.instance:getGirlFetter(activityId, girlId)
	local girlStoryCfgs = IslandStationConfig.instance:getStoryCfgsByGirlId(activityId, girlId)

	for i = #girlStoryCfgs, 1, -1 do
		local curCfg = girlStoryCfgs[i]

		if curGirlFetter >= curCfg.unLockFetter and oldFetter < curCfg.unLockFetter then
			local storyId = curCfg.storyId

			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end
	end
end

function IslandStationController:tryPlayEndStory(activityId)
	local totalFetter = self:getTotalFetter(activityId)
	local gorupCfgs = IslandStationConfig.instance:getStoryGroupCfg(activityId)
	local endStoryGroupCfg = gorupCfgs[#gorupCfgs]
	local groupId = endStoryGroupCfg.groupId
	local endStoryCfgs = IslandStationConfig.instance:getStoryCfgsByGroupId(activityId, groupId)
	local endStoryCfg = endStoryCfgs[1]

	if totalFetter >= endStoryCfg.unLockFetter then
		local storyId = endStoryCfg.storyId

		if checknumber(storyId) > 0 then
			local key = string.format("IslandStationController%s", activityId)

			local function firstCallback()
				GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
			end

			GameUtil.doCallbackWhenFirst(key, firstCallback)
		end
	end
end

IslandStationController.instance = IslandStationController.New()

return IslandStationController
