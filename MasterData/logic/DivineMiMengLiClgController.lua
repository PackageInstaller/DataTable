-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/controller/DivineMiMengLiClgController.lua

module("logic.extensions.divinemimengliclg.controller.DivineMiMengLiClgController", package.seeall)

local DivineMiMengLiClgController = class("DivineMiMengLiClgController", BaseController)

function DivineMiMengLiClgController:onInit()
	GlobalDispatcher:addListener("enterdivinemimengliclg", self._enterDivineMiMengLiClg, self)
end

function DivineMiMengLiClgController:onReset()
	return
end

function DivineMiMengLiClgController:sendPM_DivineMiMengLiClgGetInfoReq(activityId)
	DivineMiMengLiClgAgent.instance:sendPM_DivineMiMengLiClgGetInfoReq(activityId)
end

function DivineMiMengLiClgController:handlePM_DivineMiMengLiClgGetInfoRes(msg)
	local mo = self:getDivineMmlClgMo(msg.activityId)

	mo:handlePM_DivineMiMengLiClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineMiMengLiClgGetInfoRes)
end

function DivineMiMengLiClgController:sendPM_DivineMiMengLiClgFightReq(activityId, stageId, teamId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local mo = self:getDivineMmlClgMo(activityId)
		local msg = mo:getFightMsg()

		if msg and msg.isWin then
			local isLastTeam = false
			local teamCfg = DivineMiMengLiClgConfig.instance:getTeamCfg(activityId, stageId)

			if teamCfg then
				local maxTeamData = teamCfg and teamCfg[#teamCfg]

				if maxTeamData then
					if not maxTeamData.teamId then
						local maxTeamId = 0
						local count = 0

						for _, data in ipairs(teamCfg) do
							if mo:isPassTeam(stageId, data.teamId) then
								count = count + 1
							end
						end

						isLastTeam = count == maxTeamId - 1
					end
				end
			end

			local stageType = DivineMiMengLiClgConfig.instance:getStageType(activityId, stageId)

			if stageType == DivineMmlClgEnum.StageType_One then
				-- block empty
			elseif stageType == DivineMmlClgEnum.StageType_Two then
				if not isLastTeam then
					UIStateManager.instance:push(ViewName.DivineMiMengLiClgStageResultView, activityId)

					result = true
				end
			elseif stageType == DivineMmlClgEnum.StageType_Three and not isLastTeam then
				UIStateManager.instance:push(ViewName.DivineMiMengLiClgStageResultView, activityId)

				result = true
			end
		end

		return result
	end)
	DivineMiMengLiClgAgent.instance:sendPM_DivineMiMengLiClgFightReq(activityId, stageId, teamId, form)
end

function DivineMiMengLiClgController:handlePM_DivineMiMengLiClgFightRes(msg)
	return
end

function DivineMiMengLiClgController:sendPM_DivineMiMengLiClgConfirmReq(activityId, stageId, teamId)
	DivineMiMengLiClgAgent.instance:sendPM_DivineMiMengLiClgConfirmReq(activityId, stageId, teamId)
end

function DivineMiMengLiClgController:handlePM_DivineMiMengLiClgConfirmRes(msg)
	local mo = self:getDivineMmlClgMo(msg.activityId)

	mo:handlePM_DivineMiMengLiClgConfirmRes(msg)

	if msg:HasField("changeSetId") then
		mo:saveChangeSetId(msg.changeSetId)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	if ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId) and mo:isPassChallenge() then
		AoqiGodController.instance:doHandleChallengeFinishReady(self:getActivityType(), msg.activityId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineMiMengLiClgConfirmRes)
end

function DivineMiMengLiClgController:sendPM_DivineMiMengLiClgResetReq(activityId, stageId)
	DivineMiMengLiClgAgent.instance:sendPM_DivineMiMengLiClgResetReq(activityId, stageId)
end

function DivineMiMengLiClgController:handlePM_DivineMiMengLiClgResetRes(msg)
	local mo = self:getDivineMmlClgMo(msg.activityId)

	mo:handlePM_DivineMiMengLiClgResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineMiMengLiClgResetRes)
end

function DivineMiMengLiClgController:handlePM_DivineMiMengLiNotifyFightRes(msg)
	local mo = self:getDivineMmlClgMo(msg.activityId)

	mo:handlePM_DivineMiMengLiNotifyFightRes(msg)

	if msg:HasField("changeSetId") then
		mo:saveChangeSetId(msg.changeSetId)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	if msg.isWin and ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId) and self:_isPassChallengeAfterFight(msg.activityId, msg.stageId, msg.teamId) then
		AoqiGodController.instance:doHandleChallengeFinishReady(self:getActivityType(), msg.activityId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineMiMengLiNotifyFightRes)
end

function DivineMiMengLiClgController:getActivityId()
	return 460001
end

function DivineMiMengLiClgController:getActivityType()
	return GameEnum.ActivityType.Divinemimengliclg
end

function DivineMiMengLiClgController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function DivineMiMengLiClgController:_enterDivineMiMengLiClg(params)
	params = params or {}

	self:enterDivineMiMengLiClg(checknumber(params[1]))
end

function DivineMiMengLiClgController:enterDivineMiMengLiClg(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show(lang("不在活动开启时间内"))

		return
	end

	UIStateManager.instance:push(ViewName.DivineMiMengLiClgMainView, activityId)
end

function DivineMiMengLiClgController:checkPassAoqiGodProcessResult(activityId)
	if not ActivityDefineController.instance:isAoqiGodProcessType(activityId) then
		return true
	end

	local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self:getActivityType(), activityId)

	return result == GameEnum.ResultCode.Success
end

function DivineMiMengLiClgController:getDivineMmlClgMo(activityId)
	return DivineMiMengLiClgModel.instance:getDivineMmlClgMo(activityId)
end

function DivineMiMengLiClgController:_isPassChallengeAfterFight(activityId, stageId, teamId)
	local mo = self:getDivineMmlClgMo(activityId)
	local stageCfg = DivineMiMengLiClgConfig.instance:getStageCfg(activityId) or {}

	for _, stageData in ipairs(stageCfg) do
		local teamCfg = DivineMiMengLiClgConfig.instance:getTeamCfg(activityId, stageData.stageId) or {}

		for _, teamData in ipairs(teamCfg) do
			local isCurTeam = stageData.stageId == stageId and teamData.teamId == teamId

			if not isCurTeam and not mo:isPassTeam(stageData.stageId, teamData.teamId) then
				return false
			end
		end
	end

	return true
end

function DivineMiMengLiClgController:enterBattle(activityId, stageId, teamId)
	local stageData = DivineMiMengLiClgConfig.instance:getStageData(activityId, stageId)
	local fmtMo = DivineMiMengLiClgModel.instance:getDivineMiMengLiClgFmtMo(activityId, stageData.type)

	fmtMo:updateCfg(activityId, stageId, teamId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

DivineMiMengLiClgController.instance = DivineMiMengLiClgController.New()

return DivineMiMengLiClgController
