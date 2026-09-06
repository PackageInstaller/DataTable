-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineqingguclg/model/DivineQingGuClgModel.lua

module("logic.extensions.divineqingguclg.model.DivineQingGuClgModel", package.seeall)

local DivineQingGuClgModel = class("DivineQingGuClgModel", BaseModel)

DivineQingGuClgModel.MaxLevelNum = 6

function DivineQingGuClgModel:onInit()
	self:onReset()
end

function DivineQingGuClgModel:onReset()
	self._agentDic = {}
end

function DivineQingGuClgModel:getAgentInfo(activityId)
	if not self._agentDic[activityId] then
		self._agentDic[activityId] = {}

		self:_initAgent(self._agentDic[activityId])
	end

	return self._agentDic[activityId]
end

function DivineQingGuClgModel:_initAgent(info)
	info.activityId = 0
	info.stageIdPassed = {}
	info.normalFmtMo = nil
end

function DivineQingGuClgModel:getActivityId()
	if self._activityId then
		return self._activityId
	end

	self._activityId = checknumber(DivineQingGuClgConfig.instance:getCommonValue("ACTIVITY_ID"))

	return self._activityId
end

function DivineQingGuClgModel:getNormalFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.normalFmtMo == nil then
		info.normalFmtMo = DivineQingGuClgFmtMo.New()
	end

	return info.normalFmtMo
end

function DivineQingGuClgModel:onGetInfoRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.stageIdPassed = GameUtil.pbToTable(msg.stageIdPassed) or {}
end

function DivineQingGuClgModel:onNotifyFightResultRes(msg)
	if msg.win then
		local info = self:getAgentInfo(msg.activityId)

		if not TableUtil.isHad(info.stageIdPassed, msg.stageId) then
			table.insert(info.stageIdPassed, msg.stageId)
		end
	end
end

function DivineQingGuClgModel:isPassStage(activityId, stageId)
	local info = self:getAgentInfo(activityId)

	return TableUtil.isHad(info.stageIdPassed, stageId)
end

DivineQingGuClgModel.instance = DivineQingGuClgModel.New()

return DivineQingGuClgModel
