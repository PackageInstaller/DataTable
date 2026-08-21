-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airtightroom/view/AirtightRoomTimeViewPresentor.lua

module("logic.extensions.airtightroom.view.AirtightRoomTimeViewPresentor", package.seeall)

local M = class("AirtightRoomTimeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Secret_secret_time_main_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirtightRoomTimeView.New())

	local titleView = TitleView.New(CommEnum.GuideID.AirtightRoomTime)

	titleView:setHideHomeBtn(true)
	table.insert(views, titleView)

	return views
end

return M
