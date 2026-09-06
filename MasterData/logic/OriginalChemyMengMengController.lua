-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/controller/OriginalChemyMengMengController.lua

module("logic.extensions.originalchemymengmeng.controller.OriginalChemyMengMengController", package.seeall)

local OriginalChemyMengMengController = class("OriginalChemyMengMengController", BaseController)

function OriginalChemyMengMengController:onInit()
	return
end

function OriginalChemyMengMengController:sendPM_OriginAlchemyMengMengGetInfoReq(activityId)
	OriginalChemyMengMengAgent.instance:sendPM_OriginAlchemyMengMengGetInfoReq(activityId)
end

function OriginalChemyMengMengController:handlePM_OriginAlchemyMengMengGetInfoRes(msg)
	OriginalChemyMengMengModel.instance:handlePM_OriginAlchemyMengMengGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginAlchemyMengMengGetInfoRes)
end

function OriginalChemyMengMengController:sendPM_OriginAlchemyMengMengResetReq(activityId)
	OriginalChemyMengMengAgent.instance:sendPM_OriginAlchemyMengMengResetReq(activityId)
end

function OriginalChemyMengMengController:handlePM_OriginAlchemyMengMengResetRes(msg)
	OriginalChemyMengMengModel.instance:handlePM_OriginAlchemyMengMengResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginAlchemyMengMengResetRes)
end

function OriginalChemyMengMengController:sendPM_OriginAlchemyMengMengChallengeReq(activityId, stageId, useReagentId, form)
	OriginalChemyMengMengAgent.instance:sendPM_OriginAlchemyMengMengChallengeReq(activityId, stageId, useReagentId, form)
end

function OriginalChemyMengMengController:handlePM_OriginAlchemyMengMengChallengeRes(msg)
	OriginalChemyMengMengModel.instance:handlePM_OriginAlchemyMengMengChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginAlchemyMengMengChallengeRes)
end

function OriginalChemyMengMengController:sendPM_OriginAlchemyMengMengSmeltReagentReq(activityId, reagentId)
	OriginalChemyMengMengAgent.instance:sendPM_OriginAlchemyMengMengSmeltReagentReq(activityId, reagentId)
end

function OriginalChemyMengMengController:handlePM_OriginAlchemyMengMengSmeltReagentRes(msg)
	OriginalChemyMengMengModel.instance:handlePM_OriginAlchemyMengMengSmeltReagentRes(msg)

	local activityId = msg.activityId
	local reagentId = msg.reagentId
	local compoundNumMap = self:getCompoundNumMap(activityId, reagentId)

	OriginalChemyMengMengModel.instance:setCompoundNum(activityId, compoundNumMap)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginAlchemyMengMengSmeltReagentRes)
end

function OriginalChemyMengMengController:getCompoundNumMap(activityId, reagentId)
	local reagentCfg = OriginalChemyMengMengConfig.instance:getReagentCfg(activityId, reagentId) or {}
	local needCompound = checktable(reagentCfg.needCompound)
	local compoundNumMap = {}

	if #needCompound > 0 then
		for i, compoundId in ipairs(needCompound) do
			compoundNumMap[compoundId] = checknumber(compoundNumMap[compoundId]) - 1
		end
	end

	return compoundNumMap
end

function OriginalChemyMengMengController:getPassGetCompoundListNMap(activityId, stageId)
	local stageCfg = OriginalChemyMengMengConfig.instance:getStageCfg(activityId, stageId) or {}
	local markPosition = checktable(stageCfg.markPosition)
	local compoundList = {}
	local compoundMap = {}

	for i, markId in ipairs(markPosition) do
		if markId > 0 then
			local markCfg = OriginalChemyMengMengConfig.instance:getMarkCfg(activityId, markId)

			if markCfg then
				if not markCfg.gainCompound then
					local gainCompound = {}

					for i, compoundId in ipairs(gainCompound) do
						if not compoundMap[compoundId] then
							table.insert(compoundList, compoundId)
						end

						compoundMap[compoundId] = checknumber(compoundMap[compoundId]) + 1
					end
				end
			end
		end
	end

	return compoundList, compoundMap
