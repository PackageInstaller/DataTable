-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/model/MiniPartySimplePlayerInfoMO.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.model.MiniPartySimplePlayerInfoMO", package.seeall)

local MiniPartySimplePlayerInfoMO = class("MiniPartySimplePlayerInfoMO")

function MiniPartySimplePlayerInfoMO:ctor()
	self.userId = 0
	self.name = ""
	self.portrait = 0
	self.level = 0
	self.isOnline = false
	self.zoneId = 0
	self.datetime = 0
end

function MiniPartySimplePlayerInfoMO:init(info)
	self.userId = info.userId
	self.name = info.name
	self.portrait = info.portrait
	self.level = info.level
	self.isOnline = info.isOnline
	self.zoneId = info.zoneId
	self.datetime = info.datetime
end

return MiniPartySimplePlayerInfoMO
