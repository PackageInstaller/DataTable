-- chunkname: @modules/logic/survival/view/map/comp/SurvivalButtonUnlockPart.lua

module("modules.logic.survival.view.map.comp.SurvivalButtonUnlockPart", package.seeall)

local SurvivalButtonUnlockPart = class("SurvivalButtonUnlockPart", LuaCompBase)

function SurvivalButtonUnlockPart:ctor(param)
	self.unlockConditions = param.unlockConditions
	self.eventParams = param.eventParams
end

function SurvivalButtonUnlockPart:addEventListeners()
	if self.eventParams then
		for _, v in ipairs(self.eventParams) do
			self.addEventCb(self, v[1], v[2], self._onEvent, self)
		end
	end

	self:refreshButton()
end

function SurvivalButtonUnlockPart:removeEventListeners()
	if self.eventParams then
		for _, v in ipairs(self.eventParams) do
			self.removeEventCb(self, v[1], v[2], self._onEvent, self)
		end
	end
end

function SurvivalButtonUnlockPart:init(go)
	self.go = go

	self:setBtnVisible(true)
end

function SurvivalButtonUnlockPart:_onEvent()
	self:refreshButton()
end

function SurvivalButtonUnlockPart:refreshButton()
	local isUnlock = self:isUnlock()

	self:setBtnVisible(isUnlock)
end

function SurvivalButtonUnlockPart:setBtnVisible(isVisible)
	if self._isVisible == isVisible then
		return
	end

	self._isVisible = isVisible

	gohelper.setActive(self.go, self._isVisible)
end

function SurvivalButtonUnlockPart:isUnlock()
	if not self.unlockConditions then
		return true
	end

	for _, v in ipairs(self.unlockConditions) do
		if not self:_checkCondition(v) then
			return false
		end
	end

	return true
end

function SurvivalButtonUnlockPart:_checkCondition(condition)
	local conditionType = condition[1]

	if conditionType == SurvivalEnum.ShelterBtnUnlockType.BuildingTypeLev then
		local buildingType = condition[2]
		local buildingLevel = condition[3]
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		return (weekInfo:checkBuildingTypeLev(buildingType, buildingLevel))
	end

	return true
end

return SurvivalButtonUnlockPart
