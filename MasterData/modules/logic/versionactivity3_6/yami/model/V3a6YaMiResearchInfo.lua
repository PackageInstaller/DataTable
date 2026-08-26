-- chunkname: @modules/logic/versionactivity3_6/yami/model/V3a6YaMiResearchInfo.lua

module("modules.logic.versionactivity3_6.yami.model.V3a6YaMiResearchInfo", package.seeall)

local V3a6YaMiResearchInfo = class("V3a6YaMiResearchInfo")

function V3a6YaMiResearchInfo:refreshInfo(info)
	self.status = info.status
	self.startTime = info.startTime
	self.endTime = info.endTime
	self.materialIds = {}
	self.subType = nil

	if info.materialIds then
		self.subType = info.materialIds[1]

		for i = 2, #info.materialIds do
			table.insert(self.materialIds, info.materialIds[i])
		end
	end

	self.researchers = {}

	if info.researchers then
		for i = 1, #info.researchers do
			table.insert(self.researchers, info.researchers[i])
		end
	end

	self.invention = info.invention
	self._stepDict = {}
	self._attrMos = self._attrMos or {}

	self:setPerformPauseSecond(info.pauseSecond or 0)

	self._totalTime = 0

	if info.steps then
		for i = 1, #info.steps do
			local _info = info.steps[i]

			self._attrMos[i] = self._attrMos[i] or V3a6YaMiAttrMO.New()

			self._attrMos[i]:refreshInfo(_info.attr)

			local second = _info.second
			local step = {
				index = i,
				second = second,
				type = _info.type,
				researcherId = _info.researcherId,
				skillId = _info.skillId,
				effectId = _info.effectId,
				attr = self._attrMos[i],
				extString = _info.extString,
				isFinish = i == #info.steps
			}

			if second > self._totalTime then
				self._totalTime = second
			end

			self._stepDict[second] = self._stepDict[second] or {}

			table.insert(self._stepDict[second], step)
		end
	end

	self._isFinishResearch = false
end

function V3a6YaMiResearchInfo:getSecondStepInfos(second)
	if self._stepDict then
		return self._stepDict[second]
	end
end

function V3a6YaMiResearchInfo:getTotalTime()
	return V3a6YaMiConfig.instance:getConstValueByConst(V3a6YaMiEnum.ConstId.PerformTime)
end

function V3a6YaMiResearchInfo:isFinishResearch()
	return self._isFinishResearch
end

function V3a6YaMiResearchInfo:onFinishResearch()
	self._isFinishResearch = true
end

function V3a6YaMiResearchInfo:getStepInfos()
	return self._stepDict
end

function V3a6YaMiResearchInfo:getResearchMaterials()
	return self.subType, self.materialIds
end

function V3a6YaMiResearchInfo:getResearchHeros()
	return self.researchers
end

function V3a6YaMiResearchInfo:setPerformPauseSecond(second)
	self._pauseSecond = second
end

function V3a6YaMiResearchInfo:getPerformPauseSecond()
	return self._pauseSecond or 0
end

return V3a6YaMiResearchInfo
