-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/knowledgeanswer/view/KnowledgeAnswerViewPresentor.lua

module("logic.extensions.knowledgeanswer.view.KnowledgeAnswerViewPresentor", package.seeall)

local KnowledgeAnswerViewPresentor = class("KnowledgeAnswerViewPresentor", ViewPresentor)

function KnowledgeAnswerViewPresentor:ctor()
	KnowledgeAnswerViewPresentor.super.ctor(self)
end

function KnowledgeAnswerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KnowledgeAnswerViewPresentor:dependWhatResources()
	return {
		"ui/views/knowledgeanswer/knowledgeanswerview.prefab"
	}
end

function KnowledgeAnswerViewPresentor:buildViews()
	return {
		KnowledgeAnswerView.New()
	}
end

return KnowledgeAnswerViewPresentor
