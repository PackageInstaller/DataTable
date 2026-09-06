-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinecoronate/model/DivineCoronateModel.lua

module("logic.extensions.divinecoronate.model.DivineCoronateModel", package.seeall)

local DivineCoronateModel = class("DivineCoronateModel")

function DivineCoronateModel:ctor()
	return
end

function DivineCoronateModel:onInit()
	self:onReset()
end

function DivineCoronateModel:onReset()
	self._infos = {}
end

function DivineCoronateModel:onDivineCoronateGetInfoRes(msg)
	local info = GameUtil.pbToTable(msg)

	self._infos[info.activityId] = info
end

function DivineCoronateModel:DivineCoronateStartGameRes(msg)
	if not self._infos[msg.activityId] then
		return
	end

	self._infos[msg.activityId]._clientKey = msg.clientKey
	self._infos[msg.activityId]._serverKey = msg.serverKey
end

function DivineCoronateModel:onDivineCoronateEndGameRes(msg)
	if not self._infos[msg.activityId] then
		return
	end

	self._infos[msg.activityId]._isWin = msg.isWin
	self._infos[msg.activityId]._todayGameTimes = msg.todayGameTimes
	self._infos[msg.activityId]._maxUnlockTabId = msg.maxUnlockTabId
end

function DivineCoronateModel:onDivineCoronateGainPrizeRes(msg)
	if msg.tabId and self._infos[msg.activityId]._gainPrizeTabIds then
		table.insert(self._infos[msg.activityId]._gainPrizeTabIds, msg.tabId)
	end

	DivineCoronateAgent.instance:sendPM_DivineCoronateGetInfoReq(msg.activityId)
end

function DivineCoronateModel:getActivityInfoByActId(activityId)
	return self._infos[activityId]
end

function DivineCoronateModel:getMyClientKey(activityId)
	if not self._infos[activityId]._clientKey then
		return
	end

	return self._infos[activityId]._clientKey
end

function DivineCoronateModel:getMyServerKey(activityId)
	if not self._infos[activityId]._serverKey then
		return
	end

	return self._infos[activityId]._serverKey
end

function DivineCoronateModel:getGameResult(activityId)
	if not self._infos[activityId]._isWin then
		return
	end

	return self._infos[activityId]._isWin
end

DivineCoronateModel.instance = DivineCoronateModel.New()

return DivineCoronateModel
