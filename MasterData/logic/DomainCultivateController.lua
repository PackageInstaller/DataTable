-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domaincultivate/controller/DomainCultivateController.lua

module("logic.extensions.dreamteam.controller.DomainCultivateController", package.seeall)

local DomainCultivateController = class("DomainCultivateController", BaseController)

DomainCultivateController.handlePM_ResetKamuiRes = "handlePM_ResetKamuiRes"
DomainCultivateController.handlePM_ConfirmResetKamuiRes = "handlePM_ConfirmResetKamuiRes"

function DomainCultivateController:ctor()
	return
end

function DomainCultivateController:onInit()
	GlobalDispatcher:addListener(DomainCultivateController.handlePM_ResetKamuiRes, self.handleResetKamuiRes, self)
	GlobalDispatcher:addListener(DomainCultivateController.handlePM_ConfirmResetKamuiRes, self.handleConfirmResetKamuiRes, self)
end

function DomainCultivateController:onReset()
	return
end

function DomainCultivateController:resetKamui(petId, level)
	UIStateManager.instance:open(ViewName.DomainCultivateResetView, petId, level)

	local tempId = checknumber(DomainCultivateModel.instance:getResetInfo(petId, level))

	if tempId > 0 then
		UIStateManager.instance:open(ViewName.DomainCultivateResetSureView, petId, level, tempId)
	end
end

function DomainCultivateController:getInfo(petId)
	if not DomainCultivateModel.instance:getHasGetInfo(petId) then
		KamuiAgent.instance:sendPM_KamuiResetInfoReq(petId)
		DomainCultivateModel.instance:setHasGetInfo(petId, true)
	end
end

function DomainCultivateController:activeKamuiReq(petId, level)
	KamuiAgent.instance:sendPM_ActiveKamuiReq(petId, level)
end

function DomainCultivateController:resetKamuiReq(petId, level)
	KamuiAgent.instance:sendPM_ResetKamuiReq(petId, level)
end

function DomainCultivateController:handleResetKamuiRes(status, msg, petId, level)
	UIStateManager.instance:open(ViewName.DomainCultivateResetSureView, petId, level, msg.tempId)
end

function DomainCultivateController:confirmResetKamuiReq(petId, level, sure)
	KamuiAgent.instance:sendPM_ConfirmResetKamuiReq(petId, level, sure)
end

function DomainCultivateController:handleConfirmResetKamuiRes(status, msg)
	return
end

function DomainCultivateController:getIfKamuiActive(petId)
	local petMo = BagModel.instance:getPet(petId)

	if not petMo then
		return false
	end

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)

	if secondJobIdx ~= GameEnum.CareerType.Shenqi then
		return false
	end

	local kamuiInfos = petMo:getKamuiInfos()
	local petCfg = CharacterConfig.instance:getPetCo(petMo.raceId)
	local planId = petCfg.kamuiProgramId

	if planId == nil then
		print("-------------配了神启精灵，但是没配养成方案")

		return false
	end

	local levelCfg = DomainCultivateConfig.instance:getLevelCfg(planId)

	if levelCfg == nil or #levelCfg < 1 then
		print("-------------配了神启精灵，但养成方案找不到配置" .. planId .. "  " .. petMo.raceId)

		return false
	end

	local maxLevel = #levelCfg

	if maxLevel <= #kamuiInfos then
		return false
	else
		local consume = levelCfg[#kamuiInfos + 1].upgradeCost

		consume = string.split(consume, "#")

		for k, v in pairs(consume) do
			local str = string.splitToNumber(v, ":")
			local type = str[1]
			local id = str[2]
			local needNum = str[3]
			local hasNum = MaterialModel.instance:getMaterialsNumber(type, id)

			if hasNum < needNum then
				return false
			end
		end

		return true
	end
end

DomainCultivateController.instance = DomainCultivateController.New()

return DomainCultivateController
