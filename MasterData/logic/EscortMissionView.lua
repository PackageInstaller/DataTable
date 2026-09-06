-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/escort/view/EscortMissionView.lua

module("logic.extensions.escort.view.EscortMissionView", package.seeall)

local EscortMissionView = class("EscortMissionView", MissionView)

function EscortMissionView:ctor()
	EscortMissionView.super.ctor(self)
end

function EscortMissionView:onEnter()
	self.supTime = EscortModel.instance:GetBuzhengTimer()

	self:onEnterInherit()
	self:_setMaskBlock(false)
	self:procMid()
	ArenaController.instance:registerLocalNotify("ChallengeCdChange", self._refreshClgCD, self)

	if self.supTime < 1 then
		self.supTime = 1
	end

	self:CalculationSurplusTime()
end

function EscortMissionView:_onClickClose()
	removetimer(self.CalculationSurplusTime, self)

	self.supTime = 0

	EscortMissionView.super._onClickClose(self)
end

function EscortMissionView:onExit()
	if ViewMgr.instance:isOpen(ViewName.NineplacebuffselectView) then
		ViewMgr.instance:close(ViewName.NineplacebuffselectView)
	end

	CommonTipsMgr.instance:closeOneView(ViewName.PetTips)
	EscortMissionView.super.onExit(self)
	EscortModel.instance:SetBuzhengTimer(self.supTime)
	removetimer(self.CalculationSurplusTime, self)
	self:stopCool()
	ArenaController.instance:unregisterLocalNotify("ChallengeCdChange", self._refreshClgCD, self)
end

function EscortMissionView:procMid()
	local levelStr = ""
	local titleStr = string.format("阵形调整：%ss", self.supTime)
	local ruleDesc = lang("击败所有敌方精灵可获得胜利")

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_refreshClgCD()

	self._txtCd.text = ""
end

function EscortMissionView:CalculationSurplusTime()
	if self.supTime <= 1 and ViewMgr.instance:isOpen(ViewName.NineplacebuffselectView) then
		ViewMgr.instance:close(ViewName.NineplacebuffselectView)
	end

	if self.supTime <= 0 then
		FloatWordMgr.instance:show("布阵超时，请重新选择挑战目标！")
		self:_onClickClose()

		return
	end

	self.supTime = self.supTime - 1

	local titleStr = string.format("阵形调整：%ss", self.supTime)

	self:_setDescStr(titleStr, nil, nil)
	settimer(1, self.CalculationSurplusTime, self, false)
end

function EscortMissionView:_refreshClgCD()
	if not self._isClgCd then
		return
	end

	local leftTime = ArenaModel.instance:getChallengeCdEndTime() - ServerTime.now()

	if leftTime <= 0 then
		self._isClgCd = false
		self._txtCd.text = ""
	else
		self._isClgCd = true

		local hour, min, sec = GameUtil.getTimeHHMMSS(leftTime)

		self._txtCd.text = langPara("%d秒", leftTime)
	end
end

function EscortMissionView:_onClickStart()
	if self.isCool then
		FloatWordMgr.instance:show("冷却中")

		return
	end

	self:starCool()
	EscortMissionView.super._onClickStart(self)
end

function EscortMissionView:starCool()
	self.isCool = true

	settimer(0.5, self.stopCool, self)
end

function EscortMissionView:stopCool()
	self.isCool = false

	removetimer(self.stopCool, self)
end

function EscortMissionView:_enterBattle()
	local enemyInfo = EscortModel.instance:GetBattlePlayer()

	if enemyInfo == nil then
		return
	end

	TaskController.instance:stopAction()
	removetimer(self.CalculationSurplusTime, self)

	self.supTime = 0

	EscortController.instance:CSConvoyChallengeReq(enemyInfo.userId, enemyInfo.userName, enemyInfo.headInfo.headIconId, enemyInfo.headInfo.headFrameId, enemyInfo.isJuan, enemyInfo.userLevel)
end

return EscortMissionView
