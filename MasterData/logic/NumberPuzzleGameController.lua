-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/controller/NumberPuzzleGameController.lua

module("logic.extensions.numberpuzzlegame.controller.NumberPuzzleGameController", package.seeall)

local NumberPuzzleGameController = class("NumberPuzzleGameController", BaseController)

function NumberPuzzleGameController:ctor()
	return
end

function NumberPuzzleGameController:onInit()
	GlobalDispatcher:addListener("gotostartnumberpuzzlegameofnor", self.gotoStartNumberPuzzleGameOfNor, self)
	GlobalDispatcher:addListener("gotostartnumberpuzzlegameofext", self.gotoStartNumberPuzzleGameOfExt, self)
	GlobalDispatcher:addListener("gotostartnumberpuzzlegameofsup", self.gotoStartNumberPuzzleGameOfSup, self)
	self:onReset()
end

function NumberPuzzleGameController:onReset()
	local activityId = self:getActivityId()

	self:updateSupperFirstRed(activityId)
end

function NumberPuzzleGameController:updateSupperFirstRed(activityId)
	local redId = RedPointModel.ID_NUMBERPUZZLEGAMEFIRSTREDINSUPER

	RedPointController.instance:setRedPointInfo(redId, false)

	if activityId > 0 then
		local cfg = NumberPuzzleGameConfig.instance:getNpgSupStageCfg(activityId)

		if cfg then
			local key = "npgfirstsuper_" .. activityId
			local isNotFirst = GameUtil.getUserData(key, function(value)
				if checknumber(value) == 0 then
					RedPointController.instance:setRedPointInfo(redId, true)
				end
			end)
		end
	end
end

function NumberPuzzleGameController:sendPM_2048InfoReq(activityId)
	Game2048Agent.instance:sendPM_2048InfoReq(activityId)
end

function NumberPuzzleGameController:handlePM_2048InfoRes(msg)
	NumberPuzzleGameModel.instance:handlePM_2048InfoRes(msg)
	self:_updateNumberPuzzleGameOfNorRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_2048InfoRes)
end

function NumberPuzzleGameController:sendPM_2048StartGameReq(activityId, mode, stageId)
	local clientKey = math.random(1, 100000)

	NumberPuzzleGameModel.instance:setClientKey(clientKey)
	Game2048Agent.instance:sendPM_2048StartGameReq(activityId, mode, stageId, clientKey)
end

function NumberPuzzleGameController:handlePM_2048StartGameRes(status, msg)
	if status == 0 then
		NumberPuzzleGameModel.instance:handlePM_2048StartGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_2048StartGameRes, status, msg)
end

function NumberPuzzleGameController:sendPM_2048EndGameReq(activityId, mode, stageId, isPass, score, maxGridId, extremeUsedEnergy)
	local clientKey = NumberPuzzleGameModel.instance:getClientKey()
	local serverKey = NumberPuzzleGameModel.instance:getServerKey()
	local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, {
		score,
		isPass and 1 or 0
	})

	Game2048Agent.instance:sendPM_2048EndGameReq(activityId, mode, stageId, isPass, score, encryptedKey, maxGridId, extremeUsedEnergy)
end

function NumberPuzzleGameController:handlePM_2048EndGameRes(msg)
	NumberPuzzleGameModel.instance:handlePM_2048EndGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_2048EndGameRes, msg)
end

function NumberPuzzleGameController:sendPM_2048EndRankReq(activityId)
	Game2048Agent.instance:sendPM_2048EndRankReq(activityId)
end

function NumberPuzzleGameController:handlePM_2048EndRankRes(msg)
	NumberPuzzleGameModel.instance:handlePM_2048EndRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_2048EndRankRes)
end

function NumberPuzzleGameController:sendPM_2048OpenHangingEfficiencyReq(activityId, gridId)
	Game2048Agent.instance:sendPM_2048OpenHangingEfficiencyReq(activityId, gridId)
