-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/controller/DivineMiZongClgController.lua

module("logic.extensions.divinemizongclg.controller.DivineMiZongClgController", package.seeall)

local DivineMiZongClgController = class("DivineMiZongClgController", BaseController)

function DivineMiZongClgController:onInit()
	return
end

function DivineMiZongClgController:onReset()
	return
end

function DivineMiZongClgController:sendPM_DivineMiZongClgGetInfoReq(activityId)
	DivineMiZongClgAgent.instance:sendPM_DivineMiZongClgGetInfoReq(activityId)
end

function DivineMiZongClgController:handlePM_DivineMiZongClgGetInfoRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_DivineMiZongClgGetInfoRes(msg)
	self:_updateRedInBuffUpdate(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineMiZongClgGetInfoRes)
end

function DivineMiZongClgController:sendPM_DivineMiZongClgFightReq(activityId, stageId, form, specialPetId)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local mo = self:getClgMo(activityId)
		local msg = mo:getFightMsg()

		if msg then
			if msg:HasField("changeSetId") then
				MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
				BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
			end

			BattleSettlementController.instance:addDefaultConditions()

			local startPrizeCfg = DivineMiZongClgConfig.instance:getStartPrizeCfg(msg.activityId, msg.stageId) or {}

			for idx, data in ipairs(startPrizeCfg) do
				local isPass = idx <= msg.reachStar
				local arr = string.split(data.specialPetHpRate, "&")
				local target = checknumber(arr[2])

				if isPass then
					if not SettlementTarget.Colors.Sucess then
						local color = SettlementTarget.Colors.Fail
						local desc

						BattleSettlementController.instance:addConditionElement(target <= 0 and string.format("%s", data.gainStarDecs) or string.format("%s<color=#%s>（%d/%d）</color>", data.gainStarDecs, color, msg.specialPetHpRate * 100, target * 100), idx <= msg.reachStar)
					end
				end
			end
		end

		return result
	end)
	DivineMiZongClgAgent.instance:sendPM_DivineMiZongClgFightReq(activityId, stageId, form, specialPetId)
end

function DivineMiZongClgController:handlePM_DivineMiZongClgFightRes(msg)
	return
end

function DivineMiZongClgController:handlePM_DivineMiZongClgNotifyFightRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_DivineMiZongClgNotifyFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineMiZongClgNotifyFightRes)
end

function DivineMiZongClgController:sendPM_DivineMiZongClgGainBuffItemReq(activityId)
	DivineMiZongClgAgent.instance:sendPM_DivineMiZongClgGainBuffItemReq(activityId)
end

function DivineMiZongClgController:handlePM_DivineMiZongClgGainBuffItemRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_DivineMiZongClgGainBuffItemRes(msg)
	self:_updateRedInBuffUpdate(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineMiZongClgGainBuffItemRes)
end

function DivineMiZongClgController:sendPM_DivineMiZongClgUpgradeBuffReq(activityId, buffType)
	DivineMiZongClgAgent.instance:sendPM_DivineMiZongClgUpgradeBuffReq(activityId, buffType)
end

function DivineMiZongClgController:handlePM_DivineMiZongClgUpgradeBuffRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_DivineMiZongClgUpgradeBuffRes(msg)
	self:_updateRedInBuffUpdate(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineMiZongClgUpgradeBuffRes)
end

function DivineMiZongClgController:sendPM_DivineMiZongClgResetBuffReq(activityId)
	DivineMiZongClgAgent.instance:sendPM_DivineMiZongClgResetBuffReq(activityId)
end

function DivineMiZongClgController:handlePM_DivineMiZongClgResetBuffRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_DivineMiZongClgResetBuffRes(msg)
	self:_updateRedInBuffUpdate(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineMiZongClgResetBuffRes)
end

function DivineMiZongClgController:sendPM_DivineMiZongClgGainPrizeReq(activityId, prizeId)
	DivineMiZongClgAgent.instance:sendPM_DivineMiZongClgGainPrizeReq(activityId, prizeId)
end

function DivineMiZongClgController:handlePM_DivineMiZongClgGainPrizeRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_DivineMiZongClgGainPrizeRes(msg)
	self:_updateRedInBuffUpdate(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineMiZongClgGainPrizeRes)
end

function DivineMiZongClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DivineMiZongClg)
end

function DivineMiZongClgController:getClgMo(activityId)
	return DivineMiZongClgModel.instance:getClgMo(activityId)
end

function DivineMiZongClgController:enterBattle(activityId, stageId)
	local fmtMo = DivineMiZongClgModel.instance:getClgFmtMo()

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineMiZongClgController:isSpecialPet(activityId, raceId)
	local result = true
	local data = DivineMiZongClgConfig.instance:getActData(activityId)
	local specialPetSign = data and data.specialPetSign

	if not string.nilorempty(specialPetSign) then
		result = false

		local arr = string.split(specialPetSign, ",")

		for _, sign in ipairs(arr) do
			if CharacterConfig.instance:checkHasSigns(raceId, sign) then
				result = true

				break
			end
		end
	end

	return result
end

function DivineMiZongClgController:_updateRedInBuffUpdate(activityId)
	local redId = RedPointModel.ID_DIVINEMIZONGCLG_BUFFUPDATE
	local isActivated = false

	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		local clgMo = self:getClgMo(activityId)
		local cfgs = DivineMiZongClgConfig.instance:getBuffCfgs(activityId) or {}

		for buffType, cfg in pairs(cfgs) do
			local result = clgMo:getTryResultAndTipsUpdateBuff(false, buffType)

			if result == GameEnum.ResultCode.Success then
				isActivated = true

				break
			end
		end
	end

	RedPointController.instance:setRedPointInfo(redId, isActivated)
end

DivineMiZongClgController.instance = DivineMiZongClgController.New()

return DivineMiZongClgController
