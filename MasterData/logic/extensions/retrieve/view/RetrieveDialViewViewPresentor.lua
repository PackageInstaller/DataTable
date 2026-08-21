-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveDialViewViewPresentor.lua

module("logic.extensions.retrieve.view.RetrieveDialViewViewPresentor", package.seeall)

local M = class("RetrieveDialViewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.RetrieveDialView
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RetrieveDialView.New())

	return views
end

return M
