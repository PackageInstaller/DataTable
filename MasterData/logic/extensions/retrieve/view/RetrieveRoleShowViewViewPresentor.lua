-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveRoleShowViewViewPresentor.lua

module("logic.extensions.retrieve.view.RetrieveRoleShowViewViewPresentor", package.seeall)

local M = class("RetrieveRoleShowViewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.RetrieveRoleShowView,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_RetrieveMainView)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RetrieveRoleShowViewView.New())

	return views
end

return M
