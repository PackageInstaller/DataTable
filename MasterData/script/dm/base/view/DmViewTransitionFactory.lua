-- chunkname: @/tmp/or_script/lua_compile/dm/base/view/DmViewTransitionFactory.lua

require("dm.base.view.DmViewTransition")

ViewTransitionType = {
	kCommonAreaView = 3,
	kPopupEnter = 1,
	kPopupExit = 2
}

local creatorMap = {
	[ViewTransitionType.kPopupEnter] = function()
		return PopupEnterTransition:new()
	end,
	[ViewTransitionType.kPopupExit] = function()
		return PopupExitTransition:new()
	end,
	[ViewTransitionType.kCommonAreaView] = function()
		return DmAreaViewTransition:new()
	end
}

ViewTransitionFactory = ViewTransitionFactory or {}

function ViewTransitionFactory:create(type)
	local creator = creatorMap[type]

	return creator()
end
