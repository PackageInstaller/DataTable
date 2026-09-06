-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roseclg/model/RoseclgModel.lua

module("logic.extensions.roseclg.view.RoseclgModel", package.seeall)

local RoseclgModel = class("RoseclgModel", BaseModel)

function RoseclgModel:ctor()
	return
end

function RoseclgModel:onInit()
	self:onReset()
end

function RoseclgModel:onReset()
	self._msgInfos = {}
	self._fmtMo = RoseClgFmtMo.New()
end

function RoseclgModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].petHpInfo = self._msgInfos[msg.activityId].petHpInfo or {}
	self._msgInfos[msg.activityId].oriPetHpInfo = self._msgInfos[msg.activityId].petHpInfo
end

function RoseclgModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function RoseclgModel:onClgReset(activityId)
	local info = self:getInfo(activityId)

	info.curPassStageId = 0
	info.curStageTeamPassInfo = {}
	info.petHpInfo = {}
end

function RoseclgModel:isChallenged(activityId, stageId, creepsMasterId)
	local info = self:getInfo(activityId)
	local stageCfg = RoseclgConfig.instance:getStageCfg(activityId, stageId)
	local idx = 0

	for i, v in ipairs(stageCfg.teams) do
		if v == creepsMasterId then
			idx = i

			break
		end
	end

	if info.curStageTeamPassInfo and info.curStageTeamPassInfo[idx] then
		return true
	end
end

function RoseclgModel:getFmtMo()
	return self._fmtMo
end

function RoseclgModel:onClgRes(msg)
	local msg = GameUtil.pbToTable(msg)

	if msg.win then
		local info = self:getInfo(msg.activityId)

		info.curStageTeamPassInfo = info.curStageTeamPassInfo or {}
		info.curStageTeamPassInfo[msg.teamIndex] = true

		local curFightPetHpInfoMap = {}

		for i, v in ipairs(msg.curFightPetHpInfo) do
			curFightPetHpInfoMap[v.left] = v
		end

		for i = 1, #info.petHpInfo do
			local hpInfo = info.petHpInfo[i]
			local newData = curFightPetHpInfoMap[hpInfo.left]

			if newData then
				hpInfo.mid = newData.mid
				hpInfo.right = newData.right
				curFightPetHpInfoMap[hpInfo.left] = nil
			end
		end

		for petId, v in pairs(curFightPetHpInfoMap) do
			table.insert(info.petHpInfo, v)
		end

		if msg.passStage then
			info.curPassStageId = msg.curFightStageId

			if msg.curFightStageId > info.historyPassStageId then
				info.historyPassStageId = msg.curFightStageId
			end

			info.curStageTeamPassInfo = {}
		end
	end
end

function RoseclgModel:getPetHpPercent(activityId, petId)
	local info = self:getInfo(activityId)

	if info.petHpInfo then
		for i, v in ipairs(info.petHpInfo) do
			if v.left == petId then
				if v.mid <= 0 then
					return 0
				end

				return Mathf.Clamp01(v.right / v.mid)
			end
		end
	end

	return 1
end

RoseclgModel.instance = RoseclgModel.New()

return RoseclgModel
