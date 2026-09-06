-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neweranuoya/model/NeweranuoyaModel.lua

module("logic.extensions.neweranuoya.view.NeweranuoyaModel", package.seeall)

local NeweranuoyaModel = class("NeweranuoyaModel", BaseModel)

function NeweranuoyaModel:ctor()
	return
end

function NeweranuoyaModel:onInit()
	self:onReset()
end

function NeweranuoyaModel:onReset()
	self._msgInfos = {}
	self._fmtMo = nil
end

function NeweranuoyaModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
end

function NeweranuoyaModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function NeweranuoyaModel:getFmtMo()
	self._fmtMo = self._fmtMo or NeweranuoyaFmtMo.New()

	return self._fmtMo
end

function NeweranuoyaModel:isExtStagePass(activityId, floorId, stageId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.NewEraNuoyaExtFloorInfos) do
		if v.floorId == floorId then
			return stageId <= v.maxPassStageId
		end
	end
end

function NeweranuoyaModel:isNormalStagePass(activityId, stageId)
	local info = self:getInfo(activityId)

	return stageId <= info.maxPassCommonStageId
end

function NeweranuoyaModel:onNotifyExtChallengeRes(msg)
	return
end

function NeweranuoyaModel:onNotifyCommonChallengeRes(msg)
	if msg.isWin then
		local info = self:getInfo(msg.activityId)

		info.maxPassCommonStageId = msg.stageId
	end
end

function NeweranuoyaModel:getBanRaceIdMap(activityId, floorId)
	local map = {}
	local info = self:getInfo(activityId)

	for _, floorInfo in ipairs(info.NewEraNuoyaExtFloorInfos) do
		if floorInfo.floorId == floorId then
			for _, stageInfo in ipairs(floorInfo.stageInfos) do
				if stageInfo.banRaceIdToIsDead then
					for j, pair in ipairs(stageInfo.banRaceIdToIsDead) do
						map[pair.left] = true
					end
				end
			end

			break
		end
	end

	return map
end

function NeweranuoyaModel:onResetFloorRes(msg)
	for i, floorId in ipairs(msg.floorId) do
		local floorInfo = self:getFloorInfo(msg.activityId, floorId)

		floorInfo.maxPassStageId = 0

		for _, stageInfo in ipairs(floorInfo.stageInfos) do
			stageInfo.banRaceIdToIsDead = {}
			stageInfo.jobIdToBuffNum = {}
		end
	end
end

function NeweranuoyaModel:getFloorInfo(activityId, floorId)
	local info = self:getInfo(activityId)

	for _, floorInfo in ipairs(info.NewEraNuoyaExtFloorInfos) do
		if floorInfo.floorId == floorId then
			return floorInfo
		end
	end
end

function NeweranuoyaModel:getExtStageFloorInfo(activityId, floorId, stageId)
	local floorInfo = self:getFloorInfo(activityId, floorId)

	for _, v in ipairs(floorInfo.stageInfos) do
		if v.stageId == stageId then
			return v
		end
	end
end

function NeweranuoyaModel:isPrizeGain(activityId, clgType, floorId, stageId)
	local info = self:getInfo(activityId)

	if clgType == NeweranuoyaController.ClgType.Normal then
		return stageId <= info.maxPassCommonStageId
	else
		local floorInfo = self:getFloorInfo(activityId, floorId)

		if not floorInfo.gainPrizeStageId then
			return false
		end

		return table.indexof(floorInfo.gainPrizeStageId, stageId)
	end
end

NeweranuoyaModel.instance = NeweranuoyaModel.New()

return NeweranuoyaModel
