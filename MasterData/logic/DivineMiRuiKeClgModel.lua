-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiruikeclg/model/DivineMiRuiKeClgModel.lua

module("logic.extensions.divinemiruikeclg.model.DivineMiRuiKeClgModel", package.seeall)

local DivineMiRuiKeClgModel = class("DivineMiRuiKeClgModel", BaseModel)

function DivineMiRuiKeClgModel:onInit()
	self:onReset()
end

function DivineMiRuiKeClgModel:onReset()
	self._agentDic = {}
end

function DivineMiRuiKeClgModel:getAgentInfo(activityId)
	if not self._agentDic[activityId] then
		self._agentDic[activityId] = {}

		self:_initAgent(self._agentDic[activityId])
	end

	return self._agentDic[activityId]
end

function DivineMiRuiKeClgModel:_initAgent(info)
	info.curPhaseId = 1
	info.curStageId = 1
	info.activeBuffId = {}
	info.curFightPhaseId = 0
	info.curFightStageId = 0
	info.normalFmtMo = nil
end

function DivineMiRuiKeClgModel:getActivityId()
	if self._activityId then
		return self._activityId
	end

	self._activityId = checknumber(DivineMiRuiKeClgConfig.instance:getCommonValue("ACTIVITY_ID"))

	return self._activityId
end

function DivineMiRuiKeClgModel:getNormalFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.normalFmtMo == nil then
		info.normalFmtMo = DivineMiRuiKeClgFmtMo.New()
	end

	return info.normalFmtMo
end

function DivineMiRuiKeClgModel:onGetInfoRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.curPhaseId = msg.curPhaseId
	info.curStageId = msg.curStageId
	info.activeBuffId = GameUtil.pbToTable(msg.activeBuffId) or {}
end

function DivineMiRuiKeClgModel:onNotifyFightResultRes(msg)
	if msg.win then
		local info = self:getAgentInfo(msg.activityId)

		if msg:HasField("newPhaseId") then
			info.curPhaseId = msg.newPhaseId
		end

		if msg:HasField("newStageId") then
			info.curStageId = msg.newStageId
		end
	end
end

function DivineMiRuiKeClgModel:getCurPhaseId(activityId)
	local info = self:getAgentInfo(activityId)

	return info.curPhaseId
end

function DivineMiRuiKeClgModel:getCurStageId(activityId)
	local info = self:getAgentInfo(activityId)

	return info.curStageId
end

function DivineMiRuiKeClgModel:isPassAll(activityId)
	local info = self:getAgentInfo(activityId)

	return info.curPhaseId > 3 or info.curPhaseId < 0
end

DivineMiRuiKeClgModel.instance = DivineMiRuiKeClgModel.New()

return DivineMiRuiKeClgModel
