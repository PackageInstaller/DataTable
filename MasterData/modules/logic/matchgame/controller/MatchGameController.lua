-- chunkname: @modules/logic/matchgame/controller/MatchGameController.lua

module("modules.logic.matchgame.controller.MatchGameController", package.seeall)

local MatchGameController = class("MatchGameController", BaseController)

function MatchGameController:reInit()
	self:clearResultFlow()

	if self._openEnterViewId then
		MatchGameRpc.instance:removeCallbackById(self._openEnterViewId)

		self._openEnterViewId = nil
	end
end

function MatchGameController:openMatchGameFightView(params)
	if params then
		if not params.episodeId then
			local episodeId = MatchGameFightEnum.TestEpisodeId

			if params then
				if not params.activityId then
					local activityId = MatchGameFightEnum.activityId
					local episodeCo = lua_activity244_episode.configDict[episodeId]
					local matchLevelId = episodeCo and episodeCo.matchLevelId

					matchLevelId = matchLevelId or MatchGameFightEnum.TestLevelId

					local levelType = MatchGameConfig.instance:getEpisodeLevelType(episodeId)
					local isChallenge = levelType == MatchGameEnum.LevelType.Challenge

					if params then
						if not params.isGM then
							local isGM = false

							MatchGameFightConfig.instance:initChainRateDataList(activityId)
							MatchGameFightModel.instance:initConfigData(episodeId)
							MatchGameFightModel.instance:initHeroFightInfo()

							local dataParam = {
								episodeId = episodeId,
								matchLevelId = matchLevelId,
								isChallenge = isChallenge,
								isGM = isGM
							}

							ViewMgr.instance:openView(ViewName.MatchGameFightView, dataParam)
							MatchGameStatHelper.instance:enterGame(episodeId)
						end
					end
				end
			end
		end
	end
end

function MatchGameController:openMatchGameMemberInfoView(param)
	ViewMgr.instance:openView(ViewName.MatchGameMemberInfoView, param)
end

function MatchGameController:openMatchGameFightQuitTipView(param)
	ViewMgr.instance:openView(ViewName.MatchGameFightQuitTipView, param)
end

function MatchGameController:openHeroGroupView(episodeId)
	ViewMgr.instance:openView(ViewName.MatchGameHeroGroupView, {
		episodeId = episodeId
	})
end

function MatchGameController:onEpisodeSuccess(episodeId, isSuccess, stars, score, exParam, endReason)
	local activityId = MatchGameModel.instance:getCurActId()
	local isFirstPass = false

	if isSuccess then
		local curStatus = MatchGameModel.instance:getEpisodeStatus(episodeId)

		isFirstPass = curStatus and curStatus ~= MatchGameEnum.EpisodeStatus.Finish
	end

	MatchGameRpc.instance:sendAct244SettleEpisodeRequest(activityId, episodeId, isSuccess, stars, score, function(_, resultCode)
		if resultCode ~= 0 then
			return
		end

		if stars then
			if not #stars then
				local starNum = 0

				if exParam then
					if not exParam.roundCount then
						local roundCount = 0

						if exParam then
							if not exParam.maxRoundDamage then
								local maxRoundDamage = 0

								MatchGameStatHelper.instance:endGame(episodeId, isSuccess, starNum, roundCount, score, maxRoundDamage, endReason)
								MatchGameController.instance:openGameResultView(episodeId, isSuccess, score, isFirstPass, exParam)
							end
						end
					end
				end
			end
		end
	end)
end

function MatchGameController:openGameResultView(episodeId, isSuccess, score, isFirstPass, exParam)
	local episodeCo = lua_activity244_episode.configDict[episodeId]

	if not episodeCo then
		return
	end

	local params = {
		episodeId = episodeId,
		isSuccess = isSuccess,
		score = score,
		isFirstPass = isFirstPass,
		exParam = exParam
	}

	self:_buildResultFlow(episodeId, params)
	ViewMgr.instance:closeView(ViewName.MatchGameFightView)
end

