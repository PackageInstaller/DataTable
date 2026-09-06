-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/controller/FanRuiChallengeController.lua

module("logic.extensions.fanruichallenge.controller.FanRuiChallengeController", package.seeall)

local FanRuiChallengeController = class("FanRuiChallengeController", BaseController)

function FanRuiChallengeController:ctor()
	return
end

function FanRuiChallengeController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.FanRuiNotifyThemeLifeFightResultRes, self._onLifeFightResultRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FanRuiNotifyThemeDestinyFightResultRes, self._onDestinyFightResultRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FanRuiNotifyThemeControlFightResultRes, self._onControlFightResultRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FanRuiControlClosePosView, self._onCloseBuffView, self)
end

function FanRuiChallengeController:onReset()
	self._lifeViewName = nil
	self._destinyViewName = nil
	self._controlViewName = nil
end

function FanRuiChallengeController:_onLifeFightResultRes()
	if FanRuiChallengeModel.instance._fightResPb then
		local activityId = FanRuiChallengeModel.instance._fightResPb.activityId

		FanRuiChallengeModel.instance._fightResPb = nil

		if FanRuiChallengeModel.instance:isPassBigLevel(activityId, FanRuiChallengeModel.StageLife) and self._lifeViewName then
			UIJumper.instance:removeTopState(self._lifeViewName)

			self._lifeViewName = nil
		end
	end
end

function FanRuiChallengeController:_onDestinyFightResultRes(isWin, activityId, oldDestinyProgress)
	if FanRuiChallengeModel.instance._fightResPb then
		local activityId = FanRuiChallengeModel.instance._fightResPb.activityId

		FanRuiChallengeModel.instance._fightResPb = nil

		if FanRuiChallengeModel.instance:isPassBigLevel(activityId, FanRuiChallengeModel.StageDestiny) and self._destinyViewName then
			UIJumper.instance:removeTopState(self._destinyViewName)

			self._destinyViewName = nil
		end

		if BattleModel.instance:isSelfRealWin() then
			local cfgStages = FanRuiChallengeConfig.instance:getDestinyClgStageCfgList(activityId)
			local maxNum = #cfgStages
			local curStageIndex = Mathf.Clamp(oldDestinyProgress + 1, 1, maxNum)
			local cfgStage = FanRuiChallengeConfig.instance:getDestinyClgStageCfg(activityId, curStageIndex)

			if cfgStage then
				local list = FanRuiChallengeModel.instance:getProjectedRes(activityId) or {}
				local params = {}
				local choiceId1, choiceId2, choiceId3 = self:getForecastChoices(activityId)
				local choiceIds = {
					choiceId1,
					choiceId2,
					choiceId3
				}

				for i, v in ipairs(list) do
					local preTxt = FanRuiChallengeConfig.instance:getCommonValue("FANRUI_DESC" .. v.type) or ""
					local cfg = FanRuiChallengeConfig.instance:getProjectedPlanCfg(cfgStage.planId, v.type, choiceIds[v.type] or 1)

					if cfg then
						local txt = FanRuiChallengeController.instance:getRangeStr(cfg.valueRange)
						local element = {}
						local colorStr = v.isRight and "99FFB0" or "EC6941"

						element.txtDesc = string.format(preTxt .. ":<color=#%s>(%d / " .. txt .. ")</color>", colorStr, v.value)
						element.isReach = not not v.isRight

						table.insert(params, element)
					end
				end

				BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.FanRuiChallenge, params)
			end
		end
	end
end

function FanRuiChallengeController:_onControlFightResultRes()
	if FanRuiChallengeModel.instance._fightResPb then
		local activityId = FanRuiChallengeModel.instance._fightResPb.activityId

		FanRuiChallengeModel.instance._fightResPb = nil

		if FanRuiChallengeModel.instance:isPassBigLevel(activityId, FanRuiChallengeModel.StageControl) and self._controlViewName then
			UIJumper.instance:removeTopState(self._controlViewName)

			self._controlViewName = nil
		end
	end
end

function FanRuiChallengeController:_onCloseBuffView()
	return
end

function FanRuiChallengeController:openLifeMissionView(activityId, stageId, lifeViewName)
	self._lifeViewName = lifeViewName

	local customFmtMo = FanRuiChallengeModel.instance:getLifeCustomFmtMo()

	customFmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function FanRuiChallengeController:openDestinyMissionView(activityId, stageId, choiceIds, destinyViewName)
	self._destinyViewName = destinyViewName

	local customFmtMo = FanRuiChallengeModel.instance:getDestinyCustomFmtMo()

	customFmtMo:initParams(activityId, stageId, choiceIds)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function FanRuiChallengeController:openControlMissionView(activityId, stageId, childStageId, controlViewName, posView)
	self._controlViewName = controlViewName

	local customFmtMo = FanRuiChallengeModel.instance:getControlCustomFmtMo()

	customFmtMo:initParams(activityId, stageId, childStageId, posView)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function FanRuiChallengeController:getRangeStr(valueRange)
	if valueRange and #valueRange > 0 then
		local str = ""
		local count = #valueRange

		for i, v in ipairs(valueRange) do
			if v[1] and v[2] then
				str = v[1] == v[2] and str .. v[1] or str .. v[1] .. "-" .. v[2]

				if i ~= count then
					str = str .. "或"
				end
			end
		end

		return str
	else
		return ""
	end
end

function FanRuiChallengeController:getForecastChoices(activityId)
	local str = GameUtil.getUserData(ViewName.FanRuiChallengeBuffView .. activityId)

	if not string.nilorempty(str) then
		local list = string.split(str, "_")
		local choiceId1 = checknumber(list[1])
		local choiceId2 = checknumber(list[2])
		local choiceId3 = checknumber(list[3])

		return choiceId1, choiceId2, choiceId3
	else
		return 0, 0, 0
	end
end

function FanRuiChallengeController:saveForecastChoices(activityId, choiceId1, choiceId2, choiceId3)
	local choices = {
		choiceId1,
		choiceId2,
		choiceId3
	}
	local str = table.concat(choices, "_")

	GameUtil.saveUserData(ViewName.FanRuiChallengeBuffView .. activityId, str)
end

FanRuiChallengeController.instance = FanRuiChallengeController.New()

return FanRuiChallengeController
