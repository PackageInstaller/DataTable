-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/model/RecastGloryModel.lua

module("logic.extensions.recastglory.model.RecastGloryModel", package.seeall)

local RecastGloryModel = class("RecastGloryModel", BaseModel)

function RecastGloryModel:onInit()
	self:onReset()
end

function RecastGloryModel:onReset()
	self._restoryInfo = {}
	self._isRestoreSuccess = false
	self._rdTaskState = false
end

function RecastGloryModel:setInfos(msg)
	self._restoryInfo.restoreFinishId = checknumber(msg.restoreFinishId)
	self._restoryInfo.restoreRaceId = checknumber(msg.restoreRaceId)
	self._restoryInfo.finishNum = checknumber(msg.finishNum)
	self._restoryInfo.gainPrize = msg.gainProgressIds or {}
end

function RecastGloryModel:getRestoreFinishId()
	return self._restoryInfo.restoreFinishId or 0
end

function RecastGloryModel:getFinishNum()
	return self._restoryInfo.finishNum or 0
end

function RecastGloryModel:setGainPrize(msg)
	table.insert(self._restoryInfo.gainPrize, msg.progressId)
end

function RecastGloryModel:getGainPrize()
	return self._restoryInfo.gainPrize or {}
end

function RecastGloryModel:getHasGainPrize(prizeId)
	return self._restoryInfo.gainPrize and TableUtil.isHad(self._restoryInfo.gainPrize, prizeId)
end

function RecastGloryModel:getRestoreRaceId()
	return self._restoryInfo.restoreRaceId
end

function RecastGloryModel:setRestoreState(state)
	self._isRestoreSuccess = state
end

function RecastGloryModel:getRestoreState()
	return self._isRestoreSuccess
end

RecastGloryModel.instance = RecastGloryModel.New()

return RecastGloryModel
