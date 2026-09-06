-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/controller/Recap2021Controller.lua

module("logic.extensions.recap2021.controller.Recap2021Controller", package.seeall)

local Recap2021Controller = class("Recap2021Controller", BaseController)

Recap2021Controller.PM_Recap21GainEditionPrizeRes = "Recap2021Controller.PM_Recap21GainEditionPrizeRes"
Recap2021Controller.PM_Recap21GainLetterPrizeRes = "Recap2021Controller.PM_Recap21GainLetterPrizeRes"
Recap2021Controller.PM_Recap21GetInfoRes = "Recap2021Controller.PM_Recap21GetInfoRes"
Recap2021Controller.UpdateShareData = "Recap2021Controller.UpdateShareData"

function Recap2021Controller:ctor()
	return
end

function Recap2021Controller:onInit()
	GlobalDispatcher:addListener(Recap2021Agent.PM_Recap21GainEditionPrizeRes, self._PM_Recap21GainEditionPrizeRes, self)
	GlobalDispatcher:addListener(Recap2021Agent.PM_Recap21GainLetterPrizeRes, self._PM_Recap21GainLetterPrizeRes, self)
	GlobalDispatcher:addListener(Recap2021Agent.PM_Recap21GetInfoRes, self._PM_Recap21GetInfoRes, self)
	GlobalDispatcher:addListener(ShareLinkAgent.PM_GetShareLinkDataRes, self._PM_GetShareLinkDataRes, self)
	self:onReset()
end

function Recap2021Controller:onReset()
	return
end

function Recap2021Controller:_PM_Recap21GainEditionPrizeRes(status, msg)
	if status == 0 then
		Recap2021Model.instance:gainEditionPrizeRes(self._editionId)
	end

	GlobalDispatcher:dispatch(Recap2021Controller.PM_Recap21GainEditionPrizeRes, status, msg)
end

function Recap2021Controller:_PM_Recap21GainLetterPrizeRes(status, msg)
	if status == 0 then
		Recap2021Model.instance:gainLetterPrizeRes(self._letter_prizeId)
	end

	GlobalDispatcher:dispatch(Recap2021Controller.PM_Recap21GainLetterPrizeRes, status, msg)
end

function Recap2021Controller:_PM_Recap21GetInfoRes(status, msg)
	if status == 0 then
		Recap2021Model.instance:setInfo(msg)
	end

	GlobalDispatcher:dispatch(Recap2021Controller.PM_Recap21GetInfoRes, status, msg)
end

function Recap2021Controller:sendPM_Recap21GainLetterPrizeReq(prizeId)
	self._letter_prizeId = prizeId

	Recap2021Agent.instance:sendPM_Recap21GainLetterPrizeReq(prizeId)
end

function Recap2021Controller:sendPM_Recap21GainEditionPrizeReq(editionId)
	self._editionId = editionId

	Recap2021Agent.instance:sendPM_Recap21GainEditionPrizeReq(editionId)
end

function Recap2021Controller:_PM_GetShareLinkDataRes(status, msg)
	if status == 0 and self._shareId == 10 then
		self._shareId = nil

		Recap2021Model.instance:setShare10GainTime(msg.gainTimes)
		GlobalDispatcher:dispatch(Recap2021Controller.UpdateShareData)
	end
end

function Recap2021Controller:sendPM_GetShareLinkDataReq(id)
	self._shareId = id

	ShareLinkAgent.instance:sendPM_GetShareLinkDataReq(id)
end

Recap2021Controller.instance = Recap2021Controller.New()

return Recap2021Controller
