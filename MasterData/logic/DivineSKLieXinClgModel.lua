-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineskliexinclg/model/DivineSKLieXinClgModel.lua

module("logic.extensions.divineskliexinclg.model.DivineSKLieXinClgModel", package.seeall)

local DivineSKLieXinClgModel = class("DivineSKLieXinClgModel", BaseModel)

function DivineSKLieXinClgModel:ctor()
	return
end

function DivineSKLieXinClgModel:onInit()
	self:onReset()
end

function DivineSKLieXinClgModel:onReset()
	self._fmtMo = nil
	self._info = {}
	self._stageInfo = {}
	self._tempTagPos = {}
end

function DivineSKLieXinClgModel:savaInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._info[data.activityId] = data
	self._stageInfo[data.activityId] = {}

	if data.stageInfos then
		for i, v in ipairs(data.stageInfos) do
			self._stageInfo[data.activityId][v.stageId] = v
		end
	end
end

function DivineSKLieXinClgModel:savaChallengeInfo(msg)
	self._stageInfo[msg.activityId] = self._stageInfo[msg.activityId] or {}
	self._stageInfo[msg.activityId][msg.stageId] = self._stageInfo[msg.activityId][msg.stageId] or {}

	local info = self._stageInfo[msg.activityId][msg.stageId]

	info.stageId = msg.stageId
	info.reliveCount = msg.reliveCount
	info.tagCount = msg.tagCount
end

function DivineSKLieXinClgModel:getFmtMo()
	self._fmtMo = self._fmtMo or DivineSKLieXinClgFmtMo.New()

	return self._fmtMo
end

function DivineSKLieXinClgModel:getStageInfo(activityId, stageId)
	if self._stageInfo[activityId] then
		return self._stageInfo[activityId][stageId]
	end
end

function DivineSKLieXinClgModel:getTotalReliveCount(activityId)
	local total = 0

	if self._stageInfo[activityId] then
		for i, v in pairs(self._stageInfo[activityId]) do
			total = total + v.reliveCount
		end
	end

	return total
end

function DivineSKLieXinClgModel:getTotalPassStageCount(activityId)
	local total = 0

	if self._stageInfo[activityId] then
		for i, v in pairs(self._stageInfo[activityId]) do
			total = total + 1
		end
	end

	return total
end

function DivineSKLieXinClgModel:saveTempSelectStage(stageId)
	self.tempSelectStage = stageId
end

function DivineSKLieXinClgModel:getTempSelectStage()
	return self.tempSelectStage
end

function DivineSKLieXinClgModel:saveTempTagPos(stageId, map)
	self._tempTagPos[stageId] = map
end

function DivineSKLieXinClgModel:getTempTagPos(stageId)
	return self._tempTagPos[stageId]
end

function DivineSKLieXinClgModel:resetAllTempTagPos()
	self._tempTagPos = {}
end

function DivineSKLieXinClgModel:saveTempActivity(activityId)
	self._tempActivity = activityId
end

function DivineSKLieXinClgModel:getTempActivity()
	return self._tempActivity
end

DivineSKLieXinClgModel.instance = DivineSKLieXinClgModel.New()

return DivineSKLieXinClgModel
