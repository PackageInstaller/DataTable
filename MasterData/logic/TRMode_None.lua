-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/controller/mode/TRMode_None.lua

module("logic.extensions.treasureraider.controller.mode.TRMode_None", package.seeall)

local TRMode_None = class("TRMode_None", FsmState)

function TRMode_None:ctor(stateId)
	TRMode_None.super.ctor(self, stateId)
end

function TRMode_None:onEnter()
	TRMode_None.super.onEnter(self)
end

function TRMode_None:onExit()
	TRMode_None.super.onExit(self)
	self:doExitDone()
end

return TRMode_None
