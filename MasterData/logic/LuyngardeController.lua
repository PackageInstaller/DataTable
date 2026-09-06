-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/controller/LuyngardeController.lua

module("logic.extensions.luyngarde.controller.LuyngardeController", package.seeall)

local LuyngardeController = class("LuyngardeController", BaseController)

function LuyngardeController:ctor()
	return
end

function LuyngardeController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterluyngardechapter", self.enterChapter, self)
end

function LuyngardeController:onReset()
	self._chapter2FmtMo = LuyngardeChapter2FmtMo.New()
	self._chapter3FmtMo = LuyngardeChapter3FmtMo.New()
	self._chapter3HelpFmtMo = LuyngardeChapter3HelpFmtMo.New()
	self._chapter4FmtMo = LuyngardeChapter4FmtMo.New()
	self._needJump = false
end

function LuyngardeController:openChapter2MissionView(activityId, creepsMasterId, simulated)
	self._chapter2FmtMo:initParams(activityId, creepsMasterId, simulated)
	CustomFmtController.instance:showMissionView(self._chapter2FmtMo)
end

function LuyngardeController:openChapter3MissionView(activityId, creepsMasterId, posId)
	self._chapter3FmtMo:initParams(activityId, creepsMasterId, posId)
	CustomFmtController.instance:showMissionView(self._chapter3FmtMo)
end

function LuyngardeController:openChapter3HelpMissionView(activityId, otherUserId, helpId, positionInfo)
	self._chapter3HelpFmtMo:initParams(activityId, otherUserId, helpId, positionInfo)
	CustomFmtController.instance:showMissionView(self._chapter3HelpFmtMo)
end

function LuyngardeController:getChapter3HelpFmtMo()
	return self._chapter3HelpFmtMo
end

function LuyngardeController:openChapter4MissionView(activityId)
	self._chapter4FmtMo:initParams(activityId)
	CustomFmtController.instance:showMissionView(self._chapter4FmtMo)
end

function LuyngardeController:enterChapter(param)
	local activityId = checknumber(param[1])
	local chapterId = checknumber(param[2])

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		printError("路因加德副本活动未开启：" .. activityId)

		return
	end

	local baseInfo = LuyngardeModel.instance:getBaseInfoByActId(activityId)

	if baseInfo then
		local curLevel = baseInfo.level

		if curLevel < 1 then
			FloatWordMgr.instance:show("需要先将小路因加德进化为路因加德，才能解锁本章玩法")

			return
		else
			if not self:getChapterStoryIsUnlock(activityId, chapterId - 1) then
				FloatWordMgr.instance:show("请先进入前一章，再打开本章活动哦")

				return
			end

			if chapterId == 2 then
				UIStateManager.instance:push(ViewName.LuyngardeChapter2View, activityId)
				self:unlockChapterStory(activityId, chapterId)
			elseif chapterId == 3 then
				UIStateManager.instance:push(ViewName.LuyngardeChapter3View, activityId)
				self:unlockChapterStory(activityId, chapterId)
			elseif chapterId == 4 then
				UIStateManager.instance:push(ViewName.LuyngardeChapter4View, activityId)
				self:unlockChapterStory(activityId, chapterId)
			end
		end
	else
		printError("路因副本数据未初始化")
	end
end

function LuyngardeController:getInfo(activityId)
	LuyngardeAgent.instance:sendPM_LuyngardeInfoReq(activityId)
end

function LuyngardeController:handleGetInfo(msg)
	LuyngardeModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeGetInfo)

	if self._needJump then
		self:getChapter3ExploreHelpInfo(self._lastActivityId, self._lastOtherUserId, self._lastPositionId, self._lastHelpId)

		self._needJump = false
	end
end

function LuyngardeController:upgradePet(activityId)
	LuyngardeAgent.instance:sendPM_LuyngardeUpgradeReq(activityId)
end

function LuyngardeController:handleUpgradePet(msg)
	LuyngardeModel.instance:onUpgradePet(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeUpgradePet)
end

function LuyngardeController:getChapter2Info(activityId)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter2BossInfoReq(activityId)
end

function LuyngardeController:handleChapter2Info(msg)
	LuyngardeModel.instance:onGetChapter2Info(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeGetChapter2Info)
end

function LuyngardeController:getChapter2SimpleRankInfo(activityId)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter2BossSimpleRankInfoReq(activityId)
end

