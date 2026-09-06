-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyevilselectdifficltView.lua

module("logic.extensions.destroyevil.view.DestroyevilselectdifficltView", package.seeall)

local DestroyevilselectdifficltView = class("DestroyevilselectdifficltView", ViewComponent)

DestroyevilselectdifficltView.DifficultDesc = {
	"简单",
	"中等",
	"困难"
}

function DestroyevilselectdifficltView:ctor()
	DestroyevilselectdifficltView.super.ctor(self)
end

function DestroyevilselectdifficltView:unbindEvents()
	DestroyevilselectdifficltView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function DestroyevilselectdifficltView:bindEvents()
	DestroyevilselectdifficltView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function DestroyevilselectdifficltView:buildUI()
	DestroyevilselectdifficltView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtDesc = self:getTxt("cost/txtDesc")
	self._iconCost = self:getGo("cost/imgCost")
end

function DestroyevilselectdifficltView:onExit()
	DestroyevilselectdifficltView.super.onExit(self)
	self._scrollerList:dispose()
	MaterialMgr.resetAll(self._iconCost)
end

function DestroyevilselectdifficltView:onEnter()
	DestroyevilselectdifficltView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._actCfg = DestroyEvilConfig.instance:getActivityCfg(self._activityId)
	self._lastDifficultStar = DestroyEvilModel.instance:getDifficultyStar()
	self._difficultyStar = self._lastDifficultStar

	if self._difficultyStar <= 0 then
		local power = RoleModel.instance:getMaxPower()
		local cfgs = DestroyEvilConfig.instance:getDifficultRecommondCfgs(self._activityId)

		for i, v in ipairs(cfgs) do
			if power >= v.powerRange[1] and (power <= v.powerRange[2] or v.powerRange[2] == -1) then
				self._recommendDifficult = v.difficult
				self._difficultyStar = v.difficult

				break
			end
		end
	end

	if self._difficultyStar <= 0 then
		self._difficultyStar = 1
		self._recommendDifficult = 1
	end

	self:_updateUI()
	self:_updateCost()
end

function DestroyevilselectdifficltView:_onClickbtnClose()
	self:close()
end

function DestroyevilselectdifficltView:_setDifficultyStar(difficultyStar)
	self._difficultyStar = difficultyStar
end

function DestroyevilselectdifficltView:_onClickbtnSure()
	if self._lastDifficultStar > 0 and self._lastDifficultStar == self._difficultyStar then
		FloatWordMgr.instance:show("难度没有发生变化")

		return
	end

	if self._difficultyStar <= 0 then
		FloatWordMgr.instance:show("请选择难度")

		return
	end

	local actCfg = DestroyEvilConfig.instance:getActivityCfg(self._activityId)
	local refreshCfgs = DestroyEvilConfig.instance:getResetDiffitcultCostCfgs(actCfg.resetDifficultyCostPlanId)
	local refreshTime = DestroyEvilModel.instance:getTodayResetDifficultyTimes()
	local nextRefreshTime = refreshTime + 1
	local refreshCfg = refreshCfgs[nextRefreshTime]
	local matType, matId, matNum = MaterialMgr.getMatParams(refreshCfg.cost)

	local function successCallBack()
		DestroyEvilAgent.instance:sendPM_DestroyEvilSelectDifficultyReq(self._activityId, self._difficultyStar)
		self:close()
	end

	if self._lastDifficultStar <= 0 then
		TipsFacade.instance:openTipWindow("提示", "是否确认选择该难度，选择后重新调整需要消耗材料", successCallBack)
	else
		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, "确认修改难度吗？", successCallBack)
	end
end

function DestroyevilselectdifficltView:_updateCell(view, cell, difficultyStar, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local goRecommend = goutil.findChild(cell.gameObject, "recommend")
	local goCurrTag = goutil.findChild(cell.gameObject, "currTag")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtLevel1 = goutil.findChildTextComponent(cell.gameObject, "txtLevel1")
	local txtLevel2 = goutil.findChildTextComponent(cell.gameObject, "txtLevel2")
	local txtLevel3 = goutil.findChildTextComponent(cell.gameObject, "txtLevel3")
	local imgDescBgChange = goutil.findChild(cell.gameObject, "bg/imgDescBg"):GetComponent(ComponentType.UIImageColorChange)
	local txtChange = goutil.findChild(cell.gameObject, "txt"):GetComponent(ComponentType.UITextColorChange)
	local bgChange = goutil.findChild(cell.gameObject, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtLevels = {
		txtLevel1,
		txtLevel2,
		txtLevel3
	}

	for i, v in ipairs(txtLevels) do
		v.text = ""
	end

	local recommendCfg = DestroyEvilConfig.instance:getDifficultRecommondCfg(self._activityId, difficultyStar)

	imgDescBgChange:SetState(difficultyStar - 1)
	txtChange:SetState(difficultyStar - 1)
	bgChange:SetState(difficultyStar - 1)
	goutil.setActive(goSelect, self._difficultyStar == difficultyStar)
	goutil.setActive(goRecommend, self._recommendDifficult == difficultyStar)
	goutil.setActive(goCurrTag, self._lastDifficultStar == difficultyStar)

	txtDesc.text = recommendCfg.desc
	txtLevels[difficultyStar].text = DestroyevilselectdifficltView.DifficultDesc[difficultyStar]

	btn:AddClickListener(function()
		self:_setDifficultyStar(difficultyStar)
		self._scrollerList:refresh()
	end)
end

function DestroyevilselectdifficltView:_clearCell(cell)
	return
end

function DestroyevilselectdifficltView:_updateUI()
	local ticketCfg = DestroyEvilConfig.instance:getTicket(self._activityId, 1)

	self._scrollerList:reloadData(ticketCfg.difficultStar)
	goutil.setActive(self._btnClose.gameObject, self._lastDifficultStar > 0)
end

function DestroyevilselectdifficltView:_updateCost()
	local times = DestroyEvilModel.instance:getTodayResetDifficultyTimes() + 1
	local costCfg = DestroyEvilConfig.instance:getResetDiffitcultCostCfg(self._actCfg.resetDifficultyCostPlanId, times)
	local matType, matId, num = MaterialMgr.getMatParams(costCfg.cost)
	local name = MaterialMgr.getMaterialsName(matType, matId)

	self._txtDesc.text = string.format("消耗<color=#ffeca0>%s</color>%s可修改难度", num, name)

	MaterialMgr.setIcon(self._iconCost, matType, matId)
end

return DestroyevilselectdifficltView
