-- chunkname: @modules/logic/notice/model/NoticeType.lua

module("modules.logic.notice.model.NoticeType", package.seeall)

local NoticeType = _M

NoticeType.All = 0
NoticeType.Activity = 1
NoticeType.Game = 2
NoticeType.System = 3
NoticeType.Playing = 4
NoticeType.BeforeLogin = 5
NoticeType.Information = 6
NoticeType.NoticeList = {
	NoticeType.Activity,
	NoticeType.Game,
	NoticeType.System,
	NoticeType.Information
}

function NoticeType.getTypeIndex(type)
	for i, innerType in ipairs(NoticeType.NoticeList) do
		if type == innerType then
			return i
		end
	end

	return 1
end

return NoticeType
