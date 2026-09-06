-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/view/PsychicHudGoto2View.lua

module("logic.extensions.psychicimprove.view.PsychicHudGoto2View", package.seeall)

local PsychicHudGoto2View = class("PsychicHudGoto2View", PsychicHudGoto1View)

function PsychicHudGoto2View:buildUI()
	PsychicHudGoto2View.super.buildUI(self)

	self._reportBehaviorId = 201438
end

return PsychicHudGoto2View