function LuyngardeController:handleChapter2SimpleRankInfo(msg)
	LuyngardeModel.instance:onGetChapter2SimpleRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeGetChapter2SimpleRankInfo)

	local redPointId = RedPointModel.ID_Luyngarde_AreaKill_Prize
	local matchDay = LuyngardeModel.instance:getMatchAreaKillBossRelativeDay(msg.activityId)
	local chapter2SimpleRankInfo = LuyngardeModel.instance:getChapter2SimpleRankInfoByActId(msg.activityId)

	RedPointController.instance:setRedPointInfo(redPointId, (chapter2SimpleRankInfo and matchDay > 0 or nil) and not chapter2SimpleRankInfo.hadGainKillPrize)
end

function LuyngardeController:startChapter2Challenge(activityId, creepsMasterId, simulated, form_pb)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter2BossClgReq(activityId, creepsMasterId, simulated, form_pb)
end

function LuyngardeController:handleStartChapter2Challenge(msg)
	return
end

function LuyngardeController:handleNotifyChapter2ChallengeRes(msg)
	local info = GameUtil.pbToTable(msg)

	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)
		UIStateManager.instance:push(ViewName.LuyngardeResultView, info)

		return true
	end)
end

function LuyngardeController:gainChapter2Prize(activityId)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter2BossGainPrizeReq(activityId)
end

function LuyngardeController:handleGainChapter2Prize(msg)
	LuyngardeModel.instance:onGainChapter2Prize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeGainChapter2Prize)
end

function LuyngardeController:gainChapter2KillPrize(activityId)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter2BossGainKillPrizeReq(activityId)
end

function LuyngardeController:handleGainChapter2KillPrize(msg)
	LuyngardeModel.instance:onGainChapter2KillPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeGainChapter2KillPrize)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_Luyngarde_AreaKill_Prize, false)
end

function LuyngardeController:getChapter4Info(activityId)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter4FinalInfoReq(activityId)
end

function LuyngardeController:handleGetChapter4Info(msg)
	LuyngardeModel.instance:onGetChapter4Info(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeGetChapter4Info)
end

function LuyngardeController:startChapter4Challenge(activityId, form_pb)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter4FinalChallengeReq(activityId, form_pb)
end

function LuyngardeController:handleStartChapter4Challenge(msg)
	return
end

function LuyngardeController:handleNotifyChapter4ChallengeRes(msg)
	local info = GameUtil.pbToTable(msg)

	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)
		UIStateManager.instance:push(ViewName.LuyngardeChapter4ResultView, info)

		return true
	end)
end

function LuyngardeController:resetChapter4Challenge(activityId)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter4FinalResetReq(activityId)
end

function LuyngardeController:handleResetChapter4Challenge(msg)
	LuyngardeModel.instance:onResetChapter4Info(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeResetChapter4Info)
end

function LuyngardeController:getChapter3Info(activityId)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter3ExploreInfoReq(activityId)
end

function LuyngardeController:handleGetChapter3Info(msg)
	LuyngardeModel.instance:onGetChapter3Info(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeGetChapter3Info, msg)
end

function LuyngardeController:chapter3SelectStar(activityId, positionId, star)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter3ExploreSelectStarReq(activityId, positionId, star)
end

function LuyngardeController:handleChapter3SelectStar(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeChapter3SelectStar, msg)
end

function LuyngardeController:chapter3SelfClg(activityId, positionId, form_pb)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter3ExploreSelfClgReq(activityId, positionId, form_pb)
end

function LuyngardeController:hanleChapter3SelfClg(msg)
	local info = GameUtil.pbToTable(msg)
	local state = info.state

	if state == 1 then
		FloatWordMgr.instance:show("已经刷新走了")
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
	elseif state == 2 then
		FloatWordMgr.instance:show("已经被击杀")
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
	elseif state == 3 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		BattleController.instance:viewUserFightMonsterBtlResult(msg.battleResult, false)
	elseif state == 4 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		BattleController.instance:viewUserFightMonsterBtlResult(msg.battleResult, false)
	end
end

function LuyngardeController:chapter3SeekHelp(activityId, positionId)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter3ExploreSeekHelpReq(activityId, positionId)
end

function LuyngardeController:hanleChapter3SeekHelp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeChapter3SeekHelp, msg)
end

function LuyngardeController:chapter3ResetStar(activityId, positionId, star)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter3ExploreResetStarReq(activityId, positionId, star)
end

function LuyngardeController:hanleChapter3ResetStar(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeChapter3ResetStar, msg)
end

