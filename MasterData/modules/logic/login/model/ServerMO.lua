-- chunkname: @modules/logic/login/model/ServerMO.lua

module("modules.logic.login.model.ServerMO", package.seeall)

local ServerMO = pureTable("ServerMO")

function ServerMO:ctor()
	self.id = 0
	self.name = nil
	self.state = nil
	self.prefix = nil
end

function ServerMO:init(info)
	self.id = info.id
	self.name = info.name
	self.state = info.state
	self.prefix = info.prefix
end

return ServerMO
