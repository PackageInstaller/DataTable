-- chunkname: @modules/logic/versionactivity3_4/bbs/model/V3a4BBSPostMO.lua

module("modules.logic.versionactivity3_4.bbs.model.V3a4BBSPostMO", package.seeall)

local V3a4BBSPostMO = class("V3a4BBSPostMO")

function V3a4BBSPostMO:ctor(actId, postId)
	self.postId = postId
	self.actId = actId

	local coList = V3a4BBSConfig.instance:getBBSCoListByPostId(actId, postId)

	self.stepMoList = {}

	if coList then
		for _, co in pairs(coList) do
			local mo = V3a4BBSPostStepMO.New(co)

			table.insert(self.stepMoList, mo)
		end

		table.sort(self.stepMoList, function(a, b)
			return a.co.step < b.co.step
		end)
	end

	self._curStepId = 1
end

function V3a4BBSPostMO:getStepMoList()
	return self.stepMoList
end

function V3a4BBSPostMO:getCurStepId()
	return self._curStepId
end

function V3a4BBSPostMO:setCurStepId(step)
	if not step then
		local key = self:_getTriggerStepKey()
		local value = GameUtil.playerPrefsGetStringByUserId(key, "1#0")
		local split = string.splitToNumber(value, "#")

		step = split and split[1] or 1

		if split then
			if not split[2] then
				local triggerIndex = 0
				local mo = self.stepMoList[step]

				if mo then
					mo:setTriggerIndex(triggerIndex)
				end
			end
		end
	end

	if self._curStepId ~= step then
		self._curStepId = step

		local mo = self.stepMoList[step]

		if mo then
			mo:setTriggerIndex(0)
		end

		self:saveTriggerStep()
	end
end

function V3a4BBSPostMO:getCurStepMo()
	return self:getStepMo(self._curStepId)
end

function V3a4BBSPostMO:getNextStepMo()
	return self:getStepMo(self._curStepId + 1)
end

function V3a4BBSPostMO:getStepMo(step)
	return self.stepMoList[step]
end

function V3a4BBSPostMO:finishTrigger()
	local step = self:getCurStepMo()

	step:finishTrigger()
	self:saveTriggerStep()
end

function V3a4BBSPostMO:saveTriggerStep()
	local key = self:_getTriggerStepKey()
	local step = self:getCurStepMo()
	local value = self._curStepId .. "#" .. ((step and step:getTriggerIndex() or nil) and step:getTriggerIndex())

	GameUtil.playerPrefsSetStringByUserId(key, value)
end

function V3a4BBSPostMO:clearTriggerStep()
	local key = self:_getTriggerStepKey()
	local value = "1#0"

	GameUtil.playerPrefsSetStringByUserId(key, value)

	self._curStepId = 1

	for _, mo in ipairs(self.stepMoList) do
		mo:setTriggerIndex(0)
	end
end

function V3a4BBSPostMO:_getTriggerStepKey()
	return (string.format("V3a4BBSPostMO_%s_%s_%s", V3a4BBSEnum.PrefsKey.TriggerStep, self.actId, self.postId))
end

return V3a4BBSPostMO
