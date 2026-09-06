-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialSuperFmtTipView.lua

module("logic.extensions.goddesstrial.view.GoddessTrialSuperFmtTipView", package.seeall)

local GoddessTrialSuperFmtTipView = class("GoddessTrialSuperFmtTipView", ViewComponent)

function GoddessTrialSuperFmtTipView:ctor()
	GoddessTrialSuperFmtTipView.super.ctor(self)
end

function GoddessTrialSuperFmtTipView:unbindEvents()
	GoddessTrialSuperFmtTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GoddessTrialSuperFmtTipView:bindEvents()
	GoddessTrialSuperFmtTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GoddessTrialSuperFmtTipView:buildUI()
	GoddessTrialSuperFmtTipView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function GoddessTrialSuperFmtTipView:onExit()
	GoddessTrialSuperFmtTipView.super.onExit(self)
end

function GoddessTrialSuperFmtTipView:onEnter()
	GoddessTrialSuperFmtTipView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	self:_refreshView()
end

function GoddessTrialSuperFmtTipView:_refreshView()
	local list = {}
	local activityId = self._fmtMo.activityId
	local stepId = self._fmtMo.stepId
	local stepCfg = GoddessTrialConfig.instance:getStepCfg(activityId, stepId)
	local scorePlanCfgs = GoddessTrialConfig.instance:getSuperScorePlanCfgs(stepCfg.superTrialScorePlanId)

	for i = 1, #scorePlanCfgs do
		if scorePlanCfgs[i + 1] then
			table.insert(list, {
				min = scorePlanCfgs[i].filterPetCount,
				max = scorePlanCfgs[i + 1].filterPetCount,
				score = scorePlanCfgs[i].score,
				index = i
			})
		else
			table.insert(list, {
				min = scorePlanCfgs[i].filterPetCount,
				score = scorePlanCfgs[i].score,
				index = i
			})
		end
	end

	self._tableList:reloadData(list)
end

function GoddessTrialSuperFmtTipView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local bg = goutil.findChild(go, "bg")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")

	GameUtil.SetActive(bg, data.index % 2 == 0)

	txtNum.text = data.max and langPara("%d-%d", data.min, data.max - 1) or langPara("%d及以上", data.min)
	txtScore.text = data.score
end

function GoddessTrialSuperFmtTipView:_clearCell(cell)
	return
end

return GoddessTrialSuperFmtTipView