end

function NumberPuzzleGameController:handlePM_2048OpenHangingEfficiencyRes(msg)
	NumberPuzzleGameModel.instance:handlePM_2048OpenHangingEfficiencyRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_2048OpenHangingEfficiencyRes)
end

function NumberPuzzleGameController:sendPM_2048ExtremeGainPrizeReq(activityId)
	Game2048Agent.instance:sendPM_2048ExtremeGainPrizeReq(activityId)
end

function NumberPuzzleGameController:handlePM_2048ExtremeGainPrizeRes(msg)
	NumberPuzzleGameModel.instance:handlePM_2048ExtremeGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_2048ExtremeGainPrizeRes)
end

function NumberPuzzleGameController:sendPM_2048ExtremeRankReq(activityId)
	Game2048Agent.instance:sendPM_2048ExtremeRankReq(activityId)
end

function NumberPuzzleGameController:handlePM_2048ExtremeRankRes(msg)
	NumberPuzzleGameModel.instance:handlePM_2048ExtremeRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_2048ExtremeRankRes)
end

function NumberPuzzleGameController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function NumberPuzzleGameController:getActivityType()
	return GameEnum.ActivityType.NumberPuzzle
end

function NumberPuzzleGameController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function NumberPuzzleGameController:_updateNumberPuzzleGameOfNorRed(activityId)
	activityId = checknumber(activityId)

	local isNeedRed = false

	if self:isInActivityTime(activityId) then
		local curMaxPassStage = self:getCurMaxPassStage()
		local maxStage = self:getMaxStageIdOfNor(activityId)
		local result, tips = self:getTryStartNorStageResultAndTips(activityId, Mathf.Min(curMaxPassStage + 1, maxStage))

		if result == GameEnum.ResultCode.Success then
			isNeedRed = true
		end
	end

	local redId = RedPointModel.ID_NumberPuzzleGame_Nor

	RedPointController.instance:setRedPointInfo(redId, isNeedRed)
end

