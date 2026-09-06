-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summer/controller/SummerController.lua

module("logic.extensions.summer.controller.SummerController", package.seeall)

local SummerController = class("SummerController", BaseController)

function SummerController:ctor()
	SummerController.super.ctor(self)
end

function SummerController:onInit()
	self:onReset()
end

function SummerController:onReset()
	self.SummerList = {}
end

function SummerController:getSummer(index, callback)
	return
end

function SummerController:getIsSummerInit()
	return SummerModel.instance.isInitedSummerInfo == true
end

function SummerController:getSummerInfo(callback)
	return
end

function SummerController:getLaterSummer(index, callback)
	return
end

function SummerController:getSummerState(cfg)
	return
end

SummerController.instance = SummerController.New()

return SummerController
