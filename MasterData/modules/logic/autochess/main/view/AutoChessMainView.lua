-- chunkname: @modules/logic/autochess/main/view/AutoChessMainView.lua

module("modules.logic.autochess.main.view.AutoChessMainView", package.seeall)

local AutoChessMainView = class("AutoChessMainView", BaseView)

function AutoChessMainView:onInitView()
	self._goSpine = gohelper.findChild(self.viewGO, "simage_fullbg/#go_Spine")
	self._txtLeftTime = gohelper.findChildText(self.viewGO, "#txt_LeftTime")
	self._btnFriend = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Friend")
	self._btnCultivate = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Cultivate")
	self._goWarningContent = gohelper.findChild(self.viewGO, "#btn_Cultivate/#go_WarningContent")
	self._btnPVP = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_PVP")
	self._goRoundP = gohelper.findChild(self.viewGO, "#btn_PVP/#go_RoundP")
	self._txtRoundP = gohelper.findChildText(self.viewGO, "#btn_PVP/#go_RoundP/#txt_RoundP")
	self._btnGiveUpP = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_PVP/#btn_GiveUpP")
	self._btnMyCardpack = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_MyCardpack")
	self._goBadgeContent = gohelper.findChild(self.viewGO, "#go_BadgeContent")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Achievement")
	self._btnCourse = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Course")
	self._goTip = gohelper.findChild(self.viewGO, "#go_Tip")
	self._txtTip = gohelper.findChildText(self.viewGO, "#go_Tip/#txt_Tip")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessMainView:addEvents()
	self._btnFriend:AddClickListener(self._btnFriendOnClick, self)
	self._btnCultivate:AddClickListener(self._btnCultivateOnClick, self)
	self._btnPVP:AddClickListener(self._btnPVPOnClick, self)
	self._btnGiveUpP:AddClickListener(self._btnGiveUpPOnClick, self)
	self._btnMyCardpack:AddClickListener(self._btnMyCardpackOnClick, self)
	self._btnAchievement:AddClickListener(self._btnAchievementOnClick, self)
	self._btnCourse:AddClickListener(self._btnCourseOnClick, self)
end

function AutoChessMainView:removeEvents()
	self._btnFriend:RemoveClickListener()
	self._btnCultivate:RemoveClickListener()
	self._btnPVP:RemoveClickListener()
	self._btnGiveUpP:RemoveClickListener()
	self._btnMyCardpack:RemoveClickListener()
	self._btnAchievement:RemoveClickListener()
	self._btnCourse:RemoveClickListener()
end

function AutoChessMainView:_btnCultivateOnClick()
	AutoChessController.instance:statButtonClick(self.viewName, "_btnCultivateOnClick")
	ViewMgr.instance:openView(ViewName.AutoChessCultivateView)
end

function AutoChessMainView:_btnMyCardpackOnClick()
	AutoChessController.instance:statButtonClick(self.viewName, "_btnMyCardpackOnClick")
	ViewMgr.instance:openView(ViewName.AutoChessCardpackView, AutoChessCardpackView.OpenType.Own)
end

function AutoChessMainView:_btnFriendOnClick()
	AutoChessController.instance:statButtonClick(self.viewName, "_btnFriendOnClick")
	Activity182Rpc.instance:sendAct182GetHasSnapshotFriendRequest(self.actId, self._getHasSnapshotReply, self)
end

function AutoChessMainView:_getHasSnapshotReply(_, resultCode)
	if resultCode == 0 then
		AutoChessController.instance:openFriendBattleView()
		self:closeThis()
	end
end

