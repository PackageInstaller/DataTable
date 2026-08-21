-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/viewblackfade/controller/ViewBlackFadeEnum.lua

module("logic.extensions.viewblackfade.controller.ViewBlackFadeEnum", package.seeall)

local ViewBlackFadeEnum = {}

ViewBlackFadeEnum.TYP = {
	ALL = 1,
	FADE_CLOSE = 3,
	FADE_OPEN = 2
}
ViewBlackFadeEnum.Default = {
	closeFadeOutTime = 0.25,
	openDelay = 0.1,
	closeDelay = 0.1,
	openFadeOutTime = 0.25,
	openFadeInTime = 0.25,
	closeFadeInTime = 0.25,
	typ = ViewBlackFadeEnum.TYP.ALL
}
ViewBlackFadeEnum.character_heart_anchor_break_view = {
	closeDelay = 0.5,
	openDelay = 0.3,
	openFadeInTime = 0.15,
	closeFadeInTime = 0.05,
	typ = ViewBlackFadeEnum.TYP.ALL
}
ViewBlackFadeEnum.character_heart_anchor_view = {
	closeDelay = 0.5,
	openDelay = 0.3,
	openFadeInTime = 0.15,
	closeFadeInTime = 0.05,
	typ = ViewBlackFadeEnum.TYP.ALL
}

function ViewBlackFadeEnum.getNeedBlackFade(viewName)
	return ViewBlackFadeEnum[viewName] ~= nil
end

function ViewBlackFadeEnum.getInfo(viewName, key)
	local info = ViewBlackFadeEnum[viewName] or ViewBlackFadeEnum.Default

	return info.key or ViewBlackFadeEnum.Default[key]
end

function ViewBlackFadeEnum.getAllInfo(viewName)
	return ViewBlackFadeEnum[viewName] or ViewBlackFadeEnum.Default
end

return ViewBlackFadeEnum
