-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedakinosclg/view/DivineDakinoscClgFmtExViewPresentor.lua

module("logic.extensions.divinedakinosclg.view.DivineDakinoscClgFmtExViewPresentor", package.seeall)

local DivineDakinoscClgFmtExViewPresentor = class("DivineDakinoscClgFmtExViewPresentor", ViewPresentor)

function DivineDakinoscClgFmtExViewPresentor:ctor()
	DivineDakinoscClgFmtExViewPresentor.super.ctor(self)
end

function DivineDakinoscClgFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineDakinoscClgFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedakinosclg/divinedakinosclgfmtexview.prefab"
	}
end

function DivineDakinoscClgFmtExViewPresentor:buildViews()
	return {
		DivineDakinoscClgFmtExView.New()
	}
end

function DivineDakinoscClgFmtExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DivineDakinoscClgFmtExViewPresentor
