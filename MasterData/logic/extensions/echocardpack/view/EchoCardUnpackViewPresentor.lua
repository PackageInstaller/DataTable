-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardUnpackViewPresentor.lua

module("logic.extensions.echocardpack.view.EchoCardUnpackViewPresentor", package.seeall)

local M = class("EchoCardUnpackViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.EchoCardUnpackView,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Com)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EchoCardUnpackView.New())
	table.insert(views, EchoCardUnpackShowView.New())

	return views
end

return M
