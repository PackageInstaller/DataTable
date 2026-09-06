-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/controller/FamilyteamplayController.lua

module("logic.extensions.familyteamplay.controller.FamilyteamplayController", package.seeall)

local FamilyteamplayController = class("FamilyteamplayController", BaseController)

FamilyteamplayController.teamPlayType = {
	Common = 0,
	Season = 1
}

function FamilyteamplayController:ctor()
	self._currTeamPlayType = nil
	self._currZoneId = nil
	self._btnTiredGo = nil
	self._openNeedFamilyLv = nil
end

function FamilyteamplayController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(FamilyAgent.NotifyJoinLeaveFamilyRes, self._NotifyJoinLeaveFamilyRes, self)
	FamilyTeamPlayAgent.instance:setShowChangeSetFunc(GameUtil.handler(self._showChangeSet, self))
	MsgFlowMgr.instance:ignoreAutoShowFloatMsg(151, 9)
end

function FamilyteamplayController:onReset()
	self._currZoneId = nil
	self._btnTiredGo = nil
	self._openNeedFamilyLv = nil
end

function FamilyteamplayController:openView()
	local needLv = self:_getOpenFuncNeedFamilyLv()

	if needLv > 0 and needLv > FamilyModel.instance:getFamilyLv() then
		FloatWordMgr.instance:show(string.format("家族等级达到%s级解锁", needLv))

		return
	end

	if not FamilyteamplayModel.instance:isFunOpen() then
		FloatWordMgr.instance:show("活动暂未开启")

		return
	end

	UIStateManager.instance:push(ViewName.FamilytpbossgroupView)
end

function FamilyteamplayController:_getOpenFuncNeedFamilyLv()
	if self._openNeedFamilyLv then
		return self._openNeedFamilyLv
	end

	self._openNeedFamilyLv = 0

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(GameEnum.FuncType.FamilyTeamplay)

	if cfg == nil or string.nilorempty(cfg.openCondition) then
		return self._openNeedFamilyLv
	end

	local s, e = string.find(cfg.openCondition, "^10,%d*")

	if not s then
		s, e = string.find(cfg.openCondition, "&10,%d*")

		if not s then
			s, e = string.find(cfg.openCondition, "!10,%d*")

			if not s then
				s, e = string.find(cfg.openCondition, "|10,%d*")
			end
		end

		s = s and s + 1
	end

	if s then
		local str = string.sub(cfg.openCondition, s, e)
		local arr = string.split(str, ",")

		self._openNeedFamilyLv = checknumber(arr[2])
	end

	return self._openNeedFamilyLv
end

function FamilyteamplayController:clickChatItemOpenView(familyId, periodId, bossId, tpType)
	if FuncOpenModel.instance:getFuncIsOpen(GameEnum.FuncType.FamilyTeamplay) then
		self:csSendCheckTeamPlayBossValidReq(periodId, bossId, familyId, tpType)
	else
		FloatWordMgr.instance:show("功能未开启")
	end
end

function FamilyteamplayController:setBtnTiredGo(tiredGo)
	self._btnTiredGo = tiredGo
end

function FamilyteamplayController:getBtnTiredGo()
	return self._btnTiredGo
end

function FamilyteamplayController:_showChangeSet(changeSetId, msgName)
	if changeSetId and changeSetId > 0 then
		if msgName == "handlePM_NotifyAfterTeamPlayBattleRes" then
			BattleSettlementModel.instance:setChangeSetId(changeSetId)
		else
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
		end
	end
end

function FamilyteamplayController:csSendGetTeamPlayProgressInfoReq(tpType, isNeedParam)
	self._isNeedParam = isNeedParam

	if tpType then
		self._isAllSend = false
		self._currTeamPlayType = tpType

		FamilyTeamPlayAgent.instance:sendPM_GetTeamPlayProgressInfoReq(self._currTeamPlayType)

		return
	end

	self._currTeamPlayType = FamilyteamplayController.teamPlayType.Common
	self._isAllSend = true

	FamilyTeamPlayAgent.instance:sendPM_GetTeamPlayProgressInfoReq(self._currTeamPlayType)
end

function FamilyteamplayController:scGetTeamPlayProgressInfo(msg)
	FamilyteamplayModel.instance:scTeamPlayProgressInfo(self._currTeamPlayType, msg)

	if self._isAllSend then
		self._isAllSend = false

		if checknumber(msg.curZoneId) > 0 and FamilyteamplayModel.instance:isAllStagePass(FamilyteamplayController.teamPlayType.Common) then
			self:csSendGetTeamPlayProgressInfoReq(FamilyteamplayController.teamPlayType.Season)

			return
		end
	end

	if self._isNeedParam then
		GlobalDispatcher:dispatch(GlobalNotify.UpdataTeamPlayProgressInfo, self._currTeamPlayType)
	else
		GlobalDispatcher:dispatch(GlobalNotify.UpdataTeamPlayProgressInfo)
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyActivityItem, GameEnum.FamilyActivityType.TeamPlay)

	self._isNeedParam = nil