function AutoChessMainView:_btnGiveUpPOnClick()
	local moduleId = AutoChessEnum.ModuleId.PVP
	local rankCfg = lua_auto_chess_rank.configDict[self.actId][self.actMo.rank]
	local roundScores = string.splitToNumber(rankCfg.round2Score, "|")
	local gameMo = self.actMo:getGameMo(self.actId, moduleId)

	if gameMo.currRound ~= 0 then
		if not gameMo.currRound then
			local curRound = gameMo.currRound + 1
			local scoreChange = roundScores[curRound]

			if scoreChange < 0 and rankCfg.protection then
				local laseCfg = lua_auto_chess_rank.configDict[self.actId][self.actMo.rank - 1]

				if laseCfg then
					if not laseCfg.score then
						local protectionScore = 0
						local maxSubScore = protectionScore - self.actMo.score

						scoreChange = maxSubScore < scoreChange and scoreChange or maxSubScore
					end
				end
			end

			if scoreChange == 0 then
				GameFacade.showMessageBox(MessageBoxIdDefine.AutoChessGiveUpTip2, MsgBoxEnum.BoxType.Yes_No, function()
					AutoChessRpc.instance:sendAutoChessGiveUpRequest(moduleId)
				end)
			else
				local scoreStr

				if scoreChange < 0 then
					scoreStr = string.format("<color=#9f342c>%s</color>", scoreChange)
				else
					local limitRank = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.DoubleScoreRank].value)

					if limitRank >= self.actMo.rank and self.actMo.doubleScoreTimes > 0 then
						scoreChange = scoreChange * 2
					end

					scoreStr = string.format("<color=#27682e>+%s</color>", scoreChange)
				end

				GameFacade.showMessageBox(MessageBoxIdDefine.AutoChessGiveUpTip1, MsgBoxEnum.BoxType.Yes_No, function()
					AutoChessRpc.instance:sendAutoChessGiveUpRequest(moduleId)
				end, nil, nil, nil, nil, nil, scoreStr)
			end
		end
	end
end

function AutoChessMainView:_btnCourseOnClick()
	AutoChessController.instance:statButtonClick(self.viewName, "_btnCourseOnClick")
	ViewMgr.instance:openView(ViewName.AutoChessCourseView)
end

function AutoChessMainView:_btnAchievementOnClick()
	AutoChessController.instance:statButtonClick(self.viewName, "_btnAchievementOnClick")

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)
	local jumpId = actCo.achievementJumpId

	JumpController.instance:jump(jumpId)
end

function AutoChessMainView:_btnPVPOnClick()
	AutoChessController.instance:statButtonClick(self.viewName, "_btnPVPOnClick")

	if not self.actMo:isEpisodeUnlock(self.pvpEpisodeCo.id) then
		local preEpisodeId = self.pvpEpisodeCo.preEpisode
		local preEpisodeCo = AutoChessConfig.instance:getEpisodeCO(preEpisodeId)

		GameFacade.showToast(ToastEnum.AutoChessPvpLock, preEpisodeCo.name)

		return
	end

	local moduleId = AutoChessEnum.ModuleId.PVP

	AutoChessController.instance:startGame(self.actId, moduleId, self.pvpEpisodeCo)
end

function AutoChessMainView:_editableInitView()
	self.actId = Activity182Model.instance:getCurActId()
	self.actMo = Activity182Model.instance:getActMo()
	self.pvpEpisodeCo = AutoChessConfig.instance:getPvpEpisodeCo(self.actId)

	local goReddot = gohelper.findChild(self._btnCultivate.gameObject, "go_reddot")

	self.cultivateReddot = RedDotController.instance:addNotEventRedDot(goReddot, self._checkCultivateReddot, self)

	local go = self:getResInst(AutoChessStrEnum.ResPath.WarningItem, self._goWarningContent)
	local warningItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessWarningItem)

	warningItem:refresh(true)
end

function AutoChessMainView:onRefreshBossReply()
	self:refreshBtnStatus()
end

function AutoChessMainView:onSettlPush()
	if not ViewMgr.instance:isOpen(ViewName.AutoChessGameView) then
		local settleData = AutoChessModel.instance.settleData

		if settleData then
			local moduleId = settleData.moduleId

			if moduleId == AutoChessEnum.ModuleId.PVP then
				if settleData.episodeId == 0 then
					self.badgeItem:playProgressAnim(settleData.score)

					AutoChessModel.instance.settleData = nil
				else
					ViewMgr.instance:openView(ViewName.AutoChessPvpSettleView)
				end
			elseif moduleId == AutoChessEnum.ModuleId.PVP2 then
				ViewMgr.instance:openView(ViewName.AutoChessCrazySettleView)
			else
				AutoChessModel.instance.settleData = nil
			end
		end
	end
end

function AutoChessMainView:onOpen()
	self.addEventCb(self, Activity182Controller.instance, Activity182Event.UpdateInfo, self.refreshUI, self)
	self.addEventCb(self, Activity182Controller.instance, Activity182Event.RefreshBossReply, self.onRefreshBossReply, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.SettlePush, self.onSettlPush, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.updateCultivateReddot, self.onUpdateCultivateReddot, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.onUpdateReddot, self)
	self:refreshUI()
end

function AutoChessMainView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshLeftTime, self)
end

