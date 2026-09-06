-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/view/DragonKingSelectView.lua

module("logic.extensions.dragonking.view.DragonKingSelectView", package.seeall)

local DragonKingSelectView = class("DragonKingSelectView", HuarongRoadLevelView)

function DragonKingSelectView:ctor()
	DragonKingSelectView.super.ctor(self)
end

function DragonKingSelectView:unbindEvents()
	DragonKingSelectView.super.unbindEvents(self)
end

function DragonKingSelectView:bindEvents()
	DragonKingSelectView.super.bindEvents(self)
end

function DragonKingSelectView:buildUI()
	DragonKingSelectView.super.buildUI(self)
end

function DragonKingSelectView:onExit()
	DragonKingSelectView.super.onExit(self)
end

function DragonKingSelectView:onEnter()
	DragonKingSelectView.super.onEnter(self)
end

function DragonKingSelectView:_onClickStart(stageId)
	local totalTimes = HuarongRoadConfig.instance:challengeDailyTimes(self._activityId)
	local playTimes = HuarongRoadModel.instance:getPlayCount(self._activityId)
	local enterTimes = totalTimes - playTimes

	if enterTimes > 0 then
		UIStateManager.instance:push(ViewName.HuarongRoadGameView, self._activityId, stageId)
	else
		FloatWordMgr.instance:show("今日通关次数已达上限")
	end
end

return DragonKingSelectView
