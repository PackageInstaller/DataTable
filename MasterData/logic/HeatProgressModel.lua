-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heatprogress/model/HeatProgressModel.lua

module("logic.extensions.heatprogress.model.HeatProgressModel", package.seeall)

local HeatProgressModel = class("HeatProgressModel", BaseModel)

function HeatProgressModel:ctor()
	return
end

function HeatProgressModel:onInit()
	self:onReset()
end

function HeatProgressModel:onReset()
	self._isHasData = false
	self._infoRes = {
		infoList = {}
	}
	self._prizeRes = {
		changeSetId = 0
	}
end

function HeatProgressModel:getCurProgress(id)
	local infoList = self._infoRes.infoList

	return checknumber(infoList[id].progress)
end

function HeatProgressModel:getCurPrizeStatus(id)
	local infoList = self._infoRes.infoList

	return infoList[id].prizeStatus or {}
end

function HeatProgressModel:onHandleProgressGetInfoRes(msg)
	self._infoRes.infoList = msg.infoList
	self._isHasData = true
end

function HeatProgressModel:onHandleProgressGainPrizeRes(msg)
	self._prizeRes.changeSetId = checknumber(msg.changeSetId)
end

HeatProgressModel.instance = HeatProgressModel.New()

return HeatProgressModel
