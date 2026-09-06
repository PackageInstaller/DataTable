-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/model/DivineisaacclgModel.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgModel", package.seeall)

local DivineisaacclgModel = class("DivineisaacclgModel", BaseModel)

function DivineisaacclgModel:ctor()
	return
end

function DivineisaacclgModel:onInit()
	self:onReset()
end

function DivineisaacclgModel:onReset()
	self._msgInfos = {}
	self._fmtMo = nil
	self._usePuppetsMap = {}
end

function DivineisaacclgModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].curPhase.metals = self._msgInfos[msg.activityId].curPhase.metals or {}
	self._msgInfos[msg.activityId].curPhase.puppet = self._msgInfos[msg.activityId].curPhase.puppet or {}
	self._msgInfos[msg.activityId].curPhase.stages = self._msgInfos[msg.activityId].curPhase.stages or {}
end

function DivineisaacclgModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function DivineisaacclgModel:getFmtMo()
	self._fmtMo = self._fmtMo or DivineisaacclgFmtMo.New()

	return self._fmtMo
end

function DivineisaacclgModel:getMetalNum(activityId, metalId)
	local info = self:getInfo(activityId)

	if info.curPhase and info.curPhase.metals then
		for i, v in ipairs(info.curPhase.metals) do
			if v.metalId == metalId then
				return v.num
			end
		end
	end

	return 0
end

function DivineisaacclgModel:getPuppetNum(activityId, puppetId)
	local info = self:getInfo(activityId)

	if info.curPhase and info.curPhase.puppet then
		for i, v in ipairs(info.curPhase.puppet) do
			if v.puppetId == puppetId then
				return v.num
			end
		end
	end

	return 0
end

function DivineisaacclgModel:getStageMetalNum(activityId, stageId)
	local info = self:getInfo(activityId)

	if info.curPhase and info.curPhase.stages then
		for i, v in ipairs(info.curPhase.stages) do
			if v.stageId == stageId then
				return v.num
			end
		end
	end

	return 0
end

function DivineisaacclgModel:onProducePuppetRes(msg)
	local activityId = msg.activityId
	local phaseId = msg.phaseId
	local puppetId = msg.puppetId
	local info = self:getInfo(activityId)

	if phaseId > info.bestPhaseId then
		local hit = false

		for i, v in ipairs(info.curPhase.puppet) do
			if v.puppetId == puppetId then
				hit = true
				v.num = v.num + 1

				break
			end
		end

		if not hit then
			table.insert(info.curPhase.puppet, {
				num = 1,
				puppetId = puppetId
			})
		end
	end
end

function DivineisaacclgModel:onClgResetRes(activityId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.curPhase.puppet) do
		v.num = 0
	end

	for i, v in ipairs(info.curPhase.metals) do
		v.num = 0
	end

	for i, v in ipairs(info.curPhase.stages) do
		v.num = 0
	end

	info.curPhase.puppetNum = 0
end

function DivineisaacclgModel:setClgStageId(phaseId, stageId)
	self._curPhaseId = phaseId
	self._curStageId = stageId
end

function DivineisaacclgModel:getClgSatgeId()
	self._curPhaseId = self._curPhaseId or 0
	self._curStageId = self._curStageId or 0

	return self._curPhaseId, self._curStageId
end

function DivineisaacclgModel:setUsePuppets(activityId, phaseId, usePuppetsKv)
	self._usePuppetsMap[activityId] = self._usePuppetsMap[activityId] or {}
	self._usePuppetsMap[activityId][phaseId] = usePuppetsKv
end

function DivineisaacclgModel:getUsePuppets(activityId, phaseId, usePuppetsKv)
	if self._usePuppetsMap[activityId] and self._usePuppetsMap[activityId][phaseId] then
		return self._usePuppetsMap[activityId][phaseId]
	end

	return {}
end

function DivineisaacclgModel:resetUsePuppets(activityId)
	self._usePuppetsMap[activityId] = {}
end

DivineisaacclgModel.instance = DivineisaacclgModel.New()

return DivineisaacclgModel