function MatchGameController:_buildResultFlow(episodeId, params)
	self:clearResultFlow()

	local levelType = MatchGameConfig.instance:getEpisodeLevelType(episodeId)

	if levelType == MatchGameEnum.LevelType.Challenge then
		if not ViewName.MatchGameChallengeResultView then
			local resultViewName = ViewName.MatchGameResultView

			self._resultFlow = FlowSequence.New()

			self._resultFlow:addWork(OpenViewAndWaitCloseWork.New(resultViewName, params))

			local newCharacterList = MatchGameModel.instance.newCharacterList

			if newCharacterList and #newCharacterList > 0 then
				local copyNewList = {}

				tabletool.addValues(copyNewList, newCharacterList)

				MatchGameModel.instance.newCharacterList = {}

				self._resultFlow:addWork(OpenViewAndWaitCloseWork.New(ViewName.MatchGameCharacterGainView, {
					characterIdList = copyNewList
				}))
			end

			self._resultFlow:start()
		end
	end
end

function MatchGameController:clearResultFlow()
	if self._resultFlow then
		self._resultFlow:destroy()

		self._resultFlow = nil
	end
end

function MatchGameController:onGameFinished(episodeId, isSuccess)
	ViewMgr.instance:closeView(ViewName.MatchGameResultView)
	ViewMgr.instance:closeView(ViewName.MatchGameChallengeResultView)

	if isSuccess then
		self:tryShowPassMapView(episodeId)
	end
end

function MatchGameController:tryShowPassMapView(episodeId)
	local episodeCo = lua_activity244_episode.configDict[episodeId]
	local levelType = MatchGameConfig.instance:getEpisodeLevelType(episodeId)

	if not episodeCo or levelType ~= MatchGameEnum.LevelType.Normal then
		return
	end

	local nextEpisode = MatchGameConfig.instance:getNextEpisodeConfig(episodeId)

	if nextEpisode then
		return
	end

	local isPlayed = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.MatchGameShowPassMapView, 0) ~= 0

	if isPlayed then
		return
	end

	ViewMgr.instance:openView(ViewName.MatchGamePassMapView)
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.MatchGameShowPassMapView, 1)
end

function MatchGameController:switchToTargetEpisode(episodeId)
	local targetEpisodeCo = lua_activity244_episode.configDict[episodeId]
	local preEpisodeId = targetEpisodeCo and targetEpisodeCo.preEpisode
	local preEpisodeCo = lua_activity244_episode.configDict[preEpisodeId]
	local preChapterId = preEpisodeCo and preEpisodeCo.chapterId
	local targetChapterId = targetEpisodeCo and targetEpisodeCo.chapterId

	if preChapterId == targetChapterId then
		MatchGameLevelModel.instance:switchEpisode(episodeId)
		self:openHeroGroupView(episodeId)

		return
	end

	self:dispatchEvent(MatchGameEvent.PlaySwitchMapAnim, targetChapterId)
end

function MatchGameController:openCharacterView(selectTabId)
	ViewMgr.instance:openView(ViewName.MatchGameCharacterView, {
		defaultTabIds = {
			[MatchGameCharacterViewContainer.ContainerTabId] = selectTabId
		}
	})
end

function MatchGameController:openEnterView(actId)
	self._openEnterViewId = MatchGameRpc.instance:sendGetAct244InfoRequest(actId, self._openEnterViewCallback, self)
end

function MatchGameController:_openEnterViewCallback(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.MatchGameEnterView)
end

function MatchGameController:openItemTipView(itemId)
	ViewMgr.instance:openView(ViewName.MatchGameItemTipView, {
		itemId = itemId
	})
end

function MatchGameController:enterMap(mapType, chapterId)
	MatchGameLevelModel.instance:initMapType(mapType, chapterId)

	if mapType == MatchGameEnum.LevelType.Normal then
		ViewMgr.instance:openView(ViewName.MatchGameMapView)
	elseif mapType == MatchGameEnum.LevelType.Challenge then
		ViewMgr.instance:openView(ViewName.MatchGameChallengeMapView)
	end
