-- chunkname: @modules/logic/versionactivity2_1/activity165/model/Activity165StepMo.lua

module("modules.logic.versionactivity2_1.activity165.model.Activity165StepMo", package.seeall)

local Activity165StepMo = class("Activity165StepMo")

function Activity165StepMo:ctor()
	self._actId = nil
	self.stepId = nil
	self.stepCo = nil
	self.isEndingStep = nil
	self.isFirstStep = nil
	self.nextSteps = nil
	self.lastSteps = nil
	self.roundSteps = nil
	self.isUnlock = nil
	self.isFixStep = nil
	self.canUseKeywordMos = nil
end

function Activity165StepMo:onInit(actId, stepId, storyMo)
	self._actId = actId
	self.stepId = stepId
	self.stepCo = Activity165Config.instance:getStepCo(actId, stepId)
	self.nextSteps = {}

	if not string.nilorempty(self.stepCo.answersKeywordIds) then
		self.isEndingStep = self.stepCo.answersKeywordIds == "-1"

		if not self.isEndingStep then
			local _nextSteps = GameUtil.splitString2(self.stepCo.answersKeywordIds, "#", "|")

			for _, v in pairs(_nextSteps) do
				if LuaUtil.tableNotEmpty(v) then
					local nextId = v[1]
					local step = self.nextSteps[nextId]

					step = step or {
						nextId = nextId
					}

					local kws = step.needKws

					kws = kws or {}

					local needKws = {}

					for i = 2, #v do
						table.insert(needKws, v[i])
					end

					table.insert(kws, needKws)

					step.needKws = kws
					self.nextSteps[nextId] = step
				end
			end
		end
	end

	self.lastSteps = {}
	self.roundSteps = {}

	if not string.nilorempty(self.stepCo.nextStepConditionIds) then
		local steps = GameUtil.splitString2(self.stepCo.nextStepConditionIds, "#", "|")

		for j, v in pairs(steps) do
			if LuaUtil.tableNotEmpty(v) then
				local _list = {}

				for i = 2, #v do
					table.insert(_list, v[i])
				end

				if LuaUtil.tableNotEmpty(_list) then
					table.insert(self.lastSteps, _list)
				end

				local list1 = tabletool.copy(_list)

				table.insert(list1, self.stepId)
				table.insert(list1, v[1])
				table.insert(self.roundSteps, list1)
			end
		end
	end

	self.isUnlock = false
	self.canUseKeywordMos = {}

	if not string.nilorempty(self.stepCo.optionalKeywordIds) then
		local ids = string.splitToNumber(self.stepCo.optionalKeywordIds, "#")

		for _, id in pairs(ids) do
			local mo = storyMo:getKeywordMo(id)

			table.insert(self.canUseKeywordMos, mo)
		end
	end
end

function Activity165StepMo:setCanUseKeywords()
	return
end

function Activity165StepMo:isSameTableValue(tb1, tb2)
	if LuaUtil.tableNotEmpty(tb1) and LuaUtil.tableNotEmpty(tb2) then
		if tabletool.len(tb1) ~= tabletool.len(tb2) then
			return false
		end

		for _, v in pairs(tb1) do
			if not LuaUtil.tableContains(tb2, v) then
				return false
			end
		end

		return true
	end
end

function Activity165StepMo:onReset()
	self.isUnlock = nil
	self.isFixStep = nil
end

function Activity165StepMo:getNextStep(keywords)
	for _, v in pairs(self.nextSteps) do
		for _, nextkw in pairs(v.needKws) do
			if self:isSameTableValue(nextkw, keywords) then
				return v.nextId
			end
		end
	end
end

function Activity165StepMo:getNextStepKeyword(stepId)
	for _, v in pairs(self.nextSteps) do
		if v.nextId == stepId then
			local _, value = next(v.needKws)

			return value
		end
	end
end

function Activity165StepMo:setUnlock(isUnlock)
	self.isUnlock = isUnlock
end

function Activity165StepMo:getCanEndingRound(endings)
	local rounds = {}

	for _, round in pairs(self.roundSteps) do
		local finalStep = round[#round]

		if LuaUtil.tableContains(endings, finalStep) then
			table.insert(rounds, round)
		end
	end

	return rounds
end

function Activity165StepMo:getCanUseKeywords()
	return self.canUseKeywordMos
end

return Activity165StepMo
