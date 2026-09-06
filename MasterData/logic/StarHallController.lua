-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starhall/controller/StarHallController.lua

module("logic.extensions.starhall.controller.StarHallController", package.seeall)

local StarHallController = class("StarHallController", BaseController)

function StarHallController:onInit()
	self:onReset()
end

function StarHallController:onReset()
	self._fmtMoMap = {}
	self.ciList = nil
end

function StarHallController:openMissionview(activityId, stageId)
	local fmtMo = self._fmtMoMap[activityId]

	if not fmtMo then
		fmtMo = StarHallFmtMo.New()
		self._fmtMoMap[activityId] = fmtMo
	end

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function StarHallController:getInfo(activityId)
	StarHallAgent.instance:sendPM_StarHallInfoReq(activityId)
end

function StarHallController:handleGetInfo(msg)
	StarHallModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.StarHallGetInfo)
end

function StarHallController:startChallenge(activityId, stageId, difficultId, settlementId, number, form_pb)
	StarHallAgent.instance:sendPM_StarHallChallengeReq(activityId, stageId, difficultId, settlementId, number, form_pb)
end

function StarHallController:resetStage(activityId, stageId)
	StarHallAgent.instance:sendPM_StarHallResetReq(activityId, stageId)
end

function StarHallController:handleResetStage(msg)
	StarHallModel.instance:onResetStage(msg)
	GlobalDispatcher:dispatch(GlobalNotify.StarHallResetStage)
end

function StarHallController:getRankInfo(activityId)
	StarHallAgent.instance:sendPM_StarHallRankInfoReq(activityId)
end

function StarHallController:handleGetRankInfo(msg)
	StarHallModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.StarHallGetRankInfo)
end

function StarHallController:handleNorifyFinishChallenge(msg)
	self.ciList = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(self.ciList)

	local info = GameUtil.pbToTable(msg)

	if info.isWin then
		StarHallModel.instance:onNotifyClgFinish(msg)

		local activityId = checknumber(info.activityId)
		local stageId = checknumber(info.stageId)
		local number = checknumber(info.number)
		local difficultId = checknumber(info.difficultId)
		local isBest = checknumber(info.bestTotalScore) > 0
		local curTotalScore = 0
		local stageCfg = StarHallConfig.instance:getStageCfgByStageId(activityId, stageId)
		local diffCfg = StarHallConfig.instance:getStageDifficultyCfgsByDiffId(activityId, stageId, difficultId)

		if diffCfg then
			if not diffCfg.score then
				local diffScore = 0

				if number ~= -1 then
					if not stageCfg.numberScore then
						local addScore = 0

						curTotalScore = diffScore + addScore

						local resultTxt = string.format("当前关卡积分：%s", diffScore + addScore)

						if isBest then
							resultTxt = string.format("当前关卡积分：%s", curTotalScore)
							resultTxt = resultTxt .. "\n新记录"
						end

						BattleFacade.instance:registerResultHandler(nil, nil)
						BattleFacade.instance:registerResultHandler(function()
							TipsFacade.instance:openTipWindow("战斗结束", resultTxt, function()
								BattleController.instance:endBattle()
							end, "确定", UnityEngine.TextAnchor.MiddleCenter)

							return true
						end)
					end
				end
			end
		end
	end
end

function StarHallController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

StarHallController.instance = StarHallController.New()

return StarHallController
