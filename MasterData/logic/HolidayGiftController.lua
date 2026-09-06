-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holidaygift/controller/HolidayGiftController.lua

module("logic.extensions.holidaygift.controller.HolidayGiftController", package.seeall)

local HolidayGiftController = class("HolidayGiftController", BaseController)

HolidayGiftController.E_GetInfoRes = "E_GetInfoRes"
HolidayGiftController.E_GainPrizeRes = "E_GainPrizeRes"

function HolidayGiftController:ctor()
	return
end

function HolidayGiftController:onInit()
	return
end

function HolidayGiftController:onReset()
	HolidayGiftModel.instance:onReset()
end

function HolidayGiftController:handleGetInfoRes(status, msg)
	if status == 0 then
		HolidayGiftModel.instance:handleGetInfoRes(msg)
		self:localNotify(HolidayGiftController.E_GetInfoRes)
	end
end

function HolidayGiftController:handleGainPrizeRes(status, msg)
	if status == 0 then
		HolidayGiftModel.instance:handleGainPrizeRes(msg)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		MaterialController.instance:showChangeSetInTemp(msg.changeSetId)
		self:localNotify(HolidayGiftController.E_GainPrizeRes)
	end
end

HolidayGiftController.instance = HolidayGiftController.New()

return HolidayGiftController
