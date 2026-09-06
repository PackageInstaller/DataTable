-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/view/ShenyaolongzunshengzhustageViewPresentor.lua

module("logic.extensions.shenyaolongzunshengzhu.view.ShenyaolongzunshengzhustageViewPresentor", package.seeall)

local ShenyaolongzunshengzhustageViewPresentor = class("ShenyaolongzunshengzhustageViewPresentor", ViewPresentor)

function ShenyaolongzunshengzhustageViewPresentor:ctor()
	ShenyaolongzunshengzhustageViewPresentor.super.ctor(self)
end

function ShenyaolongzunshengzhustageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenyaolongzunshengzhustageViewPresentor:dependWhatResources()
	return {
		"ui/views/shenyaolongzunshengzhu/shenyaolongzunshengzhustageview.prefab"
	}
end

function ShenyaolongzunshengzhustageViewPresentor:buildViews()
	return {
		ShenyaolongzunshengzhustageView.New()
	}
end

return ShenyaolongzunshengzhustageViewPresentor