end

function MatchGameController:openRewardView(rewardType, param)
	if rewardType == MatchGameEnum.RewardType.Normal then
		ViewMgr.instance:openView(ViewName.MatchGameRewardView, param)
	elseif rewardType == MatchGameEnum.RewardType.Challenge then
		ViewMgr.instance:openView(ViewName.MatchGameChallengeRewardView, param)
	else
		logError(string.format("三消打开奖励界面失败 rewardType = %s", rewardType))
	end
end

function MatchGameController:openCareerTipView(screenPos)
	ViewMgr.instance:openView(ViewName.MatchGameCareerTipView, {
		screenPos = screenPos
	})
end

function MatchGameController:openTalentTipView(talentIdList, screenPos)
	ViewMgr.instance:openView(ViewName.MatchGameTalentTipView, {
		talentIdList = talentIdList,
		screenPos = screenPos
	})
end

function MatchGameController:initTalentRedDot()
	local redDotList = {}
	local branchList = lua_activity244_talent_branch.configList

	for _, branchCo in ipairs(branchList) do
		self:_initTalentBranchRedDot(branchCo, redDotList)
	end

	RedDotRpc.instance:clientAddRedDotGroupList(redDotList)
end

function MatchGameController:_initTalentBranchRedDot(branchCo, redDotList)
	local nodeList = MatchGameConfig.instance:getTalentNodeListByBranchType(branchCo.type)
	local branchRedDot = {
		value = 0,
		id = RedDotEnum.DotNode.MatchGameTalentCategory,
		uid = branchCo.id
	}

	if nodeList then
		for _, nodeCo in ipairs(nodeList) do
			local nodeId = nodeCo.nodeId
			local nodeValue = 0
			local isCanActive = self:isTalentNodeCanActive(nodeId)

			if isCanActive then
				local key = string.format("%s#%s", PlayerPrefsKey.MatchGameReadTalentId, nodeId)

				if GameUtil.playerPrefsGetNumberByUserId(key, 0) == 0 then
					branchRedDot.value = 1
					nodeValue = 1
				end
			end

			table.insert(redDotList, {
				id = RedDotEnum.DotNode.MatchGameTalentUnlock,
				uid = nodeId,
				value = nodeValue
			})
		end
	end

	table.insert(redDotList, branchRedDot)
end

function MatchGameController:isTalentNodeCanActive(nodeId)
	local status = MatchGameModel.instance:getTalentNodeStatus(nodeId)

	if status == MatchGameEnum.TalentNodeStatus.Unlock then
		local costList = MatchGameConfig.instance:getTalentNodeCost(nodeId)

		return (MatchGameModel.instance:isItemEnough(costList))
	end
end

function MatchGameController:onClickTalentBranchTab(branchId)
	if not RedDotModel.instance:isDotShow(RedDotEnum.DotNode.MatchGameTalentCategory, branchId) then
		return
	end

	local branchCo = lua_activity244_talent_branch.configDict[branchId]

	if not branchCo then
		return
	end

	local redDotList = {}
	local nodeList = MatchGameConfig.instance:getTalentNodeListByBranchType(branchCo.type)

	for _, nodeCo in ipairs(nodeList) do
		local nodeId = nodeCo.nodeId

		if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.MatchGameTalentUnlock, nodeId) then
			local key = string.format("%s#%s", PlayerPrefsKey.MatchGameReadTalentId, nodeId)

			GameUtil.playerPrefsSetNumberByUserId(key, 1)
			table.insert(redDotList, {
				value = 0,
				id = RedDotEnum.DotNode.MatchGameTalentUnlock,
				uid = nodeId
			})
		end
	end

	local branchRedDot = {
		value = 0,
		id = RedDotEnum.DotNode.MatchGameTalentCategory,
		uid = branchCo.id
	}

	table.insert(redDotList, branchRedDot)
	RedDotRpc.instance:clientAddRedDotGroupList(redDotList)
end

MatchGameController.instance = MatchGameController.New()

return MatchGameController