function NumberPuzzleGameController:gotoStartNumberPuzzleGameOfNor(params)
	local activityId = checknumber(params[1])
	local stageId = checknumber(params[2])
	local result, tips = NumberPuzzleGameController.instance:getTryStartNorStageResultAndTips(activityId, stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self:startNumberPuzzleGameOfNor(activityId)
end

function NumberPuzzleGameController:startNumberPuzzleGameOfNor(activityId, stageId)
	self._gameParamsOfNor = {}
	self._gameParamsOfNor[1] = activityId
	self._gameParamsOfNor[2] = stageId

	GlobalDispatcher:addListener(GlobalNotify.handlePM_2048StartGameRes, self._handleStartNumberPuzzleGameOfNor, self)
	NumberPuzzleGameController.instance:sendPM_2048StartGameReq(activityId, NPGEnum.GameMode_Nor, stageId)
end

function NumberPuzzleGameController:_handleStartNumberPuzzleGameOfNor(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_2048StartGameRes, self._handleStartNumberPuzzleGameOfNor, self)

	if self._gameParamsOfNor == nil or status ~= 0 then
		return
	end

	local activityId = self._gameParamsOfNor[1]
	local stageId = self._gameParamsOfNor[2]

	self._gameParamsOfNor = nil

	local data = NumberPuzzleGameConfig.instance:getNpgNorStageData(activityId, stageId)

	if data == nil then
		printError(string.format("配置缺失( g2048小游戏 .xlsx | export_闯关模式关卡 | activityId=%s, stageId=%s )", activityId, stageId))

		return
	end

	local actData = NumberPuzzleGameConfig.instance:getNpgActData(activityId)

	if actData == nil then
		printError(string.format("配置缺失, activityId = %s", activityId))

		return
	end

	local npgViewParam = NPGViewParam.New()

	npgViewParam:setActivityId(activityId)
	npgViewParam:setGameMode(NPGEnum.GameMode_Nor)
	npgViewParam:setMapId(data.mapId)
	npgViewParam:setMaxTotalScoreLimit(actData.rankMaxScore)
	npgViewParam:setGameEndCallBack(function(result, gameCtrl)
		if result == NPGEnum.ResultCode_GameOverOfSuccess then
			local score = gameCtrl._detailMo:getTotalScore()
			local maxGridId = gameCtrl._detailMo:getMaxGbId()
			local useEnergy = 0

			NumberPuzzleGameController.instance:sendPM_2048EndGameReq(activityId, NPGEnum.GameMode_Nor, stageId, true, score, maxGridId, useEnergy)

			local tipsContent = "游戏胜利"

			local function okFunc()
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
			end

			local alignment = UnityEngine.TextAnchor.MiddleCenter

			TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", alignment)
		elseif result == NPGEnum.ResultCode_GameOverOfFail then
			local score = gameCtrl._detailMo:getTotalScore()
			local maxGridId = gameCtrl._detailMo:getMaxGbId()
			local useEnergy = 0

			NumberPuzzleGameController.instance:sendPM_2048EndGameReq(activityId, NPGEnum.GameMode_Nor, stageId, false, score, maxGridId, useEnergy)

			local tipsContent = "游戏失败"

			local function okFunc()
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
			end

			local alignment = UnityEngine.TextAnchor.MiddleCenter

			TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", alignment)
		elseif result == NPGEnum.ResultCode_GameOverOfDropOut then
			local score = gameCtrl._detailMo:getTotalScore()
			local maxGridId = gameCtrl._detailMo:getMaxGbId()
			local useEnergy = 0

			NumberPuzzleGameController.instance:sendPM_2048EndGameReq(activityId, NPGEnum.GameMode_Nor, stageId, false, score, maxGridId, useEnergy)

			local tipsContent = "退出进度将得到短暂保留，是否退出？"

			local function okFunc()
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
			end

			local function cencelFunc()
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameCancelCloseView)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
		elseif result == NPGEnum.ResultCode_GameOverFailAndReset then
			GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameResetGame)
		else
			GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
		end
	end)
	self:startNumberPuzzleGame(npgViewParam)
end

