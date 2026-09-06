-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/model/ServerListMO.lua

module("logic.extensions.login.model.ServerListMO", package.seeall)

local ServerListMO = class("ServerListMO")

function ServerListMO:ctor()
	self.id = 0
	self.name = nil
	self.ip = nil
	self.port = nil
	self.state = nil
	self.tips = nil
	self.weight = 0
end

return ServerListMO