end

function FamilyteamplayController:csSendViewMemberZdlInfoListReq()
	FamilyTeamPlayAgent.instance:sendPM_ViewMemberZdlInfoListReq()
end

function FamilyteamplayController:scViewMemberZdlInfoList(msg)
	if msg == nil or msg.zdlInfoList == nil then
		return
	end

	FamilyteamplayModel.instance:setMemberZdlInfoList(msg.zdlInfoList)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataTeamPlayMemberZdlInfo)
end

function FamilyteamplayController:csSendViewFamilyTeamPlayRankReq()
	FamilyTeamPlayAgent.instance:sendPM_ViewFamilyTeamPlayRankReq()
end

function FamilyteamplayController:scViewFamilyTeamPlayRank(msg)
	if msg == nil or msg.periodId == nil then
		return
	end

	FamilyteamplayModel.instance:setFamilyTeamPlayRank(msg)
	RankModel.instance:setRankData(msg, GameEnum.RankType.FamilyTeamPlay, 0)
	GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
end

function FamilyteamplayController:csSendTeamPlayFightOrPracticeReq(periodId, bossId, tpType, isFight)
	self._currTeamPlayType = tpType

	if isFight then
		FamilyTeamPlayAgent.instance:sendPM_TeamPlayFightReq(periodId, bossId, tpType)
	else
		FamilyTeamPlayAgent.instance:sendPM_TeamPlayPracticeReq(periodId, bossId, tpType)
	end
end

function FamilyteamplayController:scTeamPlayFight(status)
	self:_setJumpToView(self._currTeamPlayType)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataTeamPlayFightInfo, status)
end

function FamilyteamplayController:scTeamPlayPractice(status)
	self:_setJumpToView(self._currTeamPlayType)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataTeamPlayPracticeInfo, status)
end

function FamilyteamplayController:_setJumpToView(tpType)
	tpType = tpType or FamilyteamplayController.teamPlayType.Common

	UIJumper.instance:removeTopState(ViewName.FamilytpMissionView)
	UIJumper.instance:pushOneStack(ViewName.FamilytpbossgroupView, tpType)
end

function FamilyteamplayController:csSendViewMemberDamageListReq(periodId)
	FamilyTeamPlayAgent.instance:sendPM_ViewMemberDamageListReq(periodId)
end

function FamilyteamplayController:scViewMemberDamageList(msg)
	if msg == nil or msg.memberDamages == nil then
		return
	end

	FamilyteamplayModel.instance:setMemberDamageList(msg.memberDamages)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataTeamPlayDamageInfo)
end

function FamilyteamplayController:csSendTeamPlaySmallGameStartReq(periodId, gameId)
	FamilyteamplayModel.instance:setStartSmallGameParam(gameId)
	FamilyTeamPlayAgent.instance:sendPM_TeamPlaySmallGameStartReq(periodId, gameId)
end

function FamilyteamplayController:scTeamPlaySmallGameStart()
	local baseInfo = FamilyteamplayModel.instance:getBaseProgressInfo()
	local gameId = FamilyteamplayModel.instance:getStartSmallGameParam()

	if baseInfo and checknumber(baseInfo.periodId) > 0 and gameId > 0 then
		local cfg = FamilyteamplayConfig.instance:getSmallGameCfg(gameId)

		if cfg then
			if cfg.typeId == GameEnum.FamilyTpSmallGame.KJT then
				UIStateManager.instance:push(ViewName.FamilytpkrzgameView, gameId)
			elseif cfg.typeId == GameEnum.FamilyTpSmallGame.Flynuo then
				UIStateManager.instance:push(ViewName.FamilytpflynuogameView, gameId)
			elseif cfg.typeId == GameEnum.FamilyTpSmallGame.ZSM then
				UIStateManager.instance:push(ViewName.FamilytpzsmgameView, gameId)
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataTeamPlaySmallGameStart)
end

function FamilyteamplayController:csSendTeamPlaySmallGameEndReq(gameId, score)
	local baseInfo = FamilyteamplayModel.instance:getBaseProgressInfo()

	if baseInfo == nil or checknumber(baseInfo.periodId) <= 0 then
		return
	end

	FamilyTeamPlayAgent.instance:sendPM_TeamPlaySmallGameEndReq(baseInfo.periodId, gameId, score)
