-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/round/RoundBattleStart.lua

module("logic.extensions.battle.model.round.RoundBattleStart", package.seeall)

local RoundBattleStart = class("RoundBattleStart", BattleRoundBase)

function RoundBattleStart:ctor()
	self.roundType = BattleRoundBase.RoundBattleStart
end

function RoundBattleStart:start()
	RoundBattleStart.super.start(self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClosed, self)

	self._isDone = nil

	ViewMgr.instance:open(ViewName.BattleStart)
end

function RoundBattleStart:finish()
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClosed, self)
	RoundBattleStart.super.finish(self)
end

function RoundBattleStart:isDone()
	return self._isDone
end

function RoundBattleStart:_onViewClosed(view)
	if view.viewName == ViewName.BattleStart or view.viewName == ViewName.EndlessBattleStart then
		self._isDone = true
	end
end

return RoundBattleStart
