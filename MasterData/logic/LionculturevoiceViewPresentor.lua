-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LionculturevoiceViewPresentor.lua

module("logic.extensions.lionculture.view.LionculturevoiceViewPresentor", package.seeall)

local LionculturevoiceViewPresentor = class("LionculturevoiceViewPresentor", ViewPresentor)

function LionculturevoiceViewPresentor:ctor()
	LionculturevoiceViewPresentor.super.ctor(self)
end

function LionculturevoiceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LionculturevoiceViewPresentor:dependWhatResources()
	local resPathList = {}

	table.insert(resPathList, "ui/views/lionculture/lionculturevoiceview.prefab")

	local symbolIdList = PlayMusicController.instance:getLoadSymbolIdList()

	for _, symbolId in ipairs(symbolIdList) do
		table.insert(resPathList, PlayMusicModel.instance:getSymbolPrefabPath(symbolId))
	end

	return resPathList
end

function LionculturevoiceViewPresentor:buildViews()
	return {
		LionculturevoiceView.New()
	}
end

return LionculturevoiceViewPresentor
