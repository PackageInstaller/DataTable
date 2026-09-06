-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/SearchViewPresentor.lua

module("logic.extensions.tips.view.SearchViewPresentor", package.seeall)

local SearchViewPresentor = class("SearchViewPresentor", TipsViewPresentorBase)

function SearchViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/search.prefab"
	}
end

function SearchViewPresentor:buildViews()
	local views = {}
	local sarchView = SearchView.New()

	table.insert(views, sarchView)

	return views
end

return SearchViewPresentor
