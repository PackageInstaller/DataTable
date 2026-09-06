-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playmusic/view/PlayMusicScenceViewPresentor.lua

module("logic.extensions.playmusic.view.PlayMusicScenceViewPresentor", package.seeall)

local PlayMusicScenceViewPresentor = class("PlayMusicScenceViewPresentor", ViewPresentor)

function PlayMusicScenceViewPresentor:ctor()
	PlayMusicScenceViewPresentor.super.ctor(self)
end

function PlayMusicScenceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlayMusicScenceViewPresentor:dependWhatResources()
	local resPathList = {}

	table.insert(resPathList, "ui/views/playmusic/playmusicscenceview.prefab")

	local symbolIdList = PlayMusicController.instance:getLoadSymbolIdList()

	for _, symbolId in ipairs(symbolIdList) do
		table.insert(resPathList, PlayMusicModel.instance:getSymbolPrefabPath(symbolId))
	end

	return resPathList
end

function PlayMusicScenceViewPresentor:buildViews()
	return {
		PlayMusicScenceView.New()
	}
end

return PlayMusicScenceViewPresentor
