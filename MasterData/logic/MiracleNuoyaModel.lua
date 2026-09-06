-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/model/MiracleNuoyaModel.lua

module("logic.extensions.miraclenuoya.model.MiracleNuoyaModel", package.seeall)

local MiracleNuoyaModel = class("MiracleNuoyaModel", BaseModel)

function MiracleNuoyaModel:onInit()
	self:onReset()
end

function MiracleNuoyaModel:onReset()
	self._msgMap = {}
	self.extFightEndPb = nil
	self.norFightEndPb = nil
end

function MiracleNuoyaModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._msgMap[activityId] = GameUtil.pbToTable(msg)
end

function MiracleNuoyaModel:onGetProgressPrize(msg)
	local activityId = msg.activityId
	local dataBitId = msg.dataBitId
	local info = self._msgMap[activityId]

	if info then
		info.normalClgInfo = info.normalClgInfo or {}
		info.normalClgInfo.normalClgProgressPrizeGainedBitId = info.normalClgInfo.normalClgProgressPrizeGainedBitId or {}

		table.insert(info.normalClgInfo.normalClgProgressPrizeGainedBitId, dataBitId)
	end
end

function MiracleNuoyaModel:getInfo(activityId)
	return self._msgMap[activityId]
end

function MiracleNuoyaModel:onResetExtre(msg)
	local activityId = msg.activityId
	local extremeClgInfo = GameUtil.pbToTable(msg.extremeClgInfo)
	local info = self._msgMap[activityId]

	if info then
		info.extremeClgInfo = extremeClgInfo
	end
end

function MiracleNuoyaModel:updateExtFightEnd(msg)
	self.extFightEndPb = GameUtil.pbToTable(msg)
end

function MiracleNuoyaModel:updateNorFightEnd(msg)
	local activityId = msg.activityId

	self.norFightEndPb = GameUtil.pbToTable(msg)

	local info = self._msgMap[activityId]

	if info then
		info.normalClgInfo = self.norFightEndPb.normalClgInfo
	end
end

function MiracleNuoyaModel:onConfirmExtre(msg)
	local activityId = msg.activityId
	local res = GameUtil.pbToTable(msg)

	if res.extremeClgInfo then
		local info = self._msgMap[activityId]

		if info then
			info.extremeClgInfo = res.extremeClgInfo
		end
	end
end

MiracleNuoyaModel.instance = MiracleNuoyaModel.New()

return MiracleNuoyaModel
