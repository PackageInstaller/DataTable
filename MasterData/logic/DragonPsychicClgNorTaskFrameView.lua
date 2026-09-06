-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/dragonpsychicclg/DragonPsychicClgNorTaskFrameView.lua

module("logic.extensions.eventtasksummary.view.tab.dragonpsychicclg.DragonPsychicClgNorTaskFrameView", package.seeall)

local DragonPsychicClgNorTaskFrameView = class("DragonPsychicClgNorTaskFrameView", EventTaskTabFrameView)

function DragonPsychicClgNorTaskFrameView:ctor()
	return
end

function DragonPsychicClgNorTaskFrameView:buildUI()
	DragonPsychicClgNorTaskFrameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
end

function DragonPsychicClgNorTaskFrameView:bindEvents()
	DragonPsychicClgNorTaskFrameView.super.bindEvents(self)
end

function DragonPsychicClgNorTaskFrameView:unbindEvents()
	DragonPsychicClgNorTaskFrameView.super.unbindEvents(self)
end

function DragonPsychicClgNorTaskFrameView:onEnter()
	DragonPsychicClgNorTaskFrameView.super.onEnter(self)
end

function DragonPsychicClgNorTaskFrameView:onExit()
	DragonPsychicClgNorTaskFrameView.super.onExit(self)
end

return DragonPsychicClgNorTaskFrameView
