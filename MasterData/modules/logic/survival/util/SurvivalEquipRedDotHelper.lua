-- chunkname: @modules/logic/survival/util/SurvivalEquipRedDotHelper.lua

module("modules.logic.survival.util.SurvivalEquipRedDotHelper", package.seeall)

local SurvivalEquipRedDotHelper = class("SurvivalEquipRedDotHelper")

function SurvivalEquipRedDotHelper:ctor()
	self.reddotType = -1
end

function SurvivalEquipRedDotHelper:checkRed()
	local redDot = self.reddotType

	self:_checkRed()

	if redDot ~= self.reddotType then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEquipRedUpdate)
	end
end

function SurvivalEquipRedDotHelper:_checkRed()
	self.reddotType = -1

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if not weekInfo then
		return
	end

	local hasEmpty = false

	for i, v in ipairs(weekInfo.equipBox.slots) do
		if v.item:isEmpty() and v.unlock then
			hasEmpty = true

			break
		end
	end

	local haveEquip = false

	for i, itemMo in ipairs(weekInfo:getBag(SurvivalEnum.ItemSource.Shelter).items) do
		if itemMo.equipCo then
			haveEquip = true
		end
	end

	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if weekInfo.inSurvival and sceneMo then
		for _, itemMo in ipairs(weekInfo:getBag(SurvivalEnum.ItemSource.Map).items) do
			if itemMo.equipCo then
				haveEquip = true
			end
		end
	end

	if not haveEquip then
		return
	end

	if hasEmpty and haveEquip then
		self.reddotType = 0

		return
	end

	local list = {}

	for i, v in ipairs(weekInfo.equipBox.slots) do
		if not v.item:isEmpty() and self:haveTag(v.item.equipCo.tag, weekInfo.equipBox.maxTagId) then
			table.insert(list, v.item)
		end
	end

	for i, itemMo in ipairs(weekInfo:getBag(SurvivalEnum.ItemSource.Shelter).items) do
		if itemMo.equipCo then
			for _, v in ipairs(list) do
				if v.equipCo.group == itemMo.equipCo.group and v.equipCo.score < itemMo.equipCo.score then
					self.reddotType = weekInfo.equipBox.maxTagId

					return
				end
			end
		end
	end

	if weekInfo.inSurvival and sceneMo then
		for _, itemMo in ipairs(weekInfo:getBag(SurvivalEnum.ItemSource.Map).items) do
			if itemMo.equipCo then
				for _, v in ipairs(list) do
					if v.equipCo.group == itemMo.equipCo.group and v.equipCo.score < itemMo.equipCo.score then
						self.reddotType = weekInfo.equipBox.maxTagId

						return
					end
				end
			end
		end
	end
end

local arrCache = {}

setmetatable(arrCache, {
	__mode = "v"
})

function SurvivalEquipRedDotHelper:haveTag(tagStr, tagId)
	if tagId == 0 or string.nilorempty(tagStr) then
		return false
	end

	arrCache[tagStr] = arrCache[tagStr] or string.splitToNumber(tagStr, "#")

	return tabletool.indexOf(arrCache[tagStr], tagId)
end

SurvivalEquipRedDotHelper.instance = SurvivalEquipRedDotHelper.New()

return SurvivalEquipRedDotHelper
