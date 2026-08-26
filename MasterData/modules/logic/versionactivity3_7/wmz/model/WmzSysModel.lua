-- chunkname: @modules/logic/versionactivity3_7/wmz/model/WmzSysModel.lua

module("modules.logic.versionactivity3_7.wmz.model.WmzSysModel", package.seeall)

local WmzSysModel = class("WmzSysModel", Activity220SimpleBaseModel)

function WmzSysModel:ctor(...)
	WmzSysModel.super.ctor(self, ...)
end

function WmzSysModel:onInit()
	self:reInit()
end

function WmzSysModel:reInit()
	WmzSysModel.super.reInit(self)
	self:_internal_set_configInst(WmzConfig.instance)
end

function WmzSysModel:onReceiveGetAct220InfoReply(...)
	WmzController.instance:dispatchEvent(WmzEvent.onReceiveGetAct220InfoReply, ...)
end

function WmzSysModel:onReceiveAct220FinishEpisodeReply(...)
	WmzController.instance:dispatchEvent(WmzEvent.onReceiveAct220FinishEpisodeReply, ...)
end

function WmzSysModel:onReceiveAct220EpisodePush(...)
	WmzController.instance:dispatchEvent(WmzEvent.onReceiveAct220EpisodePush, ...)
end

WmzSysModel.instance = WmzSysModel.New()

return WmzSysModel
