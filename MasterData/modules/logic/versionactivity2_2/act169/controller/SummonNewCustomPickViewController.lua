-- chunkname: @modules/logic/versionactivity2_2/act169/controller/SummonNewCustomPickViewController.lua

module("modules.logic.versionactivity2_2.act169.controller.SummonNewCustomPickViewController", package.seeall)

local SummonNewCustomPickViewController = class("SummonNewCustomPickViewController", BaseController)

function SummonNewCustomPickViewController:onInit()
	return
end

function SummonNewCustomPickViewController:onInitFinish()
	return
end

function SummonNewCustomPickViewController:addConstEvents()
	return
end

function SummonNewCustomPickViewController:getSummonInfo(activityId, callBack, callBackObj)
	SummonNewCustomPickViewRpc.instance:sendGet169InfoRequest(activityId, callBack, callBackObj)
end

function SummonNewCustomPickViewController:reInit()
	SummonNewCustomPickViewModel.instance:reInit()
end

SummonNewCustomPickViewController.instance = SummonNewCustomPickViewController.New()

return SummonNewCustomPickViewController
