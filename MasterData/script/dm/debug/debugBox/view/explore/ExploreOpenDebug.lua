-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/explore/ExploreOpenDebug.lua

ExploreOpenDebug = class("ExploreOpenDebug", DebugViewTemplate, _M)

function ExploreOpenDebug:initialize()
	self._viewConfig = {
		{
			title = "打开debug模式",
			name = "result",
			type = "Label"
		}
	}
end

function ExploreOpenDebug:onClick(data)
	_G.isExploreDebug = true

	self:dispatch(ShowTipEvent({
		tip = "开启成功"
	}))
end
