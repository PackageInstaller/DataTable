-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameBaseInteractiveMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameBaseInteractiveMO", package.seeall)

local ArcadeGameBaseInteractiveMO = class("ArcadeGameBaseInteractiveMO", ArcadeGameBaseUnitMO)

function ArcadeGameBaseInteractiveMO:addTriggerEventOptionId(optionId)
	if not optionId then
		return
	end

	self._selectedEventOptionList = self._selectedEventOptionList or {}

	table.insert(self._selectedEventOptionList, optionId)
end

function ArcadeGameBaseInteractiveMO:getCfg()
	return (ArcadeConfig.instance:getInteractiveCfg(self.id, true))
end

function ArcadeGameBaseInteractiveMO:getSize()
	if not self._sizeX then
		self._sizeX, self._sizeY = ArcadeConfig.instance:getInteractiveGrid(self.id)
	end

	return self._sizeX, self._sizeY
end

function ArcadeGameBaseInteractiveMO:getRes()
	return ArcadeConfig.instance:getInteractiveRes(self.id)
end

function ArcadeGameBaseInteractiveMO:getEventOptionList()
	return ArcadeConfig.instance:getInteractiveOptionList(self.id)
end

function ArcadeGameBaseInteractiveMO:getEventOptionId(index)
	local optionList = self:getEventOptionList()

	return optionList[index]
end

function ArcadeGameBaseInteractiveMO:getEventOptionParam(index)
	local optionId = self:getEventOptionId(index)

	return ArcadeConfig.instance:getEventOptionParam(optionId)
end

function ArcadeGameBaseInteractiveMO:getInteractDesc()
	local isCanInteract = self:isCanInteract()

	if isCanInteract then
		return ArcadeConfig.instance:getInteractiveDesc(self.id)
	else
		local lastSelectedOption = self:getLastSelectedEventOptionId()
		local optionTriggerDesc = ArcadeConfig.instance:getEventOptionTriggerDesc(lastSelectedOption)

		if not string.nilorempty(optionTriggerDesc) then
			return optionTriggerDesc
		else
			return ArcadeConfig.instance:getInteractiveDesc(self.id)
		end
	end
end

function ArcadeGameBaseInteractiveMO:isCanInteract()
	local result = true
	local limit = ArcadeConfig.instance:getInteractiveLimit(self.id)

	if limit and limit > 0 then
		if self._selectedEventOptionList then
			if not #self._selectedEventOptionList then
				local triggerCount = 0

				result = triggerCount < limit
			end
		end
	end

	return result
end

function ArcadeGameBaseInteractiveMO:getLastSelectedEventOptionId()
	return self._selectedEventOptionList and self._selectedEventOptionList[#self._selectedEventOptionList]
end

function ArcadeGameBaseInteractiveMO:getIdleShowEffectId()
	local stateShowEffectId

	if self._selectedEventOptionList then
		if not #self._selectedEventOptionList then
			local triggerCount = 0

			stateShowEffectId = triggerCount > 0 and ArcadeConfig.instance:getInteractiveAfterIdleShowEffId(self.id) or ArcadeConfig.instance:getInteractiveBeforeIdleShowEffId(self.id)

			if not stateShowEffectId or stateShowEffectId == 0 then
				stateShowEffectId = ArcadeConfig.instance:getStateShowEffectId(ArcadeGameEnum.StateShowId.Idle)
			end

			return stateShowEffectId
		end
	end
end

return ArcadeGameBaseInteractiveMO