function NumberPuzzleGameController:gotoStartNumberPuzzleGameOfExt(params)
	local activityId = checknumber(params[1])
	local result, tips = NumberPuzzleGameController.instance:getTryStartExtStageResultAndTips(activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self:startNumberPuzzleGameOfExt(activityId)
end

function NumberPuzzleGameController:startNumberPuzzleGameOfExt(activityId)
	local stageId = -1

	self._gameParamsOfExt = {}
	self._gameParamsOfExt[1] = activityId
	self._gameParamsOfExt[2] = stageId

	GlobalDispatcher:addListener(GlobalNotify.handlePM_2048StartGameRes, self._handleStartNumberPuzzleGameOfExt, self)
	NumberPuzzleGameController.instance:sendPM_2048StartGameReq(activityId, NPGEnum.GameMode_Ext, stageId)
end

function NumberPuzzleGameController:_handleStartNumberPuzzleGameOfExt(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_2048StartGameRes, self._handleStartNumberPuzzleGameOfExt, self)

	if self._gameParamsOfExt == nil then
		return
	end

	local activityId = self._gameParamsOfExt[1]
	local stageId = self._gameParamsOfExt[2]

	self._gameParamsOfExt = nil

	local data = NumberPuzzleGameConfig.instance:getNpgExtStageData(activityId)

	if data == nil then
		printError(string.format("配置缺失( g2048小游戏 .xlsx | export_挑战模式关卡 | activityId=%s )", activityId))

		return
	end

	local actData = NumberPuzzleGameConfig.instance:getNpgActData(activityId)

	if actData == nil then
		printError(string.format("配置缺失, activityId = %s", activityId))

		return
	end

	local npgViewParam = NPGViewParam.New()

	npgViewParam:setActivityId(activityId)
	npgViewParam:setGameMode(NPGEnum.GameMode_Ext)
	npgViewParam:setMapId(data.mapId)
	npgViewParam:setMaxTotalScoreLimit(actData.rankMaxScore)
	npgViewParam:setGameEndCallBack(function(result, gameCtrl)
		if result == NPGEnum.ResultCode_GameOverOfSuccess or result == NPGEnum.ResultCode_GameOverOfFail then
			local score = gameCtrl._detailMo:getTotalScore()
			local maxGridId = gameCtrl._detailMo:getMaxGbId()
			local useEnergy = 0

			NumberPuzzleGameController.instance:sendPM_2048EndGameReq(activityId, NPGEnum.GameMode_Ext, stageId, true, score, maxGridId, useEnergy)

			local tipsContent = string.format("恭喜您，本次挑战获得%s分", score)

			local function okFunc()
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
			end

			local alignment = UnityEngine.TextAnchor.MiddleCenter

			TipsFacade.instance:openTipWindowNoX("游戏结束", tipsContent, okFunc, "确定", alignment)
		elseif result == NPGEnum.ResultCode_GameOverOfDropOut then
			local tipsContent = "退出进度将得到短暂保留，是否退出？"

			local function okFunc()
				local score = gameCtrl._detailMo:getTotalScore()
				local maxGridId = gameCtrl._detailMo:getMaxGbId()
				local useEnergy = 0

				NumberPuzzleGameController.instance:sendPM_2048EndGameReq(activityId, NPGEnum.GameMode_Ext, stageId, false, score, maxGridId, useEnergy)
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
			end

			local function cencelFunc()
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameCancelCloseView)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
		elseif result == NPGEnum.ResultCode_GameOverFailAndReset then
			local score = gameCtrl._detailMo:getTotalScore()
			local maxGridId = gameCtrl._detailMo:getMaxGbId()
			local useEnergy = 0
			local tipsContent = string.format("恭喜您，本次挑战获得%s分", score)

			local function okFunc()
				NumberPuzzleGameController.instance:sendPM_2048EndGameReq(activityId, NPGEnum.GameMode_Ext, stageId, true, score, maxGridId, useEnergy)
				GlobalDispatcher:addListener(GlobalNotify.handlePM_2048EndGameRes, self._handleGameOverFailAndResetEndGameRes, self)
			end

			local alignment = UnityEngine.TextAnchor.MiddleCenter

			TipsFacade.instance:openTipWindowNoX("游戏结束", tipsContent, okFunc, "确定", alignment)
		else
			GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
		end
	end)
	self:startNumberPuzzleGame(npgViewParam)
end

function NumberPuzzleGameController:_handleGameOverFailAndResetEndGameRes(msg)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_2048EndGameRes, self._handleGameOverFailAndResetEndGameRes, self)
	GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameResetGame)
	self:startNumberPuzzleGameOfExt(msg.activityId)
end

function NumberPuzzleGameController:gotoStartNumberPuzzleGameOfSup(params)
	local activityId = checknumber(params[1])

	self:startNumberPuzzleGameOfSup(activityId)
end

