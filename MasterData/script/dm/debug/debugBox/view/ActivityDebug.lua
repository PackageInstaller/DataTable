-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ActivityDebug.lua

DrawCardFeedback = class("DrawCardFeedback", DebugViewTemplate, _M)

function DrawCardFeedback:initialize()
	self._opType = 297
	self._viewConfig = {
		{
			default = 666,
			name = "score",
			title = "梦境回馈抽卡积分",
			type = "Input"
		}
	}
end

ActivityBlockReset = class("ActivityBlockReset", DebugViewTemplate, _M)

function ActivityBlockReset:initialize()
	self._opType = 425
	self._viewConfig = {}
end

openActivity = class("openActivity", DebugViewTemplate, _M)

function openActivity:initialize()
	self._opType = 432
	self._viewConfig = {
		{
			default = "",
			name = "activityId",
			title = "活动ID",
			type = "Input"
		},
		{
			default = "3",
			name = "openDays",
			title = "开启天数",
			type = "Input"
		},
		{
			default = "1",
			name = "switch",
			title = "开启/关闭",
			type = "Input"
		}
	}
end
