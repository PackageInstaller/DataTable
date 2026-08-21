-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/facade/LivingFacilitiesFacade.lua

module("logic.extensions.livingfacilities.facade.LivingFacilitiesFacade", package.seeall)

local M = class("LivingFacilitiesFacade", BaseFacade)

function M:ctor()
	return
end

function M:enterLivingFacilities(zoneId)
	LivingFacilitiesZoneController.instance:setCurrentZoneId(zoneId)

	local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(zoneId)

	if not zoneMo then
		HouseDispatcher:dispatchEvent(HouseEventType.ON_FOCUS_ROOM_EXIST)
	elseif zoneMo:getIsActive() then
		if not zoneMo:getIsDataGet() then
			LivingFacilitiesAgent.instance:sendGetLiveZoneInfoRequest(zoneId)
		end

		ViewMgr.instance:open(ViewName.LivingFacilitiesMain)
	else
		local content = ""

		if zoneMo:getActiveCostString() and zoneMo:getActiveCostString() ~= "" then
			content = langF("tip_cost_s", zoneMo:getActiveCostString())
		end

		local dialog = Dialog.showWarnMessage(lang("tip_title"), langF("tip_charging_device", content))

		dialog:setConfirmListener(function()
			LivingFacilitiesAgent.instance:sendActiveZoneRequest(zoneId)
		end, self)
		dialog:setCancelListener(function()
			HouseDispatcher:dispatchEvent(HouseEventType.ON_FOCUS_ROOM_EXIST)
		end, self)
		dialog:setCloseListener(function()
			HouseDispatcher:dispatchEvent(HouseEventType.ON_FOCUS_ROOM_EXIST)
		end, self)
	end
end

M.instance = M.New()

return M
