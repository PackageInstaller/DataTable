-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/view/ShenyaolongzunshengzhurankViewPresentor.lua

module("logic.extensions.shenyaolongzunshengzhu.view.ShenyaolongzunshengzhurankViewPresentor", package.seeall)

local ShenyaolongzunshengzhurankViewPresentor = class("ShenyaolongzunshengzhurankViewPresentor", ViewPresentor)

function ShenyaolongzunshengzhurankViewPresentor:ctor()
	ShenyaolongzunshengzhurankViewPresentor.super.ctor(self)
end

function ShenyaolongzunshengzhurankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenyaolongzunshengzhurankViewPresentor:dependWhatResources()
	return {
		"ui/views/shenyaolongzunshengzhu/shenyaolongzunshengzhurankview.prefab"
	}
end

function ShenyaolongzunshengzhurankViewPresentor:buildViews()
	return {
		ShenyaolongzunshengzhurankView.New()
	}
end

return ShenyaolongzunshengzhurankViewPresentor
