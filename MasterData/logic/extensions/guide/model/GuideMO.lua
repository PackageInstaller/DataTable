-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/GuideMO.lua

module("logic.extensions.guide.model.GuideMO", package.seeall)

local TriggerType = GuideEnum.TriggerType
local GuideMO = class("GuideMO")

function GuideMO:ctor()
	self.id = 0
	self._guideCO = fasle
	self.isFinish = false
	self._allStepCO = false
	self._curFinishStepId = false
	self._isForBattle = false
	self._isOnLine = false
	self._needOpenSystemMap = false
	self._triggerParamParse = false
end

function GuideMO:setGuideState(isFinish)
	self.isFinish = isFinish
end

function GuideMO:getGuideFinish(isFinish)
	return isFinish
end

function GuideMO:trySetOpenSytemState(isOpen)
	if not self.id then
		return
	end

	if not self._needOpenSystemMap then
		self._needOpenSystemMap = {}
	else
		table.clear(self._needOpenSystemMap)
	end

	local allGuideOpenInfoMap = SystemOpenConfig.instance:getAllGuideOpenSystemInfo(self.id)

	if allGuideOpenInfoMap then
		for k, v in pairs(allGuideOpenInfoMap) do
			for _, systemId in pairs(v) do
				local curSystemState = SystemOpenModel.instance:isOpen(systemId)

				if not curSystemState then
					table.insert(self._needOpenSystemMap, systemId)
					SystemOpenModel.instance:addOpenSystem(systemId)
				end
			end
		end
	end

	if not isOpen then
		SystemOpenModel.instance:removeOpenSystem(self._needOpenSystemMap)
	end
end

function GuideMO:initGuideInfo(guideInfo)
	self.id = guideInfo.id
	self._guideCO = guideInfo

	if self._guideCO then
		self._isOnLine = self._guideCO.isOnLine == 0

		local stepIds = GuideConfig.instance:getGuideStepIdList(self.id)

		self._allStepCO = stepIds

		if self._guideCO.triggerType == TriggerType.EnterDungeon or self._guideCO.triggerType == TriggerType.WaitBattleStart or self._guideCO.triggerType == TriggerType.BeforeCampAdjustment then
			self._isForBattle = true
		end
	end
end

function GuideMO:isOnLine()
	return self._isOnLine
end

function GuideMO:getGuideCO()
	return self._guideCO
end

function GuideMO:getAllStepIds()
	return self._allStepCO
end

function GuideMO:setFinishClientStep(stepId)
	self._curFinishStepId = stepId
end

function GuideMO:getFinishClientStep()
	return self._curFinishStepId
end

function GuideMO:getIsBattleGuide()
	return self._isForBattle
end

function GuideMO:getTriggerParamParse()
	if not self._triggerParamParse and self._guideCO.triggerParam ~= "" then
		self._triggerParamParse = string.split(self._guideCO.triggerParam, "#")
	end

	return self._triggerParamParse
end

return GuideMO
