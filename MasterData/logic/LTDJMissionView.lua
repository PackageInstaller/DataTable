-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luotiandajiao/view/formation/LTDJMissionView.lua

module("logic.extensions.luotiandajiao.view.formation.LTDJMissionView", package.seeall)

local LTDJMissionView = class("LTDJMissionView", MissionView)

function LTDJMissionView:ctor()
	LTDJMissionView.super.ctor(self)
end

function LTDJMissionView:onEnter()
	self:onEnterInherit()
	self:procMid()
	self:_setBtnRuleActive(false)
end

function LTDJMissionView:procMid()
	local curRobot = LTDaJiaoModel.instance:getCurRobot()

	if curRobot then
		local titleStr = curRobot.info.userName
		local levelStr = ""
		local ruleDesc = "击败敌阵所有精灵即可过关"

		self:_setDescStr(titleStr, levelStr, ruleDesc)
	end
end

function LTDJMissionView:_procLRTxt()
	self._lImgIsFirst.gameObject:SetActive(false)
	self._rImgIsFirst.gameObject:SetActive(false)
end

function LTDJMissionView:_enterBattle()
	local activityId = LTDaJiaoModel.instance:getActivityId()

	LuoTianDaJiaoAgent.instance:sendPM_LuoTianDaJiaoFightReq(activityId)
	UIJumper.instance:pushOneStack(ViewName.LTDaJiaoEnterView, true)
	UIJumper.instance:pushOneStack(ViewName.LTDaJiaoMainView, true, activityId)
end

return LTDJMissionView
