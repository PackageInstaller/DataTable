-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/toptoast/CharacterTopToastTipsViewPresentor.lua

module("logic.extensions.charactersystem.view.toptoast.CharacterTopToastTipsViewPresentor", package.seeall)

local M = class("CharacterTopToastTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Charactersystem_charactersystem_top_toast
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterTopToastTipsView.New())

	return views
end

return M