end

function OriginalChemyMengMengController:handlePM_OriginAlchemyMengMengNotifyClgRes(msg)
	OriginalChemyMengMengModel.instance:handlePM_OriginAlchemyMengMengNotifyClgRes(msg)

	self._finishMsg = msg

	BattleFacade.instance:registerResultHandler(self._onResFightEnd, self)
	self:sendPM_OriginAlchemyMengMengGetInfoReq(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginAlchemyMengMengNotifyClgRes)
end

function OriginalChemyMengMengController:enterBattleClg(activityId, stageId)
	local customFmtMo = OriginalChemyMengMengModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function OriginalChemyMengMengController:getNeedMatMap(activityId, reagentId)
	local reagentCfg = OriginalChemyMengMengConfig.instance:getReagentCfg(activityId, reagentId)
	local needMatMap = {}

	if reagentCfg then
		local needCompound = reagentCfg.needCompound

		for i, compoundId in ipairs(needCompound) do
			needMatMap[compoundId] = checknumber(needMatMap[compoundId]) + 1
		end
	end

	return needMatMap
end

function OriginalChemyMengMengController:canMakeReagent(activityId, reagentId)
	local needMatMap = self:getNeedMatMap(activityId, reagentId)
	local compoundMap = OriginalChemyMengMengModel.instance:getCompoundMap(activityId)
	local reagentCfg = OriginalChemyMengMengConfig.instance:getReagentCfg(activityId, reagentId)

	if reagentCfg then
		local needCompound = reagentCfg.needCompound

		for i, compoundId in ipairs(needCompound) do
			local needMatNum = checknumber(needMatMap[compoundId])
			local hasMatNum = checknumber(compoundMap[compoundId])

			if hasMatNum < needMatNum then
				return false
			end
		end

		return true
	else
		return false
	end
end

function OriginalChemyMengMengController:_onResFightEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local msg = self._finishMsg

	self._finishMsg = nil

	if msg and msg.isWin then
		UIStateManager.instance:push(ViewName.OriginAlchemyMengMengFightEndView, msg)

		return true
	end

	return false
end

function OriginalChemyMengMengController:showCurStageCompound(activityId, stageId)
	local stageCfg = OriginalChemyMengMengConfig.instance:getStageCfg(activityId, stageId) or {}
	local markPosition = checktable(stageCfg.markPosition)
	local markIdList = {}
	local compoundList = {}
	local compoundMap = {}

	for i, v in ipairs(markPosition) do
		if v > 0 and not table.indexof(markIdList, v) then
			table.insert(markIdList, v)
		end
	end

	for i, markId in ipairs(markIdList) do
		local markCfg = OriginalChemyMengMengConfig.instance:getMarkCfg(activityId, markId)

		for i, compoundId in ipairs(markCfg.gainCompound) do
			if not table.indexof(compoundList, compoundId) then
				table.insert(compoundList, compoundId)

				compoundMap[compoundId] = markCfg.desc
			end
		end
	end

	return compoundList, compoundMap
end

function OriginalChemyMengMengController:getNeedCompoundIdList(activityId, reagentId)
	local reagentCfg = OriginalChemyMengMengConfig.instance:getReagentCfg(activityId, reagentId) or {}
	local needCompound = checktable(reagentCfg.needCompound)
	local compoundList = {}

	for i, compoundId in ipairs(needCompound) do
		if not table.indexof(compoundList, compoundId) then
			table.insert(compoundList, compoundId)
		end
	end

	return compoundList
end

function OriginalChemyMengMengController:getCanChallengeStage(activityId)
	local info = OriginalChemyMengMengModel.instance:getInfo(activityId) or {}
	local passStageId = checktable(info.passStageId)
	local stageCfgs = OriginalChemyMengMengConfig.instance:getStageCfgs(activityId)

	for i, cfg in ipairs(stageCfgs) do
		if not table.indexof(passStageId, i) then
			return i
		end
	end

	return 1
end

OriginalChemyMengMengController.instance = OriginalChemyMengMengController.New()

return OriginalChemyMengMengController
