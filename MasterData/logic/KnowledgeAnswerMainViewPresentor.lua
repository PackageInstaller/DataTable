-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/knowledgeanswer/view/KnowledgeAnswerMainViewPresentor.lua

module("logic.extensions.knowledgeanswer.view.KnowledgeAnswerMainViewPresentor", package.seeall)

local KnowledgeAnswerMainViewPresentor = class("KnowledgeAnswerMainViewPresentor", ViewPresentor)

function KnowledgeAnswerMainViewPresentor:ctor()
	KnowledgeAnswerMainViewPresentor.super.ctor(self)
end

function KnowledgeAnswerMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KnowledgeAnswerMainViewPresentor:dependWhatResources()
	return {
		"ui/views/knowledgeanswer/knowledgeanswermainview.prefab"
	}
end

function KnowledgeAnswerMainViewPresentor:buildViews()
	return {
		KnowledgeAnswerMainView.New()
	}
end

return KnowledgeAnswerMainViewPresentor
