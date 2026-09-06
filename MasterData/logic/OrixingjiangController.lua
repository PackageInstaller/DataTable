-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/controller/OrixingjiangController.lua

module("logic.extensions.orixingjiang.controller.OrixingjiangController", package.seeall)

local OrixingjiangController = class("OrixingjiangController", BaseController)

function OrixingjiangController:ctor()
	return
end

function OrixingjiangController:onInit()
	self:onReset()
end

function OrixingjiangController:onReset()
	self._currClgStageId = nil
end

function OrixingjiangController:onNotifyClgRes(msg)
	if not msg.isWin then
		return false
	end

	local petIdToTransmogId = self._petIdToTransmogId
	local needBanRaceIds = {}
	local resultDatas = {}
	local raceIdToTransmogId = {}

	for i, v in ipairs(petIdToTransmogId or {}) do
		local petMo = BagPetsController.instance:getPet(v.petId)

		if petMo then
			raceIdToTransmogId[petMo.raceId] = v.transmogId
		end
	end

	local transmogRaceIdsMap = {}

	for i, v in ipairs(msg.transmogRaceIds or {}) do
		transmogRaceIdsMap[v] = true
	end

	for i, v in ipairs(msg.aliveRaceIds or {}) do
		if transmogRaceIdsMap[v] then
			table.insert(needBanRaceIds, v)
		end

		table.insert(resultDatas, {
			isDead = false,
			raceId = v,
			transmogId = raceIdToTransmogId[v],
			isTransmog = transmogRaceIdsMap[v]
		})
	end

	for i, v in ipairs(msg.deadRaceIds or {}) do
		table.insert(resultDatas, {
			isDead = true,
			raceId = v,
			transmogId = raceIdToTransmogId[v],
			isTransmog = transmogRaceIdsMap[v]
		})
	end

	OrixingjiangModel.instance:onNotifyClgRes(msg, needBanRaceIds)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)
		UIStateManager.instance:push(ViewName.OriginxingjiangresultView, msg, resultDatas)

		return true
	end)

	self._petIdToTransmogId = nil
end

function OrixingjiangController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(284)
end

function OrixingjiangController:sendPM_OriginXingjiangClgReq(activityId, stageId, petIdToTransmogId, form)
	self._petIdToTransmogId = petIdToTransmogId

	OriginXingjiangAgent:sendPM_OriginXingjiangClgReq(activityId, stageId, petIdToTransmogId, form)
end

function OrixingjiangController:setCurrClgStageId(stageId)
	self._currClgStageId = stageId
end

function OrixingjiangController:getCurrClgStageId()
	return self._currClgStageId
end

OrixingjiangController.instance = OrixingjiangController.New()

return OrixingjiangController
