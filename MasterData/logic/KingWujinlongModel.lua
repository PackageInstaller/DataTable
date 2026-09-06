-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/model/KingWujinlongModel.lua

module("logic.extensions.kingwujinlong.model.KingWujinlongModel", package.seeall)

local KingWujinlongModel = class("KingWujinlongModel", BaseModel)

function KingWujinlongModel:onInit()
	self:onReset()
end

function KingWujinlongModel:onReset()
	self._msgPool = {}
	self._fightPbMap = {}
end

function KingWujinlongModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function KingWujinlongModel:onGetInfo(msg)
	self._msgPool[msg.activityId] = GameUtil.pbToTable(msg)
end

function KingWujinlongModel:onGetReset(msg)
	self._msgPool[msg.activityId] = GameUtil.pbToTable(msg)
end

function KingWujinlongModel:handleFightRes(msg)
	self._fightPbMap[msg.activityId] = GameUtil.pbToTable(msg)
end

function KingWujinlongModel:getFightPb(activityId)
	return self._fightPbMap[activityId]
end

function KingWujinlongModel:onGetConfirm(msg)
	local pb = GameUtil.pbToTable(msg)

	if pb.clgInfo then
		self._msgPool[msg.activityId] = pb
	end
end

function KingWujinlongModel:getAllLimitPetMap(activityId)
	local map = {}
	local info = self._msgPool[activityId]

	if info then
		if not info.clgInfo then
			if not info.clgInfo.banRace then
				local banRace = {}

				for i, raceId in ipairs(banRace) do
					map[raceId] = true
				end
			end
		end
	end

	return map
end

KingWujinlongModel.instance = KingWujinlongModel.New()

return KingWujinlongModel
