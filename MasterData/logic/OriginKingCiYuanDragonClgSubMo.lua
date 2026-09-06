-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingciyuandragonclg/data/OriginKingCiYuanDragonClgSubMo.lua

module("logic.extensions.originkingciyuandragonclg.data.OriginKingCiYuanDragonClgSubMo", package.seeall)

local OriginKingCiYuanDragonClgSubMo = class("OriginKingCiYuanDragonClgSubMo")

function OriginKingCiYuanDragonClgSubMo:ctor(activityId)
	self._activityId = activityId

	self:_resetData()
end

function OriginKingCiYuanDragonClgSubMo:_resetData()
	self._stageMap = {}
	self._gainFirstPassPrize = false
	self._fightResultMsg = nil
end

function OriginKingCiYuanDragonClgSubMo:dispose()
	self:_resetData()
end

function OriginKingCiYuanDragonClgSubMo:handlePM_OriginKingCiYuanDragonClgGetInfoRes(msg)
	table.clear(self._stageMap)

	for _, v in ipairs(msg.stageList) do
		self._stageMap[v.stageId] = v
	end

	self._gainFirstPassPrize = msg.gainFirstPassPrize
end

function OriginKingCiYuanDragonClgSubMo:handlePM_OriginKingCiYuanDragonClgNotifyFightRes(msg)
	self._fightResultMsg = msg
end

function OriginKingCiYuanDragonClgSubMo:handlePM_OriginKingCiYuanDragonClgConfirmRes(msg)
	self._stageMap[msg.stage.stageId] = msg.stage
	self._gainFirstPassPrize = msg.gainFirstPassPrize

	if msg:HasField("changeSetId") then
		self._changeSetId = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self._changeSetId)
	end
end

function OriginKingCiYuanDragonClgSubMo:handlePM_OriginKingCiYuanDragonClgResetRes(msg)
	table.clear(self._stageMap)

	for _, v in ipairs(msg.stageList) do
		self._stageMap[v.stageId] = v
	end
end

function OriginKingCiYuanDragonClgSubMo:getBlockCount()
	local cfg = OriginKingCiYuanDragonClgConfig.instance:getStageBlockCfg(self._activityId)

	return (cfg or nil) and (#cfg or 0)
end

function OriginKingCiYuanDragonClgSubMo:isBlockPass(blockId)
	local max = self:getStageCount(blockId)
	local cur = self:getPassStageCount(blockId)

	return max <= cur
end

function OriginKingCiYuanDragonClgSubMo:getProgressInBlock(blockId)
	local max = self:getStageCount(blockId)
	local cur = self:getPassStageCount(blockId)

	return (max > 0 or nil) and cur / max
end

function OriginKingCiYuanDragonClgSubMo:getPassStageCount(blockId)
	local count = 0
	local datas = OriginKingCiYuanDragonClgConfig.instance:getStageDatasByBlock(self._activityId, blockId)

	if datas then
		for _, v in ipairs(datas) do
			if self:isStagePass(v.stageId) then
				count = count + 1
			else
				break
			end
		end
	end

	return count
end

function OriginKingCiYuanDragonClgSubMo:getLatestPassStageId(blockId)
	local stageId = 0
	local datas = OriginKingCiYuanDragonClgConfig.instance:getStageDatasByBlock(self._activityId, blockId)

	for _, v in ipairs(datas) do
		if self:isStagePass(v.stageId) then
			stageId = v.stageId
		else
			break
		end
	end

	return stageId
end

function OriginKingCiYuanDragonClgSubMo:getLatestUnpassStageId(blockId)
	local stageId = 0
	local datas = OriginKingCiYuanDragonClgConfig.instance:getStageDatasByBlock(self._activityId, blockId)

	for _, v in ipairs(datas) do
		stageId = v.stageId

		if not self:isStagePass(v.stageId) then
			break
		end
	end

	return stageId
end

function OriginKingCiYuanDragonClgSubMo:getStageCount(blockId)
	local datas = OriginKingCiYuanDragonClgConfig.instance:getStageDatasByBlock(self._activityId, blockId)

	return (datas or nil) and (#datas or 0)
end

function OriginKingCiYuanDragonClgSubMo:isStagePass(stageId)
	local info = self:getStageInfo(stageId)

	return (info or nil) and (info.isPass or false)
end

function OriginKingCiYuanDragonClgSubMo:getLockRaceIds(stageId)
	local info = self:getStageInfo(stageId)

	return (info or nil) and (info.lockRaceIds or {})
end

function OriginKingCiYuanDragonClgSubMo:getStageInfo(stageId)
	return self._stageMap[stageId]
end

function OriginKingCiYuanDragonClgSubMo:hasGainFirstPassPrize()
	return self._gainFirstPassPrize
end

function OriginKingCiYuanDragonClgSubMo:getFightResultMsg()
	return self._fightResultMsg
end

function OriginKingCiYuanDragonClgSubMo:popChangeSetId()
	self._changeSetId = nil

	return self._changeSetId
end

return OriginKingCiYuanDragonClgSubMo
