-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preface/view/ChangeNameTipsViewsPresentor.lua

module("logic.extensions.preface.view.ChangeNameTipsViewsPresentor", package.seeall)

local M = class("ChangeNameTipsViewsPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Guide_start_benamed_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ChangeNameTipsViews.New())

	return views
end

return M