function NumberPuzzleGameController:startNumberPuzzleGameOfSup(activityId)
	local result, tips = self:getTryStartSupResultAndTips(activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local stageId = -1

	self._gameParamsOfSup = {}
	self._gameParamsOfSup[1] = activityId
	self._gameParamsOfSup[2] = stageId

	GlobalDispatcher:addListener(GlobalNotify.handlePM_2048StartGameRes, self._handleStartNumberPuzzleGameOfSup, self)
	NumberPuzzleGameController.instance:sendPM_2048StartGameReq(activityId, NPGEnum.GameMode_Sup, stageId)
end

function NumberPuzzleGameController:_handleStartNumberPuzzleGameOfSup(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_2048StartGameRes, self._handleStartNumberPuzzleGameOfSup, self)

	if self._gameParamsOfSup == nil then
		return
	end

	local activityId = self._gameParamsOfSup[1]
	local stageId = self._gameParamsOfSup[2]

	self._gameParamsOfSup = nil

	local oldUseEnergy = NumberPuzzleGameModel.instance:getExtremeUsedEnergy()
	local leftEnergy = self:getLeftEnergy(activityId)
	local oldMaxGbId = NumberPuzzleGameModel.instance:getExtremeMaxGridId()
	local oldMapData = NumberPuzzleGameConfig.instance:getNpgSupStageData(activityId, oldMaxGbId)

	if oldMapData == nil then
		printError(string.format("配置缺失( g2048小游戏 .xlsx | export_极限模式关卡 | activityId:%s, maxGbId:%s )", activityId, oldMaxGbId))

		return
	end

	local actData = NumberPuzzleGameConfig.instance:getNpgActData(activityId)

	if actData == nil then
		printError(string.format("配置缺失, activityId = %s", activityId))

		return
	end

	local npgViewParam = NPGViewParam.New()

	npgViewParam:setActivityId(activityId)
	npgViewParam:setGameMode(NPGEnum.GameMode_Sup)
	npgViewParam:setMapId(oldMapData.mapId)
	npgViewParam:setMaxTotalScoreLimit(actData.rankMaxScore)
	npgViewParam:setStartUpEnergy(leftEnergy)
	npgViewParam:setGameEndCallBack(function(result, gameCtrl)
		if result == NPGEnum.ResultCode_GameOverOfSuccess then
			local score = gameCtrl._detailMo:getTotalScore()
			local newMaxGbId = gameCtrl._detailMo:getMaxGbId()
			local max = NumberPuzzleGameConfig.instance:getNpgExtremeEnergy(activityId)
			local left = gameCtrl._detailMo:getLeftEnergy()
			local oldCur = NumberPuzzleGameModel.instance:getExtremeUsedEnergy()
			local useEnergy = Mathf.Max(max - left, 0)

			useEnergy = Mathf.Max(useEnergy, oldCur)

			NumberPuzzleGameController.instance:sendPM_2048EndGameReq(activityId, NPGEnum.GameMode_Sup, stageId, true, score, newMaxGbId, useEnergy)

			local newGbData = NumberPuzzleGameConfig.instance:getNpgGridLibDataById(newMaxGbId)
			local oldGbData = NumberPuzzleGameConfig.instance:getNpgGridLibDataById(oldMaxGbId)

			if newGbData then
				if not newGbData.name then
					local newGbName = "无"

					if oldGbData then
						if not oldGbData.name then
							local oldGbName = "无"
							local tipsContent = string.format("恭喜您，成功刷新记录，已提升挂机速度！\n本局游戏最大宝珠：%s\n个人历史最大宝珠：%s", newGbName, oldGbName)

							local function okFunc()
								GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
								NumberPuzzleGameController.instance:startNumberPuzzleGameOfSup(activityId)
							end

							local maxGbId = NumberPuzzleGameConfig.instance:getNpgMaxGbId(activityId)

							if oldMaxGbId ~= maxGbId then
								UIStateManager.instance:push(ViewName.NumberPuzzleGameSuperBuffView, activityId)
							end

							if maxGbId < newMaxGbId + 1 then
								TipsFacade.instance:openTipWindowNoX("游戏结束", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
							else
								local function cencelFunc()
									GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
								end

								TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "下一关", "退出")
							end
						end
					end
				end
			end
		elseif result == NPGEnum.ResultCode_GameOverOfFail then
			local tipsContent = "体力耗尽\n未能刷新本局最大宝珠记录，本局体力、道具消耗和游戏结果均不保留"

			local function okFunc()
				local score = gameCtrl._detailMo:getTotalScore()

				NumberPuzzleGameController.instance:sendPM_2048EndGameReq(activityId, NPGEnum.GameMode_Sup, stageId, false, score, oldMaxGbId, oldUseEnergy)
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
			end

			local function cencelFunc()
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameResetGame)
			end

			TipsFacade.instance:openPopupWindow("游戏结束", tipsContent, okFunc, cencelFunc, "退出", "重开")
		elseif result == NPGEnum.ResultCode_GameOverOfDropOut then
			local tipsContent = "退出后，体力、道具消耗和本局游戏结果仅为临时保留，是否退出？"

			local function okFunc()
				local score = gameCtrl._detailMo:getTotalScore()

				NumberPuzzleGameController.instance:sendPM_2048EndGameReq(activityId, NPGEnum.GameMode_Sup, stageId, false, score, oldMaxGbId, oldUseEnergy)
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
			end

			local function cencelFunc()
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameCancelCloseView)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
		elseif result == NPGEnum.ResultCode_GameOverFailAndReset then
			local score = gameCtrl._detailMo:getTotalScore()
			local maxGridId = gameCtrl._detailMo:getMaxGbId()
			local tipsContent = "重置后，体力、道具消耗和本局游戏结果均不保留噢，是否确认？"

			local function okFunc()
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameResetGame)
			end

			local function cencelFunc()
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameCancelCloseView)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
		else
			GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
		end
	end)
	self:startNumberPuzzleGame(npgViewParam)
