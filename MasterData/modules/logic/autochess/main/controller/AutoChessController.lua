-- chunkname: @modules/logic/autochess/main/controller/AutoChessController.lua

module("modules.logic.autochess.main.controller.AutoChessController", package.seeall)

local AutoChessController = class("AutoChessController", BaseController)

function AutoChessController:onInit()
	self:reInit()
end

function AutoChessController:reInit()
	self.cachePopupViewList = {}
end

function AutoChessController:addConstEvents()
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.StartFight, self.onStartFight, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.SkipFight, self.recordSkipFight, self)
end

function AutoChessController:enterMainView(actId)
	Activity182Rpc.instance:sendGetAct182InfoRequest(actId, self._enterReply, self)
end

function AutoChessController:_enterReply(_, resultCode)
	if resultCode == 0 then
		self:openMainView()
	end
end

function AutoChessController:openMainView()
	ViewMgr.instance:openView(ViewName.AutoChessMainView)
end

function AutoChessController:openBeginView()
	ViewMgr.instance:openView(ViewName.AutoChessBeginView)
end

function AutoChessController:openGameView()
	ViewMgr.instance:openView(ViewName.AutoChessGameView)
end

function AutoChessController:openMallView(param)
	ViewMgr.instance:openView(ViewName.AutoChessMallView, param)

	self.startBuyTime = ServerTime.now()
end

function AutoChessController:openResultView()
	ViewMgr.instance:openView(ViewName.AutoChessResultView)
end

function AutoChessController:openCardInfoView(param)
	ViewMgr.instance:openView(ViewName.AutoChessMallInfoView, param)
end

function AutoChessController:openLeaderNextView(param)
	ViewMgr.instance:openView(ViewName.AutoChessLeaderNextView, param)
end

function AutoChessController:openFriendBattleView(param)
	ViewMgr.instance:openView(ViewName.AutoChessFriendBattleView, param)
end

function AutoChessController:openFriendBattleRecordView()
	ViewMgr.instance:openView(ViewName.AutoChessFriendBattleRecordView)
end

function AutoChessController:openFriendListView(param)
	ViewMgr.instance:openView(ViewName.AutoChessFriendListView, param)
end

function AutoChessController:openAutoChessHandbookPreviewView(param)
	ViewMgr.instance:openView(ViewName.AutoChessHandbookPreviewView, param)
end

function AutoChessController:startGame(actId, moduleId, episodeCo)
	local episodeId = episodeCo.id
	local actMo = Activity182Model.instance:getActMo()
	local gameMo = actMo:getGameMo(actId, moduleId)

	if moduleId == AutoChessEnum.ModuleId.PVE then
		if gameMo.episodeId == episodeId then
			AutoChessRpc.instance:sendAutoChessEnterSceneRequest(actId, moduleId, episodeId, gameMo.selectMasterId)
		else
			self.tempEpisodeId = episodeId

			if gameMo.episodeId == 0 then
				self:startPveGame(0, 0)
			else
				GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessChangeEpisode, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self._yesCallback, nil, nil, self)
			end
		end
	elseif moduleId == AutoChessEnum.ModuleId.PVP2 then
		if gameMo.episodeId == 0 then
			local param = {
				actId = actId,
				moduleId = AutoChessEnum.ModuleId.PVP2,
				episodeId = episodeCo.id,
				leaderId = episodeCo.masterId
			}

			self:openLeaderNextView(param)
		else
			AutoChessRpc.instance:sendAutoChessEnterSceneRequest(actId, moduleId, episodeId, gameMo.selectMasterId)
		end
	elseif gameMo.episodeId == 0 then
		if gameMo.bossId == 0 then
			Activity182Rpc.instance:sendAct182RefreshBossRequest(actId, self.openBeginView, self)
		else
			self:openBeginView()
		end
	else
		AutoChessRpc.instance:sendAutoChessEnterSceneRequest(actId, moduleId, episodeId, gameMo.selectMasterId)
	end
end

function AutoChessController:_yesCallback()
	AutoChessRpc.instance:sendAutoChessGiveUpRequest(AutoChessEnum.ModuleId.PVE, self.startPveGame, self)
end

function AutoChessController:startPveGame(cmd, resultCode)
	if resultCode == 0 then
		local param = {
			moduleId = AutoChessEnum.ModuleId.PVE,
			episodeId = self.tempEpisodeId,
			leaderId = AutoChessConfig.instance:getEpisodeCO(self.tempEpisodeId).masterId
		}

		self:openLeaderNextView(param)
	end

	self.tempEpisodeId = nil
end