function AutoChessMainView:refreshUI()
	local isUnlock = self.actMo:isEpisodeUnlock(self.pvpEpisodeCo.id)

	ZProj.UGUIHelper.SetGrayscale(self._btnPVP.gameObject, not isUnlock)
	self:refreshLeftTime()
	TaskDispatcher.runRepeat(self.refreshLeftTime, self, TimeUtil.OneMinuteSecond)

	if not self.badgeItem then
		local badgeGo = self:getResInst(AutoChessStrEnum.ResPath.BadgeItem, self._goBadgeContent)

		self.badgeItem = MonoHelper.addNoUpdateLuaComOnceToGo(badgeGo, AutoChessBadgeItem)
	end

	self.badgeItem:setData(self.actMo.rank, self.actMo.score, AutoChessBadgeItem.ShowType.MainView)
	self:refreshBtnStatus()
	self:refreshDoubleRankTip()
end

function AutoChessMainView:refreshBtnStatus()
	local gameMo = self.actMo:getGameMo(self.actId, AutoChessEnum.ModuleId.PVP)
	local episodeId = gameMo.episodeId

	gohelper.setActive(self._btnGiveUpP, gameMo.start)

	if episodeId ~= 0 then
		local maxRound = self.actMo:getMaxRound(episodeId)

		self._txtRoundP.text = string.format("%d/%d", gameMo.currRound, maxRound)

		gohelper.setActive(self._goRoundP, true)
	else
		gohelper.setActive(self._goRoundP, false)
	end
end

function AutoChessMainView:refreshLeftTime()
	self._txtLeftTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function AutoChessMainView:refreshDoubleRankTip()
	local limitRank = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.DoubleScoreRank].value)
	local rankName = lua_auto_chess_rank.configDict[self.actId][limitRank].name
	local doubleCnt = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.DoubleScoreCnt].value)

	if limitRank >= self.actMo.rank then
		local txt = luaLang("autochess_mainview_tips1")
		local allCnt = string.format("（%d/%d）", self.actMo.doubleScoreTimes, doubleCnt)

		self._txtTip.text = GameUtil.getSubPlaceholderLuaLangThreeParam(txt, rankName, doubleCnt, allCnt)

		gohelper.setActive(self._goTip, true)
	else
		gohelper.setActive(self._goTip, false)
	end
end

function AutoChessMainView:onUpdateCultivateReddot()
	self.cultivateReddot:refreshRedDot()
end

function AutoChessMainView:onUpdateReddot(idList)
	if idList[RedDotEnum.DotNode.V2a5_AutoChess] then
		self.cultivateReddot:refreshRedDot()
	end
end

function AutoChessMainView:_checkCultivateReddot()
	local isShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a5_AutoChess, 0)

	if isShow then
		return true
	end

	local collectionCfgs = AutoChessConfig.instance:getSpecialCollectionCfgs()
	local key = AutoChessStrEnum.ClientReddotKey.SpecialCollection

	for _, config in ipairs(collectionCfgs) do
		local unlockLvl = AutoChessConfig.instance:getCollectionUnlockLevel(config.id)

		if unlockLvl <= self.actMo.warnLevel and AutoChessHelper.getUnlockReddot(key, config.id) then
			return true
		end
	end

	local leaderCfgs = AutoChessConfig.instance:getSpecialLeaderCfgs()

	key = AutoChessStrEnum.ClientReddotKey.SpecialLeader

	for _, config in ipairs(leaderCfgs) do
		local unlockLvl = AutoChessConfig.instance:getLeaderUnlockLevel(config.id)

		if unlockLvl <= self.actMo.warnLevel and AutoChessHelper.getUnlockReddot(key, config.id) then
			return true
		end
	end

	key = AutoChessStrEnum.ClientReddotKey.Boss

	for _, config in ipairs(lua_auto_chess_boss.configList) do
		local unlockLvl = AutoChessConfig.instance:getBossUnlockLevel(config.id)

		if unlockLvl <= self.actMo.warnLevel and AutoChessHelper.getUnlockReddot(key, config.id) then
			return true
		end
	end

	key = AutoChessStrEnum.ClientReddotKey.Cardpack

	for _, config in pairs(lua_auto_chess_cardpack.configDict[self.actId]) do
		local unlockLvl = AutoChessConfig.instance:getCardpackUnlockLevel(config.id)

		if unlockLvl <= self.actMo.warnLevel and AutoChessHelper.getUnlockReddot(key, config.id) then
			return true
		end
	end
end

return AutoChessMainView
