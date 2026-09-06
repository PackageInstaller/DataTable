-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongyanclg/controller/OriginLongYanClgController.lua

module("logic.extensions.originlongyanclg.controller.OriginLongYanClgController", package.seeall)

local OriginLongYanClgController = class("OriginLongYanClgController", BaseController)

function OriginLongYanClgController:onInit()
	self:onReset()
end

function OriginLongYanClgController:onReset()
	self.ciList = nil
	self._fmtMo = nil
end

function OriginLongYanClgController:showMissionView(activityId, stageId)
	self._fmtMo = self._fmtMo or OriginLongYanClgFmtMo.New()

	self._fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(self._fmtMo)
end

function OriginLongYanClgController:getInfo(activityId)
	OriginLongYanClgAgent.instance:sendPM_OriginLongYanClgGetInfoReq(activityId)
end

function OriginLongYanClgController:handlePM_OriginLongYanClgGetInfoRes(msg)
	OriginLongYanClgModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginLongYanClgGetInfoRes)
end

function OriginLongYanClgController:challenge(activityId, stageId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResBossBattleEnd, self, activityId, stageId))
	OriginLongYanClgAgent.instance:sendPM_OriginLongYanClgChallengeReq(activityId, stageId, form_pb)
end

function OriginLongYanClgController:handleNotifyChallenge(msg)
	OriginLongYanClgModel.instance:handleNotifyChallenge(msg)

	if msg.isWin then
		self.ciList = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self.ciList)
	end
end

function OriginLongYanClgController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function OriginLongYanClgController:_onResBossBattleEnd(activityId, stageId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local lastFightInfo = OriginLongYanClgModel.instance:getLastFightInfo()

	if lastFightInfo then
		if lastFightInfo.win then
			BattleSettlementController.instance:addDefaultConditions()

			local stageCfg = OriginLongYanClgConfig.instance:getStageCfgById(activityId, stageId)

			if stageCfg then
				if not stageCfg.passSignId then
					local signId = 0
					local signCfg = OriginLongYanClgConfig.instance:getSignCfgById(activityId, signId)

					if not lastFightInfo.stagePass then
						if not lastFightInfo.signProgress then
							local signProgress = 0

							if not lastFightInfo.signId then
								BattleSettlementController.instance:addConditionElement(string.format("本关需要注入%s意志(触发要求印记数:%s/%s)", signCfg.signName or "未知", signProgress, signCfg.needLayoutNum or 10), lastFightInfo.stagePass)

								if lastFightInfo.stagePass then
									UIStateManager.instance:open(ViewName.BattleSettlementSuccess)
								else
									UIStateManager.instance:open(ViewName.BattleSettlementFail)
								end
							end
						end
					end
				end
			end
		else
			UIStateManager.instance:open(ViewName.BattleSettlementFailSimple)
		end
	else
		printError("源起龙炎挑战结算数据异常，打开默认失败界面")
		UIStateManager.instance:open(ViewName.BattleSettlementFailSimple)
	end

	return true
end

function OriginLongYanClgController:setExBuffParam(param)
	self._exBuffParam = param
end

function OriginLongYanClgController:getExBuffParam()
	return self._exBuffParam
end

OriginLongYanClgController.instance = OriginLongYanClgController.New()

return OriginLongYanClgController