function AutoChessController:enterGame(episodeId, firstEnter)
	AutoChessModel.instance:setEpisodeId(episodeId)
	self:openGameView()
	self:openMallView({
		firstEnter = firstEnter
	})

	self.startGameTime = ServerTime.now()
end

function AutoChessController:exitGame()
	self:statExitGame()
	AutoChessModel.instance:clearData()
	ViewMgr.instance:closeView(ViewName.AutoChessMallView)
	ViewMgr.instance:closeView(ViewName.AutoChessGameView)
	AutoChessGameModel.instance:setUsingLeaderSkill(false)

	local actId = Activity182Model.instance:getCurActId()

	Activity182Rpc.instance:sendGetAct182InfoRequest(actId)
end

function AutoChessController:enterSingleGame()
	self:openGameView()

	self.startGameTime = ServerTime.now()
end

function AutoChessController:onResultViewClose()
	AutoChessModel.instance.resultData = nil

	local moduleId = AutoChessModel.instance.moduleId

	if moduleId == AutoChessEnum.ModuleId.Friend then
		self:exitGame()

		return
	end

	local settleData = AutoChessModel.instance.settleData

	if settleData then
		if settleData.moduleId == AutoChessEnum.ModuleId.PVE then
			if settleData.isFirstPass then
				ViewMgr.instance:openView(ViewName.AutoChessPveFirstSettleView)
			else
				ViewMgr.instance:openView(ViewName.AutoChessPveSettleView)
			end
		elseif settleData.moduleId == AutoChessEnum.ModuleId.PVP then
			ViewMgr.instance:openView(ViewName.AutoChessPvpSettleView)
		elseif settleData.moduleId == AutoChessEnum.ModuleId.PVP2 then
			ViewMgr.instance:openView(ViewName.AutoChessCrazySettleView)
		end
	else
		self:openMallView()
		self:dispatchEvent(AutoChessEvent.NextRound)
	end
end

function AutoChessController:onSettleViewClose()
	AutoChessModel.instance.settleData = nil

	if ViewMgr.instance:isOpen(ViewName.AutoChessGameView) then
		self:exitGame()
	end
end

function AutoChessController:checkPopView()
	local actMo = Activity182Model.instance:getActMo()

	if actMo.warnLevelUp then
		ViewMgr.instance:openView(ViewName.AutoChessWarnUpView)
	elseif actMo.rankUp then
		ViewMgr.instance:openView(ViewName.AutoChessRankUpView)
	end
end

function AutoChessController:isClickDisable(operation)
	return not self:isOperationEnable(operation)
end

function AutoChessController:isDragDisable(operation, param, paramType)
	return not self:isOperationEnable(operation, param, paramType)
end

function AutoChessController:isRowIndexEnable(index)
	local value = tonumber(GuideModel.instance:getFlagValue(GuideModel.instance.GuideFlag.AutoChessSetPlaceIndex))

	if value == nil or value == 0 then
		return true
	end

	local result = value == index

	if result == false then
		if GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessToast) then
			local toastParam = GuideModel.instance:getFlagValue(GuideModel.instance.GuideFlag.AutoChessToast)
			local toastId = tonumber(toastParam)

			if toastParam ~= nil and toastId ~= nil then
				GameFacade.showToast(toastId)
			else
				logError("自走棋引导没有配置限定操作飘字id 弹出保底飘字")
				self:showGuideToast()
			end
		else
			logError("自走棋引导没有配置限定操作飘字id 弹出保底飘字")
			self:showGuideToast()
		end
	end

	return result
end

function AutoChessController:isOperationEnable(operation, param, paramType)
	local isEnable = not GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessBanAllOper)

	if operation == nil then
		logNormal(string.format("当前是否允许操作：%s", isEnable))
	else
		local operationEnable = GuideModel.instance:isFlagEnable(operation)

		if param ~= nil then
			param = tostring(param)

			local value = tostring(GuideModel.instance:getFlagValue(operation))

			operationEnable = operationEnable and value ~= nil and value == param

			logNormal(string.format("当前 操作id:%s 参数：%s 是否允许操作：%s", operation, param, operationEnable))
		else
			logNormal(string.format("当前 操作id: %s 是否允许操作：%s", operation, operationEnable))
		end

		isEnable = isEnable or operationEnable
	end

	if isEnable == false then
		if GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessToast) then
			local toastParam = GuideModel.instance:getFlagValue(GuideModel.instance.GuideFlag.AutoChessToast)
			local toastId = tonumber(toastParam)

			if toastParam ~= nil and toastId ~= nil then
				GameFacade.showToast(toastId)
			else
				logError("自走棋引导没有配置限定操作飘字id 弹出保底飘字")
				self:showGuideToast()
			end
		else
			self:showGuideToast()
		end
	end

	return isEnable
end

