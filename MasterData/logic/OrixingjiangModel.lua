-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/model/OrixingjiangModel.lua

module("logic.extensions.orixingjiang.view.OrixingjiangModel", package.seeall)

local OrixingjiangModel = class("OrixingjiangModel", BaseModel)

function OrixingjiangModel:ctor()
	return
end

function OrixingjiangModel:onInit()
	self:onReset()
end

function OrixingjiangModel:onReset()
	self._msgInfos = {}
	self._fmtMo = OrixingjiangFmtMo.New()
end

function OrixingjiangModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].stageInfos = self._msgInfos[msg.activityId].stageInfos or {}

	for i, v in ipairs(self._msgInfos[msg.activityId].stageInfos) do
		v.banRaceIds = v.banRaceIds or {}
	end
end

function OrixingjiangModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function OrixingjiangModel:isStagesPass(activityId)
	local info = self:getInfo(activityId)
	local stageCfgs = OrixingjiangConfig.instance:getStageCfgs(activityId)

	if #info.stageInfos < #stageCfgs then
		return false
	end

	local actCfg = OrixingjiangConfig.instance:getActCfg(activityId)
	local num = 0

	for i, v in ipairs(info.stageInfos) do
		num = num + #v.banRaceIds
	end

	return num >= actCfg.passNeedAliveTransmog
end

function OrixingjiangModel:getStageInfo(activityId, stageId)
	local info = self:getInfo(activityId)

	if not info then
		return nil
	end

	for i, v in ipairs(info.stageInfos) do
		if v.stageId == stageId then
			return v
		end
	end

	return nil
end

function OrixingjiangModel:onResetRes(activityId, stageId)
	local info = self:getInfo(activityId)

	if not info then
		return
	end

	for i, v in ipairs(info.stageInfos) do
		if v.stageId == stageId then
			table.remove(info.stageInfos, i)

			break
		end
	end
end

function OrixingjiangModel:getFmtMo()
	return self._fmtMo
end

function OrixingjiangModel:getLockRaceIdMap(activityId)
	local info = self:getInfo(activityId)

	if not info then
		return {}
	end

	local map = {}

	for i, stageInfo in ipairs(info.stageInfos) do
		for i, v in ipairs(stageInfo.banRaceIds) do
			map[v] = true
		end
	end

	return map
end

function OrixingjiangModel:getTransmogCnt(activityId)
	local info = self:getInfo(activityId)

	if not info then
		return 0
	end

	local cnt = 0

	for i, v in ipairs(info.stageInfos) do
		cnt = cnt + ((v.banRaceIds or nil) and (#v.banRaceIds or 0))
	end

	return cnt
end

function OrixingjiangModel:onNotifyClgRes(msg, needBanRaceIds)
	local activityId = msg.activityId
	local stageId = msg.stageId
	local info = self:getInfo(activityId)

	if not info then
		return
	end

	local isHit = false

	for i, v in ipairs(info.stageInfos) do
		if v.stageId == stageId then
			v.banRaceIds = needBanRaceIds or {}
			isHit = true

			break
		end
	end

	if not isHit then
		table.insert(info.stageInfos, {
			stageId = stageId,
			banRaceIds = needBanRaceIds or {}
		})
	end
end

function OrixingjiangModel:getAliveTransmogNum(activityId)
	local info = self:getInfo(activityId)

	if not info then
		return 0
	end

	local cnt = 0

	for i, v in ipairs(info.stageInfos) do
		cnt = cnt + ((v.banRaceIds or nil) and (#v.banRaceIds or 0))
	end

	return cnt
end

function OrixingjiangModel:getStagePassNum(activityId)
	local info = self:getInfo(activityId)

	if not info then
		return 0
	end

	return #info.stageInfos
end

OrixingjiangModel.instance = OrixingjiangModel.New()

return OrixingjiangModel
