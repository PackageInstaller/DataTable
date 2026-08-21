-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/music/HandbookMusicEntryViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.music.HandbookMusicEntryViewPresentor", package.seeall)

local M = class("HandbookMusicEntryViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_music_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookMusicEntryView.New())

	return views
end

return M
