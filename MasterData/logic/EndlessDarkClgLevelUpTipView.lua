-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessdark/view/EndlessDarkClgLevelUpTipView.lua

module("logic.extensions.endlessdark.view.EndlessDarkClgLevelUpTipView", package.seeall)

local EndlessDarkClgLevelUpTipView = class("EndlessDarkClgLevelUpTipView", ViewComponent)

function EndlessDarkClgLevelUpTipView:ctor()
	EndlessDarkClgLevelUpTipView.super.ctor(self)
end

function EndlessDarkClgLevelUpTipView:unbindEvents()
	EndlessDarkClgLevelUpTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function EndlessDarkClgLevelUpTipView:bindEvents()
	EndlessDarkClgLevelUpTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function EndlessDarkClgLevelUpTipView:buildUI()
	EndlessDarkClgLevelUpTipView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("main/btnSure")
	self._txtCurDesc = self:getTxt("main/curBuff/tableview/viewport/content/txtDesc")
	self._txtNextDesc = self:getTxt("main/nextBuff/tableview/viewport/content/txtDesc")
	self._txtHasNum = self:getTxt("main/curCoin/txtNum")
	self._txtNeedNum = self:getTxt("main/costCoin/txtNum")
	self._imgGo1 = self:getGo("main/costCoin/img")
	self._imgGo2 = self:getGo("main/curCoin/img")
end

function EndlessDarkClgLevelUpTipView:onExit()
	EndlessDarkClgLevelUpTipView.super.onExit(self)
	MaterialMgr.resetAll(self._imgGo1)
	MaterialMgr.resetAll(self._imgGo2)
end

function EndlessDarkClgLevelUpTipView:onEnter()
	EndlessDarkClgLevelUpTipView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_EndlessDarkClgUpgradeBuffRes, self.close, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._buffType = checknumber(params[2])

	if self._activityId <= 0 then
		self._activityId = 555001
	end

	self:_refreshUI()
end

function EndlessDarkClgLevelUpTipView:_refreshUI()
	local buffMap = EndlessDarkClgModel.instance:getBuffMap(self._activityId)
	local curLv = checknumber(buffMap[self._buffType])
	local nextLv = checknumber(buffMap[self._buffType]) + 1
	local curBuffCfg = EndlessDarkClgConfig.instance:getBuffCfgsById(self._activityId, self._buffType, curLv)
	local nextBuffCfg = EndlessDarkClgConfig.instance:getBuffCfgsById(self._activityId, self._buffType, nextLv)
	local nextPrize = nextBuffCfg.costItem
	local matType, matId, matNum = MaterialMgr.getMatParams(nextPrize)
	local hasMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	self._txtHasNum.text = hasMatNum
	self._txtNeedNum.text = matNum
	self._txtCurDesc.text = curBuffCfg.desc
	self._txtNextDesc.text = nextBuffCfg.desc

	MaterialMgr.setIcon(self._imgGo1, matType, matId, nil, nil)
	MaterialMgr.setIcon(self._imgGo2, matType, matId, nil, nil)

	self._displayCost = nextPrize
	self._isEnough = matNum <= hasMatNum
end

function EndlessDarkClgLevelUpTipView:_onClickBtnSure()
	if self._isEnough == true then
		EndlessDarkClgController.instance:sendPM_EndlessDarkClgUpgradeBuffReq(self._activityId, self._buffType)
	else
		local matType, matId, matNum = MaterialMgr.getMatParams(self._displayCost)
		local name = MaterialMgr.getMaterialsName(matType, matId)

		FloatWordMgr.instance:show(langPara("拥有的%s不足", name))
	end
end

return EndlessDarkClgLevelUpTipView
