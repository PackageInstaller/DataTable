-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/facade/StarEquipmentFacade.lua

module("logic.extensions.starequipment.facade.StarEquipmentFacade", package.seeall)

local StarEquipmentFacade = class("StarEquipmentFacade")

function StarEquipmentFacade:ctor()
	return
end

function StarEquipmentFacade:getPetEquipAttrsWithTargetStarLv(petMo, targetStarLv)
	local content = ""

	if targetStarLv == CharacterConfig.MAX_STAR_LVL or petMo._starLevel == targetStarLv - 1 then
		local slotsInfo = petMo._equipSlots

		for _, slotInfo in pairs(slotsInfo) do
			local equip = slotInfo.slotItems[1]

			if equip ~= nil then
				local equipLvCfg = StarEquipmentConfig.instance:getEquipLvCfg(equip.equipmentId, equip.level)
				local equipCfg = StarEquipmentConfig.instance:getEquipCfg(equip.equipmentId)

				if not string.nilorempty(content) then
					content = content .. "\n"
				end

				content = content .. string.format("Lv.%s  %s:  %s", equip.level, equipCfg.name, equipLvCfg.propertyApp)
			end
		end
	else
		local equipLv = petMo._starLevel < targetStarLv - 1 and 1 or StarEquipmentConfig.MaxStarEquipmentLv

		for slotIndex = 1, 3 do
			local equipId = CharacterConfig.instance:getRecommendEquipId(petMo.raceId, targetStarLv, slotIndex)
			local equipCfg = StarEquipmentConfig.instance:getEquipCfg(equipId)
			local equipLvCfg = StarEquipmentConfig.instance:getEquipLvCfg(equipId, equipLv)

			if not string.nilorempty(content) then
				content = content .. "\n"
			end

			content = content .. string.format("Lv.%s  %s:  %s", equipLv, equipCfg.name, equipLvCfg.propertyApp)
		end
	end

	return content
end

StarEquipmentFacade.instance = StarEquipmentFacade.New()

return StarEquipmentFacade
