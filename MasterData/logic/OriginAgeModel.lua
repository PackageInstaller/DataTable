-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/model/OriginAgeModel.lua

module("logic.extensions.originage.model.OriginAgeModel", package.seeall)

local OriginAgeModel = class("OriginAgeModel", BaseModel)

function OriginAgeModel:onInit()
	self:onReset()
end

function OriginAgeModel:onReset()
	self._msgPool = {}
end

function OriginAgeModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._msgPool[activityId] = GameUtil.pbToTable(msg)
end

function OriginAgeModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function OriginAgeModel:onBindCode(msg)
	local activityId = msg.activityId
	local pb = GameUtil.pbToTable(msg)

	if pb.resultCode == 0 then
		local info = self._msgPool[activityId]

		if info then
			info.bindPlayerId = 1

			if checknumber(msg.changeSetId) > 0 then
				info.gainPrizeTypeList = info.gainPrizeTypeList or {}

				table.insert(info.gainPrizeTypeList, "BIND_CODE")
			end
		end
	end
end

function OriginAgeModel:onGetPrize(msg)
	local activityId = msg.activityId
	local prizeType = msg.prizeType
	local info = self._msgPool[activityId]

	if info then
		info.gainPrizeTypeList = info.gainPrizeTypeList or {}

		table.insert(info.gainPrizeTypeList, prizeType)
	end
end

OriginAgeModel.instance = OriginAgeModel.New()

return OriginAgeModel
