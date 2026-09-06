-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/view/SpringRedPackPopViewPresentor.lua

module("logic.extensions.springredpack.view.SpringRedPackPopViewPresentor", package.seeall)

local SpringRedPackPopViewPresentor = class("SpringRedPackPopViewPresentor", ViewPresentor)

SpringRedPackPopViewPresentor.EffectPathBack = "20220128/xinnianhongbao/fx_ui_xinchunhongbao.prefab"
SpringRedPackPopViewPresentor.EffectPathFront = "20220128/xinnianhongbao/fx_ui_xinchunhongbao_qian.prefab"

function SpringRedPackPopViewPresentor:ctor()
	SpringRedPackPopViewPresentor.super.ctor(self)
end

function SpringRedPackPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SpringRedPackPopViewPresentor:dependWhatResources()
	return {
		"ui/views/springredpack/springredpackpopview.prefab"
	}
end

function SpringRedPackPopViewPresentor:buildViews()
	return {
		SpringRedPackPopView.New()
	}
end

function SpringRedPackPopViewPresentor:getTempResources()
	local pathList = {}

	table.insert(pathList, UIEffectManager.instance:getEffectPath(SpringRedPackPopViewPresentor.EffectPathBack))
	table.insert(pathList, UIEffectManager.instance:getEffectPath(SpringRedPackPopViewPresentor.EffectPathFront))

	return pathList
end

return SpringRedPackPopViewPresentor
