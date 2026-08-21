-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/record/HandbookRecordTranscendencyViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.record.HandbookRecordTranscendencyViewPresentor", package.seeall)

local M = class("HandbookRecordTranscendencyViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_record_transcendency_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookRecordTranscendencyView.New())

	return views
end

return M
