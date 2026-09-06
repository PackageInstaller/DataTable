-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/model/DivinewatertianyanModel.lua

module("logic.extensions.divinewatertianyan.view.DivinewatertianyanModel", package.seeall)

local DivinewatertianyanModel = class("DivinewatertianyanModel", BaseModel)

function DivinewatertianyanModel:ctor()
	return
end

function DivinewatertianyanModel:onInit()
	self:onReset()
end

function DivinewatertianyanModel:onReset()
	self._msgInfos = {}
	self._fmtMo = nil
	self._currStageType = nil
end

function DivinewatertianyanModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].stageList = self._msgInfos[msg.activityId].stageList or {}
	self._msgInfos[msg.activityId].unlockBuffIds = self._msgInfos[msg.activityId].unlockBuffIds or {}
end

function DivinewatertianyanModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function DivinewatertianyanModel:getFmtMo()
	self._fmtMo = self._fmtMo or DivinewatertianyanFmtMo.New()

	return self._fmtMo
end

function DivinewatertianyanModel:isStagePass(activityId, stageId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.stageList) do
		if v.stageId == stageId and v.isPass then
			return true
		end
	end

	return false
end

function DivinewatertianyanModel:isStageTypePass(activityId, stageType)
	local info = self:getInfo(activityId)
	local map = {}

	for i, v in ipairs(info.stageList) do
		map[v.stageId] = v
	end

	local cfgs = DivinewatertianyanConfig.instance:getStageCfgs(activityId)

	for i, v in ipairs(cfgs) do
		if v.stageType == stageType and (not map[v.stageId] or not map[v.stageId].isPass) then
			return false
		end
	end

	return true
end

function DivinewatertianyanModel:isAllStagePass(activityId)
	local info = self:getInfo(activityId)
	local cfgs = DivinewatertianyanConfig.instance:getStageCfgs(activityId)
	local cnt = #info.stageList

	if cnt <= 0 or cnt ~= #cfgs then
		return false
	end

	for i, v in ipairs(info.stageList) do
		if not v.isPass then
			return false
		end
	end

	return true
end

function DivinewatertianyanModel:getFireNum(activityId)
	local info = self:getInfo(activityId)

	return info.leftFireCount
end

function DivinewatertianyanModel:onUnlockBuffRes(msg)
	local info = self:getInfo(msg.activityId)

	info.leftFireCount = msg.leftFireCount

	table.insert(info.unlockBuffIds, msg.buffId)
end

function DivinewatertianyanModel:isBuffUnlock(activityId, buffId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.unlockBuffIds) do
		if buffId == v then
			return true
		end
	end

	return false
end

function DivinewatertianyanModel:onBattleSuccessRes(msg)
	local stageCfg = DivinewatertianyanConfig.instance:getStageCfg(msg.activityId, msg.stageId)

	if stageCfg.stageType == DivinewatertianyanController.StageType.Fire then
		if not msg.isWin then
			local isWin = msg.isPass
			local stageInfo
			local info = self:getInfo(msg.activityId)

			for i, v in ipairs(info.stageList) do
				if msg.stageId == v.stageId then
					stageInfo = v

					break
				end
			end

			if not stageInfo then
				stageInfo = {
					stageSaveValue = 0,
					stageId = msg.stageId,
					isPass = isWin
				}

				table.insert(info.stageList, stageInfo)
			end

			stageInfo.stageSaveValue = msg.curStageValue
			stageInfo.isPass = isWin

			if isWin then
				info.leftFireCount = msg.leftFireCount
			end
		end
	end
end

function DivinewatertianyanModel:getStageSaveValue(activityId, stageId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.stageList) do
		if v.stageId == stageId then
			return v.stageSaveValue
		end
	end

	return 0
end

function DivinewatertianyanModel:setCurrStageType(stageType)
	self._currStageType = stageType
end

function DivinewatertianyanModel:getCurrStageType()
	return self._currStageType
end

DivinewatertianyanModel.instance = DivinewatertianyanModel.New()

return DivinewatertianyanModel