function AutoChessController:showGuideToast()
	if GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessEnableDragFreeChess) then
		GameFacade.showToast(ToastEnum.AutoChessDragFree)
	elseif GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessEnableExchangeEXP) then
		GameFacade.showToast(ToastEnum.AutoChessExchangeExp)
	elseif GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessEnableSale) then
		GameFacade.showToast(ToastEnum.AutoChessExchangeExp)
	else
		logError("未指定任何操作")
	end
end

function AutoChessController:isEnableSale()
	local isStepFinish = GuideModel.instance:isStepFinish(25405, 13) or GuideModel.instance:isGuideFinish(25406)

	if not isStepFinish then
		local canSale = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.AutoChessEnableSale)

		if canSale then
			return true
		end
	else
		return true
	end

	GameFacade.showToast(ToastEnum.AutoChessSaleLock)

	return false
end

function AutoChessController:isEnableRefresh()
	if not GuideModel.instance:isStepFinish(25409, 3) then
		GameFacade.showToast(ToastEnum.AutoChessRefreshLock)

		return false
	end

	return true
end

function AutoChessController:setGuideEventFlag(type)
	self._curRpcType = type
end

function AutoChessController:checkGuideEventFlag()
	if self._curRpcType and self._curRpcType == AutoChessEnum.BuildType.Sell then
		self:dispatchEvent(AutoChessEvent.ZSaleChess)
	end
end

function AutoChessController:onStartFight()
	if self.startBuyTime then
		local chessMo = AutoChessModel.instance:getChessMo()
		local useTime = ServerTime.now() - self.startBuyTime

		StatController.instance:track(StatEnum.EventName.AutoChessFightStart, {
			[StatEnum.EventProperties.EpisodeId] = tostring(AutoChessModel.instance.episodeId),
			[StatEnum.EventProperties.RoundNum] = chessMo.sceneRound,
			[StatEnum.EventProperties.OurRemainingHP] = tonumber(chessMo.svrFight.mySideMaster.hp),
			[StatEnum.EventProperties.UseTime] = useTime,
			[StatEnum.EventProperties.ActivityId] = tostring(AutoChessModel.instance.actId)
		})
	end

	self.startFightTime = ServerTime.now()
end

function AutoChessController:recordSkipFight()
	self.skipFight = true
end

function AutoChessController:statExitGame()
	local chessMo = AutoChessModel.instance:getChessMo()
	local useTime = ServerTime.now() - self.startGameTime

	StatController.instance:track(StatEnum.EventName.AutoChessSceneExit, {
		[StatEnum.EventProperties.EpisodeId] = tostring(AutoChessModel.instance.episodeId),
		[StatEnum.EventProperties.RoundNum] = chessMo.sceneRound,
		[StatEnum.EventProperties.OurRemainingHP] = tonumber(chessMo.svrFight.mySideMaster.hp),
		[StatEnum.EventProperties.UseTime] = useTime,
		[StatEnum.EventProperties.ActivityId] = tostring(AutoChessModel.instance.actId)
	})
end

function AutoChessController:statFightEnd(leaderHp)
	local chessMo = AutoChessModel.instance:getChessMo()
	local useTime = ServerTime.now() - self.startFightTime

	StatController.instance:track(StatEnum.EventName.AutoChessFightEnd, {
		[StatEnum.EventProperties.EpisodeId] = tostring(AutoChessModel.instance.episodeId),
		[StatEnum.EventProperties.RoundNum] = chessMo.sceneRound,
		[StatEnum.EventProperties.OurRemainingHP] = leaderHp,
		[StatEnum.EventProperties.SkipFight] = self.skipFight,
		[StatEnum.EventProperties.UseTime] = useTime,
		[StatEnum.EventProperties.ActivityId] = tostring(AutoChessModel.instance.actId)
	})

	self.skipFight = nil
end

function AutoChessController:statButtonClick(viewName, buttonName)
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = tostring(viewName),
		[StatEnum.EventProperties.ButtonName] = tostring(buttonName)
	})
end

function AutoChessController:addPopupView(viewName, param)
	table.insert(self.cachePopupViewList, 1, {
		viewName = viewName,
		param = param
	})
end

function AutoChessController:popupRewardView()
	for _, cacheTbl in ipairs(self.cachePopupViewList) do
		if cacheTbl.viewName == ViewName.CommonPropView then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, cacheTbl.viewName, cacheTbl.param)
		else
			PopupController.instance:addPopupView(PopupEnum.PriorityType.GainSkinView, cacheTbl.viewName, cacheTbl.param)
		end
	end

	tabletool.clear(self.cachePopupViewList)
end

AutoChessController.instance = AutoChessController.New()

return AutoChessController