end

function FamilyteamplayController:scTeamPlaySmallGameEnd(msg)
	if msg == nil or msg.periodId == nil then
		return
	end

	local cfg = FamilyteamplayConfig.instance:getSmallGameCfg(msg.gameId)

	if cfg.typeId == GameEnum.FamilyTpSmallGame.Flynuo then
		if msg.changeSetId and msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			UIStateManager.instance:push(ViewName.FamilytpflynuoitemgetView, msg.gameId, msg.changeSetId)
		else
			FloatWordMgr.instance:show("积分不足，未获得奖励")
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataTeamPlaySmallGameEnd)
end

function FamilyteamplayController:csSendCheckTeamPlayBossValidReq(periodId, bossId, familyId, tpType)
	FamilyTeamPlayAgent.instance:sendPM_CheckTeamPlayBossValidReq(periodId, bossId, familyId, tpType)
end

function FamilyteamplayController:scCheckTeamPlayBossValid()
	UIStateManager.instance:push(ViewName.FamilytpbossgroupView)
end

function FamilyteamplayController:csSendChooseTeamPlayWarZoneReq(periodId, zoneId, familyId)
	FamilyTeamPlayAgent.instance:sendPM_ChooseTeamPlayWarZoneReq(periodId, zoneId, familyId)
end

function FamilyteamplayController:scChooseTeamPlayWarZone(zoneId)
	FamilyteamplayModel.instance:scChooseTeamPlayWarZone(zoneId)

	local cfg = FamilyteamplayConfig.instance:getBossWarZoneCfg(zoneId)

	if not FamilyteamplayModel.instance:isAllStagePass(FamilyteamplayController.teamPlayType.Common) then
		FloatWordMgr.instance:show(string.format("成功加入了%s，围剿模式通关14关后可进入！", (cfg or nil) and (cfg.name or "战区")))
	else
		FloatWordMgr.instance:show(string.format("成功加入了%s！", (cfg or nil) and (cfg.name or "战区")))
		self:csSendGetTeamPlayProgressInfoReq(FamilyteamplayController.teamPlayType.Season, true)
	end
end

function FamilyteamplayController:getFamilySeasonRankList(periodId, zoneId)
	local rankList = {}
	local myRank = -1

	if checknumber(zoneId) > 0 then
		local info, isSend = FamilyteamplayModel.instance:getFamilySeasonRankList(periodId, zoneId)

		if info then
			rankList = info.rankList or {}
			myRank = checknumber(info.myRank)
		end

		if isSend then
			self._currZoneId = zoneId

			FamilyTeamPlayAgent.instance:sendPM_GetFamilyZoneRnakReq(periodId, zoneId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilySeasonRankInfo, rankList, myRank)
end

function FamilyteamplayController:scGetFamilyZoneRnak(msg)
	if msg == nil or msg.periodId == nil then
		return
	end

	FamilyteamplayModel.instance:setFamilySeasonRankList(msg, self._currZoneId)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilySeasonRankInfo, msg.rankInfo, msg.myRank)

	self._currZoneId = nil
end

function FamilyteamplayController:csSendGetFamilyZoneInfoReq(periodId)
	FamilyTeamPlayAgent.instance:sendPM_GetFamilyZoneInfoReq(periodId)
end

function FamilyteamplayController:scGetFamilyZoneInfo(msg)
	if msg == nil or msg.infos == nil then
		return
	end

	local list = {}

	for _, info in pairs(msg.infos or {}) do
		if info and info.zoneId and checknumber(info.zoneId) > 0 then
			list[info.zoneId] = checknumber(info.familyNum)
		end
	end

	UIStateManager.instance:push(ViewName.FamilyBossSeason, list)
end

function FamilyteamplayController:scNotifyAfterTeamPlayBattle(msg, status)
	if status == 0 then
		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.FamilyTeamplay)
		FamilyteamplayModel.instance:setEndBattleInfo(msg)
	elseif ViewMgr.instance:isOpen(ViewName.FamilytpmainView) then
		UIStateManager.instance:clear(true)
	end
end

function FamilyteamplayController:_NotifyJoinLeaveFamilyRes(status, msg)
	if status ~= 0 or msg.reason == 0 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.FamilytpmainView) or ViewMgr.instance:isOpen(ViewName.FamilytpbossgroupView) then
		UIStateManager.instance:clear(true)
	end

	if SceneMgr.instance.isGogingToEnterBattleScene and BattleModel.instance.familyTeamPlayType then
		UIJumper.instance:clear(true)
	end
end

FamilyteamplayController.instance = FamilyteamplayController.New()

return FamilyteamplayController
