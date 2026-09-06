-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeHudView.lua

module("logic.extensions.luyngarde.view.LuyngardeHudView", package.seeall)

local LuyngardeHudView = class("LuyngardeHudView", ActivityGrandSummaryView)

function LuyngardeHudView:ctor()
	LuyngardeHudView.super.ctor(self)
end

function LuyngardeHudView:unbindEvents()
	LuyngardeHudView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnEvole)
	GameUtil.rmClickHandler(self._btnTip)
end

function LuyngardeHudView:bindEvents()
	LuyngardeHudView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJump1, self._onClickBtnJump1, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickBtnJump2, self)
	GameUtil.addClickHandler(self._btnJump3, self._onClickBtnJump3, self)
	GameUtil.addClickHandler(self._btnJump4, self._onClickBtnJump4, self)
	GameUtil.addClickHandler(self._btnEvole, self._onClickBtnEvole, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function LuyngardeHudView:buildUI()
	LuyngardeHudView.super.buildUI(self)

	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._bg_1 = self:getGo("bg_1")
	self._bg_2 = self:getGo("bg_2")
	self._btnEvole = self:getGo("btnEvole")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._evole = self:getGo("evole")
	self._txtCostShow = self:getTxt("evole/cost")
	self._txtCost = self:getTxt("evole/cost/txt")
	self._iconCost = self:getGo("evole/cost/icon")
end

function LuyngardeHudView:onExit()
	LuyngardeHudView.super.onExit(self)
	MaterialMgr.resetAll(self._iconCost)

	if self._bianBaiEff then
		UIEffectManager.instance:stopEffect(self._bianBaiEff)
	end
end

function LuyngardeHudView:onEnter()
	LuyngardeHudView.super.onEnter(self)

	self._activityId = 466001

	self.addGEvent(self, GlobalNotify.LuyngardeGetInfo, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.LuyngardeUpgradePet, self._handleUpgradePet, self)
	LuyngardeController.instance:getInfo(self._activityId)
	LuyngardeController.instance:getChapter2SimpleRankInfo(self._activityId)
	self:_updateUIByCfg()
end

function LuyngardeHudView:_getSumActivityId()
	return 17152
end

function LuyngardeHudView:_onClickBtnJump1()
	GotoMgr.gotoByString(self._actCfg.shopJump)
end

function LuyngardeHudView:_onClickBtnJump2()
	UIStateManager.instance:push(ViewName.PowerPillaStoryView)
end

function LuyngardeHudView:_onClickBtnJump3()
	GotoMgr.gotoByString("func#1130")
end

function LuyngardeHudView:_onClickBtnJump4()
	UIStateManager.instance:push(ViewName.LuyngardeStroyView, self._activityId)
end

function LuyngardeHudView:_onClickBtnEvole()
	if self._curLevel == 0 then
		if MaterialMgr.getMatEnough(self._firstUpgradeCfg.cost) then
			LuyngardeController.instance:upgradePet(self._activityId)
		else
			local matName = MaterialMgr.getMaterialsNameByCfg(self._firstUpgradeCfg.cost)

			FloatWordMgr.instance:show(string.format("%s不足，去龙塔探秘获得更多吧!", matName))
		end
	else
		UIStateManager.instance:push(ViewName.LuyngardeUpgradeView, self._activityId)
	end
end

function LuyngardeHudView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function LuyngardeHudView:_updateUIByCfg()
	self._actCfg = LuyngardeConfig.instance:getActCfg(self._activityId)
	self._upgradeCfgs = LuyngardeConfig.instance:getPetUpgradeCfgs(self._activityId)
	self._firstUpgradeCfg = self._upgradeCfgs[1]

	local matType, cfgId, matNum = MaterialMgr.getMatParams(self._firstUpgradeCfg.cost)
	local num = MaterialModel.instance:getMaterialsNumber(matType, cfgId)

	self._txtCost.text = string.format("%s/%s", num, matNum)
	self._txtCostShow.text = string.format("%s/%s", num, matNum)

	MaterialMgr.setIcon(self._iconCost, matType, cfgId)
end

function LuyngardeHudView:_handleGetInfo()
	local baseInfo = LuyngardeModel.instance:getBaseInfoByActId(self._activityId)

	self._curLevel = baseInfo.level

	goutil.setActive(self._bg_1, self._curLevel == 0)
	goutil.setActive(self._bg_2, self._curLevel ~= 0)
	goutil.setActive(self._evole, self._curLevel == 0)
end

function LuyngardeHudView:_handleUpgradePet()
	local baseInfo = LuyngardeModel.instance:getBaseInfoByActId(self._activityId)

	self._curLevel = baseInfo.level

	if self._curLevel == 1 then
		local effParent = self.mainGO
		local path = "20241220/zhongyanzhizhan/fx_ui_bianbai.prefab"

		if self._bianBaiEff then
			UIEffectManager.instance:stopEffect(self._bianBaiEff)
		end

		local function finishHandler(handlerTarget, eff)
			goutil.setActive(self._bg_1, self._curLevel == 0)
			goutil.setActive(self._bg_2, self._curLevel ~= 0)
			goutil.setActive(self._evole, self._curLevel == 0)
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		self._bianBaiEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, nil)
	end
end

return LuyngardeHudView
