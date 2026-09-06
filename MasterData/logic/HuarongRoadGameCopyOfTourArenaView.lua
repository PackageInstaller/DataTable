-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/huarong/HuarongRoadGameCopyOfTourArenaView.lua

module("logic.extensions.tourarena.view.copy.huarong.HuarongRoadGameCopyOfTourArenaView", package.seeall)

local HuarongRoadGameCopyOfTourArenaView = class("HuarongRoadGameCopyOfTourArenaView", HuarongRoadGameView)

function HuarongRoadGameCopyOfTourArenaView:_endStory()
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._endStory, self)

	if self._moveWin == false then
		self:_PM_HuarongRoadBuyQuickPassRes(-100, nil)
	elseif self._moveWin == true then
		self:_PM_HuarongRoadPassRes(-100, nil)
	end

	self._isEnding = false
end

return HuarongRoadGameCopyOfTourArenaView
