-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenvsjiu/model/JieShenVsJiuModel.lua

module("logic.extensions.jieshenvsjiu.view.JieShenVsJiuModel", package.seeall)

local JieShenVsJiuModel = class("JieShenVsJiuModel", BaseModel)

function JieShenVsJiuModel:ctor()
	return
end

function JieShenVsJiuModel:onInit()
	self:onReset()
end

function JieShenVsJiuModel:onReset()
	self._info = {}
end

function JieShenVsJiuModel:onJieShenVsJiuGetInfoRes(msg)
	print("test JieShenVsJiuModel 成功获取信息")

	self._info[msg.activityId] = msg
end

function JieShenVsJiuModel:onJieShenVsJiuGainPrizeRes(msg)
	local info = self._info[msg.activityId]
	local prizeId = msg.prizeId

	if prizeId and not TableUtil.isHad(info.gainPrizeIds, prizeId) then
		table.insert(info.gainPrizeIds, prizeId)
	end
end

function JieShenVsJiuModel:onJieShenVsJiuChooseTeamRes(msg)
	local info = self._info[msg.activityId]

	if info then
		info.myTeamId = msg.myTeamId
	end

	print("test JieShenVsJiuModel 成功选择pick队伍")
end

function JieShenVsJiuModel:onJieShenVsJiuStartGameRes(msg)
	self._severKey = msg.serverKey
end

function JieShenVsJiuModel:onJieShenVsJiuEndGameRes(msg)
	self._info[msg.activityId].myScore = msg.myScore
	self._info[msg.activityId].todayGameTimes = msg.todayGameTimes
end

function JieShenVsJiuModel:onJieShenVsJiuGainWorldProgressPrizeRes(msg)
	local info = self._info[msg.activityId]
	local prizeId = msg.prizeId

	if info and prizeId and not TableUtil.isHad(info.gainWorldPrizeIds, prizeId) then
		table.insert(info.gainWorldPrizeIds, prizeId)
	end
end

function JieShenVsJiuModel:creatMyClientKey()
	self._clientKey = math.random(ServerTime.now())

	return self._clientKey
end

function JieShenVsJiuModel:getMyTeamId(activityId)
	return self._info[activityId].myTeamId
end

function JieShenVsJiuModel:getPercentPair(activityId)
	return self._info[activityId].percentPair
end

function JieShenVsJiuModel:getTodayGameTimes(activityId)
	return self._info[activityId].todayGameTimes
end

function JieShenVsJiuModel:getMyScore(activityId)
	return self._info[activityId].myScore
end

function JieShenVsJiuModel:getGainPrizeIds(activityId)
	return self._info[activityId].gainPrizeIds
end

function JieShenVsJiuModel:getMyServerKey()
	return self._severKey
end

function JieShenVsJiuModel:getMyClientKey()
	return self._clientKey
end

function JieShenVsJiuModel:chooseMyTeamId(activityId, teamId)
	self._info[activityId].myTeamId = teamId
end

function JieShenVsJiuModel:getInfo(activityId)
	return self._info[activityId] or {}
end

JieShenVsJiuModel.instance = JieShenVsJiuModel.New()

return JieShenVsJiuModel
