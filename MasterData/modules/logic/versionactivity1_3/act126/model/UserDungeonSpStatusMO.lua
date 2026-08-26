-- chunkname: @modules/logic/versionactivity1_3/act126/model/UserDungeonSpStatusMO.lua

module("modules.logic.versionactivity1_3.act126.model.UserDungeonSpStatusMO", package.seeall)

local UserDungeonSpStatusMO = pureTable("UserDungeonSpStatusMO")

function UserDungeonSpStatusMO:init(info)
	self.chapterId = info.chapterId
	self.episodeId = info.episodeId
	self.status = info.status
	self.refreshTime = info.refreshTime
end

return UserDungeonSpStatusMO
