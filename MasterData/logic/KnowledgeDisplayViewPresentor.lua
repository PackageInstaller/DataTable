-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/knowledgeanswer/view/KnowledgeDisplayViewPresentor.lua

module("logic.extensions.knowledgeanswer.view.KnowledgeDisplayViewPresentor", package.seeall)

local KnowledgeDisplayViewPresentor = class("KnowledgeDisplayViewPresentor", ViewPresentor)

function KnowledgeDisplayViewPresentor:ctor()
	KnowledgeDisplayViewPresentor.super.ctor(self)
end

function KnowledgeDisplayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KnowledgeDisplayViewPresentor:dependWhatResources()
	return {
		"ui/views/knowledgeanswer/knowledgedisplayview.prefab"
	}
end

function KnowledgeDisplayViewPresentor:buildViews()
	return {
		KnowledgeDisplayView.New()
	}
end

return KnowledgeDisplayViewPresentor
