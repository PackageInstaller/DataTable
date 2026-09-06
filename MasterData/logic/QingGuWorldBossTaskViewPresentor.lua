-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/QingGuWorldBossTaskViewPresentor.lua

module("logic.extensions.eventtasksummary.view.QingGuWorldBossTaskViewPresentor", package.seeall)

local QingGuWorldBossTaskViewPresentor = class("QingGuWorldBossTaskViewPresentor", ViewPresentor)

function QingGuWorldBossTaskViewPresentor:ctor()
	QingGuWorldBossTaskViewPresentor.super.ctor(self)
end

function QingGuWorldBossTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function QingGuWorldBossTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/worldbosstask/qingguworldbosstaskview.prefab"
	}
end

function QingGuWorldBossTaskViewPresentor:buildViews()
	return {
		QingGuWorldBossTaskView.New()
	}
end

function QingGuWorldBossTaskViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return QingGuWorldBossTaskViewPresentor
