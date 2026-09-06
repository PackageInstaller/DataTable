-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/view/JiuClgResultView.lua

module("logic.extensions.jiuclg.view.JiuClgResultView", package.seeall)

local JiuClgResultView = class("JiuClgResultView", ViewComponent)

function JiuClgResultView:buildUI()
	JiuClgResultView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._btnReset = self:getBtn("btnReset")
	self._txtDesc1 = self:getTxt("tips/txtDesc1")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)
end

function JiuClgResultView:bindEvents()
	JiuClgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
end

function JiuClgResultView:unbindEvents()
	JiuClgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnReset)
end

function JiuClgResultView:onEnter()
	JiuClgResultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.JiuClgExtremeFightConfirmRes, self._handleJiuClgExtremeFightConfirmRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._phaseId = params[2]
	self._stageId = params[3]
	self._isClick = false
	self._cfgStage = JiuClgConfig.instance:getExtremeStageCfg(self._activityId, self._phaseId, self._stageId)
	self._balancedValue = JiuClgModel.instance:getBtlBalancedValue(self._activityId)

	self:_setTitleDesc()
	self:_setContentDesc()
end

function JiuClgResultView:onExit()
	JiuClgResultView.super.onExit(self)
	self._scrollList:dispose()
end

function JiuClgResultView:_onClickSure()
	if not self._isClick then
		UIStateManager.instance:push(ViewName.JiuClgChangeView, self._activityId, self._phaseId, self._stageId)
	end
end

function JiuClgResultView:_onClickReset()
	if not self._isClick then
		self._isClick = true

		JiuClgController.instance:resetExtremeChallenge(self._activityId, self._phaseId, self._stageId)
	end
end

function JiuClgResultView:_handleJiuClgExtremeFightConfirmRes(status)
	self:close()
	BattleController.instance:endBattle()
end

function JiuClgResultView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local selectGo = goutil.findChild(cell, "select")
	local leftNum = data.range[1]
	local rightNum = data.range[2]
	local isInRange = leftNum <= self._balancedValue and rightNum >= self._balancedValue

	goutil.setActive(selectGo, isInRange)

	local showNum = rightNum <= 99 and rightNum or 99

	if self._cfgStage.balanceType == 1 then
		txtDesc.text = string.format("我方回合数为%d回合内 锁定%d只精灵", showNum, data.lockCount)
	elseif self._cfgStage.balanceType == 2 then
		txtDesc.text = string.format("我方Buff数为%d数量内 锁定%d只精灵", showNum, data.lockCount)
	end
end

function JiuClgResultView:_clearCell(cell)
	return
end

function JiuClgResultView:_setTitleDesc()
	if self._cfgStage.balanceType == 1 then
		self._txtDesc1.text = "当前胜利回合数：" .. self._balancedValue
	elseif self._cfgStage.balanceType == 2 then
		self._txtDesc1.text = "己方目标Buff数：" .. self._balancedValue
	end
end

function JiuClgResultView:_setContentDesc()
	local cfgLockPetPlanList = JiuClgConfig.instance:getExtremeLockPetPlanList(self._cfgStage.lockPetPlanId)

	self._scrollList:reloadData(cfgLockPetPlanList)
end

return JiuClgResultView
