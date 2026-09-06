-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/model/ShadowdragonclgModel.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclgModel", package.seeall)

local ShadowdragonclgModel = class("ShadowdragonclgModel", BaseModel)

function ShadowdragonclgModel:ctor()
	return
end

function ShadowdragonclgModel:onInit()
	self:onReset()
end

function ShadowdragonclgModel:onReset()
	self._msgInfos = {}
	self._fmtMo = nil
end

function ShadowdragonclgModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)

	self:_setDefultValue(msg.activityId)
end

function ShadowdragonclgModel:_setDefultValue(activityId)
	for i, v in ipairs(self._msgInfos[activityId].nowStageList) do
		v.activeRacePosList = v.activeRacePosList or {}
		v.dieRacePosList = v.dieRacePosList or {}
	end
end

function ShadowdragonclgModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function ShadowdragonclgModel:getFmtMo()
	self._fmtMo = self._fmtMo or ShadowdragonclgFmtMo.New()

	return self._fmtMo
end

function ShadowdragonclgModel:getPassFuturePetRaceIds(activityId, isFuture)
	local info = self:getInfo(activityId)
	local petRaceIds = {}

	for i, v in ipairs(info.nowStageList) do
		if isFuture then
			for _, p in ipairs(v.activeRacePosList) do
				table.insert(petRaceIds, p.left)
			end
		else
			for _, p in ipairs(v.dieRacePosList) do
				table.insert(petRaceIds, p.left)
			end
		end
	end

	return petRaceIds
end

function ShadowdragonclgModel:getNowStageSelectBuffId(activityId, stageId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.nowStageList) do
		if v.stageId == stageId then
			return v.selectBuffId
		end
	end

	return -1
end

function ShadowdragonclgModel:isFloorPass(activityId, floorType)
	local info = self:getInfo(activityId)

	if floorType == ShadowdragonclgController.FloorType.Now then
		return info.passNowTier
	else
		return info.passFuturePassTier
	end
end

function ShadowdragonclgModel:isAllFloorPass(activityId)
	local info = self:getInfo(activityId)

	if not info.passNowTier or not info.passFuturePassTier then
		return false
	end

	for i, v in ipairs(info.nowStageList) do
		if not v.pass then
			return false
		end
	end

	for i, v in ipairs(info.futurePassStageList) do
		if not v.pass then
			return false
		end
	end

	return true
end

function ShadowdragonclgModel:isStagePass(activityId, floorType, stageId)
	local info = self:getInfo(activityId)

	if floorType == ShadowdragonclgController.FloorType.Now then
		for i, v in ipairs(info.nowStageList) do
			if v.stageId == stageId then
				return v.pass
			end
		end
	elseif floorType == ShadowdragonclgController.FloorType.PassFuture then
		for i, v in ipairs(info.futurePassStageList) do
			if v.stageId == stageId then
				return v.pass
			end
		end
	end
end

function ShadowdragonclgModel:onConfirmRes(msg)
	local info = self:getInfo(msg.activityId)

	info.passNowTier = msg.passNowTier

	for i, v in ipairs(info.nowStageList) do
		if v.stageId == msg.stageId then
			info.nowStageList[i] = GameUtil.pbToTable(msg.nowStage)

			self:_setDefultValue(msg.activityId)

			break
		end
	end
end

function ShadowdragonclgModel:getNowStageLockPetRaceIdMap(activityId)
	local map = {}
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.nowStageList) do
		for _, p in ipairs(v.activeRacePosList) do
			map[p.left] = p.left
		end

		for _, p in ipairs(v.dieRacePosList) do
			map[p.left] = p.left
		end
	end

	return map
end

function ShadowdragonclgModel:getPassFutureStageLockPetRaceIdMap(activityId, stageId)
	local stageCfg = ShadowdragonclgConfig.instance:getFuturePassStageCfg(activityId, stageId)
	local map = {}
	local bagpets = BagPetsController.instance:getFightBagPet()

	for i, v in ipairs(bagpets) do
		map[v.raceId] = v.raceId
	end

	local info = self:getInfo(activityId)

	for i, v in ipairs(info.nowStageList) do
		if stageCfg.type == ShadowdragonclgController.PassFutureStageType.Pass then
			for _, p in ipairs(v.dieRacePosList) do
				map[p.left] = nil
			end
		end

		if stageCfg.type == ShadowdragonclgController.PassFutureStageType.Future then
			for _, p in ipairs(v.activeRacePosList) do
				map[p.left] = nil
			end
		end
	end

	return map
end

function ShadowdragonclgModel:onSelectBuffRes(msg)
	local info = self:getInfo(msg.activityId)

	for i, v in ipairs(info.nowStageList) do
		if v.stageId == msg.stageId then
			v.selectBuffId = msg.selectBuffId

			break
		end
	end
end

function ShadowdragonclgModel:onResetAllStageRes(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self:getInfo(msg.activityId)

	info.nowStageList = data.nowStageList
	info.futurePassStageList = data.futurePassStageList

	self:_setDefultValue(data.activityId)
end

function ShadowdragonclgModel:onFuturePassStageFightNotifyRes(msg)
	if msg.isWin then
		local info = self:getInfo(msg.activityId)

		info.passFuturePassTier = msg.passFuturePassTier

		for i, v in ipairs(info.futurePassStageList) do
			if v.stageId == msg.stageId then
				v.pass = true

				if msg.useBuff then
					v.param = checknumber(msg.param)
				end

				break
			end
		end
	end
end

ShadowdragonclgModel.instance = ShadowdragonclgModel.New()

return ShadowdragonclgModel
