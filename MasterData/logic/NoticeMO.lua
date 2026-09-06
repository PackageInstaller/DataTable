-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/notice/model/NoticeMO.lua

module("logic.extensions.notice.model.NoticeMO", package.seeall)

local NoticeMO = class("NoticeMO")

function NoticeMO:ctor()
	self.id = 0
	self.type = 0
	self.flag = 0
	self.title = nil
	self.url = nil
	self.order = nil
end

return NoticeMO
