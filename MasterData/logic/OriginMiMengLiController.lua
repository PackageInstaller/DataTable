-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmimengli/controller/OriginMiMengLiController.lua

module("logic.extensions.originmimengli.controller.OriginMiMengLiController", package.seeall)

local OriginMiMengLiController = class("OriginMiMengLiController", BaseController)

function OriginMiMengLiController:onInit()
	self:onReset()
end

function OriginMiMengLiController:onReset()
	self.ciList = nil
	self._curFmtMoMap = self._curFmtMoMap or {}

	table.clear(self._curFmtMoMap)
end

function OriginMiMengLiController:getInfo(activityId)
	OriginMiMengLiAgent.instance:sendPM_OriginMiMengLiInfoReq(activityId)
end

function OriginMiMengLiController:handlePM_OriginMiMengLiInfoRes(msg)
	OriginMiMengLiModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginMiMengLiInfoRes)
end

function OriginMiMengLiController:challenge(activityId, form_pb, stageId)
	BattleFacade.instance:registerResultHandler(function()
		return self:_onBattleEnd(activityId, stageId)
	end)
	OriginMiMengLiAgent.instance:sendPM_OriginMiMengLiClgReq(activityId, form_pb, stageId)
end

function OriginMiMengLiController:handlePM_OriginMiMengLiClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginMiMengLiClgRes)
end

function OriginMiMengLiController:handlePM_OriginMiMengLiNotifyClgRes(msg)
	OriginMiMengLiModel.instance:onNotifyClg(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginMiMengLiNotifyClgRes)

	self.ciList = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(self.ciList)
end

function OriginMiMengLiController:getDefaultActivityId()
	return 621001
end

function OriginMiMengLiController:showCI()
	if self.ciList ~= nil then
		MaterialController.instance:showChangeSetInTemp(self.ciList)

		self.ciList = nil
	end
end

function OriginMiMengLiController:showMissionView(activityId, stageId)
	local stageCfg = OriginMiMengLiConfig.instance:getSingleStageCfgById(activityId, stageId)

	if not stageCfg then
		printError("源起弥梦离挑战配置缺失，activityId: %d, stageId: %d", activityId, stageId)

		return
	end

	self._curFmtMoMap = self._curFmtMoMap or {}

	local fmtMo = self._curFmtMoMap[activityId]

	if not fmtMo then
		fmtMo = OriginMiMengLiFmtMo.New()
		self._curFmtMoMap[activityId] = fmtMo
	end

	fmtMo:initParams(activityId, stageCfg)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginMiMengLiController:_onBattleEnd(activityId, stageId)
	BattleFacade.instance:registerResultHandler(nil, nil)
	BattleSettlementController.instance:addDefaultConditions()

	local lastClgResult = OriginMiMengLiModel.instance:getLastClgResult(activityId)

	if lastClgResult then
		local stageCfg = OriginMiMengLiConfig.instance:getSingleStageCfgById(activityId, stageId)

		if stageCfg then
			if not stageCfg.passCount then
				local passNeedCount = 0
				local isPass = lastClgResult.isPass
				local dreamBuffCount = checknumber(lastClgResult.dreamBuffCount)
				local memoryBuffCount = checknumber(lastClgResult.memoryBuffCount)
				local isPassDreamCount = passNeedCount <= dreamBuffCount

				if isPassDreamCount then
					if not GameEnum.ColorConst.Green then
						local addDreamTipsColor = GameEnum.ColorConst.Red
						local dreamDesc = langPara("梦境超杀次数≥%s(<color=%s>%s</color>/%s)", passNeedCount, addDreamTipsColor, dreamBuffCount, passNeedCount)

						BattleSettlementController.instance:addConditionElement(dreamDesc, isPassDreamCount)

						local isPassMemoryCount = passNeedCount <= memoryBuffCount

						if isPassMemoryCount then
							if not GameEnum.ColorConst.Green then
								local addMemoryTipsColor = GameEnum.ColorConst.Red
								local memoryDesc = langPara("记忆复活次数≥%s(<color=%s>%s</color>/%s)", passNeedCount, addMemoryTipsColor, memoryBuffCount, passNeedCount)

								BattleSettlementController.instance:addConditionElement(memoryDesc, isPassMemoryCount)

								local isEqualPass = dreamBuffCount == memoryBuffCount

								if isEqualPass then
									if not GameEnum.ColorConst.Green then
										local colorStr = GameEnum.ColorConst.Red
										local equalDesc = langPara("梦境超杀次数(<color={0}>{1}</color>){2}记忆复活次数(<color={3}>{4}</color>)", colorStr, dreamBuffCount, "=", colorStr, memoryBuffCount)

										BattleSettlementController.instance:addConditionElement(equalDesc, isEqualPass)

										if isPass then
											UIStateManager.instance:push(ViewName.BattleSettlementSuccess)
										else
											BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.Default, {
												isShowTeam = true,
												isHideRecommend = true
											})
											UIStateManager.instance:push(ViewName.BattleSettlementFail)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	else
		UIStateManager.instance:push(ViewName.BattleSettlementFailSimple)
	end

	return true
end

OriginMiMengLiController.instance = OriginMiMengLiController.New()

return OriginMiMengLiController
