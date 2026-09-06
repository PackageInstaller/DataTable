-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/model/ServerUserInfoMO.lua

module("logic.extensions.login.model.ServerUserInfoMO", package.seeall)

local ServerUserInfoMO = class("ServerUserInfoMO")

function ServerUserInfoMO:ctor()
	self.id = nil
	self.name = nil
	self.level = nil
	self.vipLevel = nil
end

return ServerUserInfoMO
