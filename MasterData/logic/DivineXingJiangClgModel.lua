-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/model/DivineXingJiangClgModel.lua

module("logic.extensions.divinexingjiangclg.model.DivineXingJiangClgModel", package.seeall)

local DivineXingJiangClgModel = class("DivineXingJiangClgModel", BaseModel)

function DivineXingJiangClgModel:onInit()
	self:onReset()
end

function DivineXingJiangClgModel:onReset()
	self._agentDic = {}
end

function DivineXingJiangClgModel:getAgentInfo(activityId)
	if not self._agentDic[activityId] then
		self._agentDic[activityId] = {}

		self:_initAgent(self._agentDic[activityId])
	end

	return self._agentDic[activityId]
end

function DivineXingJiangClgModel:_initAgent(info)
	info.activityId = 0
	info.clgPassed = false
	info.stageInfo = {}
	info.buffProgress = 0
	info.todayHasPlayGameCount = 0
	info.customFmtMo = nil
end

function DivineXingJiangClgModel:getActivityId()
	if self._activityId then
		return self._activityId
	end

	self._activityId = checknumber(DivineXingJiangClgConfig.instance:getCommonValue("ACTIVITY_ID"))

	return self._activityId
end

function DivineXingJiangClgModel:getCustomFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.customFmtMo == nil then
		info.customFmtMo = DivineXingJiangClgFmtMo.New()
	end

	return info.customFmtMo
end

function DivineXingJiangClgModel:onGetInfoRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.activityId = msg.activityId
	info.clgPassed = msg.clgPassed
	info.stageInfo = GameUtil.pbToTable(msg.stageInfo) or {}
	info.buffProgress = msg:HasField("buffProgress") and msg.buffProgress or 0
	info.todayHasPlayGameCount = msg:HasField("todayHasPlayGameCount") and msg.todayHasPlayGameCount or 0
end

function DivineXingJiangClgModel:onFightRes(msg)
	return
end

function DivineXingJiangClgModel:onNotifyFightResultRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.win = msg.win

	if msg.win then
		if msg:HasField("clgPassed") then
			info.clgPassed = msg.clgPassed
		end

		local isUpdate = false

		for i, v in ipairs(info.stageInfo) do
			if v.stageId == msg.stageId then
				isUpdate = true
				v.activePosId = GameUtil.pbToTable(msg.activePosId) or {}
			end
		end

		if not isUpdate then
			local item = {}

			item.stageId = msg.stageId
			item.activePosId = GameUtil.pbToTable(msg.activePosId) or {}

			table.insert(info.stageInfo, item)
		end
	end
end

function DivineXingJiangClgModel:onPlayGameRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.buffProgress = msg.buffProgress
	info.todayHasPlayGameCount = info.todayHasPlayGameCount + 1
end

function DivineXingJiangClgModel:isPassStage(activityId, stageId)
	local info = self:getAgentInfo(activityId)

	if info.clgPassed then
		return true
	end

	local cfgSameTeam = DivineXingJiangClgConfig.instance:getSameTeamStageCfg(activityId, stageId)

	if cfgSameTeam then
		local isPassSelfStage = false
		local isPassSameTeamStage = false
		local sameTeamStageId = cfgSameTeam.stageId
		local tempActivePosIds = {}

		for i, v in ipairs(info.stageInfo) do
			if v.stageId == stageId then
				isPassSelfStage = true

				if v.activePosId then
					for _, pos in ipairs(v.activePosId) do
						if not TableUtil.isHad(tempActivePosIds, pos) then
							table.insert(tempActivePosIds, pos)
						end
					end
				end
			end

			if v.stageId == sameTeamStageId then
				isPassSameTeamStage = true

				if v.activePosId then
					for _, pos in ipairs(v.activePosId) do
						if not TableUtil.isHad(tempActivePosIds, pos) then
							table.insert(tempActivePosIds, pos)
						end
					end
				end
			end
		end

		return isPassSelfStage and isPassSameTeamStage and self:isActiveAllPos(activityId, stageId, tempActivePosIds)
	end

	return false
end

function DivineXingJiangClgModel:isActiveSelfStageAllPos(activityId, stageId)
	local info = self:getAgentInfo(activityId)
	local tempActivePosIds = {}

	for i, v in ipairs(info.stageInfo) do
		if v.stageId == stageId and v.activePosId then
			for _, pos in ipairs(v.activePosId) do
				if not TableUtil.isHad(tempActivePosIds, pos) then
					table.insert(tempActivePosIds, pos)
				end
			end
		end
	end

	return self:isActiveAllPos(activityId, stageId, tempActivePosIds)
end

function DivineXingJiangClgModel:isActiveAllPos(activityId, stageId, activePosIdList)
	if activePosIdList and #activePosIdList > 0 then
		local cfgStage = DivineXingJiangClgConfig.instance:getStageCfg(activityId, stageId)

		if cfgStage then
			local cfgStarAtlas = DivineXingJiangClgConfig.instance:getStarAtlasCfg(cfgStage.starAtlasId)
			local count1 = #activePosIdList
			local count2 = #cfgStarAtlas.posIds

			if count2 <= count1 then
				local activeNum = 0

				for i, pos1 in ipairs(cfgStarAtlas.posIds) do
					for i, pos2 in ipairs(activePosIdList) do
						if pos1 == pos2 then
							activeNum = activeNum + 1

							break
						end
					end
				end

				if count2 <= activeNum then
					return true
				end
			end
		else
			return false
		end
	else
		return false
	end
end

function DivineXingJiangClgModel:getTodayHasPlayGameCount(activityId)
	local info = self:getAgentInfo(activityId)

	return info.todayHasPlayGameCount
end

function DivineXingJiangClgModel:getBuffProgress(activityId)
	local info = self:getAgentInfo(activityId)

	return info.buffProgress
end

function DivineXingJiangClgModel:isActivePos(activityId, stageId, pos)
	local info = self:getAgentInfo(activityId)

	if info.stageInfo and #info.stageInfo > 0 then
		for i, v in ipairs(info.stageInfo) do
			if v.stageId == stageId and v.activePosId and #v.activePosId > 0 then
				for _, activePosId in ipairs(v.activePosId) do
					if activePosId == pos then
						return true
					end
				end
			end
		end
	end

	return false
end

DivineXingJiangClgModel.instance = DivineXingJiangClgModel.New()

return DivineXingJiangClgModel
