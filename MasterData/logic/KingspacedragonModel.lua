-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/model/KingspacedragonModel.lua

module("logic.extensions.kingspacedragon.view.KingspacedragonModel", package.seeall)

local KingspacedragonModel = class("KingspacedragonModel", BaseModel)

function KingspacedragonModel:ctor()
	return
end

function KingspacedragonModel:onInit()
	self:onReset()
end

function KingspacedragonModel:onReset()
	self._msgInfos = {}
	self._activityId = 0
	self._customFmtMo = nil
end

function KingspacedragonModel:setInfo(msg)
	self._msgInfos[msg.activityId] = msg
end

function KingspacedragonModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function KingspacedragonModel:getPassedStageId(activityId)
	if self._msgInfos[activityId] then
		if not self._msgInfos[activityId].curStageId then
			local stageId = 0

			stageId = stageId - 1

			if stageId < 0 then
				stageId = 0
			end

			return stageId
		end
	end
end

function KingspacedragonModel:getCurrStageId(activityId)
	return (self._msgInfos[activityId] or nil) and (self._msgInfos[activityId].curStageId or 0)
end

function KingspacedragonModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = KingspacedragonCustomFmtMo.New()
	end

	return self._customFmtMo
end

function KingspacedragonModel:setActivityId(activityId)
	self._activityId = activityId
end

function KingspacedragonModel:getActivityId()
	return self._activityId
end

function KingspacedragonModel:fightWinRes(msg)
	local info = self:getInfo(msg.activityId)

	if info then
		if msg.curStageId > 0 and msg.curStageId > info.curStageId then
			info.curStageId = msg.curStageId
			info.curStageTimeValue = -1
			info.curStageSpaceValue = -1

			return
		end

		if msg.curStageTimeValue > 0 then
			info.curStageTimeValue = msg.curStageTimeValue
		end

		if msg.curStageSpaceValue > 0 then
			info.curStageSpaceValue = msg.curStageSpaceValue
		end
	end
end

function KingspacedragonModel:confirmRes(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)

	if info then
		if msg.curStageId > info.curStageId then
			info.curStageId = msg.curStageId
			info.curStageTimeValue = -1
			info.curStageSpaceValue = -1

			return
		end

		if msg.curStageTimeValue > 0 then
			info.curStageTimeValue = msg.curStageTimeValue
		end

		if msg.curStageSpaceValue > 0 then
			info.curStageSpaceValue = msg.curStageSpaceValue
		end
	end
end

KingspacedragonModel.instance = KingspacedragonModel.New()

return KingspacedragonModel
