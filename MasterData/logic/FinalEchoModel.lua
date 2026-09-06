-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/finalecho/model/FinalEchoModel.lua

module("logic.extensions.finalecho.model.FinalEchoModel", package.seeall)

local FinalEchoModel = class("FinalEchoModel", BaseModel)

function FinalEchoModel:onInit()
	self:onReset()
end

function FinalEchoModel:onReset()
	self._baseInfoMap = {}
	self._rankInfoMap = {}
end

function FinalEchoModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoMap[info.activityId] = info
end

function FinalEchoModel:onResetInfo(msg)
	local info = self:getBaseInfo(msg.activityId)

	if info then
		info.boss = {}
	end
end

function FinalEchoModel:onGetRankInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._rankInfoMap[info.activityId] = info
end

function FinalEchoModel:getBaseInfo(activityId)
	if not self._baseInfoMap[activityId] then
		printError("最终回响数据未初始化")
	end

	return self._baseInfoMap[activityId]
end

function FinalEchoModel:getRankInfo(activityId)
	if not self._rankInfoMap[activityId] then
		printError("最终回响排行榜数据未初始化")
	end

	return self._rankInfoMap[activityId]
end

FinalEchoModel.instance = FinalEchoModel.New()

return FinalEchoModel
