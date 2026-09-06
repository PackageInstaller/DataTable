-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfuleggs/model/ColorfulEggsModel.lua

module("logic.extensions.colorfuleggs.model.ColorfulEggsModel", package.seeall)

local ColorfulEggsModel = class("ColorfulEggsModel", BaseModel)

function ColorfulEggsModel:onInit()
	self:onReset()
end

function ColorfulEggsModel:onReset()
	self._finishEggs = {}
	self._triggeredEggs = {}
	self._unavailableEggs = {}
	self.isReady = nil
	self._relatedNpcIdleEggs = nil
end

function ColorfulEggsModel:onTaskListRespond()
	local eggsList = ColorfulEggConfig.instance:getDataList()

	if not eggsList then
		return
	end

	for i = 1, #eggsList do
		local eggMo = ColorfulEggFactory.createEgg(eggsList[i].id)

		if eggMo:isAllTimesFinished() then
			self._finishEggs[eggsList[i].id] = eggMo

			eggMo:setState(ColorfulEggsConst.States.Finished)
		elseif ColorfulEggsConst.shouldTriggered(eggsList[i]) then
			self._triggeredEggs[eggsList[i].id] = eggMo

			eggMo:setState(ColorfulEggsConst.States.Triggered)
		else
			self._unavailableEggs[eggsList[i].id] = eggMo

			eggMo:setState(ColorfulEggsConst.States.UnTriggered)
		end

		if not string.nilorempty(eggMo.eggCo.idle_strategy) and eggMo.eggCo.npcId and #eggMo.eggCo.npcId > 0 then
			self._relatedNpcIdleEggs = self._relatedNpcIdleEggs or {}
			self._relatedNpcIdleEggs[eggMo.eggCo.npcId[1]] = self._relatedNpcIdleEggs[eggMo.eggCo.npcId[1]] or {}

			table.insert(self._relatedNpcIdleEggs[eggMo.eggCo.npcId[1]], eggMo)
		end
	end

	self.isReady = true
end

function ColorfulEggsModel:getTriggeredEggs()
	return self._triggeredEggs
end

function ColorfulEggsModel:getFinishEggs()
	return self._finishEggs
end

function ColorfulEggsModel:getUnavailableEggs()
	return self._unavailableEggs
end

function ColorfulEggsModel:triggerEgg(egg)
	egg:triggerColorfulEgg()

	self._triggeredEggs[egg:getEggId()] = egg
	self._unavailableEggs[egg:getEggId()] = nil
end

function ColorfulEggsModel:getRelatedNpcEggs(npcId)
	if not self._relatedNpcIdleEggs then
		return
	end

	return self._relatedNpcIdleEggs[npcId]
end

function ColorfulEggsModel:finishEgg(egg)
	egg:finishColorfulEgg()

	if egg:isAllTimesFinished() then
		self._triggeredEggs[egg:getEggId()] = nil
		self._finishEggs[egg:getEggId()] = egg
	else
		egg:setState(ColorfulEggsConst.States.UnTriggered)

		self._triggeredEggs[egg:getEggId()] = nil
		self._unavailableEggs[egg:getEggId()] = egg
	end
end

function ColorfulEggsModel:closeEgg(egg)
	egg:closeColorfulEgg()

	self._triggeredEggs[egg:getEggId()] = nil
	self._unavailableEggs[egg:getEggId()] = egg
end

function ColorfulEggsModel:isEggTriggered(id)
	return self._triggeredEggs[id] ~= nil
end

function ColorfulEggsModel:isEggFinished(id)
	return self._finishEggs[id] ~= nil
end

function ColorfulEggsModel:updateEggs(deltaTime)
	for k, v in pairs(self._unavailableEggs) do
		-- block empty
	end
end

ColorfulEggsModel.instance = ColorfulEggsModel.New()

return ColorfulEggsModel
