-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineshikonglongzunmainview/model/DivineShiKongLongZunModel.lua

module("logic.extensions.divineshikonglongzunmainview.model.DivineShiKongLongZunModel", package.seeall)

local DivineShiKongLongZunModel = class("DivineShiKongLongZunModel", BaseModel)

function DivineShiKongLongZunModel:ctor()
	return
end

function DivineShiKongLongZunModel:onInit()
	self:onReset()
end

function DivineShiKongLongZunModel:onReset()
	self._ModelPool = {}
	self._customFmtMoPool = {}
	self._changeSetIdList = {}
end

function DivineShiKongLongZunModel:GetModel(activityId)
	if self._ModelPool[activityId] == nil then
		local curModel = {}

		curModel.passStageId = 0
		curModel.teamScores = {}
		curModel.lastStageTeamScores = {}
		curModel.resNeedConfirm = false
		curModel.resPassStage = false
		curModel.resScore = {
			0,
			0
		}
		curModel.resTeamIndex = 0
		curModel.resStageId = 0
		self._ModelPool[activityId] = curModel
	end

	return self._ModelPool[activityId]
end

function DivineShiKongLongZunModel:addChangeSetId(value)
	table.insert(self._changeSetIdList, value)
end

function DivineShiKongLongZunModel:getChangeSetIdCount()
	return #self._changeSetIdList
end

function DivineShiKongLongZunModel:popChangeSetId()
	return table.remove(self._changeSetIdList, #self._changeSetIdList)
end

function DivineShiKongLongZunModel:handlePM_DivineTSDragonLordClgGetInfoRes(_msg)
	local msg = GameUtil.pbToTable(_msg)
	local curModel = self:GetModel(msg.activityId)

	curModel.teamScores = msg.teamScores or {}
	curModel.lastStageTeamScores = msg.lastStageTeamScores or {}
	curModel.passStageId = msg.passStageId

	if #curModel.teamScores == 0 then
		curModel.teamScores = curModel.lastStageTeamScores
	end
end

function DivineShiKongLongZunModel:handlePM_DivineTSDragonLordClgConfirmScoreRes(_msg)
	local curModel = self:GetModel(_msg.activityId)
	local teamIndex = _msg.teamIndex
	local score = _msg.curScore

	if score and score.left + score.right > 0 then
		curModel.teamScores[teamIndex].left = score.left
		curModel.teamScores[teamIndex].right = score.right
	end

	curModel.resPassStage = checkbool(_msg.passStage)
end

function DivineShiKongLongZunModel:handlePM_Notify_DivineTSDragonLordClgChallengeEndRes(_msg)
	local curModel = self:GetModel(_msg.activityId)

	curModel.resNeedConfirm = _msg.needConfirm
	curModel.resTeamIndex = _msg.teamIndex
	curModel.resScore[1] = _msg.score.left
	curModel.resScore[2] = _msg.score.right
	curModel.resPassStage = checkbool(_msg.passStage)
	curModel.resStageId = _msg.stageId
end

function DivineShiKongLongZunModel:getCurShowStageId(activityId)
	local curModel = self:GetModel(activityId)
	local stageNum = DivineShiKongLongZunConfig.instance:getStageTotalNum(activityId)

	if stageNum <= curModel.passStageId then
		return curModel.passStageId
	end

	if #curModel.lastStageTeamScores > 0 and self:isOpenTime(activityId, curModel.passStageId + 1) then
		return curModel.passStageId + 1
	end

	return curModel.passStageId == 0 and 1 or curModel.passStageId
end

function DivineShiKongLongZunModel:isOpenTime(activityId, stageId)
	local stageCfg = DivineShiKongLongZunConfig.instance:getStageData(activityId, stageId)
	local startTime = ActivityDefineController.instance:getStartTimeAndEndTime(DivineShiKongLongZunController.instance:getActivityType(), activityId)

	return (stageCfg.openDay - 1) * 86400 + startTime <= ServerTime.now()
end

function DivineShiKongLongZunModel:getStageTeamScore(activityId, stageId, teamId)
	local curModel = self:GetModel(activityId)
	local arr = {
		0,
		0
	}
	local showStageId = self:getCurShowStageId(activityId)
	local stageNum = DivineShiKongLongZunConfig.instance:getStageTotalNum(activityId)

	if stageNum >= showStageId + 1 then
		if not (showStageId + 1) then
			local nextShowStageId = showStageId

			if self:isOpenTime(activityId, nextShowStageId) or showStageId ~= curModel.passStageId then
				if curModel.teamScores and #curModel.teamScores > 0 then
					if curModel.teamScores[teamId] then
						arr[1] = curModel.teamScores[teamId].left or 0
					end

					if curModel.teamScores[teamId] then
						arr[2] = curModel.teamScores[teamId].right or 0
					end
				end
			elseif curModel.lastStageTeamScores and #curModel.lastStageTeamScores > 0 then
				if curModel.lastStageTeamScores[teamId] then
					arr[1] = curModel.lastStageTeamScores[teamId].left or 0
				end

				if curModel.lastStageTeamScores[teamId] then
					arr[2] = curModel.lastStageTeamScores[teamId].right or 0
				end
			end

			return arr
		end
	end
end

function DivineShiKongLongZunModel:getTotalScoreArr(activityId, stageId)
	local curModel = self:GetModel(activityId)
	local arr = {
		0,
		0
	}
	local showStageId = self:getCurShowStageId(activityId)
	local stageNum = DivineShiKongLongZunConfig.instance:getStageTotalNum(activityId)

	if stageNum >= showStageId + 1 then
		if not (showStageId + 1) then
			local nextShowStageId = showStageId

			if self:isOpenTime(activityId, nextShowStageId) or showStageId ~= curModel.passStageId then
				for i, v in ipairs(curModel.teamScores) do
					arr[1] = arr[1] + v.left
					arr[2] = arr[2] + v.right
				end
			else
				for i, v in ipairs(curModel.lastStageTeamScores) do
					arr[1] = arr[1] + v.left
					arr[2] = arr[2] + v.right
				end
			end

			return arr
		end
	end
end

function DivineShiKongLongZunModel:curTeamIsPass(activityId, stageId, teamId)
	local curModel = self:GetModel(activityId)
	local showStageId = self:getCurShowStageId(activityId)
	local stageNum = DivineShiKongLongZunConfig.instance:getStageTotalNum(activityId)

	if stageNum >= showStageId + 1 then
		if not (showStageId + 1) then
			local nextShowStageId = showStageId

			if self:isOpenTime(activityId, nextShowStageId) or showStageId ~= curModel.passStageId then
				if #curModel.teamScores > 0 and curModel.teamScores[teamId] then
					return curModel.teamScores[teamId].left ~= 0 or curModel.teamScores[teamId].right ~= 0
				end
			elseif #curModel.lastStageTeamScores > 0 and curModel.lastStageTeamScores[teamId] then
				return curModel.lastStageTeamScores[teamId].left ~= 0 or curModel.lastStageTeamScores[teamId].right ~= 0
			end

			return false
		end
	end
end

function DivineShiKongLongZunModel:curShowStageIsPass(activityId, stageId)
	local curModel = self:GetModel(activityId)

	return stageId <= curModel.passStageId
end

function DivineShiKongLongZunModel:getCustomFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = DivineShiKongLongZunFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

DivineShiKongLongZunModel.instance = DivineShiKongLongZunModel.New()

return DivineShiKongLongZunModel
