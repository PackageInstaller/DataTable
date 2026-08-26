-- chunkname: @modules/logic/dungeon/model/UserChapterTypeNumMO.lua

module("modules.logic.dungeon.model.UserChapterTypeNumMO", package.seeall)

local UserChapterTypeNumMO = pureTable("UserChapterTypeNumMO")

function UserChapterTypeNumMO:init(info)
	self.chapterType = info.chapterType
	self.todayPassNum = info.todayPassNum
end

return UserChapterTypeNumMO
