-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/controller/DestroyEvilController.lua

module("logic.extensions.destroyevil.controller.DestroyEvilController", package.seeall)

local DestroyEvilController = class("DestroyEvilController", BaseController)

function DestroyEvilController:onInit()
	MsgFlowMgr.instance:registerCustomHandledErrCode(-1902)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilChallengeRes, self._onNotifyChallengeRes, self)
end

function DestroyEvilController:_onNotifyChallengeRes()
	UIJumper.instance:pushOneStack(ViewName.DestroyEvilMainView, true)

	local tempBattleInfo = DestroyEvilModel.instance:GetBattleBossInfo()

	if tempBattleInfo then
		if checknumber(tempBattleInfo.targetPlayerId) == checknumber(RoleModel.instance:getUserId()) then
			UIJumper.instance:pushOneStack(ViewName.DestroyEvilMyView, true, DestroyEvilModel.instance:getActivityId())
		else
			UIJumper.instance:pushOneStack(ViewName.DestroyEvilHelpView, true, DestroyEvilModel.instance:getActivityId())
		end
	else
		UIJumper.instance:removeTopState(ViewName.DestroyEvilHelpView)
	end

	self:_handleBattleResult()
end

function DestroyEvilController:onCostAutoChange()
	GlobalDispatcher:dispatch(GlobalNotify.DestroyEvilCostChange)
end

function DestroyEvilController:openMyMissionView(activityId, targetPlayerId, monsterId, monsterUniqueId, strongChallenge, isNoPaid)
	local customFmtMo = DestroyEvilModel.instance:getFmtMo()

	customFmtMo:initParams(activityId, targetPlayerId, monsterId, monsterUniqueId, strongChallenge, isNoPaid)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DestroyEvilController:_handleBattleResult()
	local battleResult = DestroyEvilModel.instance:getBattleResult()

	BattleFacade.instance:startDestroyEvilFight()
	BattleController.instance:viewUserFightMonsterBtlResult(battleResult, false)
end

function DestroyEvilController:openBattleResultView()
	UIStateManager.instance:push(ViewName.DestroyEvilBattleResultView)
end

function DestroyEvilController:getMonsterName(activityId, monsterId)
	local cfgMonster = DestroyEvilConfig.instance:getMonsterCfg(activityId, monsterId)

	if cfgMonster then
		local cfgMaster = DestroyEvilConfig.instance:getMaster(cfgMonster.creepsMasterId)

		if cfgMaster then
			return cfgMaster.name
		end
	end
end

function DestroyEvilController:getFirstPetCfgByCreeps(activityId, monsterId)
	local cfgMonster = DestroyEvilConfig.instance:getMonsterCfg(activityId, monsterId)

	if cfgMonster then
		local cfgCreeps = DestroyEvilConfig.instance:getCreeps(cfgMonster.creepsMasterId)
		local targetPosId = cfgCreeps[1].posId
		local cfgTarget = cfgCreeps[1]

		for i, v in ipairs(cfgCreeps) do
			if targetPosId > v.posId then
				targetPosId = v.posId
				cfgTarget = v
			end
		end

		return cfgTarget
	end
end

function DestroyEvilController:getLeftTodayHelpTimes(activityId)
	local cfg = DestroyEvilConfig.instance:getActivityCfg(activityId)
	local maxNum = cfg.fixHelpTimes
	local curNum = DestroyEvilModel.instance:getTodayHelpTimes()

	return (Mathf.Max(maxNum - curNum, 0))
end

function DestroyEvilController:getLeftTodayNoPaidHelpTimes(activityId)
	local cfg = DestroyEvilConfig.instance:getActivityCfg(activityId)
	local maxNum = cfg.noPaidHelpTimes
	local curNum = DestroyEvilModel.instance:getTodayNoPaidHelpTimes()

	return (Mathf.Max(maxNum - curNum, 0))
end

function DestroyEvilController:getSelectTicketId(activityId)
	local key = DestroyEvilModel.SelectTicketIdKey .. activityId

	return (checknumber(GameUtil.getUserData(key)))
end

function DestroyEvilController:saveSelectTicketId(activityId, ticketId)
	local key = DestroyEvilModel.SelectTicketIdKey .. activityId

	GameUtil.saveUserData(key, ticketId)
end

function DestroyEvilController:getAutoCostTicket(activityId)
	local key = DestroyEvilModel.OpenAutoCostTicketKey .. activityId

	return (GameUtil.getUserData(key))
end

function DestroyEvilController:saveAutoCostTicket(activityId, isToggle)
	local key = DestroyEvilModel.OpenAutoCostTicketKey .. activityId

	GameUtil.saveUserData(key, isToggle)
end

function DestroyEvilController:isExistTicket(activityId, ticketId)
	local cfg = DestroyEvilConfig.instance:getTicket(activityId, ticketId)

	if cfg and not string.nilorempty(cfg.itemKey) then
		local count = MaterialMgr.getMatCount(cfg.itemKey)

		return count > 0
	else
		return false
	end
end

DestroyEvilController.instance = DestroyEvilController.New()

return DestroyEvilController
