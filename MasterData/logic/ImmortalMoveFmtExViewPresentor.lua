-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/view/ImmortalMoveFmtExViewPresentor.lua

module("logic.extensions.immortalmovement.view.ImmortalMoveFmtExViewPresentor", package.seeall)

local ImmortalMoveFmtExViewPresentor = class("ImmortalMoveFmtExViewPresentor", ViewPresentor)

function ImmortalMoveFmtExViewPresentor:ctor()
	ImmortalMoveFmtExViewPresentor.super.ctor(self)
end

function ImmortalMoveFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ImmortalMoveFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/immortalmovement/immortalmovefmtexview.prefab"
	}
end

function ImmortalMoveFmtExViewPresentor:buildViews()
	return {
		ImmortalMoveFmtExView.New()
	}
end

return ImmortalMoveFmtExViewPresentor
