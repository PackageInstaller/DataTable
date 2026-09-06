-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/view/ShenyaolongzunshengzhuresultViewPresentor.lua

module("logic.extensions.shenyaolongzunshengzhu.view.ShenyaolongzunshengzhuresultViewPresentor", package.seeall)

local ShenyaolongzunshengzhuresultViewPresentor = class("ShenyaolongzunshengzhuresultViewPresentor", ViewPresentor)

function ShenyaolongzunshengzhuresultViewPresentor:ctor()
	ShenyaolongzunshengzhuresultViewPresentor.super.ctor(self)
end

function ShenyaolongzunshengzhuresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShenyaolongzunshengzhuresultViewPresentor:dependWhatResources()
	return {
		"ui/views/shenyaolongzunshengzhu/shenyaolongzunshengzhuresultview.prefab"
	}
end

function ShenyaolongzunshengzhuresultViewPresentor:buildViews()
	return {
		ShenyaolongzunshengzhuresultView.New()
	}
end

return ShenyaolongzunshengzhuresultViewPresentor
