-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/model/LuYinJiaDeModel.lua

module("logic.extensions.luyinjiade.model.LuYinJiaDeModel", package.seeall)

local LuYinJiaDeModel = class("LuYinJiaDeModel", BaseModel)

function LuYinJiaDeModel:onInit()
	self:onReset()
end

function LuYinJiaDeModel:onReset()
	self._customFmtMoPool = {}
	self._infos = {}
end

function LuYinJiaDeModel:getInfo(activityId)
	return self._infos[activityId]
end

function LuYinJiaDeModel:handlePM_LuYinJiaDeClgGetInfoRes(msg)
	local info = GameUtil.pbToTable(msg)

	self._infos[msg.activityId] = info

	if msg.stageList then
		for i, stageCfg in ipairs(msg.stageList) do
			local stageId = stageCfg.stageId

			info.stageList[stageId] = stageCfg
		end
	else
		info.stageList = {}
	end
end

function LuYinJiaDeModel:handlePM_LuYinJiaDeClgGodRankViewRes(msg)
	local info = self:getInfo(msg.activityId)

	info.rankInfoListGod = msg.rankInfoList or {}
	info.myRankGod = msg.myRank
end

function LuYinJiaDeModel:handlePM_LuYinJiaDeClgDailyRankViewRes(msg)
	local info = self:getInfo(msg.activityId)

	info.rankInfoListDaily = msg.rankInfoList or {}
	info.myRankDaily = msg.myRank
end

function LuYinJiaDeModel:handlePM_LuYinJiaDeClgNotifyFightRes(msg)
	local activityId = msg.activityId
	local info = self:getInfo(activityId)
	local stageId = msg.stageId

	info.stageList[stageId] = msg.stageInfo
	info.signBuffId = msg.signBuffId
end

function LuYinJiaDeModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = LuYinJiaDeFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

LuYinJiaDeModel.instance = LuYinJiaDeModel.New()

return LuYinJiaDeModel
