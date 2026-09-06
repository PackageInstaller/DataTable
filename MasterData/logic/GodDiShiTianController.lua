-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddishitian/controller/GodDiShiTianController.lua

module("logic.extensions.goddishitian.controller.GodDiShiTianController", package.seeall)

local GodDiShiTianController = class("GodDiShiTianController", BaseController)

function GodDiShiTianController:ctor()
	return
end

function GodDiShiTianController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.GodDiShiTianStageOverRes, self._onBattleEndRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GodDiShiTianQuickPassRes, self._onQuickPassRes, self)
end

function GodDiShiTianController:_onBattleEndRes()
	local stageType = GodDiShiTianModel.instance:getBattleStageTypeId()
	local cfg = GodDiShiTianConfig.instance:getStageTypeCfg(stageType)
	local params = {}

	params.scoreList = GodDiShiTianModel.instance:getConditionStrs()

	if cfg then
		params.isShowBossHp = cfg.bShowScore or false
	end

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.GodDiShiTian, params)
	printInfo("test _onBattleEndRes 是否通关", GodDiShiTianModel.instance:isPassFinalLevel())

	local challengeId = GodDiShiTianModel.instance:getChallengeId()

	if not GodDiShiTianModel.instance:isPassFinalLevel() then
		UIJumper.instance:pushOneStack(ViewName.GodDiShiTianMainView, true, challengeId)
		UIJumper.instance:pushOneStack(ViewName.GodDiShiTianStageView, true, stageType)
	else
		local isShowChallengeSuccessView = true

		UIJumper.instance:pushOneStack(ViewName.GodDiShiTianMainView, true, challengeId, isShowChallengeSuccessView)
	end
end

function GodDiShiTianController:_onQuickPassRes(msg)
	if msg:HasField("changeSetId") then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	local function callback()
		GodDiShiTianController.instance:showOneKeyReward()
	end

	UIStateManager.instance:popByName(ViewName.GodDiShiTianMainView)
	UIStateManager.instance:push(ViewName.DivineEvolveTipView, callback)
end

function GodDiShiTianController:openExtraBattleResultView()
	local isShow = GodDiShiTianModel.instance:isShowCoverScoreView()

	if isShow then
		local stageType = GodDiShiTianModel.instance:getBattleStageTypeId()
		local battleStageId = GodDiShiTianModel.instance:getBattleStageId()
		local isWinBefore = GodDiShiTianModel.instance:isBattleStageWinedBefore(battleStageId)

		if isWinBefore then
			local oldScore, newScore = GodDiShiTianModel.instance:getBattleScore()

			UIStateManager.instance:push(ViewName.GodDiShiTianScoreView, oldScore, newScore, battleStageId)
		else
			GodDiShiTianAgent.instance:sendPM_GodDiShiTianSetScoreReq(battleStageId)
		end
	end
end

function GodDiShiTianController:showOneKeyReward()
	local changeSetId = GodDiShiTianModel.instance:getOneKeyChangeSetId()

	MaterialController.instance:showChangeSetInTemp(changeSetId)
end

function GodDiShiTianController:getChapterColorState()
	local list = {}
	local sameScoreList = {}
	local stateList = {}

	for i = 1, 3 do
		list[i] = {}
		list[i].curScore = GodDiShiTianModel.instance:getChapterScore(i)
		list[i].targetScore = GodDiShiTianConfig.instance:getStageTypeCfg(i).passLine
		list[i].isPassScore = list[i].curScore >= list[i].targetScore
		list[i].isChapterPass = GodDiShiTianModel.instance:isChapterPass(i)
		list[i].isAnyStagePass = GodDiShiTianModel.instance:isAnyStagePass(i)
		stateList[i] = 0

		if list[i].isChapterPass then
			if list[i].isPassScore then
				sameScoreList[list[i].curScore] = sameScoreList[list[i].curScore] or {}

				table.insert(sameScoreList[list[i].curScore], i)
			else
				stateList[i] = 1
			end
		else
			stateList[i] = list[i].isAnyStagePass and 1 or 0
		end
	end

	for i, v in pairs(sameScoreList) do
		if #v == 1 then
			local index = v[1]

			stateList[index] = list[index].isAnyStagePass and 1 or 0
		else
			for j, index in ipairs(v) do
				stateList[index] = 2
			end
		end
	end

	return stateList
end

GodDiShiTianController.instance = GodDiShiTianController.New()

return GodDiShiTianController