end

function NumberPuzzleGameController:gotoStartNumberPuzzleGameOfTourArenaGame(mapId, finishCallBack)
	local mapData = NumberPuzzleGameConfig.instance:getNpgMapData(mapId)

	if mapData == nil then
		printError(string.format("缺失地图配置( g2048小游戏 .xlsx | export_地图库 | mapId=%s )", mapId))

		return
	end

	if finishCallBack == nil then
		printError(string.format("缺失传入完成回调，请联系开发检查( g2048小游戏 .xlsx | mapId=%s )", mapId))

		return
	end

	local npgViewParam = NPGViewParam.New()

	npgViewParam:setActivityId(0)
	npgViewParam:setGameMode(NPGEnum.GameMode_Nor)
	npgViewParam:setMapId(mapId)
	npgViewParam:setMaxTotalScoreLimit(800000)
	npgViewParam:setGameEndCallBack(function(result, gameCtrl)
		local score = gameCtrl._detailMo:getTotalScore()
		local info = {}

		info.isPass = false
		info.gameScore = 0

		if result == NPGEnum.ResultCode_GameOverOfSuccess then
			info.isPass = true
			info.gameScore = score

			local tipsContent = string.format("恭喜您，本次游戏完成！")

			local function okFunc()
				GameUtil.callBack(finishCallBack, info)
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
			end

			local alignment = UnityEngine.TextAnchor.MiddleCenter

			TipsFacade.instance:openTipWindowNoX("游戏结束", tipsContent, okFunc, "确定", alignment)
		elseif result == NPGEnum.ResultCode_GameOverOfFail then
			info.isPass = false
			info.gameScore = 0

			local tipsContent = string.format("条件没有达成，本次游戏失败")

			local function okFunc()
				GameUtil.callBack(finishCallBack, info)
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
			end

			local alignment = UnityEngine.TextAnchor.MiddleCenter

			TipsFacade.instance:openTipWindowNoX("游戏结束", tipsContent, okFunc, "确定", alignment)
		elseif result == NPGEnum.ResultCode_GameOverOfDropOut then
			local tipsContent = "退出进度将得到短暂保留，是否退出？"

			local function okFunc()
				info.isPass = false

				GameUtil.callBack(finishCallBack, info)
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
			end

			local function cencelFunc()
				GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameCancelCloseView)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
		elseif result == NPGEnum.ResultCode_GameOverFailAndReset then
			TipsFacade.instance:openTipWindowNoX("提示", "游戏已重置", nil, "确定", UnityEngine.TextAnchor.MiddleCenter)
			GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameResetGame)
		else
			GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameSureCloseView)
		end
	end)
	self:startNumberPuzzleGame(npgViewParam)
