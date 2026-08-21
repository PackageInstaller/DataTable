-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/EchoFullScreenPreviewPresentor.lua

module("logic.extensions.charactersystem.view.carrier.EchoFullScreenPreviewPresentor", package.seeall)

local M = class("EchoFullScreenPreviewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Carryitem_echo_fullscreen
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EchoFullScreenPreview.New())

	return views
end

return M
