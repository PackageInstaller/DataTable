-- chunkname: @modules/logic/guide/model/GuideMO.lua

module("modules.logic.guide.model.GuideMO", package.seeall)

local GuideMO = pureTable("GuideMO")

function GuideMO:ctor()
	self.id = 0
	self.serverStepId = -1
	self.clientStepId = -1
	self.currGuideId = -1
	self.currStepId = -1
	self.isFinish = false
	self.isExceptionFinish = false
	self.isJumpPass = false
	self.targetStepId = nil
	self._againStepCOs = nil
end

function GuideMO:getCurStepCO()
	return (GuideConfig.instance:getStepCO(self.currGuideId, self.currStepId))
end

function GuideMO:init(guideInfo)
	self.id = guideInfo.guideId
	self.serverStepId = guideInfo.stepId or 0
	self.clientStepId = guideInfo.stepId or 0

	self:_setCurrStep()

	self.isFinish = self.serverStepId == -1

	local currStepCO = GuideConfig.instance:getStepCO(self.id, self.currStepId)

	if currStepCO ~= nil and string.nilorempty(currStepCO.againSteps) == false then
		self._againStepCOs = {}

		local steps = GameUtil.splitString2(currStepCO.againSteps, true, "|", "#")

		for _, oneStep in ipairs(steps) do
			if #oneStep == 1 then
				if not self.id then
					local guideId = oneStep[1]

					if #oneStep == 1 then
						if not oneStep[1] then
							local stepId = oneStep[2]
							local stepCO = GuideConfig.instance:getStepCO(guideId, stepId)

							if stepCO then
								table.insert(self._againStepCOs, stepCO)
							else
								logError("againSteps invalid: guide_" .. self.id .. "_" .. currStepCO.stepId)
							end
						end
					end
				end
			end
		end

		if #self._againStepCOs > 0 then
			self.currGuideId = self._againStepCOs[1].id
			self.currStepId = self._againStepCOs[1].stepId

			table.remove(self._againStepCOs, 1)
		end
	end
end

function GuideMO:exceptionFinishGuide()
	self.serverStepId = -1
	self.clientStepId = -1
	self.currGuideId = -1
	self.currStepId = -1
	self.isFinish = true
	self.isExceptionFinish = true
end

function GuideMO:updateGuide(guideInfo)
	self._againStepCOs = nil
	self.id = guideInfo.guideId
	self.serverStepId = guideInfo.stepId

	if self.targetStepId then
		self.clientStepId = GuideConfig.instance:getPrevStepId(self.id, self.targetStepId)
		self.targetStepId = nil
	elseif self.isJumpPass then
		self.clientStepId = -1
	elseif guideInfo.stepId ~= -1 then
		self.clientStepId = guideInfo.stepId
	else
		local targetClientStepId = -1
		local stepCOList = GuideConfig.instance:getStepList(self.id)

		if stepCOList[#stepCOList].keyStep ~= 1 then
			for i = #stepCOList - 1, 1, -1 do
				local oneStepCO = stepCOList[i]

				if oneStepCO.keyStep == 1 then
					targetClientStepId = oneStepCO.stepId

					break
				end
			end
		end

		self.clientStepId = targetClientStepId
	end

	self:_setCurrStep()

	self.isFinish = self.serverStepId == -1
end

function GuideMO:setClientStep(stepId)
	if self._againStepCOs then
		if not #self._againStepCOs then
			local interruptStepsCount = 0

			if interruptStepsCount == 0 and stepId < self.serverStepId then
				self.clientStepId = self.serverStepId
			else
				self.clientStepId = stepId

				local stepCOList = GuideConfig.instance:getStepList(self.id)
				local lastStepCO = stepCOList and stepCOList[#stepCOList]

				if lastStepCO and self.clientStepId == lastStepCO.stepId then
					self.clientStepId = -1
				end
			end

			self:_setCurrStep()
		end
	end
end

function GuideMO:gotoStep(stepId)
	self._againStepCOs = nil
	self.clientStepId = GuideConfig.instance:getPrevStepId(self.id, stepId)

	self:_setCurrStep()
end

function GuideMO:toGotoStep(stepId)
	self._againStepCOs = nil
	self.targetStepId = stepId
end

function GuideMO:_setCurrStep()
	local stepCOList = GuideConfig.instance:getStepList(self.id)

	self.currGuideId = -1
	self.currStepId = -1

	if self._againStepCOs and #self._againStepCOs > 0 then
		self.currGuideId = self._againStepCOs[1].id
		self.currStepId = self._againStepCOs[1].stepId

		table.remove(self._againStepCOs, 1)
	elseif self.clientStepId == 0 then
		self.currGuideId = self.id
		self.currStepId = stepCOList[1].stepId
	elseif self.clientStepId > 0 then
		self.currGuideId = self.id
		self.currStepId = GuideConfig.instance:getNextStepId(self.id, self.clientStepId)
	end
end

return GuideMO
