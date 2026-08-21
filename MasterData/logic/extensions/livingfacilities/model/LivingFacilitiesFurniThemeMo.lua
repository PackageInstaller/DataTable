-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/model/LivingFacilitiesFurniThemeMo.lua

module("logic.extensions.livingfacilities.model.LivingFacilitiesFurniThemeMo", package.seeall)

local M = class("LivingFacilitiesFurniThemeMo")

function M:ctor(id)
	self.id = id
	self._furnitureCoList = {}
	self._effectList = {}

	if id > 0 then
		local co = LivingFacilitiesConfig.instance:getConfigByKey(ConfigName.HouseFurnitureTheme, id)

		self._name = co.name

		local len = string.len(co.effect)
		local effectString = string.sub(co.effect, 2, len - 1)
		local effectStringList = string.split(effectString, ",")

		for _, effectStringItem in pairs(effectStringList) do
			local effectItemList = string.split(effectStringItem, ":")
			local count = checknumber(effectItemList[1])
			local num = checkint(effectItemList[2])
			local effect = {}

			effect.count = count
			effect.num = num

			table.insert(self._effectList, effect)
		end

		self._fullCount = co.count
		self._skill = co.skill
	end
end

function M:getEffectNumByCount(count)
	local num = 0

	for i, effect in ipairs(self._effectList) do
		if count >= effect.count then
			num = effect.num
		end
	end

	return num
end

function M:getId()
	return self.id
end

function M:getName()
	if self.id == 0 then
		return lang("tip_all_theme")
	end

	return self._name
end

function M:getEffectList()
	return self._effectList
end

function M:getFullCount()
	return self._fullCount
end

function M:getSkillCode()
	return self._skill
end

function M:insertFurnitureList(co)
	table.insert(self._furnitureCoList, co)
end

function M:getFurnitureCoList()
	return self._furnitureCoList
end

function M:getFurnitureCoListOnline()
	local list = {}

	for _, CO in ipairs(self._furnitureCoList) do
		if CO.isOnline == 1 then
			table.insert(list, CO)
		end
	end

	return list
end

function M:getStatusByFurnitureList(furnitureList)
	local list = {}
	local num = 0

	for i, furniture in ipairs(furnitureList) do
		local furnitureCo = BackpackConfig.instance:getItemInfoByItemId(furniture)

		if furnitureCo.theme == self.id and not table.indexof(list, furnitureCo.group) then
			table.insert(list, furnitureCo.group)
		end
	end

	local count = #list

	for i, effect in ipairs(self._effectList) do
		if count >= effect.count then
			num = effect.num
		end
	end

	return count, num
end

return M
