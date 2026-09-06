-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/view/ShenyaolongzunshengzhuextViewPresentor.lua

module("logic.extensions.shenyaolongzunshengzhu.view.ShenyaolongzunshengzhuextViewPresentor", package.seeall)

local ShenyaolongzunshengzhuextViewPresentor = class("ShenyaolongzunshengzhuextViewPresentor", ViewPresentor)

function ShenyaolongzunshengzhuextViewPresentor:ctor()
	ShenyaolongzunshengzhuextViewPresentor.super.ctor(self)
end

function ShenyaolongzunshengzhuextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenyaolongzunshengzhuextViewPresentor:dependWhatResources()
	return {
		"ui/views/shenyaolongzunshengzhu/shenyaolongzunshengzhuextview.prefab"
	}
end

function ShenyaolongzunshengzhuextViewPresentor:buildViews()
	return {
		ShenyaolongzunshengzhuextView.New()
	}
end

return ShenyaolongzunshengzhuextViewPresentor
