-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrialView.lua

module("logic.extensions.dragontrial.view.DragontrialView", package.seeall)

local DragontrialView = class("DragontrialView", ViewComponent)

function DragontrialView:ctor()
	DragontrialView.super.ctor(self)
end

function DragontrialView:unbindEvents()
	DragontrialView.super.unbindEvents(self)
	self._btnAdvanced:RemoveClickListener()
	self._btnPrimary:RemoveClickListener()
end

function DragontrialView:bindEvents()
	DragontrialView.super.bindEvents(self)
	self._btnAdvanced:AddClickListener(self._onClickbtnAdvanced, self)
	self._btnPrimary:AddClickListener(self._onClickbtnPrimary, self)
end

function DragontrialView:buildUI()
	DragontrialView.super.buildUI(self)

	self._txt1 = goutil.findChildTextComponent(self.mainGO, "btnAdvanced/remain/txt1")
	self._txt2 = goutil.findChildTextComponent(self.mainGO, "btnAdvanced/remain/txt2")
	self._txtLock = goutil.findChildTextComponent(self.mainGO, "btnAdvanced/lock/txt")
	self._lockGo = self:getGo("btnAdvanced/lock")
	self._btnAdvanced = self:getBtn("btnAdvanced")
	self._btnPrimary = self:getBtn("btnPrimary")
end

function DragontrialView:onExit()
	DragontrialView.super.onExit(self)
	GlobalDispatcher:removeListener(DragontrialController.PM_DragonTrialGetInfoRes, self._PM_DragonTrialGetInfoRes, self)
end

function DragontrialView:onEnter()
	DragontrialView.super.onEnter(self)
	GlobalDispatcher:addListener(DragontrialController.PM_DragonTrialGetInfoRes, self._PM_DragonTrialGetInfoRes, self)

	self._activityId = DragontrialModel.instance:getCurrActivityId()
	self._actBaseCfg = DragontrialConfig.instance:getActCfg(self._activityId)

	self:_updateView()
end

function DragontrialView:_onClickbtnAdvanced()
	if not self._isAllBasePass then
		FloatWordMgr.instance:show("完成初之试炼全部关卡可解锁")

		return
	end

	UIStateManager.instance:push(ViewName.DragontrialadvancedView)
end

function DragontrialView:_onClickbtnPrimary()
	UIStateManager.instance:push(ViewName.DragontrialprimaryView)
end

function DragontrialView:_setLongshenChallengeTime()
	if self._isAllBasePass then
		local fightTime = DragontrialModel.instance:getDragonFightTime()
		local buyTime = DragontrialModel.instance:getDragonBuyTime()
		local totalTime = self._actBaseCfg.dragonTrialFreeTimes
		local leftTime = totalTime + buyTime - fightTime

		leftTime = math.max(0, leftTime)

		local colorStr = leftTime > 0 and "#20b376" or "#eb4342"

		self._txt1.text = string.format("龙神挑战剩余次数：<color=%s>%s/%s</color>", colorStr, leftTime, totalTime)
	else
		self._txt1.text = ""
	end
end

function DragontrialView:_setDreamTeamChallengeTime()
	if self._isAllBasePass then
		local fightTime = DragontrialModel.instance:getDreamFightTime()
		local buyTime = DragontrialModel.instance:getDreamBuyTime()
		local totalTime = self._actBaseCfg.dreamTrialFreeTimes
		local leftTime = totalTime + buyTime - fightTime

		leftTime = math.max(0, leftTime)

		local colorStr = leftTime > 0 and "#20b376" or "#eb4342"

		self._txt2.text = string.format("梦之队挑战剩余次数：<color=%s>%s/%s</color>", colorStr, leftTime, totalTime)
	else
		self._txt2.text = ""
	end
end

function DragontrialView:_checkAdvancedUnlock()
	goutil.setActive(self._lockGo, not self._isAllBasePass)
end

function DragontrialView:_updateView()
	self._isAllBasePass = DragontrialModel.instance:isFirstTrialAllPass()

	self:_setLongshenChallengeTime()
	self:_setDreamTeamChallengeTime()
	self:_checkAdvancedUnlock()
end

function DragontrialView:_PM_DragonTrialGetInfoRes(status)
	if status == 0 then
		self:_updateView()
	end
end

return DragontrialView
