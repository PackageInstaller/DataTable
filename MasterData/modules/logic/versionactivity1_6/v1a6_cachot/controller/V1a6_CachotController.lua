-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/controller/V1a6_CachotController.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotController", package.seeall)

local V1a6_CachotController = class("V1a6_CachotController", BaseController)

function V1a6_CachotController:onInit()
	self.needShowCureEffect = nil
	self.heartNum = nil
	self.cureAddHp = nil
end

function V1a6_CachotController:onInitFinish()
	return
end

function V1a6_CachotController:addConstEvents()
	return
end

function V1a6_CachotController:reInit()
	self.needShowCureEffect = nil
	self.heartNum = nil
	self.cureAddHp = nil
end

function V1a6_CachotController:enterMap(isFightBack)
	if V1a6_CachotModel.instance:isInRogue() then
		local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

		if not rogueInfo then
			RogueRpc.instance:sendGetRogueInfoRequest(V1a6_CachotEnum.ActivityId)
		else
			local topEventMo = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

			if topEventMo and not topEventMo:isBattleSuccess() and topEventMo:getRetries() > 0 then
				local fightCo = lua_rogue_event_fight.configDict[topEventMo:getEventCo().eventId]

				DungeonModel.instance:SetSendChapterEpisodeId(nil, fightCo.episode)
				FightController.instance:setFightParamByEpisodeId(fightCo.episode, false, 1)
				V1a6_CachotHeroGroupModel.instance:clear()
				V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(V1a6_CachotEnum.HeroCountInGroup)
				V1a6_CachotHeroGroupModel.instance:onGetHeroGroupList(V1a6_CachotModel.instance:getTeamInfo():getGroupInfos())
				V1a6_CachotHeroGroupModel.instance:updateGroupIndex()
				self:setFightHeroGroup()

				local fightParam = FightModel.instance:getFightParam()

				DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, 1)

				return
			end

			if V1a6_CachotRoomModel.instance:getLayerIsChange() then
				GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingCachotChangeView)
			elseif not isFightBack then
				GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingCachotView)
			end

			local bgmId = V1a6_CachotEventConfig.instance:getBgmIdByLayer(rogueInfo.layer)

			AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Cachot, bgmId)
			V1a6_CachotRoomModel.instance:clearRoomChangeStatus()
			GameSceneMgr.instance:startScene(SceneType.Cachot, 90001, V1a6_CachotConfig.instance:getSceneLevelId(rogueInfo.sceneId), true, true)
		end
	else
		AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Cachot, AudioEnum.Bgm.CachotMainScene)
		GameSceneMgr.instance:startScene(SceneType.Cachot, 90001, 90001, true, true)
	end
end

function V1a6_CachotController:abandonGame()
	V1a6_CachotStatController.instance:statReset()
	RogueRpc.instance:sendAbortRogueRequest(V1a6_CachotEnum.ActivityId)
end

function V1a6_CachotController:checkRogueStateInfo()
	if V1a6_CachotModel.instance:getRogueStateInfo() then
		return
	end

	RogueRpc.instance:sendGetRogueStateRequest()
end

function V1a6_CachotController:openRoom()
	V1a6_CachotController.instance:openV1a6_CachotRoomView()
	self:enterMap()
end

function V1a6_CachotController:openV1a6_CachotEnterView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEnterView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotMainView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotMainView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotRoomView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoomView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotCollectionView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotDifficultyView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotDifficultyView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotResultView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotResultView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotFinishView(param, isImmediate)
	local rogueEndingInfo = V1a6_CachotModel.instance:getRogueEndingInfo()

	if not rogueEndingInfo or rogueEndingInfo:isEnterEndingFlow() then
		return
	end

	ViewMgr.instance:openView(ViewName.V1a6_CachotFinishView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotProgressView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotProgressView, param, isImmediate)
end

function V1a6_CachotController:setFightHeroGroup()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return false
	end

	local curGroupMO = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()

	if not curGroupMO then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local main, mainCount = curGroupMO:getMainList()
	local sub, subCount = curGroupMO:getSubList()

	if (not curGroupMO.aidDict or #curGroupMO.aidDict <= 0) and mainCount + subCount == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local battleId = fightParam.battleId
	local battleConfig = battleId and lua_battle.configDict[battleId]

	if battleConfig and battleConfig.noClothSkill == 0 then
		if not curGroupMO.clothId then
			local clothId = 0

			fightParam:setMySide(clothId, main, curGroupMO:getSubList(), curGroupMO:getAllHeroEquips(), curGroupMO:getAllHeroActivity104Equips())

			return true
		end
	end
end

function V1a6_CachotController:_initHeroSingleGroupModel()
	V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(V1a6_CachotEnum.HeroCountInGroup)
	V1a6_CachotHeroGroupModel.instance:clear()

	local teamInfo = V1a6_CachotModel.instance:getTeamInfo()

	V1a6_CachotHeroGroupModel.instance:onGetHeroGroupList(teamInfo.groupInfos)
	V1a6_CachotHeroGroupModel.instance:setCurGroupId(teamInfo.groupIdx)
end

function V1a6_CachotController:selectHeroFromEvent(eventMo)
	V1a6_CachotHeroGroupModel.instance:clear()

	local teamInfo = V1a6_CachotModel.instance:getTeamInfo()
	local heroList = teamInfo:getAllHeroUids()
	local groupMO = V1a6_CachotHeroGroupMO.New()

	groupMO:setMaxHeroCount(#heroList)

	local curGroupId = 1

	groupMO:init({
		groupId = curGroupId,
		heroList = heroList
	})
	V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(#heroList)
	V1a6_CachotHeroSingleGroupModel.instance:setSingleGroup(groupMO)

	local param = {}

	param.singleGroupMOId = 1
	param.originalHeroUid = "0"
	param.equips = {
		"0"
	}
	param.hideCancel = true
	param.selectHeroFromEvent = true
	param.heroGroupEditType = V1a6_CachotEnum.HeroGroupEditType.Event
	param.eventMo = eventMo

	ViewMgr.instance:openView(ViewName.V1a6_CachotHeroGroupEditView, param)
end

function V1a6_CachotController:openV1a6_CachotTeamView(param, isImmediate)
	if param and param.selectLevel then
		V1a6_CachotTeamModel.instance:setSelectLevel(param.selectLevel)
	end

	ViewMgr.instance:openView(ViewName.V1a6_CachotTeamView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotTeamPreView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotTeamPreView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotLoadingView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotLoadingView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotRoleRevivalView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoleRevivalView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotRoleRevivalResultView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoleRevivalResultView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotRoleRecoverView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoleRecoverView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotRoleRecoverResultView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoleRecoverResultView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotUpgradeView(param, isImmediate)
	self:_initHeroSingleGroupModel()
	ViewMgr.instance:openView(ViewName.V1a6_CachotUpgradeView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotUpgradeResultView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotUpgradeResultView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotEquipInfoTeamShowView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEquipInfoTeamShowView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotEndingView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEndingView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotCollectionBagView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionBagView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotCollectionUnlockedView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionUnlockedView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotCollectionOverView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionOverView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotStoreView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotStoreView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotTipsView(param, isImmediate)
	V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Tips)
	ViewMgr.instance:openView(ViewName.V1a6_CachotTipsView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotEpisodeView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEpisodeView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotCollectionEnchantView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionEnchantView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotCollectionGetView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionGetView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotCollectionSelectView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionSelectView, param, isImmediate)
end

function V1a6_CachotController:openV1a6_CachotRewardView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRewardView, param, isImmediate)
end

V1a6_CachotController.instance = V1a6_CachotController.New()

return V1a6_CachotController
