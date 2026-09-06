-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/res/GameRes.lua

module("logiccommon.common.res.GameRes", package.seeall)

local GameRes = class("GameRes")

function GameRes:ctor()
	self.handleId = self
	self.resPath = nil
	self.res = nil
	self.isEnabled = nil
	self.loadedHandler = nil
	self.loadedHandlerTarget = nil
end

function GameRes:onEnable()
	self.isEnabled = true
end

function GameRes:onDisable()
	self.isEnabled = nil
	self.resPath = nil
	self.res = nil
	self.loadedHandler = nil
	self.loadedHandlerTarget = nil
end

return GameRes
