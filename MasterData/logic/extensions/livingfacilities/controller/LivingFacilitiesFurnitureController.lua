-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/controller/LivingFacilitiesFurnitureController.lua

module("logic.extensions.livingfacilities.controller.LivingFacilitiesFurnitureController", package.seeall)

local M = class("LivingFacilitiesFurnitureController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._filterCondition = {}
end

function M:getBagFurnitureByRoomType(roomType)
	local tempList = {}
	local furnitureDataMoList = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.FurnitureItemType)

	for i, furnitureMo in ipairs(furnitureDataMoList) do
		if furnitureMo:getIsOnline() then
			local isInUse, roomId = furnitureMo:isUsing()

			if not isInUse then
				table.insert(tempList, furnitureMo)
			elseif furnitureMo:getCanUse(roomType) then
				table.insert(tempList, furnitureMo)
			end
		end
	end

	return tempList
end

function M:setFilterCondition(filter)
	for name, condition in pairs(filter) do
		self._filterCondition[name] = condition
	end
end

function M:isFitCondition(furnitureMo)
	if self._filterCondition.theme and self._filterCondition.theme ~= 0 then
		return furnitureMo:getTheme() == self._filterCondition.theme
	end

	return true
end

function M:saveFurnituresRequest()
	local zoneId = LivingFacilitiesZoneController.instance:getCurrentZoneId()
	local furnitureList = {}

	if LivingFacilitiesZoneController.instance:getInPlaceTemple() then
		furnitureList = LivingFacilitiesZoneController.instance:getCacheFurnitureDatas()
	else
		furnitureList = HouseFacade.instance:getCurrFurnitureDatas(zoneId) or {}
	end

	HouseAgent.instance:sendSaveFurnituresRequest(zoneId, furnitureList)
end

function M:getFurnitureSubType(firstType, secondType)
	return firstType * 100 + secondType
end

M.instance = M.New()

return M