function LuyngardeController:getChapter3ExploreHelpInfo(activityId, otherUserId, positionId, helpId)
	if checknumber(RoleModel.instance:getUserId()) == checknumber(otherUserId) then
		return
	end

	local baseInfo = LuyngardeModel.instance:getBaseInfoByActId(checknumber(activityId))

	self._lastActivityId = checknumber(activityId)
	self._lastOtherUserId = checknumber(otherUserId)
	self._lastHelpId = checknumber(helpId)
	self._lastPositionId = checknumber(positionId)
	self._needJump = false

	if BattleController.instance:isBattling() then
		FloatWordMgr.instance:show("战斗中")

		return
	end

	if baseInfo then
		if baseInfo.level < 1 then
			FloatWordMgr.instance:show("需要先将小路因加德进化为路因加德，才能帮打")

			return
		end

		LuyngardeAgent.instance:sendPM_LuyngardeChapter3ExploreHelpInfoReq(activityId, otherUserId, positionId, helpId)
	else
		self._needJump = true

		self:getInfo(activityId)
	end
end

function LuyngardeController:handleGetChapter3ExploreHelpInfo(msg)
	local info = GameUtil.pbToTable(msg)

	if not info.position then
		FloatWordMgr.instance:show("该求助已处理了")

		return
	else
		self:openChapter3HelpMissionView(self._lastActivityId, self._lastOtherUserId, self._lastHelpId, info.position)
	end

	self._lastActivityId = nil
	self._lastOtherUserId = nil
	self._lastHelpId = nil
	self._lastPositionId = nil

	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeChapter3GetHelpInfo, msg)
end

function LuyngardeController:getChapter3ExploreHelpCenter(activityId, star)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter3ExploreHelpCenterReq(activityId, star)
end

function LuyngardeController:handleGetChapter3ExploreHelpCenter(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeChapter3GetHelpInfoList, msg)
end

function LuyngardeController:chapter3HelpClg(activityId, otherUserId, helpId, positionId, form_pb)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter3ExploreHelpClgReq(activityId, otherUserId, helpId, positionId, form_pb)
end

function LuyngardeController:hanleChapter3HelpClg(msg)
	local info = GameUtil.pbToTable(msg)
	local state = info.state

	if state == 1 then
		FloatWordMgr.instance:show("已经刷新走了")
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
	elseif state == 2 then
		FloatWordMgr.instance:show("已经被击杀")
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
	elseif state == 3 then
		BattleController.instance:viewUserFightMonsterBtlResult(msg.battleResult, false)
		BattleFacade.instance:registerResultHandler(function()
			BattleFacade.instance:registerResultHandler(nil, nil)
			UIStateManager.instance:push(ViewName.LuyngardeHelpCfgResultView, info)

			return true
		end)
	elseif state == 4 then
		BattleController.instance:viewUserFightMonsterBtlResult(msg.battleResult, false)
		BattleFacade.instance:registerResultHandler(function()
			BattleFacade.instance:registerResultHandler(nil, nil)
			UIStateManager.instance:push(ViewName.LuyngardeHelpCfgResultView, info)

			return true
		end)
	end
end

function LuyngardeController:getChapter2BossRankInfo(activityId, typeId)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter2BossRankInfoReq(activityId, typeId)
end

function LuyngardeController:handleGetChapter2RankInfo(msg)
	LuyngardeModel.instance:onGetChapter2RankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeUpdateRankInfoList)
end

function LuyngardeController:getChapter3ExploreRankInfo(activityId)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter3ExploreRankInfoReq(activityId)
end

function LuyngardeController:handleGetChapter3RankInfo(msg)
	LuyngardeModel.instance:onGetChapter3RankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeUpdateRankInfoList)
end

function LuyngardeController:getChapter4FinalRankInfo(activityId)
	LuyngardeAgent.instance:sendPM_LuyngardeChapter4FinalRankInfoReq(activityId)
end

function LuyngardeController:handleGetChapter4RankInfo(msg)
	LuyngardeModel.instance:onGetChapter4RankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.LuyngardeUpdateRankInfoList)
end

function LuyngardeController:unlockChapterStory(activityId, chapterId)
	if not self:getChapterStoryIsUnlock(activityId, chapterId) then
		local userDataKey = string.format("Luyngarde_Unlock_ChapterStory_%s_%s", activityId, chapterId)

		GameUtil.saveUserData(userDataKey, 1)

		local cfg = LuyngardeConfig.instance:getStoryCfgByChapterId(activityId, chapterId)

		GlobalDispatcher:dispatch(GlobalNotify.PushStory, cfg.storyId, StoryModel.StoryType.SCCopy)
	end
end

function LuyngardeController:getChapterStoryIsUnlock(activityId, chapterId)
	local userDataKey = string.format("Luyngarde_Unlock_ChapterStory_%s_%s", activityId, chapterId)

	return checknumber(GameUtil.getUserData(userDataKey)) > 0
end

LuyngardeController.instance = LuyngardeController.New()

return LuyngardeController
