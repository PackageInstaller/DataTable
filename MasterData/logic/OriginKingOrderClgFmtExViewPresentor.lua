-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/view/OriginKingOrderClgFmtExViewPresentor.lua

module("logic.extensions.originkingorderclg.view.OriginKingOrderClgFmtExViewPresentor", package.seeall)

local OriginKingOrderClgFmtExViewPresentor = class("OriginKingOrderClgFmtExViewPresentor", ViewPresentor)

function OriginKingOrderClgFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKingOrderClgFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingorderclg/originkingorderclgfmtexview.prefab"
	}
end

function OriginKingOrderClgFmtExViewPresentor:buildViews()
	return {
		OriginKingOrderClgFmtExView.New()
	}
end

return OriginKingOrderClgFmtExViewPresentor
