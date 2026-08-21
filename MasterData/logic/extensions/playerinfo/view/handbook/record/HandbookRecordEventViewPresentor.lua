-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/record/HandbookRecordEventViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.record.HandbookRecordEventViewPresentor", package.seeall)

local M = class("HandbookRecordEventViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_record_event_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookRecordEventView.New())

	return views
end

return M
