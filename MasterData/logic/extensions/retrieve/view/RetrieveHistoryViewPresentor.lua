-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveHistoryViewPresentor.lua

module("logic.extensions.retrieve.view.RetrieveHistoryViewPresentor", package.seeall)

local M = class("RetrieveHistoryViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.RetrieveLogTips,
		ResName.RetrieveLogItem
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RetrieveHistoryView.New())

	return views
end

return M
