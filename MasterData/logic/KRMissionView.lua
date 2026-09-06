-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingroad/view/KRMissionView.lua

module("logic.extensions.kingroad.view.KRMissionView", package.seeall)

local KRMissionView = class("KRMissionView", MissionView)

function KRMissionView:ctor()
	KRMissionView.super.ctor(self)
end

function KRMissionView:onEnter()
	self:onEnterInherit()
	self:procMid()
end

function KRMissionView:procMid()
	local levelStr = "1/1"
	local titleStr = ""
	local ruleDesc = lang("击败敌方阵容即可通关")

	self:_setDescStr(titleStr, levelStr, ruleDesc)
end

function KRMissionView:_startNow()
	self:_setBattleResultTxtTitle()
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._startNow, self)
	UIJumper.instance:pushOneStack(ViewName.KingRoad, true)
	UIJumper.instance:pushOneStack(ViewName.KingRoadPractice, true)

	local subKey = checknumber(self._viewPresentor._openParam[1])

	KingRoadController.instance:goFight(subKey)
end

return KRMissionView
