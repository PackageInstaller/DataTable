-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinesuperdragon/model/DivinesuperdragonModel.lua

module("logic.extensions.divinesuperdragon.view.DivinesuperdragonModel", package.seeall)

local DivinesuperdragonModel = class("DivinesuperdragonModel", BaseModel)

function DivinesuperdragonModel:ctor()
	return
end

function DivinesuperdragonModel:onInit()
	self:onReset()
end

function DivinesuperdragonModel:onReset()
	self._fmtMo = nil
	self._msgInfos = {}
	self._lastSuperStageViewStageIds = {}
end

function DivinesuperdragonModel:getFmtMo()
	self._fmtMo = self._fmtMo or DivinesuperdragonFmtMo.New()

	return self._fmtMo
end

function DivinesuperdragonModel:setInfo(msg)
	self._msgInfos[msg.activityId] = msg
end

function DivinesuperdragonModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function DivinesuperdragonModel:getPassMaxBuffStageId(activityId)
	local info = self:getInfo(activityId)

	if info then
		local stageId = 0

		for i, v in ipairs(info.buffStageIdPassed) do
			if stageId < v then
				stageId = v
			end
		end

		return stageId
	end

	return 0
end

function DivinesuperdragonModel:getSuperStageProgress(activityId)
	local info = self:getInfo(activityId)

	if info then
		return info.superStageProgress
	end

	return 0
end

function DivinesuperdragonModel:getLastSuperStageViewStageId(activityId)
	return self._lastSuperStageViewStageIds[activityId] or 0
end

function DivinesuperdragonModel:setLastSuperStageViewStageId(activityId, stageId)
	self._lastSuperStageViewStageIds[activityId] = stageId
end

function DivinesuperdragonModel:updateSuperStageProgress(activityId, superStageProgress)
	local info = self:getInfo(activityId)

	if info then
		info.superStageProgress = superStageProgress
	end
end

function DivinesuperdragonModel:updateBuffStageProgress(activityId, stageId)
	local info = self:getInfo(activityId)

	if info and not table.indexof(info.buffStageIdPassed, stageId) then
		info.buffStageIdPassed:append(stageId)
	end
end

function DivinesuperdragonModel:isBuffStagePass(activityId, stageId)
	local info = self:getInfo(activityId)

	if info then
		for i, v in ipairs(info.buffStageIdPassed) do
			if v == stageId then
				return true
			end
		end
	end

	return false
end

DivinesuperdragonModel.instance = DivinesuperdragonModel.New()

return DivinesuperdragonModel