end

function NumberPuzzleGameController:startNumberPuzzleGame(npgViewParam)
	UIStateManager.instance:push(ViewName.NumberPuzzleGameSceneView, npgViewParam)
end

function NumberPuzzleGameController:getTryStartNorStageResultAndTips(activityId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif self:isPassOfNorStage(stageId) then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	elseif not self:isInTimeOfNorStage(activityId, stageId) then
		result = GameEnum.ResultCode.ErrorTime
		tips = "不在开放时间内"
	elseif not self:isPassPreOfNorStage(stageId) then
		result = GameEnum.ResultCode.NotPassLast
		tips = "前面关卡未通关"
	end

	return result, tips
end

function NumberPuzzleGameController:isPassOfNorStage(stageId)
	local passedStageId = self:getCurMaxPassStage()

	return stageId <= passedStageId
end

function NumberPuzzleGameController:isPassPreOfNorStage(stageId)
	local isPass = true

	for i = stageId - 1, 0, -1 do
		if not self:isPassOfNorStage(i) then
			isPass = false

			break
		end
	end

	return isPass
end

function NumberPuzzleGameController:isInTimeOfNorStage(activityId, stageId)
	local data = NumberPuzzleGameConfig.instance:getNpgNorStageData(activityId, stageId)

	return GameUtil.getTimePeriod(data.openDateTime, nil) == GameUtil.inTimePeriod
end

function NumberPuzzleGameController:isHasGainPrizeOfNorStage(stageId)
	return self:isPassOfNorStage(stageId)
end

function NumberPuzzleGameController:getCurMaxPassStage()
	return NumberPuzzleGameModel.instance:getPassedStageIdOfNor()
end

function NumberPuzzleGameController:getMaxStageIdOfNor(activityId)
	local cfg = NumberPuzzleGameConfig.instance:getNpgNorStageCfg(activityId)
	local data = cfg and cfg[#cfg]

	return (data or nil) and (data.stageId or 0)
end

function NumberPuzzleGameController:getTryStartExtStageResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	return result, tips
end

function NumberPuzzleGameController:getTryStartSupResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local left = self:getLeftEnergy(activityId)

		if left <= 0 then
			result = GameEnum.ResultCode.Error
			tips = "体力不足"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local maxGbId = NumberPuzzleGameModel.instance:getExtremeMaxGridId()
		local max = NumberPuzzleGameConfig.instance:getNpgMaxGbId(activityId)

		if max <= maxGbId then
			result = GameEnum.ResultCode.Error
			tips = "您已通关"
		end
	end

	return result, tips
end

function NumberPuzzleGameController:getLeftEnergy(activityId)
	local cur = NumberPuzzleGameModel.instance:getExtremeUsedEnergy()
	local max = NumberPuzzleGameConfig.instance:getNpgExtremeEnergy(activityId)

	return Mathf.Max(max - cur, 0)
end

function NumberPuzzleGameController:isCanUnlock(gbId)
	return self:isEnoughUnlock(gbId) and not self:isHasUnlock(gbId)
end

function NumberPuzzleGameController:isEnoughUnlock(gbId)
	local maxGbId = NumberPuzzleGameModel.instance:getExtremeMaxGridId()

	return gbId <= maxGbId
end

function NumberPuzzleGameController:isHasUnlock(gbId)
	local cur = NumberPuzzleGameModel.instance:getExtremeHangingEfficiency()
	local gbData = NumberPuzzleGameConfig.instance:getNpgGridLibDataById(gbId)
	local target = gbData.hangingEfficiency

	return target <= cur
end

function NumberPuzzleGameController:isEmptyGridById(gridId)
	return gridId == 0
end

NumberPuzzleGameController.instance = NumberPuzzleGameController.New()

return NumberPuzzleGameController
