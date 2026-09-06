-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petegg/controller/PetEggController.lua

module("logic.extensions.petegg.controller.PetEggController", package.seeall)

local PetEggController = class("PetEggController", BaseController)

function PetEggController:onInit()
	return
end

function PetEggController:hatchEgg(hatcherId, petEggId)
	PetEggAgent.instance:sendHatchPetEggReq(hatcherId, petEggId)
end

function PetEggController:unloadEgg(hatcherId)
	PetEggAgent.instance:sendCancelHatchPetReq(hatcherId)
end

function PetEggController:getPet(hatcherId)
	PetEggAgent.instance:sendGetHatchOutPetReq(hatcherId)
end

function PetEggController:speedUpEgg(hatcherId)
	PetEggAgent.instance:sendSpeedUpHatchPetEggReq(hatcherId)
end

function PetEggController:_hatchEgg(hatcherId, data)
	if not PetEggModel.instance:isHatcherEmpty(hatcherId) then
		FloatWordMgr.instance:show(lang("petegg_hatching"))

		return
	end

	local isVip = true

	if not isVip and hatcherId > 1 then
		FloatWordMgr.instance:show(lang("petegg_needvip"))

		return
	end

	local cfg = PetEggConfig.instance:getCfgById(data)

	if not cfg.costTime then
		TipsFacade.instance:openPopupWindow(lang("tip"), langPara("petegg_ifhatch", lang(cfg.name), tostring(cfg.costTime / 60) .. "分钟"), function()
			PetEggController.instance:hatchEgg(hatcherId, data)
			PetEggModel.instance:setSelectEgg(-1)
		end)
	end
end

PetEggController.instance = PetEggController.New()

return PetEggController
