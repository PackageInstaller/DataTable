-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/view/ShenyaolongzunshengzhumainViewPresentor.lua

module("logic.extensions.shenyaolongzunshengzhu.view.ShenyaolongzunshengzhumainViewPresentor", package.seeall)

local ShenyaolongzunshengzhumainViewPresentor = class("ShenyaolongzunshengzhumainViewPresentor", ViewPresentor)

function ShenyaolongzunshengzhumainViewPresentor:ctor()
	ShenyaolongzunshengzhumainViewPresentor.super.ctor(self)
end

function ShenyaolongzunshengzhumainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenyaolongzunshengzhumainViewPresentor:dependWhatResources()
	return {
		"ui/views/shenyaolongzunshengzhu/shenyaolongzunshengzhumainview.prefab"
	}
end

function ShenyaolongzunshengzhumainViewPresentor:buildViews()
	return {
		ShenyaolongzunshengzhumainView.New()
	}
end

return ShenyaolongzunshengzhumainViewPresentor
