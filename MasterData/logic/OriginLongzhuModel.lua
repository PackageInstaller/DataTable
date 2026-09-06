-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/model/OriginLongzhuModel.lua

module("logic.extensions.originlongzhu.model.OriginLongzhuModel", package.seeall)

local OriginLongzhuModel = class("OriginLongzhuModel", BaseModel)

function OriginLongzhuModel:onInit()
	self:onReset()
end

function OriginLongzhuModel:onReset()
	self._msgPool = {}
	self._fightPbMap = {}
	self._msgGodRankPool = {}
end

function OriginLongzhuModel:onGetInfo(msg)
	local pb = GameUtil.pbToTable(msg, {})
	local activityId = pb.activityId

	self._msgPool[activityId] = pb
end

function OriginLongzhuModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function OriginLongzhuModel:onResetFight(msg)
	local activityId = msg.activityId
	local stageId = msg.stageId
	local info = self._msgPool[activityId]

	if info then
		local stageInfos = info.stageInfos

		if stageInfos then
			for i, v in ipairs(stageInfos) do
				if v.stageId == stageId then
					table.remove(stageInfos, i)

					break
				end
			end
		end
	end
end

function OriginLongzhuModel:handleFightRes(msg)
	local pb = GameUtil.pbToTable(msg)
	local activityId = pb.activityId

	self._fightPbMap[activityId] = pb
end

function OriginLongzhuModel:getFightPb(activityId)
	return self._fightPbMap[activityId]
end

function OriginLongzhuModel:onGetGodRankInfo(msg)
	local activityId = msg.activityId

	self._msgGodRankPool[activityId] = GameUtil.pbToTable(msg)
end

function OriginLongzhuModel:getGodRankInfo(activityId)
	return self._msgGodRankPool[activityId]
end

OriginLongzhuModel.instance = OriginLongzhuModel.New()

return OriginLongzhuModel
