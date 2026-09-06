-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/model/OriginHuociyuanModel.lua

module("logic.extensions.originhuociyuan.model.OriginHuociyuanModel", package.seeall)

local OriginHuociyuanModel = class("OriginHuociyuanModel", BaseModel)

function OriginHuociyuanModel:onInit()
	self:onReset()
end

function OriginHuociyuanModel:onReset()
	self._msgPool = {}
	self._fightPbMap = {}
end

function OriginHuociyuanModel:onGetInfo(msg)
	local pb = GameUtil.pbToTable(msg, {})
	local activityId = pb.activityId

	self._msgPool[activityId] = pb
end

function OriginHuociyuanModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function OriginHuociyuanModel:onResetFight(msg)
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

function OriginHuociyuanModel:handleFightRes(msg)
	local pb = GameUtil.pbToTable(msg)
	local activityId = pb.activityId

	self._fightPbMap[activityId] = pb
end

function OriginHuociyuanModel:getFightPb(activityId)
	return self._fightPbMap[activityId]
end

OriginHuociyuanModel.instance = OriginHuociyuanModel.New()

return OriginHuociyuanModel
