-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/TitleViewViewPresentor.lua

module("logic.extensions.common.view.TitleViewViewPresentor", package.seeall)

local M = class("TitleViewViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Common_title_view
	}
end

function M:buildViews()
	local views = {}

	return views
end

return M
