-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/solicitwealth/model/SolicitWealthModel.lua

module("logic.extensions.solicitwealth.model.SolicitWealthModel", package.seeall)

local SolicitWealthModel = class("SolicitWealthModel", BaseModel)

function SolicitWealthModel:onInit()
	self:onReset()
end

function SolicitWealthModel:onReset()
	self._dailyFreeTimes = 1
	self._times = 2
	self._gainNum = 3
end

function SolicitWealthModel:handleMoneyCatInfoRes(msg)
	self._dailyFreeTimes = msg.dailyFreeTimes
	self._times = msg.times
	self._gainNum = msg.gainNum
end

function SolicitWealthModel:getDailyFreeTimes()
	return self._dailyFreeTimes
end

SolicitWealthModel.instance = SolicitWealthModel.New()

return SolicitWealthModel
